vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr \
"../../../bd/schema/ip/schema_orGate_0_0/sim/schema_orGate_0_0.v" \
"../../../bd/schema/ip/schema_registruTampon_0_0/sim/schema_registruTampon_0_0.v" \
"../../../bd/schema/ip/schema_registruTampon_1_0/sim/schema_registruTampon_1_0.v" \
"../../../bd/schema/ip/schema_orGate_1_0/sim/schema_orGate_1_0.v" \
"../../../bd/schema/ip/schema_registruTampon_2_0/sim/schema_registruTampon_2_0.v" \
"../../../bd/schema/ip/schema_registruTampon_3_0/sim/schema_registruTampon_3_0.v" \
"../../../bd/schema/ip/schema_orGate_2_0/sim/schema_orGate_2_0.v" \
"../../../bd/schema/ip/schema_registruTampon_4_0/sim/schema_registruTampon_4_0.v" \
"../../../bd/schema/sim/schema.v" \


vlog -work xil_defaultlib \
"glbl.v"

