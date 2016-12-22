onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /counter_to_t_sub_1_tb/DATA_WIDTH
add wave -noupdate /counter_to_t_sub_1_tb/dut/clk
add wave -noupdate /counter_to_t_sub_1_tb/dut/ce
add wave -noupdate /counter_to_t_sub_1_tb/dut/rst
add wave -noupdate /counter_to_t_sub_1_tb/dut/inc
add wave -noupdate -radix unsigned /counter_to_t_sub_1_tb/dut/t_sub_1
add wave -noupdate -radix unsigned /counter_to_t_sub_1_tb/dut/o_cnt
add wave -noupdate -radix unsigned /counter_to_t_sub_1_tb/dut/cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {380884 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 239
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
WaveRestoreZoom {0 ps} {840 ns}
