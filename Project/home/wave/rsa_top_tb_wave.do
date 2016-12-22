onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Power
add wave -noupdate -radix unsigned /rsa_top_tb/dut/gnd_n
add wave -noupdate -radix unsigned /rsa_top_tb/dut/vdd_n
add wave -noupdate -color Cyan -itemcolor Cyan -radix unsigned /rsa_top_tb/dut/sw_vdd_n
add wave -noupdate -group {Power Switch} /rsa_top_tb/dut/SW/supply
add wave -noupdate -group {Power Switch} /rsa_top_tb/dut/SW/PWR
add wave -noupdate -group {Power Switch} /rsa_top_tb/dut/SW/GND
add wave -noupdate -group {Power Switch} /rsa_top_tb/dut/SW/SW_IN
add wave -noupdate -group {Power Switch} /rsa_top_tb/dut/SW/SW_OUT
add wave -noupdate -group {Power Switch} /rsa_top_tb/dut/SW/SW_DIS
add wave -noupdate -divider rsa_top
add wave -noupdate -radix unsigned /rsa_top_tb/DATA_WIDTH
add wave -noupdate /rsa_top_tb/clk
add wave -noupdate /rsa_top_tb/ce
add wave -noupdate /rsa_top_tb/rst
add wave -noupdate /rsa_top_tb/req_enable
add wave -noupdate /rsa_top_tb/req_disable
add wave -noupdate -radix unsigned /rsa_top_tb/c
add wave -noupdate -radix unsigned /rsa_top_tb/d
add wave -noupdate -radix unsigned /rsa_top_tb/t_sub_1
add wave -noupdate -radix unsigned /rsa_top_tb/r2_mod_n
add wave -noupdate -radix unsigned /rsa_top_tb/n
add wave -noupdate -color Cyan -itemcolor Cyan /rsa_top_tb/start
add wave -noupdate -color Cyan -itemcolor Cyan /rsa_top_tb/ready
add wave -noupdate -color Orange -itemcolor Orange -radix unsigned /rsa_top_tb/m
add wave -noupdate -color Orange -itemcolor Orange /rsa_top_tb/done
add wave -noupdate -color Magenta -itemcolor Magenta /rsa_top_tb/dut/w_sw_ack
add wave -noupdate -color Cyan -itemcolor Cyan /rsa_top_tb/dut/rsa_power_control_0/iso_en
add wave -noupdate -color Cyan -itemcolor Cyan /rsa_top_tb/dut/rsa_power_control_0/reset_on_enable
add wave -noupdate /rsa_top_tb/dut/rsa_power_control_0/sw_disable
add wave -noupdate -expand -group rsa_power_control_0 /rsa_top_tb/dut/rsa_power_control_0/clk
add wave -noupdate -expand -group rsa_power_control_0 /rsa_top_tb/dut/rsa_power_control_0/ce
add wave -noupdate -expand -group rsa_power_control_0 /rsa_top_tb/dut/rsa_power_control_0/rst
add wave -noupdate -expand -group rsa_power_control_0 /rsa_top_tb/dut/rsa_power_control_0/req_enable
add wave -noupdate -expand -group rsa_power_control_0 /rsa_top_tb/dut/rsa_power_control_0/req_disable
add wave -noupdate -expand -group rsa_power_control_0 -color Magenta -itemcolor Magenta /rsa_top_tb/dut/rsa_power_control_0/sw_ack
add wave -noupdate -expand -group rsa_power_control_0 /rsa_top_tb/dut/rsa_power_control_0/outputs_force_zero
add wave -noupdate -expand -group rsa_power_control_0 -color Cyan -itemcolor Cyan /rsa_top_tb/dut/rsa_power_control_0/iso_en
add wave -noupdate -expand -group rsa_power_control_0 /rsa_top_tb/dut/rsa_power_control_0/sw_disable
add wave -noupdate -expand -group rsa_power_control_0 -color Cyan -itemcolor Cyan /rsa_top_tb/dut/rsa_power_control_0/reset_on_enable
add wave -noupdate -expand -group rsa_power_control_0 /rsa_top_tb/dut/rsa_power_control_0/mode_change_ack
add wave -noupdate -expand -group rsa_power_control_0 /rsa_top_tb/dut/rsa_power_control_0/present_state
add wave -noupdate -expand -group rsa_power_control_0 /rsa_top_tb/dut/rsa_power_control_0/next_state
add wave -noupdate -divider mod_exp_0
add wave -noupdate -radix unsigned /rsa_top_tb/dut/mod_exp_0/DATA_WIDTH
add wave -noupdate /rsa_top_tb/dut/mod_exp_0/clk
add wave -noupdate /rsa_top_tb/dut/mod_exp_0/ce
add wave -noupdate -color Cyan -itemcolor Cyan /rsa_top_tb/dut/mod_exp_0/rst
add wave -noupdate /rsa_top_tb/dut/mod_exp_0/start
add wave -noupdate -radix unsigned /rsa_top_tb/dut/mod_exp_0/c
add wave -noupdate -radix unsigned /rsa_top_tb/dut/mod_exp_0/d
add wave -noupdate -radix unsigned /rsa_top_tb/dut/mod_exp_0/t_sub_1
add wave -noupdate -radix unsigned /rsa_top_tb/dut/mod_exp_0/r2_mod_n
add wave -noupdate -radix unsigned /rsa_top_tb/dut/mod_exp_0/n
add wave -noupdate -divider <NULL>
add wave -noupdate -expand -group Isolated /rsa_top_tb/dut/mod_exp_0/ready
add wave -noupdate -expand -group Isolated /rsa_top_tb/dut/ready_UPF_ISO
add wave -noupdate -expand -group Isolated -radix unsigned /rsa_top_tb/dut/mod_exp_0/m
add wave -noupdate -expand -group Isolated -radix unsigned /rsa_top_tb/dut/m_UPF_ISO
add wave -noupdate -expand -group Isolated /rsa_top_tb/dut/mod_exp_0/done
add wave -noupdate -expand -group Isolated /rsa_top_tb/dut/done_UPF_ISO
add wave -noupdate -divider <NULL>
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/DATA_WIDTH
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/K
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/clk
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/ce
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/rst
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/start
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/c
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/d
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/t_sub_1
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/r2_mod_n
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/n
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/ready
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/m
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/done
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/r_ready
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/set_ready
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/r_c
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/r_t_sub_1
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/r_r2_mod_n
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/r_n
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/inc
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/cnt
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/r_d
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/r_d_0
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/a0_r
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/a1_r
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/b0_r
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/b1_r
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/s0_r
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/s1_r
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/start_r
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/ready_next_r
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/ready_next_prev_r
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/ready_next_3prev_r
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/a0_p
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/a1_p
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/b0_p
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/b1_p
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/s0_p
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/s1_p
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/start_p
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/ready_next_p
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/ready_next_prev_p
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/ready_next_3prev_p
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/commutation_config
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/start_final_addition
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/d1_start_final_addition
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/d2_start_final_addition
add wave -noupdate -expand -group mod_exp_0 /rsa_top_tb/dut/mod_exp_0/mod_exp_0/r_n_prev
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9839674 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 403
configure wave -valuecolwidth 119
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {10500 ns}
