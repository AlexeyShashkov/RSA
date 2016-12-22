onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /bit_shift_adder_tb/DATA_WIDTH
add wave -noupdate /bit_shift_adder_tb/dut/clk
add wave -noupdate /bit_shift_adder_tb/dut/ce
add wave -noupdate /bit_shift_adder_tb/dut/rst
add wave -noupdate /bit_shift_adder_tb/dut/en
add wave -noupdate /bit_shift_adder_tb/dut/load
add wave -noupdate -radix binary /bit_shift_adder_tb/dut/a0
add wave -noupdate -radix binary /bit_shift_adder_tb/dut/a1
add wave -noupdate /bit_shift_adder_tb/dut/a_i
add wave -noupdate -radix binary /bit_shift_adder_tb/dut/r_a0
add wave -noupdate -radix binary /bit_shift_adder_tb/dut/r_a1
add wave -noupdate -radix binary /bit_shift_adder_tb/dut/fa
add wave -noupdate /bit_shift_adder_tb/dut/r_c
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {371283 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 231
configure wave -valuecolwidth 90
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
WaveRestoreZoom {0 ps} {416924 ps}
