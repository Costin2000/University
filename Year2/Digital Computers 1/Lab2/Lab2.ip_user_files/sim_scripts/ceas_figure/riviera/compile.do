vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/ceas_figure/ip/ceas_figure_pOR_0_0/sim/ceas_figure_pOR_0_0.v" \
"../../../bd/ceas_figure/ip/ceas_figure_pAND_0_0/sim/ceas_figure_pAND_0_0.v" \
"../../../bd/ceas_figure/ip/ceas_figure_bin2bcd_0_1/sim/ceas_figure_bin2bcd_0_1.v" \
"../../../bd/ceas_figure/ip/ceas_figure_bin2bcd_1_1/sim/ceas_figure_bin2bcd_1_1.v" \
"../../../bd/ceas_figure/ip/ceas_figure_numarator_59_0_1/sim/ceas_figure_numarator_59_0_1.v" \
"../../../bd/ceas_figure/ip/ceas_figure_numarator_59_1_1/sim/ceas_figure_numarator_59_1_1.v" \
"../../../bd/ceas_figure/sim/ceas_figure.v" \


vlog -work xil_defaultlib \
"glbl.v"

