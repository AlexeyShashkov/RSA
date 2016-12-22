

            function CrossQueueType create_ignore_even_n();
                for (bit [(DATA_WIDTH-1):0] nn = 1'b0; nn < ((2**DATA_WIDTH)-1); nn++)
                begin
                    if (1'b0 == nn[0])
                        create_ignore_even_n.push_back('{ nn });
                end
            endfunction


    covergroup cg_all_valid_mod_exp_inputs;
        all_c_cp: coverpoint this.c
        {
            bins c[] =
            {
                [0:((2**DATA_WIDTH)-1)]
            };
            option.weight = 0;
        }
        all_d_cp: coverpoint this.d
        {
            bins d[] =
            {
                [0:((2**DATA_WIDTH)-1)]
            };
            option.weight = 0;
        }
        all_n_cp: coverpoint this.n
        {
            bins n[] =
            {
                [0:((2**DATA_WIDTH)-1)]
            };
            option.weight = 0;
        }
        valid_c_d_n_cross: cross all_c_cp, all_d_cp, all_n_cp
        {
            ignore_bins ignore_c_higher_or_eq_to_n = valid_c_d_n_cross with (all_c_cp >= all_n_cp);
            ignore_bins ignore_d_eq_to_0 = binsof(all_d_cp) intersect {1'b0};
            ignore_bins ignore_even_n_bins = valid_c_d_n_cross with (1'b0 == (all_n_cp % 2));
        }
        option.per_instance = 1;
    endgroup: cg_all_valid_mod_exp_inputs

