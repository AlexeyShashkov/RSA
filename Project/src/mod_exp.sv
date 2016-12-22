`include "config.sv"

//% mod_exp is designated for RSA encryption or decryption class m = (c ^ d) mod n, where c < n and n is odd.
//% Odd n is the limitation of mod_exp due to the underlying fast Montgomery multiplication algorithm.
//% Designed by Alexey Shashkov for NTLab in Jan-Feb 2016.
module mod_exp #(parameter DATA_WIDTH = (`CONFIG_DATA_WIDTH))
(
    input clk,                                 //% Clock.
    input ce,                                  //% Clock enable.
    input rst,                                 //% Reset.
    input start,                               //% Starts encryption/decryption process (only if in ready state).
    input [(DATA_WIDTH-1):0] c,                //% Input to encrypt/decrypt.
    input [(DATA_WIDTH-1):0] d,                //% Encrypt/decrypt exponent. d must satisfy d > 0.
    input [($clog2(DATA_WIDTH)-1):0] t_sub_1,  //% Effective number of bits in d, but minus 1.
    input [(DATA_WIDTH-1):0] r2_mod_n,         //% r2_mod_n = (r ^ 2) mod n = ((2 ^ (2 + DATA_WIDTH)) ^ 2) mod n.
    input [(DATA_WIDTH-1):0] n,                //% Modulus n: n must be odd.
    output ready,                              //% Ready signal for new input of start, c, d, t_sub_1, r2_mod_n, and n.
    output [(DATA_WIDTH-1):0] m,               //% Output of encryption/decryption.
    output done                                //% Denotes m as m = (c ^ d) mod n (completion of operation).
);


//% K is the number of bits required for correct mod_exp operation.
//% K must be: K = 2 + nomber_of_bits(n).
localparam K = (2 + DATA_WIDTH);


//% ready setting and resetting logic.
logic r_ready;
logic set_ready;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        r_ready <= 1'b1;
    else if (ce)
    begin
        if (set_ready)
            r_ready <= 1'b1;
        else if (start)
            r_ready <= 1'b0;
    end
end

assign ready = r_ready;


//% Input registers for c, t_sub_1, r2_mod_n, n (d-register goes later).
logic [(DATA_WIDTH-1):0] r_c;
logic [($clog2(DATA_WIDTH)-1):0] r_t_sub_1;
logic [(DATA_WIDTH-1):0] r_r2_mod_n;
logic [(DATA_WIDTH-1):0] r_n;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_c, r_t_sub_1, r_r2_mod_n, r_n} <= 1'b0;
    else if (ce)
    begin
        if (start & r_ready)
        begin
            r_c <= c;
            r_t_sub_1 <= t_sub_1;
            r_r2_mod_n <= r2_mod_n;
            r_n <= n;
        end
    end
end


//% Counter for the main R/P loop.
logic inc;
logic [($clog2(DATA_WIDTH)-1):0] cnt;

counter_to_t_sub_1 #(DATA_WIDTH) counter_to_t_sub_1_0
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .inc(inc),
    .t_sub_1(r_t_sub_1),
    .o_cnt(cnt)
);


//% Input register for d. Also serves for shifting of the current bit of
//% d to r_d[0], inevitably spoiling initial input d (and that is OK).
logic [(DATA_WIDTH-1):0] r_d;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_d} <= 1'b0;
    else if (ce)
    begin
        if (start & r_ready)
            r_d <= d;
        else if (inc)
            r_d <= {1'b0, r_d[(DATA_WIDTH-1):1]};
    end
end

//% Current bit of d.
logic r_d_0;
assign r_d_0 = r_d[0];


//% MontMult for R calculations.
logic [(K-1):0] a0_r, a1_r, b0_r, b1_r, s0_r, s1_r;
logic start_r, ready_next_r, ready_next_prev_r, ready_next_3prev_r;

mont_mult #(K) mont_mult_r
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .start(start_r),
    .a0(a0_r),
    .a1(a1_r),
    .b0(b0_r),
    .b1(b1_r),
    .n({2'b00, r_n}),
    .s0(s0_r),
    .s1(s1_r),
    .ready_next(ready_next_r),
    .ready_next_prev(ready_next_prev_r),
    .ready_next_3prev(ready_next_3prev_r)
);


//% MontMult for P calculations.
logic [(K-1):0] a0_p, a1_p, b0_p, b1_p, s0_p, s1_p;
logic start_p, ready_next_p, ready_next_prev_p, ready_next_3prev_p;

mont_mult #(K) mont_mult_p
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .start(start_p),
    .a0(a0_p),
    .a1(a1_p),
    .b0(b0_p),
    .b1(b1_p),
    .n({2'b00, r_n}),
    .s0(s0_p),
    .s1(s1_p),
    .ready_next(ready_next_p),
    .ready_next_prev(ready_next_prev_p),
    .ready_next_3prev(ready_next_3prev_p)
);


//% MontMult R & P commutation configuration logic.
logic [1:0] commutation_config;

always_comb
begin
    case (commutation_config)
        2'b01: begin
            a0_r = {2'b00, r_r2_mod_n};
            a1_r = 1'b0;
            b0_r = 1'b1;
            b1_r = 1'b0;
            a0_p = {2'b00, r_r2_mod_n};
            a1_p = 1'b0;
            b0_p = {2'b00, r_c};
            b1_p = 1'b0;
        end
        2'b10: begin
            a0_r = s0_r;
            a1_r = s1_r;
            b0_r = 1'b1;
            b1_r = 1'b0;
            a0_p = s0_p;
            a1_p = s1_p;
            b0_p = s0_p;
            b1_p = s1_p;
        end
        default: begin
            a0_r = s0_r;
            a1_r = s1_r;
            b0_r = s0_p;
            b1_r = s1_p;
            a0_p = s0_p;
            a1_p = s1_p;
            b0_p = s0_p;
            b1_p = s1_p;
        end
    endcase
end


//% Set delay for start_final_addition.
logic start_final_addition;
logic d1_start_final_addition, d2_start_final_addition;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {d1_start_final_addition, d2_start_final_addition} <= 1'b0;
    else if (ce)
    begin
        d1_start_final_addition <= start_final_addition;
        d2_start_final_addition <= d1_start_final_addition;
    end
end

//% MontMult R in final MM(R, 1, n) produces s = (s0 + s1) <= n, thus logical (s - n) = 0 is
//% performed in case (s == n) in final_adder_0. Because of this, n needs to be stored for
//% final_adder_0 as a next new value of n can be registered for MuntMult-pipeline stage,
//% spoiling actual n for final_adder_0.
logic [(DATA_WIDTH-1):0] r_n_prev;
always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_n_prev} <= 1'b0;
    else if (ce)
    begin
        if (start_final_addition)
            r_n_prev <= r_n;
    end
end

//% Final pipeline stage of mod_exp.
final_adder #(DATA_WIDTH) final_adder_0
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .start_final_addition(d2_start_final_addition),
    .s0_r(s0_r[(DATA_WIDTH-1):0]),
    .s1_r(s1_r[(DATA_WIDTH-1):0]),
    .n(r_n_prev),
    .done(done),
    .m(m)
);


//% Control logic is implemented in two logically-equivalent ways: using FSM and using FSM-like logic.
//% One should use the one of these two which is the fastest for a target implementation.
//control_fsm #(DATA_WIDTH) control_0
control_logic #(DATA_WIDTH) control_0
(
    // Inputs
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .start(start),
    .ready_next_r(ready_next_r),
    .ready_next_p(ready_next_p),
    .r_t_sub_1(r_t_sub_1),
    .cnt(cnt),
    .ready_next_prev_r(ready_next_prev_r),
    .ready_next_prev_p(ready_next_prev_p),
    .ready_next_3prev_r(ready_next_3prev_r),
    .r_d_0(r_d_0),
    // Outputs
    .commutation_config(commutation_config),
    .start_r(start_r),
    .start_p(start_p),
    .inc(inc),
    .start_final_addition(start_final_addition),
    .set_ready(set_ready)
);

endmodule: mod_exp
