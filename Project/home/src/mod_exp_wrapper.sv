`include "config.sv"

//% mod_exp_wrapper wraps mod_exp_0 so the outputs of mod_exp_0 can be forced to all zeros.
//% This functionality is required to prevent signal level toggles for isolation outputs at
//% the moments when isolation is turned on and turned off (for isolation clamp to all zeros).
module mod_exp_wrapper #(parameter DATA_WIDTH = (`CONFIG_DATA_WIDTH))
(
    input clk,
    input ce,
    input rst,
    input outputs_force_zero,
    input start,
    input [(DATA_WIDTH-1):0] c,
    input [(DATA_WIDTH-1):0] d,
    input [($clog2(DATA_WIDTH)-1):0] t_sub_1,
    input [(DATA_WIDTH-1):0] r2_mod_n,
    input [(DATA_WIDTH-1):0] n,
    output ready,
    output [(DATA_WIDTH-1):0] m,
    output done
);

logic w_ready;
logic [(DATA_WIDTH-1):0] w_m;
logic w_done;

mod_exp #(DATA_WIDTH) mod_exp_0
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
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

logic w0_ready;
logic [(DATA_WIDTH-1):0] w0_m;
logic w0_done;
always_comb
begin
    if (outputs_force_zero)
    begin
        w0_ready <= 1'b0;
        w0_m <= 1'b0;
        w0_done <= 1'b0;
    end
    else
    begin
        w0_ready <= w_ready;
        w0_m <= w_m;
        w0_done <= w_done;
    end
end

assign ready = w0_ready;
assign m = w0_m;
assign done = w0_done;

endmodule: mod_exp_wrapper
