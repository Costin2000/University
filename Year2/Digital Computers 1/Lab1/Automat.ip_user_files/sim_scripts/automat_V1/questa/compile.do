vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../bd/automat_V1/sim/automat_V1.v" \
"../../../bd/automat_V1/ip/automat_V1_automat_0_0_1/sim/automat_V1_automat_0_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

