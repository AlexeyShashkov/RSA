`include "config.sv"

module csa_tb();

parameter K = 8;

logic [(K-1):0] x1, x2, x3;
logic [K:0] s;
logic [K:0] c;

csa #(K) dut
(
    .x1(x1),
    .x2(x2),
    .x3(x3),
    .s(s),
    .c(c)
);

initial
begin
    x1 = 8'b11111111;
    x2 = 8'b11111111;
    x3 = 8'b11111111;
    #1;
    $display("s = %b", s);
    $display("c = %b", c);
end

endmodule: csa_tb
