vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_0_0/sim/design_1_sumator_complet_1bit_0_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_1_0/sim/design_1_sumator_complet_1bit_1_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_2_0/sim/design_1_sumator_complet_1bit_2_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_3_0/sim/design_1_sumator_complet_1bit_3_0.v" \
"../../../bd/design_1/ip/design_1_modul_concatenare_0_0/sim/design_1_modul_concatenare_0_0.v" \
"../../../bd/design_1/ip/design_1_UAT_0_0/sim/design_1_UAT_0_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_4_0/sim/design_1_sumator_complet_1bit_4_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_5_0/sim/design_1_sumator_complet_1bit_5_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_6_0/sim/design_1_sumator_complet_1bit_6_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_7_0/sim/design_1_sumator_complet_1bit_7_0.v" \
"../../../bd/design_1/ip/design_1_modul_concatenare_1_0/sim/design_1_modul_concatenare_1_0.v" \
"../../../bd/design_1/ip/design_1_UAT_1_0/sim/design_1_UAT_1_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_8_0/sim/design_1_sumator_complet_1bit_8_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_9_0/sim/design_1_sumator_complet_1bit_9_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_10_0/sim/design_1_sumator_complet_1bit_10_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_11_0/sim/design_1_sumator_complet_1bit_11_0.v" \
"../../../bd/design_1/ip/design_1_modul_concatenare_2_0/sim/design_1_modul_concatenare_2_0.v" \
"../../../bd/design_1/ip/design_1_UAT_2_0/sim/design_1_UAT_2_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_12_0/sim/design_1_sumator_complet_1bit_12_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_13_0/sim/design_1_sumator_complet_1bit_13_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_14_0/sim/design_1_sumator_complet_1bit_14_0.v" \
"../../../bd/design_1/ip/design_1_sumator_complet_1bit_15_0/sim/design_1_sumator_complet_1bit_15_0.v" \
"../../../bd/design_1/ip/design_1_modul_concatenare_3_0/sim/design_1_modul_concatenare_3_0.v" \
"../../../bd/design_1/ip/design_1_UAT_3_0/sim/design_1_UAT_3_0.v" \
"../../../bd/design_1/ip/design_1_extragere_0_0/sim/design_1_extragere_0_0.v" \
"../../../bd/design_1/ip/design_1_extragere_1_0/sim/design_1_extragere_1_0.v" \
"../../../bd/design_1/ip/design_1_GUAT_0_0/sim/design_1_GUAT_0_0.v" \
"../../../bd/design_1/ip/design_1_extragere_GUAT_0_0/sim/design_1_extragere_GUAT_0_0.v" \
"../../../bd/design_1/ip/design_1_intrare_0_1/sim/design_1_intrare_0_1.v" \
"../../../bd/design_1/ip/design_1_intrare_c_in_0_0/sim/design_1_intrare_c_in_0_0.v" \
"../../../bd/design_1/ip/design_1_concatenare_uat_0_0/sim/design_1_concatenare_uat_0_0.v" \
"../../../bd/design_1/ip/design_1_split_UAT_0_0/sim/design_1_split_UAT_0_0.v" \
"../../../bd/design_1/ip/design_1_split_UAT_1_0/sim/design_1_split_UAT_1_0.v" \
"../../../bd/design_1/ip/design_1_split_UAT_2_0/sim/design_1_split_UAT_2_0.v" \
"../../../bd/design_1/ip/design_1_split_UAT_3_0/sim/design_1_split_UAT_3_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

