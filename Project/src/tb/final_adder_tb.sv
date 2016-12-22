`include "config.sv"

module final_adder_tb();

parameter DATA_WIDTH = 6;

logic clk, ce, rst, start_final_addition;
logic [(DATA_WIDTH-1):0] s0_r, s1_r;
logic done;
logic [(DATA_WIDTH-1):0] n;
logic [(DATA_WIDTH-1):0] m;

final_adder #(DATA_WIDTH) dut
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .start_final_addition(start_final_addition),
    .s0_r(s0_r),
    .s1_r(s1_r),
    .done(done),
    .n(n),
    .m(m)
);

always #(`CLK_PERIOD/2) clk = ~clk;

initial
begin
    clk = 1'b1;
    ce = 1'b1;
    start_final_addition = 1'b0;
    n = 1'b0;

    s0_r = 6'b101010;
    s1_r = 6'b010101;

    rst = 1'b0;
    @(posedge clk);
    rst = 1'b1;
    @(posedge clk);
    rst = 1'b0;

    start_final_addition = 1'b1;
    @(posedge clk);
    start_final_addition = 1'b0;
end

endmodule: final_adder_tb
