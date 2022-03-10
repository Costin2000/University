onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+Schema -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Schema xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {Schema.udo}

run -all

endsim

quit -force
