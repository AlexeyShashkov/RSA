onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /bit_comp_tb/DATA_WIDTH
add wave -noupdate /bit_comp_tb/dut/clk
add wave -noupdate /bit_comp_tb/dut/ce
add wave -noupdate /bit_comp_tb/dut/rst
add wave -noupdate /bit_comp_tb/dut/start_cmp
add wave -noupdate -radix binary /bit_comp_tb/dut/in0
add wave -noupdate -radix binary /bit_comp_tb/dut/in1
add wave -noupdate -color Cyan -itemcolor Cyan /bit_comp_tb/dut/done_cmp
add wave -noupdate -color Cyan -itemcolor Cyan /bit_comp_tb/dut/are_equal
add wave -noupdate -radix binary /bit_comp_tb/dut/r_in0
add wave -noupdate -radix binary /bit_comp_tb/dut/r_in1
add wave -noupdate /bit_comp_tb/dut/r_done_cmp
add wave -noupdate /bit_comp_tb/dut/bits_are_equal
add wave -noupdate /bit_comp_tb/dut/is_working
add wave -noupdate -radix unsigned /bit_comp_tb/dut/cnt
add wave -noupdate /bit_comp_tb/dut/r_are_equal
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {317315 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 219
configure wave -valuecolwidth 94
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
WaveRestoreZoom {0 ps} {420 ns}
