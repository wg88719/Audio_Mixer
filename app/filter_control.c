/**
 * =====================================================================================
 *
 *       Filename:  filter_control.c
 *
 *    Description:  Filter control functions
 *
 *        Version:  1.0
 *        Created:  15/05/16 14:31:31
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Harsha Chaitanya Manam
 *   Organization:  FOSS
 *
 * =====================================================================================
 */
#include "include/filter_control.h"

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
int set_coefficients (void *filter_base, filter_coefficients coeff) {
  if (filter_base == NULL) {
    return -1;
  }

  WriteReg (filter_base, FILTER_CONTROL_REG15_OFFSET, 1);
  WriteReg (filter_base, FILTER_CONTROL_REG15_OFFSET, 0);

  WriteReg (filter_base, FILTER_CONTROL_REG16_OFFSET, 1 );

  for (int i = 0; i < 15; i++) {

    WriteReg (filter_base, (i*4), coeff.coefficients[i]);
  }
  WriteReg (filter_base, FILTER_CONTROL_REG15_OFFSET, 0 );

  return 0;
}

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
int set_filter_type (void *filter_base, FILTER_TYPE type, unsigned int enable) {
  if (filter_base == NULL) {
    return -1;
  }

  if ((type >= FILTER_TYPE_MAX) || (type <= 0)) {
    return -1;
  }

  if ((type & FILTER_HIGH_PASS) == FILTER_HIGH_PASS) {
    WriteReg (filter_base, FILTER_CONTROL_REG17_OFFSET, enable);
  }

  if ((type & FILTER_BAND_PASS) == FILTER_BAND_PASS) {
    WriteReg (filter_base, FILTER_CONTROL_REG18_OFFSET, enable);
  }

  if ((type & FILTER_LOW_PASS) == FILTER_LOW_PASS) {
    WriteReg (filter_base, FILTER_CONTROL_REG19_OFFSET, enable);
  }

  return 0;
}
