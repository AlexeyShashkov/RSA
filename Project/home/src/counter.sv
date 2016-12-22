`include "config.sv"

module counter #(parameter K = 2+1024+1)
(
    input clk,
    input ce,
    input rst,
    input restart,
    output active,
    output ready_next,
    output ready_next_prev,
    output ready_next_3prev
);

logic [($clog2(K)-1):0] cnt;
logic r_active;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {cnt, r_active} <= 1'b0;
    else if (ce)
    begin
        if (restart)
        begin
            cnt <= 1'b0;
            r_active <= 1'b1;
        end
        else if ((K-1) == cnt)
            r_active <= 1'b0;
        else if (r_active)
            cnt <= (cnt + 1'b1);
    end
end

assign active = r_active;


logic r_ready_next;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_ready_next} <= 1'b0;
    else if (ce)
        r_ready_next <= ((K-3) == cnt);
end

assign ready_next = r_ready_next;


logic r_ready_next_prev;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_ready_next_prev} <= 1'b0;
    else if (ce)
        r_ready_next_prev <= ((K-4) == cnt);
end

assign ready_next_prev = r_ready_next_prev;


logic r_ready_next_3prev;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_ready_next_3prev} <= 1'b0;
    else if (ce)
        r_ready_next_3prev <= ((K-6) == cnt);
end

assign ready_next_3prev = r_ready_next_3prev;


endmodule: counter
