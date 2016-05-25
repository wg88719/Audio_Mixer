
PROJ_HOME=/home/harsha/work/Zynq/workspace/
DTC=$(PROJ_HOME)linux/digilent/scripts/dtc/dtc

all:
	$(DTC) -I dts -O dtb -o $(PROJ_HOME)sd-image/devicetree.dtb devicetree.dts

clean:
	rm -rf ../../sd-image/devicetree.dtb
