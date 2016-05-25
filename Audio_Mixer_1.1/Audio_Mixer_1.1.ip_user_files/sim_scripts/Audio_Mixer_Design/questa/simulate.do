onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -pli "/media/harsha/HydraDrive/EDA/Vivado/Vivado/2015.4/lib/lnx64.o/libxil_vsim.so" -lib xil_defaultlib Audio_Mixer_Design_opt

do {wave.do}

view wave
view structure
view signals

do {Audio_Mixer_Design.udo}

run -all

quit -force
