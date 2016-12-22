onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /mod_exp_tb/dut/K
add wave -noupdate /mod_exp_tb/dut/clk
add wave -noupdate /mod_exp_tb/dut/ce
add wave -noupdate /mod_exp_tb/dut/rst
add wave -noupdate -radix unsigned /mod_exp_tb/dut/c
add wave -noupdate -radix unsigned /mod_exp_tb/dut/d
add wave -noupdate -radix unsigned /mod_exp_tb/dut/t_sub_1
add wave -noupdate -radix unsigned /mod_exp_tb/dut/r2_mod_n
add wave -noupdate -radix unsigned /mod_exp_tb/dut/n
add wave -noupdate -color Magenta /mod_exp_tb/dut/start
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb/dut/ready
add wave -noupdate -color Cyan -itemcolor Cyan -radix unsigned /mod_exp_tb/dut/m
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb/dut/done
add wave -noupdate -radix unsigned /mod_exp_tb/dut/r_c
add wave -noupdate -radix unsigned /mod_exp_tb/dut/r_t_sub_1
add wave -noupdate -radix unsigned /mod_exp_tb/dut/r_r2_mod_n
add wave -noupdate -radix unsigned /mod_exp_tb/dut/r_n
add wave -noupdate -radix unsigned /mod_exp_tb/dut/a0_r
add wave -noupdate -radix unsigned /mod_exp_tb/dut/a1_r
add wave -noupdate -radix unsigned /mod_exp_tb/dut/b0_r
add wave -noupdate -radix unsigned /mod_exp_tb/dut/b1_r
add wave -noupdate -color Cyan -itemcolor Cyan -radix unsigned /mod_exp_tb/dut/s0_r
add wave -noupdate -color Cyan -itemcolor Cyan -radix unsigned /mod_exp_tb/dut/s1_r
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb/dut/ready_next_r
add wave -noupdate -color Gold -itemcolor Gold /mod_exp_tb/dut/start_r
add wave -noupdate /mod_exp_tb/dut/ready_next_prev_r
add wave -noupdate -radix unsigned /mod_exp_tb/dut/a0_p
add wave -noupdate -radix unsigned /mod_exp_tb/dut/a1_p
add wave -noupdate -radix unsigned /mod_exp_tb/dut/b0_p
add wave -noupdate -radix unsigned /mod_exp_tb/dut/b1_p
add wave -noupdate -color Cyan -itemcolor Cyan -radix unsigned /mod_exp_tb/dut/s0_p
add wave -noupdate -color Cyan -itemcolor Cyan -radix unsigned /mod_exp_tb/dut/s1_p
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb/dut/ready_next_p
add wave -noupdate -color Gold -itemcolor Gold /mod_exp_tb/dut/start_p
add wave -noupdate -color Gold -itemcolor Gold /mod_exp_tb/dut/inc
add wave -noupdate -radix unsigned /mod_exp_tb/dut/cnt
add wave -noupdate -radix unsigned /mod_exp_tb/dut/r_d
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb/dut/r_d_0
add wave -noupdate -color Gold -itemcolor Gold /mod_exp_tb/dut/start_final_addition
add wave -noupdate -color Gold -itemcolor Gold /mod_exp_tb/dut/set_ready
add wave -noupdate /mod_exp_tb/dut/r_ready
add wave -noupdate -color Gold -itemcolor Gold -radix binary /mod_exp_tb/dut/commutation_config
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6691618 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 245
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {7140 ns}
