vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  \
"../../../bd/Schema/ip/Schema_Automat_0_0/sim/Schema_Automat_0_0.v" \
"../../../bd/Schema/sim/Schema.v" \


vlog -work xil_defaultlib \
"glbl.v"

