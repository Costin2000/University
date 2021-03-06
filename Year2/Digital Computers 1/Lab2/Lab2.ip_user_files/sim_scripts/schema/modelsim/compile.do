vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr \
"../../../bd/schema/ip/schema_numarator_59_0_2/sim/schema_numarator_59_0_2.v" \
"../../../bd/schema/ip/schema_PoartaOr_0_2/sim/schema_PoartaOr_0_2.v" \
"../../../bd/schema/ip/schema_PoartaAnd_0_2/sim/schema_PoartaAnd_0_2.v" \
"../../../bd/schema/ip/schema_numarator_59_1_1/sim/schema_numarator_59_1_1.v" \
"../../../bd/schema/ip/schema_bin2bcd_0_1/sim/schema_bin2bcd_0_1.v" \
"../../../bd/schema/ip/schema_bin2bcd_1_1/sim/schema_bin2bcd_1_1.v" \
"../../../bd/schema/sim/schema.v" \


vlog -work xil_defaultlib \
"glbl.v"

