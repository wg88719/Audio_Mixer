/**
 * =====================================================================================
 *
 *       Filename:  filter_control.h
 *
 *    Description:  Filter control functions
 *
 *        Version:  1.0
 *        Created:  15/05/16 14:28:44
 *       Revision:  none
 *       Compiler:  arm-xilinx-linux-gnueabi-gcc
 *
 *         Author:  Harsha Chaitanya Manam
 *   Organization:  FOSS
 *
 * =====================================================================================
 */

#ifndef FILTER_CONTROL_H
#define FILTER_CONTROL_H

#include "reg_io.h"

/**
 * =======================================================
 * Structure to hold the filter coefficients
 * =======================================================
 */
typedef struct _filter_coefficients {
	unsigned int coefficients[15];
}filter_coefficients;


/**
 * =======================================================
 * Function to set the filter coefficients
 * @param		: filter_base					: filter base address
 * @param		: filter_coefficients	: filter coefficients
 *           												structure
 * @return	: 0 upon successfun initialization
 *           -1 otherwise
 * =======================================================
 */
int set_coefficients (void *filter_base, filter_coefficients coefficients);

/**
 * =======================================================
 * Function to set the filter type
 * @param		: filter_base	: filter base address
 * @param		: FILTER_TYPE	: Type of the filter
 * @param		: enable			: Enable/Disable filter
 * @return	: 0 upon successfun initialization
 *           -1 otherwise
 * =======================================================
 */
int set_filter_type (void *filter_base, FILTER_TYPE type, unsigned int enable);

#endif //FILTER_CONTROL_H
