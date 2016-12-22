`include "config.sv"

module mod_exp_tb();

parameter DATA_WIDTH = (8+1);

logic clk;
logic ce;
logic rst;
logic start;
logic [(DATA_WIDTH-1):0] c;
logic [(DATA_WIDTH-1):0] d;
logic [($clog2(DATA_WIDTH)-1):0] t_sub_1;
logic [(DATA_WIDTH-1):0] r2_mod_n;
logic [(DATA_WIDTH-1):0] n;
logic ready;
logic [(DATA_WIDTH-1):0] m;
logic done;

mod_exp #(DATA_WIDTH) dut
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
    .ready(ready),
    .m(m),
    .done(done)
);

always #(`CLK_PERIOD/2) clk = ~clk;

initial
begin
    clk = 1'b1;
    ce = 1'b1;
    start = 1'b0;

    rst = 1'b0;
    @(posedge clk);
    rst = 1'b1;
    @(posedge clk);
    rst = 1'b0;

    // K = (2 + DATA_WIDTH) = 11. r = 2 ^ K = 2 ^ 11.

    // (255 ^ 4) mod 511 = 32.
    c = 8'd_255;
    d = 4;
    n = 511;
    t_sub_1 = 2;    // t is the effective bit-width of d.
    r2_mod_n = 16;  // r2_mod_n = (r ^ 2) mod 511 = 16.
    // Correct output: m = 32.

    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);


    @(ready);
    @(posedge clk);

    // (56 ^ 5) mod 509 = 393.
    c = 56;
    d = 3'd_5;
    n = 509;
    t_sub_1 = 2;
    r2_mod_n = 144;  // r2_mod_n = (r ^ 2) mod 509 = 144.
    // Correct output: m = 393.

    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);


    @(ready);
    @(posedge clk);

    // (56 ^ 1) mod 509 = 56.
    c = 56;
    d = 1'd_1;
    t_sub_1 = 0;
    r2_mod_n = 144;  // r2_mod_n = (r ^ 2) mod 509 = 144.
    n = 509;
    // Correct output: m = 56.

    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);


    @(ready);
    @(posedge clk);

    // (0 ^ 1) mod 509 = 0.
    c = 0;
    d = 1'd_1;
    n = 509;
    t_sub_1 = 0;  // t is the effective bit-width of d.
    r2_mod_n = 144;  // For K = 11: r = 2 ^ 11. (r ^ 2) mod 509 = 144.
    // Correct output: m = 0.

    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);


    @(ready);
    @(posedge clk);

    // (1 ^ 1) mod 509 = 1.
    c = 1;
    d = 1'd_1;
    n = 509;
    t_sub_1 = 0;  // t is the effective bit-width of d.
    r2_mod_n = 144;  // For K = 11: r = 2 ^ 11. (r ^ 2) mod 509 = 144.
    // Correct output: m = 1.

    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);


    @(ready);
    @(posedge clk);


    // (45 ^ 5) mod 225 = 0.
    c = 45;
    d = 5;
    n = 225;
    t_sub_1 = 2;
    r2_mod_n = 79;  // For K = 11: ((2 ^ 11) ^ 2) mod 225 = 79.
    // Correct output: m = 0

    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

end  // initial

endmodule: mod_exp_tb
