`include "config.sv"

//% mont_mult implements the Montgomery multiplication algorithm
//% without final subtractions.
module mont_mult #(parameter K = (2+1024+1))
(
    input clk,
    input ce,
    input rst,
    input start,
    input [(K-1):0] a0,
    input [(K-1):0] a1,
    input [(K-1):0] b0,
    input [(K-1):0] b1,
    input [(K-1):0] n,
    output [(K-1):0] s0,
    output [(K-1):0] s1,
    output ready_next,
    output ready_next_prev,
    output ready_next_3prev
);

logic a_i;
logic active;

counter #(K) counter_0
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .restart(start),
    .active(active),
    .ready_next(ready_next),
    .ready_next_prev(ready_next_prev),
    .ready_next_3prev(ready_next_3prev)
);

bit_shift_adder #(K) bit_shift_adder_0
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .en(active),
    .load(start),
    .a0(a0),
    .a1(a1),
    .a_i(a_i)
);

logic [(K-1):0] r_b0, r_b1, r_n;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_b0, r_b1, r_n} <= 1'b0;
    else if (ce)
    begin
        if (start)
        begin
            r_b0 <= b0;
            r_b1 <= b1;
            r_n <= n;
        end
    end
end

logic [(K-1):0] fb_s0, fb_s1;

logic [(K-1):0] b0_ai, b1_ai;
always_comb
begin
    if (a_i)
    begin
        b0_ai = r_b0;
        b1_ai = r_b1;
    end
    else
    begin
        b0_ai = 1'b0;
        b1_ai = 1'b0;
    end
end

logic q_i;
assign q_i = fb_s0[0] ^ fb_s1[0] ^ (a_i & (r_b0[0] ^ r_b1[0]));

logic [(K-1):0] n_qi;

always_comb
begin
    if (q_i)
        n_qi = r_n;
    else
        n_qi = 1'b0;
end

csa_5_to_2_div_2 #(K) csa_5_to_2_div_2_0
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .clr(start),
    .en(active),
    .x1(fb_s0),
    .x2(fb_s1),
    .x3(b0_ai),
    .x4(b1_ai),
    .x5(n_qi),
    .s0(fb_s0),
    .s1(fb_s1)
);

assign s0 = fb_s0;
assign s1 = fb_s1;

endmodule: mont_mult
