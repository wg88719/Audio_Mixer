obj-m += uio_pdrv_genirq.o

CC=$(CROSS_COMPILE)gcc
PROJ_HOME=/home/harsha/work/Zynq/workspace/
KDIR=$(PROJ_HOME)linux/digilent/
INSTALL_DIR = /media/harsha/ZED_BOOT/

all:
	make -C $(KDIR) M=$(PWD) modules

clean:
	make -C $(KDIR) M=$(PWD) clean

install:
	cp uio_pdrv_genirq.ko $(INSTALL_DIR)
