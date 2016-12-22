`include "config.sv"

//% Carry-save adder (CSA). (s + c) = (x1 + x2 + x3).
//% CSA has no carry propagation as common adder does, thus
//% CSA-way is the fastest way to perform addition for
//% intermediate addition results.
module csa #(parameter K = 2+1024+1)
(
    input [(K-1):0] x1,
    input [(K-1):0] x2,
    input [(K-1):0] x3,
    output [K:0] s,
    output [K:0] c
);

assign s = {1'b0, (x1 ^ x2 ^ x3)};
assign c = {(x1 | x2) & (x1 | x3) & (x2 | x3), 1'b0};

endmodule: csa
