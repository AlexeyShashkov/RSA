onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/K
add wave -noupdate /csa_5_to_2_div_2_tb/dut/clk
add wave -noupdate /csa_5_to_2_div_2_tb/dut/ce
add wave -noupdate /csa_5_to_2_div_2_tb/dut/rst
add wave -noupdate /csa_5_to_2_div_2_tb/dut/clr
add wave -noupdate /csa_5_to_2_div_2_tb/dut/en
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/x1
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/x2
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/x3
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/x4
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/x5
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/s0
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/s1
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/csa_0_s
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/csa_0_c
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/csa_1_x4
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/csa_1_s
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/csa_1_c
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/csa_2_x5
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/csa_2_s
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/csa_2_c
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/r_s0
add wave -noupdate -radix unsigned /csa_5_to_2_div_2_tb/dut/r_s1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {192595 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 237
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
WaveRestoreZoom {0 ps} {420 ns}
