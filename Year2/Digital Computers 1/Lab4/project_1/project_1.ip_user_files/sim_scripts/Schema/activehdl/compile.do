vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/Schema/ip/Schema_Convertor2_32_0_0/sim/Schema_Convertor2_32_0_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_0_0/sim/Schema_sumator_complet_1bit_0_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_1_0/sim/Schema_sumator_complet_1bit_1_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_2_0/sim/Schema_sumator_complet_1bit_2_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_3_0/sim/Schema_sumator_complet_1bit_3_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_4_0/sim/Schema_sumator_complet_1bit_4_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_5_0/sim/Schema_sumator_complet_1bit_5_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_6_0/sim/Schema_sumator_complet_1bit_6_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_7_0/sim/Schema_sumator_complet_1bit_7_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_8_0/sim/Schema_sumator_complet_1bit_8_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_9_0/sim/Schema_sumator_complet_1bit_9_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_10_0/sim/Schema_sumator_complet_1bit_10_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_11_0/sim/Schema_sumator_complet_1bit_11_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_12_0/sim/Schema_sumator_complet_1bit_12_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_13_0/sim/Schema_sumator_complet_1bit_13_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_14_0/sim/Schema_sumator_complet_1bit_14_0.v" \
"../../../bd/Schema/ip/Schema_sumator_complet_1bit_15_0/sim/Schema_sumator_complet_1bit_15_0.v" \
"../../../bd/Schema/ip/Schema_UAT_0_0/sim/Schema_UAT_0_0.v" \
"../../../bd/Schema/ip/Schema_UAT_1_0/sim/Schema_UAT_1_0.v" \
"../../../bd/Schema/ip/Schema_UAT_2_0/sim/Schema_UAT_2_0.v" \
"../../../bd/Schema/ip/Schema_UAT_3_0/sim/Schema_UAT_3_0.v" \
"../../../bd/Schema/ip/Schema_Convertor4_1_0_0/sim/Schema_Convertor4_1_0_0.v" \
"../../../bd/Schema/ip/Schema_Convertor4_1_1_0/sim/Schema_Convertor4_1_1_0.v" \
"../../../bd/Schema/ip/Schema_Convertor4_1_2_0/sim/Schema_Convertor4_1_2_0.v" \
"../../../bd/Schema/ip/Schema_Convertor4_1_3_0/sim/Schema_Convertor4_1_3_0.v" \
"../../../bd/Schema/ip/Schema_Convertor4_1_4_0/sim/Schema_Convertor4_1_4_0.v" \
"../../../bd/Schema/ip/Schema_Convertor4_1_5_0/sim/Schema_Convertor4_1_5_0.v" \
"../../../bd/Schema/ip/Schema_Convertor4_1_6_0/sim/Schema_Convertor4_1_6_0.v" \
"../../../bd/Schema/ip/Schema_Convertor4_1_7_0/sim/Schema_Convertor4_1_7_0.v" \
"../../../bd/Schema/ip/Schema_GUAT_0_0/sim/Schema_GUAT_0_0.v" \
"../../../bd/Schema/ip/Schema_Convertor1_4_0_0/sim/Schema_Convertor1_4_0_0.v" \
"../../../bd/Schema/ip/Schema_Convertor16_1_0_1/sim/Schema_Convertor16_1_0_1.v" \
"../../../bd/Schema/ip/Schema_EliminareBit_0_1/sim/Schema_EliminareBit_0_1.v" \
"../../../bd/Schema/ip/Schema_EliminareBit_1_1/sim/Schema_EliminareBit_1_1.v" \
"../../../bd/Schema/ip/Schema_EliminareBit_2_1/sim/Schema_EliminareBit_2_1.v" \
"../../../bd/Schema/ip/Schema_EliminareBit_3_0/sim/Schema_EliminareBit_3_0.v" \
"../../../bd/Schema/ip/Schema_Convertor4_1_8_0/sim/Schema_Convertor4_1_8_0.v" \
"../../../bd/Schema/ip/Schema_Convertor4_1_9_0/sim/Schema_Convertor4_1_9_0.v" \
"../../../bd/Schema/sim/Schema.v" \


vlog -work xil_defaultlib \
"glbl.v"

