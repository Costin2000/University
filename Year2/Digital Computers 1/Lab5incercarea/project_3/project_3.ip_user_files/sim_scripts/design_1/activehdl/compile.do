vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/design_1/ip/design_1_concatMantise_0_0/sim/design_1_concatMantise_0_0.v" \
"../../../bd/design_1/ip/design_1_concatExp_0_0/sim/design_1_concatExp_0_0.v" \
"../../../bd/design_1/ip/design_1_reg47_0_0/sim/design_1_reg47_0_0.v" \
"../../../bd/design_1/ip/design_1_reg16_0_0/sim/design_1_reg16_0_0.v" \
"../../../bd/design_1/ip/design_1_M1_0_0/sim/design_1_M1_0_0.v" \
"../../../bd/design_1/ip/design_1_M7_0_0/sim/design_1_M7_0_0.v" \
"../../../bd/design_1/ip/design_1_reg56_0_0/sim/design_1_reg56_0_0.v" \
"../../../bd/design_1/ip/design_1_reg16_1_0/sim/design_1_reg16_1_0.v" \
"../../../bd/design_1/ip/design_1_M4_0_0/sim/design_1_M4_0_0.v" \
"../../../bd/design_1/ip/design_1_M2_0_0/sim/design_1_M2_0_0.v" \
"../../../bd/design_1/ip/design_1_reg47_1_0/sim/design_1_reg47_1_0.v" \
"../../../bd/design_1/ip/design_1_reg7_0_0/sim/design_1_reg7_0_0.v" \
"../../../bd/design_1/ip/design_1_M5_0_1/sim/design_1_M5_0_1.v" \
"../../../bd/design_1/ip/design_1_reg25_0_0/sim/design_1_reg25_0_0.v" \
"../../../bd/design_1/ip/design_1_reg7_1_0/sim/design_1_reg7_1_0.v" \
"../../../bd/design_1/ip/design_1_M6_0_0/sim/design_1_M6_0_0.v" \
"../../../bd/design_1/ip/design_1_M3_0_0/sim/design_1_M3_0_0.v" \
"../../../bd/design_1/ip/design_1_reg23_0_0/sim/design_1_reg23_0_0.v" \
"../../../bd/design_1/ip/design_1_reg7_2_0/sim/design_1_reg7_2_0.v" \
"../../../bd/design_1/sim/design_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

