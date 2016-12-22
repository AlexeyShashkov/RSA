`include "config.sv"

module bit_comp_tb();

parameter DATA_WIDTH = 8;

logic clk;
logic ce;
logic rst;
logic start_cmp;
logic [(DATA_WIDTH-1):0] in0;
logic [(DATA_WIDTH-1):0] in1;
logic done_cmp;
logic are_equal;

bit_comp #(DATA_WIDTH) dut
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .start_cmp(start_cmp),
    .in0(in0),
    .in1(in1),
    .done_cmp(done_cmp),
    .are_equal(are_equal)
);

always #(`CLK_PERIOD/2) clk = ~clk;

initial
begin
    clk = 1'b1;
    ce = 1'b1;
    rst = 1'b0;
    start_cmp = 1'b0;
    in0 = 1'b0;
    in1 = 1'b0;

    @(posedge clk);
    rst = 1'b1;
    @(posedge clk);
    rst = 1'b0;

    in0 = 8'b01010101;
    in1 = 8'b00010101;

    start_cmp = 1'b1;
    @(posedge clk);
    start_cmp = 1'b0;

    @(done_cmp)
    @(posedge clk);

    in0 = 8'b01010101;
    in1 = 8'b01010101;

    start_cmp = 1'b1;
    @(posedge clk);
    start_cmp = 1'b0;
end

endmodule: bit_comp_tb
