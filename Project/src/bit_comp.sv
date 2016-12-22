`include "config.sv"

//% bit_comp compares in0 and in1 and determines if (in0 == in1).
module bit_comp #(parameter DATA_WIDTH = (1024+1))
(
    input clk,
    input ce,
    input rst,
    input start_cmp,
    input [(DATA_WIDTH-1):0] in0,
    input [(DATA_WIDTH-1):0] in1,
    output done_cmp,
    output are_equal
);

logic [(DATA_WIDTH-1):0] r_in0;
logic [(DATA_WIDTH-1):0] r_in1;

logic r_done_cmp;
logic r_are_equal;

logic bits_are_equal;
assign bits_are_equal = !(r_in0[DATA_WIDTH-1] ^ r_in1[DATA_WIDTH-1]);

logic is_working;
logic [($clog2((DATA_WIDTH-1)+1)-1):0] cnt;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_in0, r_in1} <= 1'b0;
    else if (ce)
    begin
        if (start_cmp)
        begin
            r_in0 <= in0;
            r_in1 <= in1;
        end
        else if (is_working)
        begin
            r_in0 <= {r_in0[(DATA_WIDTH-2):0], 1'b0};
            r_in1 <= {r_in1[(DATA_WIDTH-2):0], 1'b0};
        end
    end
end

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {cnt, is_working, r_are_equal, r_done_cmp} <= 1'b0;
    else if (ce)
    begin
        if (r_done_cmp)
        begin
            r_done_cmp <= 1'b0;
            r_are_equal <= 1'b0;
        end
        else if (start_cmp)
        begin
            is_working <= 1'b1;
            cnt <= 1'b0;
            r_are_equal <= 1'b0;
        end
        else if (is_working & !bits_are_equal)
        begin
            is_working <= 1'b0;
            r_are_equal <= 1'b0;
            r_done_cmp <= 1'b1;
        end
        else if (is_working & ((DATA_WIDTH-1) == cnt))
        begin
            is_working <= 1'b0;
            r_are_equal <= 1'b1;
            r_done_cmp <= 1'b1;
        end
        else if (is_working & bits_are_equal)
            cnt <= (cnt + 1'b1);
    end
end

assign done_cmp = r_done_cmp;
assign are_equal = r_are_equal;

endmodule: bit_comp
