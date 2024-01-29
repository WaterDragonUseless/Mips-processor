transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/full_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/carry_select_adder_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/rippe_carry_adder_16bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/comparator.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/adder_subtractor.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/and_gate.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/or_gate.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/arithmetic_right_shift.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/logical_left_shift.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/register_32bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/decoder_5to32.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/processor.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/skeleton.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/dffe.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/clk_div4.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/dmem.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/imem.v}
vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/ripple_carry_adder_32bit.v}

vlog -vlog01compat -work work +incdir+C:/Users/lenovo/Desktop/DEC.2\ yt210 {C:/Users/lenovo/Desktop/DEC.2 yt210/skeleton_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  skeleton_tb

add wave *
view structure
view signals
run -all
