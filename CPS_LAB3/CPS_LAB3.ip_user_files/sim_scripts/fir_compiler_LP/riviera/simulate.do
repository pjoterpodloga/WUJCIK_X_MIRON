onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+fir_compiler_LP  -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L fir_compiler_v7_2_18 -L xil_defaultlib -L secureip -O5 xil_defaultlib.fir_compiler_LP

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {fir_compiler_LP.udo}

run 1000ns

endsim

quit -force
