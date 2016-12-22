onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /mont_mult_tb/K
add wave -noupdate /mont_mult_tb/clk
add wave -noupdate /mont_mult_tb/ce
add wave -noupdate /mont_mult_tb/rst
add wave -noupdate /mont_mult_tb/start
add wave -noupdate /mont_mult_tb/ready_next
add wave -noupdate /mont_mult_tb/ready_next_prev
add wave -noupdate /mont_mult_tb/ready_next_3prev
add wave -noupdate -radix unsigned /mont_mult_tb/a0
add wave -noupdate -radix unsigned /mont_mult_tb/a1
add wave -noupdate -radix unsigned /mont_mult_tb/b0
add wave -noupdate -radix unsigned /mont_mult_tb/b1
add wave -noupdate -radix unsigned /mont_mult_tb/n
add wave -noupdate -radix unsigned /mont_mult_tb/s0
add wave -noupdate -radix unsigned /mont_mult_tb/s1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {249832 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 217
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
WaveRestoreZoom {0 ps} {525 ns}
