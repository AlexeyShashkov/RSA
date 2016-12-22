onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /final_adder_tb/dut/DATA_WIDTH
add wave -noupdate /final_adder_tb/dut/clk
add wave -noupdate /final_adder_tb/dut/ce
add wave -noupdate /final_adder_tb/dut/rst
add wave -noupdate /final_adder_tb/dut/start_final_addition
add wave -noupdate -radix binary /final_adder_tb/dut/s0_r
add wave -noupdate -radix binary /final_adder_tb/dut/s1_r
add wave -noupdate -radix unsigned /final_adder_tb/dut/n
add wave -noupdate /final_adder_tb/dut/done
add wave -noupdate -radix binary /final_adder_tb/dut/m
add wave -noupdate -radix unsigned /final_adder_tb/dut/cnt_addition
add wave -noupdate /final_adder_tb/dut/cnt_addition_continue
add wave -noupdate /final_adder_tb/dut/sum_i
add wave -noupdate -radix binary /final_adder_tb/dut/final_sum
add wave -noupdate /final_adder_tb/dut/addition_done
add wave -noupdate /final_adder_tb/dut/done_cmp
add wave -noupdate /final_adder_tb/dut/are_equal
add wave -noupdate -radix binary /final_adder_tb/dut/m_out
add wave -noupdate /final_adder_tb/dut/r_done
add wave -noupdate -radix binary /final_adder_tb/dut/r_m_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {257318 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 262
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
WaveRestoreZoom {0 ps} {413996 ps}
