onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib automat_V1_opt

do {wave.do}

view wave
view structure
view signals

do {automat_V1.udo}

run -all

quit -force
