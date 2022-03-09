vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../bd/design_1/ip/design_1_ANDGate_0_0/sim/design_1_ANDGate_0_0.v" \
"../../../bd/design_1/ip/design_1_memoryBuffer_0_0/sim/design_1_memoryBuffer_0_0.v" \
"../../../bd/design_1/ip/design_1_memoryBuffer_1_0/sim/design_1_memoryBuffer_1_0.v" \
"../../../bd/design_1/ip/design_1_ANDGate_1_0/sim/design_1_ANDGate_1_0.v" \
"../../../bd/design_1/ip/design_1_memoryBuffer_2_0/sim/design_1_memoryBuffer_2_0.v" \
"../../../bd/design_1/ip/design_1_memoryBuffer_3_0/sim/design_1_memoryBuffer_3_0.v" \
"../../../bd/design_1/ip/design_1_ANDGate_2_0/sim/design_1_ANDGate_2_0.v" \
"../../../bd/design_1/ip/design_1_memoryBuffer_4_0/sim/design_1_memoryBuffer_4_0.v" \
"../../../bd/design_1/sim/design_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

