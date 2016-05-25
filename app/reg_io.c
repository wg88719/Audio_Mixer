/**
 * =====================================================================================
 *
 *       Filename:  reg_io.c
 *
 *    Description:  Register read write helper macros and functions
 *    				with register offset definitions.
 *
 *        Version:  1.0
 *        Created:  15/05/16 05:38:25
 *       Revision:  none
 *       Compiler:  arm-xilinx-linux-gnueabi-gcc
 *
 *         Author:  Harsha Chaitanya Manam
 *   Organization:  FOSS
 *
 * =====================================================================================
 */

#include "include/reg_io.h"


/**
 * =======================================================
 * Function to open the device file and map the register
 * area in to user accessible address space
 *
 * @Param	: device_file_name	: String specifies the
 * 			  											name of the device file
 *
 * @Return	: Returns the pointer to the mapped
 * 			  		Base address of the device file
 *
 * =======================================================
 */
void* map_device (const char *device_file_name) {

	int dev_fd = -1;
	void *base_address;

	if (device_file_name == NULL) {
		fprintf (stderr, "map_device: NULL Pointer argument :%s\n", device_file_name);
		return NULL;
	}

	dev_fd = open (device_file_name, O_RDWR);
	if (dev_fd < 1) {
		perror(device_file_name); return NULL;
	}

	base_address = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, dev_fd, 0);

	return base_address;
}

/**
 * =======================================================
 * Function to unmap the register map from user space
 *
 * @Param	: pointer to the base address of the
 * 			  	mapped area.
 *
 * @Return	: None
 *
 * =======================================================
 */
void unmap_device (void *device_base) {

	munmap(device_base, PAGE_SIZE);
}
