# Power-aware simulation of RSA Processor project in Mentor Graphics Questa Sim 10.2c.

# Compiling RTL files.
vlog -sv ./src/config.sv +incdir+./src
vlog -sv ./src/bit_shift_adder.sv +incdir+./src
vlog -sv ./src/control_fsm.sv +incdir+./src
vlog -sv ./src/control_logic.sv +incdir+./src
vlog -sv ./src/counter.sv +incdir+./src
vlog -sv ./src/counter_to_t_sub_1.sv +incdir+./src
vlog -sv ./src/csa.sv +incdir+./src
vlog -sv ./src/csa_5_to_2_div_2.sv +incdir+./src
vlog -sv ./src/final_adder.sv +incdir+./src
vlog -sv ./src/mod_exp.sv +incdir+./src
vlog -sv ./src/mod_exp_wrapper.sv +incdir+./src
vlog -sv ./src/mont_mult.sv +incdir+./src
vlog -sv ./src/rsa_power_control.sv +incdir+./src
vlog -sv ./src/rsa_top.sv +incdir+./src
vlog -sv ./src/bit_comp.sv +incdir+./src
vlog -sv ./src/tb/rsa_top_tb.sv +incdir+./src

# Standard Flow: creating fully-optimized power-aware simulation model using UPF specification.
# Enable full debugging.
# Enable UPF object display and UPF wave highlighting.
# Enable both static and dynamic checking.
# Enable static checks debugging.
# Generate all verbose reports.
vopt rsa_top_tb \
    -pa_top rsa_top_tb/dut \
    -pa_upf ./src/rsa_top_power_intent.upf \
    -debugdb \
    -pa_enable=highlight+supplynetworkdebug \
    -pa_checks=all \
    -pa_dbgstatic=rsn+msk \
    -pa_genrpt=v+u+c+b+pa+de \
    -pa_reportdir ./report \
    -o rsa_top_sim_model

# Write report files to pa_reportdir.
pa report

# Start power-aware simulation.
vsim rsa_top_sim_model \
    -pa \
    -debugdb \
    -pa_highlight \
    -coverage \
    -vopt \
    -do ./wave/rsa_top_tb_opt_wave.do

run 10us

view powerstatelist

# Open design schematic.
add schematic -full sim:/rsa_top_tb
