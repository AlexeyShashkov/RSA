`include "config.sv"

typedef enum int unsigned
{
  S0,
  S1,
  S2,
  S3,
  S4,
  S5,
  S6
} control_fsm_states_e;

module control_fsm #(parameter DATA_WIDTH = (1024+1))
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


//% FSM outputs registering.
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


//% FSM state registers.
control_fsm_states_e present_state;
control_fsm_states_e next_state;

//% FSM present state logic.
always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        present_state <= S0;
    else if (ce)
        present_state <= next_state;
end

//% FSM next state logic.
always_comb
begin
    // Default.
    next_state = present_state;
    case (present_state)
        S0: begin
            if (start)
                next_state = S1;
        end
        S1: begin
            next_state = S2;
        end
        S2: begin
            if (ready_next_r)
                next_state = S3;
        end
        S3: begin
            next_state = S4;
        end
        S4: begin
            if (ready_next_r | ready_next_p)
            begin
                if (r_t_sub_1 == cnt)
                    next_state = S5;
                else
                    next_state = S3;
            end
        end
        S5: begin
            next_state = S6;
        end
        S6: begin
            if (ready_next_prev_r)
            begin
                if (start)
                    next_state = S1;
                else
                    next_state = S0;
            end
        end
        default: begin
            next_state = S0;
        end
    endcase
end

//% FSM output logic.
always_comb
begin
    w_commutation_config = 2'b00;
    w_start_r = 1'b0;
    w_start_p = 1'b0;
    w_inc = 1'b0;
    w_start_final_addition = 1'b0;
    w_set_ready = 1'b0;
    // State dependences.
    case (present_state)
        S0: begin
        end
        S1: begin
            w_commutation_config = 2'b01;
            w_start_r = 1'b1;
            w_start_p = 1'b1;
        end
        S2: begin
        end
        S3: begin
            w_commutation_config = 2'b00;
            if (r_d_0)
                w_start_r = 1'b1;
            if (r_t_sub_1 != cnt)
                w_start_p = 1'b1;
        end
        S4: begin
            if (ready_next_prev_r | ready_next_prev_p)
                w_inc = 1'b1;
        end
        S5: begin
            w_commutation_config = 2'b10;
            w_start_r = 1'b1;
        end
        S6: begin
            if (ready_next_3prev_r)
                w_set_ready = 1'b1;
            if (ready_next_prev_r)
                w_start_final_addition = 1'b1;
        end
    endcase
end

endmodule: control_fsm
