`include "config.sv"

module control_logic #(parameter DATA_WIDTH = (1024+1))
(
    input clk,
    input ce,
    input rst,
    input start,
    input ready_next_r,
    input ready_next_p,
    input [($clog2(DATA_WIDTH)-1):0] r_t_sub_1,
    input [($clog2(DATA_WIDTH)-1):0] cnt,
    input ready_next_prev_r,
    input ready_next_prev_p,
    input ready_next_3prev_r,
    input r_d_0,
    output [1:0] commutation_config,
    output start_r,
    output start_p,
    output inc,
    output start_final_addition,
    output set_ready
);

logic [1:0] w_commutation_config;
logic w_start_r;
logic w_start_p;
logic w_inc;
logic w_start_final_addition;
logic w_set_ready;

logic [1:0] r_commutation_config;
logic r_start_r;
logic r_start_p;
logic r_inc;
logic r_start_final_addition;
logic r_set_ready;


//% Control outputs registering.
always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
    begin
        {
            r_commutation_config,
            r_start_r,
            r_start_p,
            r_inc,
            r_start_final_addition,
            r_set_ready
        } <= 1'b0;
    end
    else if (ce)
    begin
        r_commutation_config <= w_commutation_config;
        r_start_r <= w_start_r;
        r_start_p <= w_start_p;
        r_inc <= w_inc;
        r_start_final_addition <= w_start_final_addition;
        r_set_ready <= w_set_ready;
    end
end

assign commutation_config = r_commutation_config;
assign start_r = r_start_r;
assign start_p = r_start_p;
assign inc = r_inc;
assign start_final_addition = r_start_final_addition;
assign set_ready = r_set_ready;


//% Control state registers.
logic r_s0, r_s1, r_s2, r_s3, r_s4, r_s5, r_s6;

//% Control state registers transitions.
always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
    begin
        r_s0 <= 1'b1;
        {r_s1, r_s2, r_s3, r_s4, r_s5, r_s6} <= 1'b0;
    end
    else if (ce)
    begin
        // S6.
        if (r_s6)
        begin
            if (ready_next_prev_r)
            begin
                r_s6 <= 1'b0;
                if (start)
                    r_s1 <= 1'b1;
                else
                    r_s0 <= 1'b1;
            end
        end
        // S5.
        if (r_s5)
        begin
            r_s6 <= 1'b1;
            r_s5 <= 1'b0;
        end
        // S4.
        if (r_s4)
        begin
            if (ready_next_r | ready_next_p)
            begin
                r_s4 <= 1'b0;
                if (r_t_sub_1 == cnt)
                    r_s5 <= 1'b1;
                else
                    r_s3 <= 1'b1;
            end
        end
        // S3.
        if (r_s3)
        begin
            r_s4 <= 1'b1;
            r_s3 <= 1'b0;
        end
        // S2.
        if (r_s2)
        begin
            if (ready_next_r)
            begin
                r_s3 <= 1'b1;
                r_s2 <= 1'b0;
            end
        end
        // S1.
        if (r_s1)
        begin
            r_s2 <= 1'b1;
            r_s1 <= 1'b0;
        end
        // S0.
        if (r_s0)
        begin
            if (start)
            begin
                r_s1 <= 1'b1;
                r_s0 <= 1'b0;
            end
        end
    end  // if (rst)
end  // always_ff


//% Output control logic.
always_comb
begin
    // Defaults.
    w_commutation_config = 2'b00;
    w_start_r = 1'b0;
    w_start_p = 1'b0;
    w_inc = 1'b0;
    w_start_final_addition = 1'b0;
    w_set_ready = 1'b0;
    // S6.
    if (r_s6)
    begin
        if (ready_next_3prev_r)
            w_set_ready = 1'b1;
        if (ready_next_prev_r)
            w_start_final_addition = 1'b1;
    end
    // S5.
    if (r_s5)
    begin
        w_commutation_config = 2'b10;
        w_start_r = 1'b1;
    end
    // S4.
    if (r_s4)
    begin
        if (ready_next_prev_r | ready_next_prev_p)
            w_inc = 1'b1;
    end
    // S3.
    if (r_s3)
    begin
        w_commutation_config = 2'b00;
        if (r_d_0)
            w_start_r = 1'b1;
        if (r_t_sub_1 != cnt)
            w_start_p = 1'b1;
    end
    // S1.
    if (r_s1)
    begin
        w_commutation_config = 2'b01;
        w_start_r = 1'b1;
        w_start_p = 1'b1;
    end
end

endmodule: control_logic
