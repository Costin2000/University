vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/design_1/ip/design_1_poartaOR_0_0/sim/design_1_poartaOR_0_0.v" \
"../../../bd/design_1/ip/design_1_registruTampon_0_0/sim/design_1_registruTampon_0_0.v" \
"../../../bd/design_1/ip/design_1_registruTampon_1_0/sim/design_1_registruTampon_1_0.v" \
"../../../bd/design_1/ip/design_1_poartaOR_1_0/sim/design_1_poartaOR_1_0.v" \
"../../../bd/design_1/ip/design_1_registruTampon_2_0/sim/design_1_registruTampon_2_0.v" \
"../../../bd/design_1/ip/design_1_registruTampon_3_0/sim/design_1_registruTampon_3_0.v" \
"../../../bd/design_1/ip/design_1_poartaOR_2_0/sim/design_1_poartaOR_2_0.v" \
"../../../bd/design_1/ip/design_1_registruTampon_4_0/sim/design_1_registruTampon_4_0.v" \
"../../../bd/design_1/sim/design_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

