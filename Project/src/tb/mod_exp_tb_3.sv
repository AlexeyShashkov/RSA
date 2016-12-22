`include "config.sv"


//% Configurable testbench parameters.
parameter DATA_WIDTH = (`CONFIG_DATA_WIDTH);  //% For (DATA_WIDTH >= 4) only.
parameter NUMBER_OF_TEST_RUNS = (100_000);


//% All inputs coverage works only for small DATA_WIDTH <= (5+1)
//% due to the limited maximum number of bins support.
//`define ENABLE_ALL_INPUTS_COVERAGE


class mod_exp_dataset_c;

    //% K must be: K = 2 + nomber_of_bits(n).
    localparam K = (2 + DATA_WIDTH);

    rand bit [(DATA_WIDTH-1):0] c;
    rand bit [(DATA_WIDTH-1):0] d;
    rand bit [(DATA_WIDTH-1):0] n;

    bit [(DATA_WIDTH-1):0] r2_mod_n;
    bit [($clog2(DATA_WIDTH)-1):0] t_sub_1;
    bit [(DATA_WIDTH-1):0] model_m;

    constraint c1
    {
        d > 0;
        1'b1 == n[0];  //% n is odd.
        c < n;
    }

`ifdef ENABLE_ALL_INPUTS_COVERAGE
    covergroup cg_all_valid_mod_exp_inputs;
        all_valid_c_cp: coverpoint this.c
        {
            bins c[] = { [0:((2**DATA_WIDTH)-2)] };  //% Not including c = ((2**DATA_WIDTH)-1) bin.
            option.weight = 0;
        }
        all_valid_d_cp: coverpoint this.d
        {
            bins d[] = { [1:((2**DATA_WIDTH)-1)] };  //% Not including d = 0 bin.
            option.weight = 0;
        }
        all_valid_n_cp: coverpoint this.n
        {
            wildcard bins n[] = { 'b?1 };  //% Including only odd n bins.
            option.weight = 0;
        }
        valid_c_d_n_cross: cross all_valid_c_cp, all_valid_d_cp, all_valid_n_cp
        {
            ignore_bins ignore_c_higher_or_eq_to_n = valid_c_d_n_cross with (all_valid_c_cp >= all_valid_n_cp);
        }
        option.per_instance = 1;
    endgroup: cg_all_valid_mod_exp_inputs
`endif

    function new();
        this.c = 1'b0;
        this.d = 1'b0;
        this.n = 1'b0;
        this.r2_mod_n = 1'b0;
        this.t_sub_1 = 1'b0;
        this.model_m = 1'b0;
`ifdef ENABLE_ALL_INPUTS_COVERAGE
        this.cg_all_valid_mod_exp_inputs = new();
`endif
    endfunction: new

    // r2_mod_n = (r ^ 2) mod n = ((2 ^ K) ^ 2) mod n.
    function void calc_r2_mod_n();
        //% The line below does not process correctly for large K (with no warnings).
        //% r2_mod_n = (((2 ** K) ** 2) % n);

        //% The following code works fine on the other hand.
        bit [K:0] v_2_pow_k;
        bit [(2*(K+1)):0] sq_v_2_pow_k;

        v_2_pow_k = (2 ** K);
        sq_v_2_pow_k = (v_2_pow_k * v_2_pow_k);
        r2_mod_n = (sq_v_2_pow_k % n);
    endfunction: calc_r2_mod_n

    function void calc_t_sub_1();
        bit [(DATA_WIDTH-1):0] d_w;
        d_w = d;
        t_sub_1 = 1'b0;
        while (d_w > 0)
        begin
            t_sub_1 = (t_sub_1 + 1);
            d_w = (d_w >> 1);
        end
        t_sub_1 = (t_sub_1 - 1);
    endfunction: calc_t_sub_1

    //% calc_model_m calculates m = (c ^ d) mod n using classical (and slow)
    //% left-to-right binary modular exponentiation method. Algorithm used in this calculation
    //% is different from the Montgomery exponentiation algorithm used in mod_exp DUT.
    function void calc_model_m();
        bit [(DATA_WIDTH-1):0] c_w;
        bit [(DATA_WIDTH-1):0] d_w;
        bit [(2*DATA_WIDTH-1):0] mult_var;
        if (1 == n)
        begin
            model_m = 0;
            return;
        end
        if (0 == c)
        begin
            model_m = 0;
            return;
        end
        c_w = c;
        d_w = d;
        model_m = 1'b1;
        while (d_w > 0)
        begin
            if (1'b1 == (d_w % 2))
            begin
                mult_var = (model_m * c_w);
                model_m = (mult_var % n);
            end

            mult_var = (c_w * c_w);
            c_w = (mult_var % n);

            d_w = (d_w >> 1);
        end
    endfunction: calc_model_m

    function void display_contents();
        $display("mod_exp_dataset_c object now contains:");
        $display("c = 'h_%h", c);
        $display("d = 'h_%h", d);
        $display("n = 'h_%h", n);
        $display("r2_mod_n = 'h_%h", r2_mod_n);
        $display("t_sub_1 = 'h_%h", t_sub_1);
        $display("model_m = 'h_%h", model_m);
    endfunction: display_contents

    function void copy(ref mod_exp_dataset_c other);
        this.c = other.c;
        this.d = other.d;
        this.n = other.n;
        this.r2_mod_n = other.r2_mod_n;
        this.t_sub_1 = other.t_sub_1;
        this.model_m = other.model_m;
    endfunction: copy

    function void post_randomize();
        calc_model_m();
        calc_r2_mod_n();
        calc_t_sub_1();
`ifdef ENABLE_ALL_INPUTS_COVERAGE
        cg_all_valid_mod_exp_inputs.sample();
`endif
    endfunction: post_randomize

endclass: mod_exp_dataset_c


module mod_exp_tb_3 ();

mod_exp_dataset_c mod_exp_dataset;
mod_exp_dataset_c prev_mod_exp_dataset;

int number_of_run_errors = 0;


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


//% Clock generation.
always #(`CLK_PERIOD/2) clk = ~clk;

initial
auto_test: begin

    check_data_width: assert(DATA_WIDTH >= 4)
    else
    begin
        $display("CONFIGURATION_ERROR: DATA_WIDTH = %d, ignoring demand (DATA_WIDTH >= 4)", DATA_WIDTH);
        $stop;
    end: check_data_width

    //% Creating new mod_exp_dataset_c objects for inputs
    //% generation and model logic.
    mod_exp_dataset = new();
    prev_mod_exp_dataset = new();

    //% Initial values.
    clk = 1'b1;
    ce = 1'b1;
    start = 1'b0;
    rst = 1'b0;

    //% Reset.
    @(posedge clk);
    rst = 1'b1;
    @(posedge clk);
    rst = 1'b0;

    //% Main inputs change loop.
    for (int i = 0; i < NUMBER_OF_TEST_RUNS; i++)
    begin
        //% Break loop if full coverage is achieved. WARNING: This makes simulation much slower.
        //% This code can be used if one wants to know what minimum number of iterations
        //% full coverage is achieved with.
        /*
        if (100.0 == mod_exp_dataset.cg_all_valid_mod_exp_inputs.valid_c_d_n_cross.get_coverage())
        begin
            break;
        end
        */

        $display("test # %d", i);
        assert(mod_exp_dataset.randomize());
        c = mod_exp_dataset.c;
        d = mod_exp_dataset.d;
        n = mod_exp_dataset.n;
        t_sub_1 = mod_exp_dataset.t_sub_1;
        r2_mod_n = mod_exp_dataset.r2_mod_n;

        start = 1'b1;
        @(posedge clk);
        start = 1'b0;
        @(posedge clk);

        @(ready);
        @(posedge clk);

        prev_mod_exp_dataset.copy(mod_exp_dataset);
    end

    //% Waiting for the last operation of this test to
    //% complete and then stopping.
    @(done);
    repeat(20) @(posedge clk);
    $display("TEST_FINISHED");
    $display("NUMBER_OF_RUN_ERRORS_OCCURED: %d", number_of_run_errors);
    $stop;
end: auto_test

//% This process reads new m outputs on (1 == done).
//% m is then compared to the corresponding model_m.
always
check_m: begin
    @(done);
    @(posedge clk);
    compare_m_and_model_m: assert(m == prev_mod_exp_dataset.model_m)
    else
    begin
        $display("VERIFICATION_ERROR: model_m = 'h_%h, but m = 'h_%h", prev_mod_exp_dataset.model_m, m);
        $display("Executing prev_mod_exp_dataset.display_contents()");
        prev_mod_exp_dataset.display_contents();
        number_of_run_errors++;
        $stop;
    end: compare_m_and_model_m
end: check_m

endmodule: mod_exp_tb_3
