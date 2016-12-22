`include "config.sv"

typedef enum int unsigned
{
    S0,
    S0_2,
    S1,
    S2,
    S3,
    S4
} pmu_fsm_states_e;

module rsa_power_control
(
    input clk,
    input ce,
    input rst,
    input req_enable,
    input req_disable,
    input sw_ack,
    output outputs_force_zero,
    output iso_en,
    output sw_disable,
    output reset_on_enable,
    output clk_disable,
    output mode_change_ack
);

pmu_fsm_states_e present_state;
pmu_fsm_states_e next_state;

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
    next_state = present_state;  //% Default.
    case (present_state)
        S0: if (1'b1 == req_disable) next_state = S0_2;
        S0_2: if (1) next_state = S1;
        S1: if (1'b0 == sw_ack) next_state = S2;
        S2: if (1) next_state = S3;
        S3: if (1'b1 == req_enable) next_state = S4;
        S4: if (1'b1 == sw_ack) next_state = S0;
    endcase
end

//% FSM output logic.
logic w_outputs_force_zero;
logic w_iso_en;
logic w_mode_change_ack;
logic w_sw_disable;
logic w_reset_on_enable;
logic w_clk_disable;

always_comb
begin
    w_outputs_force_zero = 1'b0;
    w_iso_en = 1'b0;
    w_mode_change_ack = 1'b0;
    w_sw_disable = 1'b0;
    w_reset_on_enable = 1'b0;
    w_clk_disable = 1'b0;
    //% State dependencies.
    case (present_state)
        S0: begin
            if (1'b1 == req_disable)
                w_outputs_force_zero = 1'b1;
        end
        S0_2: begin
            w_outputs_force_zero = 1'b1;
            w_iso_en = 1'b1;
            w_clk_disable = 1'b1;
        end
        S1: begin
            w_iso_en = 1'b1;
            w_clk_disable = 1'b1;
            w_sw_disable = 1'b1;
        end
        S2: begin
            w_iso_en = 1'b1;
            w_clk_disable = 1'b1;
            w_sw_disable = 1'b1;
            w_mode_change_ack = 1'b1;
        end
        S3: begin
            w_iso_en = 1'b1;
            w_clk_disable = 1'b1;
            w_sw_disable = 1'b1;
        end
        S4: begin
            w_outputs_force_zero = 1'b1;
            if (1'b0 == sw_ack)
            begin
                w_iso_en = 1'b1;
                w_reset_on_enable = 1'b1;
            end
            else
                w_mode_change_ack = 1'b1;
        end
    endcase
end

//% FSM output registers.
logic r_outputs_force_zero;
logic r_iso_en;
logic r_mode_change_ack;
logic r_sw_disable;
logic r_reset_on_enable;
logic r_clk_disable;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {
            r_outputs_force_zero,
            r_iso_en,
            r_mode_change_ack,
            r_sw_disable,
            r_reset_on_enable,
            r_clk_disable
        } <= 1'b0;
    else
    begin
        r_outputs_force_zero <= w_outputs_force_zero;
        r_iso_en <= w_iso_en;
        r_mode_change_ack <= w_mode_change_ack;
        r_sw_disable <= w_sw_disable;
        r_reset_on_enable <= w_reset_on_enable;
        r_clk_disable <= w_clk_disable;
    end
end

assign outputs_force_zero = r_outputs_force_zero;
assign iso_en = r_iso_en;
assign mode_change_ack = r_mode_change_ack;
assign sw_disable = r_sw_disable;
assign reset_on_enable = r_reset_on_enable;
assign clk_disable = r_clk_disable;

endmodule: rsa_power_control
