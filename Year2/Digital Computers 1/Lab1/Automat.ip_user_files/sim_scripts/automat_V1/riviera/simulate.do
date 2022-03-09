onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+automat_V1 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.automat_V1 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {automat_V1.udo}

run -all

endsim

quit -force
