`include "config.sv"

module csa_5_to_2_div_2_tb();

parameter K = 8;

logic clk, ce, rst, clr, en;
logic [(K-1):0] x1, x2;
logic [(K-1):0] x3, x4, x5;
logic [(K-1):0] s0, s1;

csa_5_to_2_div_2 #(K) dut
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .clr(clr),
    .en(en),
    .x1(x1),
    .x2(x2),
    .x3(x3),
    .x4(x4),
    .x5(x5),
    .s0(s0),
    .s1(s1)
);

always #(`CLK_PERIOD/2) clk = ~clk;

initial
begin
    clk = 1'b1;
    ce = 1'b1;
    clr = 1'b0;
    en = 1'b0;

    x1 = 5;
    x2 = 5;
    x3 = 5;
    x4 = 5;
    x5 = 4;

    rst = 1'b0;
    @(posedge clk);
    rst = 1'b1;
    @(posedge clk);
    rst = 1'b0;

    @(posedge clk);
    en = 1'b1;
    @(posedge clk);
    en = 1'b0;

    repeat(3) @(posedge clk);

    clr = 1'b1;
    @(posedge clk);
    clr = 1'b0;
end

endmodule: csa_5_to_2_div_2_tb
