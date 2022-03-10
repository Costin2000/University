onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+schema -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.schema xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {schema.udo}

run -all

endsim

quit -force
