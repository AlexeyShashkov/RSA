`include "config.sv"

module counter_to_t_sub_1 #(parameter DATA_WIDTH = (1024+1))
(
    input clk,
    input ce,
    input rst,
    input inc,
    input [($clog2(DATA_WIDTH)-1):0] t_sub_1,
    output [($clog2(DATA_WIDTH)-1):0] o_cnt
);

logic [($clog2(DATA_WIDTH)-1):0] cnt;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {cnt} <= 1'b0;
    else if (ce)
    begin
        if (inc)
        begin
            if (t_sub_1 != cnt)
                cnt <= (cnt + 1'b1);
            else
                cnt <= 1'b0;
        end
    end
end

assign o_cnt = cnt;

endmodule: counter_to_t_sub_1
