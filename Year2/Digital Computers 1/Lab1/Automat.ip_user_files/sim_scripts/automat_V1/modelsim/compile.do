vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../bd/automat_V1/sim/automat_V1.v" \
"../../../bd/automat_V1/ip/automat_V1_automat_0_0_1/sim/automat_V1_automat_0_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

