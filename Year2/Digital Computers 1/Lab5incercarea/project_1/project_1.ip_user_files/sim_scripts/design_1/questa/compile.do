vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  \
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

