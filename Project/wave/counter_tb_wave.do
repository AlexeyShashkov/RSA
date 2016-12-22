onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /counter_tb/dut/K
add wave -noupdate /counter_tb/dut/clk
add wave -noupdate /counter_tb/dut/ce
add wave -noupdate /counter_tb/dut/rst
add wave -noupdate /counter_tb/dut/restart
add wave -noupdate /counter_tb/dut/active
add wave -noupdate /counter_tb/dut/ready_next
add wave -noupdate /counter_tb/dut/ready_next_prev
add wave -noupdate /counter_tb/dut/ready_next_3prev
add wave -noupdate -radix unsigned /counter_tb/dut/cnt
add wave -noupdate /counter_tb/dut/r_active
add wave -noupdate /counter_tb/dut/r_ready_next
add wave -noupdate /counter_tb/dut/r_ready_next_prev
add wave -noupdate /counter_tb/dut/r_ready_next_3prev
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {574475 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 234
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
WaveRestoreZoom {0 ps} {630 ns}
