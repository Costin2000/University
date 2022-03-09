vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/automat_V1/sim/automat_V1.v" \
"../../../bd/automat_V1/ip/automat_V1_automat_0_0_1/sim/automat_V1_automat_0_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

