
CC = $(CROSS_COMPILE)gcc
INSTALL_DIR = /media/harsha/ZED_BOOT/
IDIR = ./include
CFLAGS = -I$(IDIR) --std=gnu99 -O0
LIBS = -lrt -lpthread
OBJS = reg_io.o udpclient.o stream_control.o volume_control.o filter_control.o ui_control.o app_main.o

audio_mixer : $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LIBS) -o audio_mixer

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf *.o audio_mixer

install:
	cp audio_mixer $(INSTALL_DIR)
