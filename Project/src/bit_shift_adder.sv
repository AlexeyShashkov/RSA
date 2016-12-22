`include "config.sv"

//% bit_shift_adder produces the sum of a0 and a1 one bit per clock cycle.
//% en input should be set for not more than necessary amount of clocks
//% in order to guarantee correct operation.
module bit_shift_adder #(parameter DATA_WIDTH = (1024+1))
(
    input clk,
    input ce,
    input rst,
    input en,
    input load,
    input [(DATA_WIDTH-1):0] a0,
    input [(DATA_WIDTH-1):0] a1,
    output a_i
);

logic [(DATA_WIDTH-1):0] r_a0, r_a1;
logic r_c;

//% 1-bit full adder. fa[0] is the current bit output, fa[1] is carry.
logic [1:0] fa;
assign fa = r_a0[0] + r_a1[0] + r_c;

//% Load and shift operations. Shift moves current bits of r_a0 and r_a1
//% to r_a0[0] + r_a1[0] respectively to calculate current bit of sum with fa.
//% r_c is also updated here.
always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_a0, r_a1, r_c} <= 1'b0;
    else if (ce)
    begin
        if (load)
        begin
            r_a0 <= a0;
            r_a1 <= a1;
            r_c <= 1'b0;
        end
        else if (en)
        begin
            r_a0 <= {1'b0, r_a0[(DATA_WIDTH-1):1]};
            r_a1 <= {1'b0, r_a1[(DATA_WIDTH-1):1]};
            r_c <= fa[1];
        end
    end
end

assign a_i = fa[0];

endmodule: bit_shift_adder
