vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr \
"../../../bd/Schema/ip/Schema_Automat_0_0/sim/Schema_Automat_0_0.v" \
"../../../bd/Schema/sim/Schema.v" \


vlog -work xil_defaultlib \
"glbl.v"

