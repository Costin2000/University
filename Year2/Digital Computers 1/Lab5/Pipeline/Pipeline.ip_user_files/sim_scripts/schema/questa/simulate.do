onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib schema_opt

do {wave.do}

view wave
view structure
view signals

do {schema.udo}

run -all

quit -force
