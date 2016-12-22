`include "config.sv"

//% CSA cascade with output registers. Additionally performs
//% div 2 for outputs using shifted wiring only.
module csa_5_to_2_div_2 #(parameter K = 2+1024+1)
(
    input clk,
    input ce,
    input rst,
    input clr,
    input en,
    input [(K-1):0] x1,
    input [(K-1):0] x2,
    input [(K-1):0] x3,
    input [(K-1):0] x4,
    input [(K-1):0] x5,
    output [(K-1):0] s0,
    output [(K-1):0] s1
);

logic [K:0] csa_0_s, csa_0_c;

csa #(K) csa_0
(
    .x1(x1),
    .x2(x2),
    .x3(x3),
    .s(csa_0_s),
    .c(csa_0_c)
);

logic [K:0] csa_1_x4;
assign csa_1_x4 = {1'b0, x4};
logic [(K+1):0] csa_1_s, csa_1_c;

csa #(K+1) csa_1
(
    .x1(csa_0_s),
    .x2(csa_0_c),
    .x3(csa_1_x4),
    .s(csa_1_s),
    .c(csa_1_c)
);

logic [(K+1):0] csa_2_x5;
assign csa_2_x5 = {2'b00, x5};
logic [(K+2):0] csa_2_s, csa_2_c;

csa #(K+2) csa_2
(
    .x1(csa_1_s),
    .x2(csa_1_c),
    .x3(csa_2_x5),
    .s(csa_2_s),
    .c(csa_2_c)
);

logic [(K-1):0] r_s0, r_s1;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_s0, r_s1} <= 1'b0;
    else if (ce)
    begin
        if (clr)
        begin
            r_s0 <= 1'b0;
            r_s1 <= 1'b0;
        end
        else if (en)
        begin
            //% Performing csa_2_s div 2, csa_2_c div 2.
            r_s0 <= csa_2_s[K:1];
            r_s1 <= csa_2_c[K:1];
        end
    end
end

assign s0 = r_s0;
assign s1 = r_s1;

endmodule: csa_5_to_2_div_2
