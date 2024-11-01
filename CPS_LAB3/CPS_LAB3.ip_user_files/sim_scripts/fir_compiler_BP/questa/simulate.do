onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib fir_compiler_BP_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {fir_compiler_BP.udo}

run 1000ns

quit -force
