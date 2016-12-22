onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Power
add wave -noupdate -radix unsigned /rsa_top_tb/dut/gnd_n
add wave -noupdate -radix unsigned /rsa_top_tb/dut/vdd_n
add wave -noupdate /rsa_top_tb/dut/req_disable
add wave -noupdate /rsa_top_tb/dut/req_enable
add wave -noupdate -color Cyan -itemcolor Cyan -radix unsigned /rsa_top_tb/dut/sw_vdd_n
add wave -noupdate -color {Medium Aquamarine} -itemcolor {Medium Aquamarine} -radix unsigned /rsa_top_tb/dut/PD_sw
add wave -noupdate -color {Medium Aquamarine} -itemcolor {Medium Aquamarine} -radix unsigned /rsa_top_tb/dut/PD_top
add wave -noupdate -divider rsa_top_tb
add wave -noupdate -radix unsigned /rsa_top_tb/dut/c
add wave -noupdate -radix unsigned /rsa_top_tb/dut/d
add wave -noupdate -radix unsigned /rsa_top_tb/dut/t_sub_1
add wave -noupdate -radix unsigned /rsa_top_tb/dut/r2_mod_n
add wave -noupdate -radix unsigned /rsa_top_tb/dut/n
add wave -noupdate -color Coral -itemcolor Coral /rsa_top_tb/dut/start
add wave -noupdate -color Coral -itemcolor Coral /rsa_top_tb/ready
add wave -noupdate -color Coral -itemcolor Coral -radix unsigned /rsa_top_tb/m
add wave -noupdate -color Coral -itemcolor Coral /rsa_top_tb/done
add wave -noupdate -divider dut
add wave -noupdate -color {Medium Aquamarine} -itemcolor {Medium Aquamarine} -radix unsigned /rsa_top_tb/dut/PD_sw
add wave -noupdate -color {Medium Aquamarine} -itemcolor {Medium Aquamarine} /rsa_top_tb/dut/srcSimState_1
add wave -noupdate -color {Medium Aquamarine} -itemcolor {Medium Aquamarine} /rsa_top_tb/dut/sinkSimState_1
add wave -noupdate -color {Medium Aquamarine} -itemcolor {Medium Aquamarine} /rsa_top_tb/dut/iso_needed_cntr_1
add wave -noupdate -color {Medium Aquamarine} -itemcolor {Medium Aquamarine} /rsa_top_tb/dut/ira_monitor_1
add wave -noupdate -color {Medium Aquamarine} -itemcolor {Medium Aquamarine} /rsa_top_tb/dut/iso_needed_1
add wave -noupdate -expand -group Isolation /rsa_top_tb/dut/pa_iniso_1
add wave -noupdate -expand -group Isolation /rsa_top_tb/dut/pa_outiso_1_1
add wave -noupdate -expand -group Isolation /rsa_top_tb/dut/w2_ready
add wave -noupdate -expand -group Isolation -radix unsigned /rsa_top_tb/dut/pa_iniso_2
add wave -noupdate -expand -group Isolation -radix unsigned /rsa_top_tb/dut/pa_outiso_2_1
add wave -noupdate -expand -group Isolation -radix unsigned /rsa_top_tb/dut/w2_m
add wave -noupdate -expand -group Isolation /rsa_top_tb/dut/pa_iniso_3
add wave -noupdate -expand -group Isolation /rsa_top_tb/dut/pa_outiso_3_1
add wave -noupdate -expand -group Isolation /rsa_top_tb/dut/w2_done
add wave -noupdate -radix unsigned /rsa_top_tb/dut/DATA_WIDTH
add wave -noupdate /rsa_top_tb/dut/clk
add wave -noupdate /rsa_top_tb/dut/ce
add wave -noupdate /rsa_top_tb/dut/rst
add wave -noupdate /rsa_top_tb/dut/req_enable
add wave -noupdate /rsa_top_tb/dut/req_disable
add wave -noupdate -color Cyan -itemcolor Cyan /rsa_top_tb/dut/start
add wave -noupdate -radix unsigned /rsa_top_tb/dut/c
add wave -noupdate -radix unsigned /rsa_top_tb/dut/d
add wave -noupdate -radix unsigned /rsa_top_tb/dut/t_sub_1
add wave -noupdate -radix unsigned /rsa_top_tb/dut/r2_mod_n
add wave -noupdate -radix unsigned /rsa_top_tb/dut/n
add wave -noupdate -color Cyan -itemcolor Cyan /rsa_top_tb/dut/ready
add wave -noupdate -color Cyan -itemcolor Cyan -radix unsigned /rsa_top_tb/dut/m
add wave -noupdate -color Cyan -itemcolor Cyan /rsa_top_tb/dut/done
add wave -noupdate /rsa_top_tb/dut/clk_enable_latch
add wave -noupdate /rsa_top_tb/dut/clk_disable
add wave -noupdate /rsa_top_tb/dut/clk_gated
add wave -noupdate /rsa_top_tb/dut/w_iso_en
add wave -noupdate /rsa_top_tb/dut/w_sw_disable
add wave -noupdate /rsa_top_tb/dut/w_sw_ack
add wave -noupdate /rsa_top_tb/dut/d2_w_sw_ack
add wave -noupdate /rsa_top_tb/dut/w_outputs_force_zero
add wave -noupdate /rsa_top_tb/dut/w_mode_change_ack
add wave -noupdate /rsa_top_tb/dut/reset_on_enable
add wave -noupdate /rsa_top_tb/dut/w_ready
add wave -noupdate -radix unsigned /rsa_top_tb/dut/w_m
add wave -noupdate /rsa_top_tb/dut/w_done
add wave -noupdate /rsa_top_tb/dut/power_enabled
add wave -noupdate -radix unsigned /rsa_top_tb/dut/GND
add wave -noupdate -radix unsigned /rsa_top_tb/dut/VDD
add wave -noupdate -radix unsigned /rsa_top_tb/dut/sw_vdd_n
add wave -noupdate -radix unsigned /rsa_top_tb/dut/gnd_n
add wave -noupdate -radix unsigned /rsa_top_tb/dut/vdd_n
add wave -noupdate -radix unsigned /rsa_top_tb/dut/sw_pwr_ss
add wave -noupdate -radix unsigned /rsa_top_tb/dut/pwr_ss
add wave -noupdate -radix unsigned /rsa_top_tb/dut/PD_sw
add wave -noupdate -radix unsigned /rsa_top_tb/dut/PD_top
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9903326 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 248
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
