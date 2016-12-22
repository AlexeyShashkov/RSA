`include "config.sv"

//% As MontMult has two outputs s0 and s1, and final s = (s0 + s1),
//% the final result is s calculated with final_adder.
module final_adder #(parameter DATA_WIDTH = (1024+1))
(
    input clk,
    input ce,
    input rst,
    input start_final_addition,
    input [(DATA_WIDTH-1):0] s0_r,
    input [(DATA_WIDTH-1):0] s1_r,
    input [(DATA_WIDTH-1):0] n,
    output done,
    output [(DATA_WIDTH-1):0] m
);

logic [($clog2(DATA_WIDTH+1)-1):0] cnt_addition;
logic cnt_addition_continue;

always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {cnt_addition, cnt_addition_continue} <= 1'b0;
    else if (ce)
    begin
        if (start_final_addition)
        begin
            cnt_addition <= 1'b1;
            cnt_addition_continue <= 1'b1;
        end
        else if (cnt_addition_continue)
        begin
            cnt_addition <= (cnt_addition + 1'b1);
            if ((DATA_WIDTH) == cnt_addition)
                cnt_addition_continue <= 1'b0;
        end
    end
end

//% Addition is performed bit by bit (bit per clock).
logic sum_i;

bit_shift_adder #(DATA_WIDTH) bit_shift_adder_final
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .en(cnt_addition_continue),
    .load(start_final_addition),
    .a0(s0_r),
    .a1(s1_r),
    .a_i(sum_i)
);

logic [(DATA_WIDTH-1):0] final_sum;

//% Final sum is shifted-in bit by bit also.
always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {final_sum} <= 1'b0;
    else if (ce)
    begin
        if (cnt_addition_continue)
            final_sum <= {sum_i, final_sum[(DATA_WIDTH-1):1]};
    end
end

logic addition_done;
always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {addition_done} <= 1'b0;
    else if (ce)
        addition_done <= ((DATA_WIDTH) == cnt_addition);
end

//% Produce (n == final_sum).
logic done_cmp;
logic are_equal;
bit_comp #(DATA_WIDTH) bit_comp_0
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .start_cmp(addition_done),
    .in0(n),
    .in1(final_sum),
    .done_cmp(done_cmp),
    .are_equal(are_equal)
);

//% In rare cases final MontMult R produces s = (s0 + s1) == n,
//% thus logical (s - n) = 0 is performed in this case.
logic [(DATA_WIDTH-1):0] m_out;
always_comb
begin
    if (are_equal)
        m_out = 1'b0;
    else
        m_out = final_sum;
end

//% Registering outputs.
logic [(DATA_WIDTH-1):0] r_m_out;
logic r_done;
always_ff @(posedge clk `SYNC_OR_ASYNC_RESET)
begin
    if (rst)
        {r_m_out, r_done} <= 1'b0;
    else if (ce)
    begin
        if (done_cmp)
            r_m_out <= m_out;
        r_done <= done_cmp;
    end
end

assign m = r_m_out;
assign done = r_done;

endmodule: final_adder
