onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib ceas_figure_opt

do {wave.do}

view wave
view structure
view signals

do {ceas_figure.udo}

run -all

quit -force
