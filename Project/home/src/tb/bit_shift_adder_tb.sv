`include "config.sv"

module bit_shift_adder_tb();

parameter DATA_WIDTH = 8;

logic clk, ce, rst, en, load;
logic [(DATA_WIDTH-1):0] a0, a1;
logic a_i;

bit_shift_adder #(DATA_WIDTH) dut
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .en(en),
    .load(load),
    .a0(a0),
    .a1(a1),
    .a_i(a_i)
);

always #(`CLK_PERIOD/2) clk = ~clk;

initial
begin
    clk = 1'b1;
    ce = 1'b1;
    en = 1'b1;
    load = 1'b0;

    a0 = 8'b01011011;
    a1 = 8'b00101010;

    rst = 1'b0;
    @(posedge clk);
    rst = 1'b1;
    @(posedge clk);
    rst = 1'b0;

    repeat(2) @(posedge clk);

    load = 1'b1;
    @(posedge clk);
    load = 1'b0;
end

endmodule: bit_shift_adder_tb
