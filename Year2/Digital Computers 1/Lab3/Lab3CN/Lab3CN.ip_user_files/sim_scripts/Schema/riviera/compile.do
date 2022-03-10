vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/Schema/ip/Schema_Automat_0_0/sim/Schema_Automat_0_0.v" \
"../../../bd/Schema/sim/Schema.v" \


vlog -work xil_defaultlib \
"glbl.v"

