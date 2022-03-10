onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib Schema_opt

do {wave.do}

view wave
view structure
view signals

do {Schema.udo}

run -all

quit -force
