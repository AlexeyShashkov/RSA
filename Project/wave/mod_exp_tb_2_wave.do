onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /mod_exp_tb_2/dut/K
add wave -noupdate /mod_exp_tb_2/dut/clk
add wave -noupdate /mod_exp_tb_2/dut/ce
add wave -noupdate /mod_exp_tb_2/dut/rst
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/c
add wave -noupdate -radix unsigned /mod_exp_tb_2/dut/d
add wave -noupdate -radix unsigned /mod_exp_tb_2/dut/t_sub_1
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/r2_mod_n
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/n
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb_2/dut/start
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb_2/dut/ready
add wave -noupdate -color Cyan -itemcolor Cyan -radix hexadecimal /mod_exp_tb_2/dut/m
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb_2/dut/done
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/r_c
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/r_t_sub_1
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/r_r2_mod_n
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/r_n
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/a0_r
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/a1_r
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/b0_r
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/b1_r
add wave -noupdate -color Cyan -itemcolor Cyan -radix hexadecimal /mod_exp_tb_2/dut/s0_r
add wave -noupdate -color Cyan -itemcolor Cyan -radix hexadecimal /mod_exp_tb_2/dut/s1_r
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb_2/dut/ready_next_r
add wave -noupdate /mod_exp_tb_2/dut/start_r
add wave -noupdate /mod_exp_tb_2/dut/ready_next_prev_r
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/a0_p
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/a1_p
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/b0_p
add wave -noupdate -radix hexadecimal /mod_exp_tb_2/dut/b1_p
add wave -noupdate -color Cyan -itemcolor Cyan -radix hexadecimal /mod_exp_tb_2/dut/s0_p
add wave -noupdate -color Cyan -itemcolor Cyan -radix hexadecimal /mod_exp_tb_2/dut/s1_p
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb_2/dut/ready_next_p
add wave -noupdate /mod_exp_tb_2/dut/start_p
add wave -noupdate /mod_exp_tb_2/dut/ready_next_prev_p
add wave -noupdate /mod_exp_tb_2/dut/inc
add wave -noupdate -radix unsigned /mod_exp_tb_2/dut/cnt
add wave -noupdate -radix unsigned /mod_exp_tb_2/dut/r_d
add wave -noupdate /mod_exp_tb_2/dut/r_d_0
add wave -noupdate /mod_exp_tb_2/dut/start_final_addition
add wave -noupdate -color Cyan -itemcolor Cyan /mod_exp_tb_2/dut/set_ready
add wave -noupdate /mod_exp_tb_2/dut/r_ready
add wave -noupdate -radix unsigned /mod_exp_tb_2/dut/commutation_config
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {78388309 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
configure wave -valuecolwidth 130
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
WaveRestoreZoom {0 ps} {84 us}
