`include "config.sv"

module mont_mult_tb();

parameter K = 8;

logic clk, ce, rst, start, ready_next, ready_next_prev, ready_next_3prev;
logic [(K-1):0] a0, a1, b0, b1, n, s0, s1;

mont_mult #(K) dut
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .start(start),
    .a0(a0),
    .a1(a1),
    .b0(b0),
    .b1(b1),
    .n(n),
    .s0(s0),
    .s1(s1),
    .ready_next(ready_next),
    .ready_next_prev(ready_next_prev),
    .ready_next_3prev(ready_next_3prev)
);

always #(`CLK_PERIOD/2) clk = ~clk;

initial
begin
    clk = 1'b1;
    ce = 1'b1;
    start = 1'b0;

    a0 = 10;
    a1 = 15;
    b0 = 32;
    b1 = 4;
    n = 131;  // 25 * 36 * 109 mod 131 = 112.

    rst = 1'b0;
    @(posedge clk);
    rst = 1'b1;
    @(posedge clk);
    rst = 1'b0;

    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
end

endmodule: mont_mult_tb
