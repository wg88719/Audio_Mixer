onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -pli "/media/harsha/HydraDrive/EDA/Vivado/Vivado/2015.4/lib/lnx64.o/libxil_vsim.so" -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_8 -L generic_baseblocks_v2_1_0 -L axi_infrastructure_v1_1_0 -L axi_register_slice_v2_1_7 -L fifo_generator_v13_0_1 -L axi_data_fifo_v2_1_6 -L axi_crossbar_v2_1_8 -L axi_protocol_converter_v2_1_7 -lib xil_defaultlib xil_defaultlib.Audio_Mixer_Design xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {Audio_Mixer_Design.udo}

run -all

quit -force
