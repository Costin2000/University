vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/Schema/ip/Schema_Automat_0_0/sim/Schema_Automat_0_0.v" \
"../../../bd/Schema/sim/Schema.v" \


vlog -work xil_defaultlib \
"glbl.v"

