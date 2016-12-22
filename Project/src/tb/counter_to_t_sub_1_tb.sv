`include "config.sv"

module counter_to_t_sub_1_tb();

parameter DATA_WIDTH = 8;
parameter T_SUB_1 = 3'b100;

logic [($clog2(DATA_WIDTH)-1):0] o_cnt;
logic clk, ce, rst, inc;

counter_to_t_sub_1 #(DATA_WIDTH) dut
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .inc(inc),
    .t_sub_1(T_SUB_1),
    .o_cnt(o_cnt)
);

always #(`CLK_PERIOD/2) clk = ~clk;

initial
begin
    clk = 1'b1;
    ce = 1'b0;
    inc = 1'b1;

    rst = 1'b0;
    @(posedge clk);
    rst = 1'b1;
    @(posedge clk);
    rst = 1'b0;

    ce = 1'b0;
    repeat(3) @(posedge clk);
    ce = 1'b1;
    repeat(7) @(posedge clk);
    ce = 1'b0;
end

endmodule: counter_to_t_sub_1_tb
