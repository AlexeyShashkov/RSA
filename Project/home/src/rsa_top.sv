`include "config.sv"

//% rsa_top is a power-aware module and it must be combined with the file rsa_top_power_intent.upf.
//% rsa_top contains mod_exp_0 as the main component, and mod_exp_0 can be switched off.
//% This file contains only RTL-logic, while rsa_top_power_intent.upf file adds descriptions of several
//% power-related components, such as power nets, power switch and isolation blocks with their
//% corresponding control and status signals.
module rsa_top #(parameter DATA_WIDTH = (`CONFIG_DATA_WIDTH))
(
    input clk,                                 //% Clock.
    input ce,                                  //% Clock enable.
    input rst,                                 //% Reset.
    input req_enable,                          //% Request to enable power for mod_exp.
    input req_disable,                         //% Request to disable power for mod_exp.
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

//% Latch-based clock gate.
//% Clock gating is necessary before disabling power for mod_exp_0, because
//% mod_exp_0.ce = 0 has no effect when power for mod_exp_0 is off.
logic clk_enable_latch;
logic clk_disable;
logic clk_gated;
always_latch
begin
    if (rst)
        clk_enable_latch <= 1'b1;
    else if (~clk)
        clk_enable_latch <= ~clk_disable;
end
assign clk_gated = clk & clk_enable_latch;

//% UPF-connected signals (explicitly defined as wires).
wire w_iso_en;
wire w_sw_disable;
wire w_sw_ack;  //% Asynchronous acknowledge signal from UPF-defined switch SW.

//% Metastability buffer for w_sw_ack.
logic d1_w_sw_ack, d2_w_sw_ack;
always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {d1_w_sw_ack, d2_w_sw_ack} <= 1'b0;
    else if (ce)
    begin
        d1_w_sw_ack <= w_sw_ack;
        d2_w_sw_ack <= d1_w_sw_ack;
    end
end

logic w_outputs_force_zero;
logic w_mode_change_ack;

rsa_power_control rsa_power_control_0
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .req_enable(req_enable),
    .req_disable(req_disable),
    .sw_ack(d2_w_sw_ack),
    .outputs_force_zero(w_outputs_force_zero),
    .iso_en(w_iso_en),
    .sw_disable(w_sw_disable),
    .reset_on_enable(reset_on_enable),
    .clk_disable(clk_disable),
    .mode_change_ack(w_mode_change_ack)
);

//% UPF-connected signals. These signals have isolation.
wire w_ready;
wire [(DATA_WIDTH-1):0] w_m;
wire w_done;

//% mod_exp_0 is situated in the power domain PD_sw (PD_sw can be turned off).
//% The rest of the logic described in this file is in PD_top.
mod_exp_wrapper #(DATA_WIDTH) mod_exp_0
(
    .clk(clk_gated),
    .ce(ce & ~clk_disable),
    .rst(rst | reset_on_enable),
    .outputs_force_zero(w_outputs_force_zero),
    .start(start),
    .c(c),
    .d(d),
    .t_sub_1(t_sub_1),
    .r2_mod_n(r2_mod_n),
    .n(n),
    .ready(w_ready),
    .m(w_m),
    .done(w_done)
);

logic power_enabled;
always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
    begin
        power_enabled <= 1'b1;
    end
    else if (ce)
    begin
        if (w_mode_change_ack)
            power_enabled <= ~power_enabled;
    end
end

//% Power-aware hack. Makes sinks of mod_exp_0 be considered in
//% PD_top, not in testbench (testbench is not in any power domain).
//% This way power-aware isolation static checks can be performed.
logic w2_ready;
logic [(DATA_WIDTH-1):0] w2_m;
logic w2_done;
always_comb
begin
    w2_ready = (w_ready & power_enabled & ~w_iso_en);
    w2_m = w_m;
    w2_done = w_done;
end

assign ready = w2_ready;
assign m = w2_m;
assign done = w2_done;

endmodule: rsa_top
