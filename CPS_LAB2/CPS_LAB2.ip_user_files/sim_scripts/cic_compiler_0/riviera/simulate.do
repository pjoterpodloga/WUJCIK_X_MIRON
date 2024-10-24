onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+cic_compiler_0 -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L cic_compiler_v4_0_14 -L xil_defaultlib -L secureip -O5 xil_defaultlib.cic_compiler_0

do {wave.do}

view wave
view structure

do {cic_compiler_0.udo}

run -all

endsim

quit -force
