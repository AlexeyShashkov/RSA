`include "config.sv"

module counter_tb();

parameter K = 9;

logic clk, ce, rst, restart, active, ready_next, ready_next_prev, ready_next_3prev;

counter #(K) dut
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .restart(restart),
    .active(active),
    .ready_next(ready_next),
    .ready_next_prev(ready_next_prev),
    .ready_next_3prev(ready_next_3prev)
);

always #(`CLK_PERIOD/2) clk = ~clk;

initial
begin
    clk = 1;
    ce = 1;
    restart = 0;

    rst = 0;
    @(posedge clk);
    rst = 1;
    @(posedge clk);
    rst = 0;

    @(posedge clk);
    restart = 1;
    @(posedge clk);
    restart = 0;

    repeat(10) @(posedge clk);
    restart = 1;
    @(posedge clk);
    restart = 0;
end

endmodule: counter_tb
