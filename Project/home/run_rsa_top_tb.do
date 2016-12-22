# Power-aware simulation of RSA Processor project in Mentor Graphics Questa Sim 10.2c.

# Compiling RTL files.
vlog -novopt -sv ./src/config.sv +incdir+./src
vlog -novopt -sv ./src/bit_shift_adder.sv +incdir+./src
vlog -novopt -sv ./src/control_fsm.sv +incdir+./src
vlog -novopt -sv ./src/control_logic.sv +incdir+./src
vlog -novopt -sv ./src/counter.sv +incdir+./src
vlog -novopt -sv ./src/counter_to_t_sub_1.sv +incdir+./src
vlog -novopt -sv ./src/csa.sv +incdir+./src
vlog -novopt -sv ./src/csa_5_to_2_div_2.sv +incdir+./src
vlog -novopt -sv ./src/final_adder.sv +incdir+./src
vlog -novopt -sv ./src/mod_exp.sv +incdir+./src
vlog -novopt -sv ./src/mod_exp_wrapper.sv +incdir+./src
vlog -novopt -sv ./src/mont_mult.sv +incdir+./src
vlog -novopt -sv ./src/rsa_power_control.sv +incdir+./src
vlog -novopt -sv ./src/rsa_top.sv +incdir+./src
vlog -novopt -sv ./src/bit_comp.sv +incdir+./src
vlog -novopt -sv ./src/tb/csa_tb.sv +incdir+./src
vlog -novopt -sv ./src/tb/final_adder_tb.sv +incdir+./src
vlog -novopt -sv ./src/tb/mod_exp_tb.sv +incdir+./src
vlog -novopt -sv ./src/tb/mod_exp_tb_2.sv +incdir+./src
vlog -novopt -sv ./src/tb/mod_exp_tb_3.sv +incdir+./src
vlog -novopt -sv ./src/tb/mont_mult_tb.sv +incdir+./src
vlog -novopt -sv ./src/tb/rsa_top_tb.sv +incdir+./src
vlog -novopt -sv ./src/tb/bit_comp_tb.sv +incdir+./src
vlog -novopt -sv ./src/tb/bit_shift_adder_tb.sv +incdir+./src
vlog -novopt -sv ./src/tb/counter_tb.sv +incdir+./src
vlog -novopt -sv ./src/tb/counter_to_t_sub_1_tb.sv +incdir+./src
vlog -novopt -sv ./src/tb/csa_5_to_2_div_2_tb.sv +incdir+./src

# No-Optimization Flow: vopt step is performed only to process the UPF specification.
vopt rsa_top_tb \
    -pa_top rsa_top_tb/dut \
    -pa_upf ./src/rsa_top_power_intent.upf \
    -pa_enable=highlight+supplynetworkdebug+nonoptimizedflow \
    -pa_checks=all

# An alternative way:
# vopt rsa_top \
#     -pa_upf ./src/rsa_top_power_intent.upf \
#     -pa_prefix "/rsa_top_tb/" \
#     -pa_replacetop "dut" \
#     -pa_enable=highlight+supplynetworkdebug+nonoptimizedflow \
#     -pa_checks=all

# Start power-aware simulation.
vsim rsa_top_tb \
    -novopt \
    -L mtiPA \
    -pa \
    -pa_highlight \
    -do ./wave/rsa_top_tb_wave.do

run 10us
