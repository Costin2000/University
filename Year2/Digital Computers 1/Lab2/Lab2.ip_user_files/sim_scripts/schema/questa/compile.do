vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  \
"../../../bd/schema/ip/schema_numarator_59_0_2/sim/schema_numarator_59_0_2.v" \
"../../../bd/schema/ip/schema_PoartaOr_0_2/sim/schema_PoartaOr_0_2.v" \
"../../../bd/schema/ip/schema_PoartaAnd_0_2/sim/schema_PoartaAnd_0_2.v" \
"../../../bd/schema/ip/schema_numarator_59_1_1/sim/schema_numarator_59_1_1.v" \
"../../../bd/schema/ip/schema_bin2bcd_0_1/sim/schema_bin2bcd_0_1.v" \
"../../../bd/schema/ip/schema_bin2bcd_1_1/sim/schema_bin2bcd_1_1.v" \
"../../../bd/schema/sim/schema.v" \


vlog -work xil_defaultlib \
"glbl.v"

