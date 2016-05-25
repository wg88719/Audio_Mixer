/**
 * =====================================================================================
 *
 *       Filename:  volume_control.c
 *
 *    Description:  Volume control helper macros and functions
 *
 *        Version:  1.0
 *        Created:  16/05/16 00:45:22
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Harsha Chaitanya Manam
 *   Organization:  FOSS
 *
 * =====================================================================================
 */

#include "include/volume_control.h"

/**
 * =======================================================
 * set_volume function sets the volume gain value
 * to the volume control IP
 * @param   : volume_base : volume control base address
 * @param   : gain        : gain value
 * @param   : channel     : channel ID
 * @return  : returns 0 upon success
 *            -1 otherwise
 * =======================================================
 */
int set_volume (void *volume_base, unsigned int gain, CHANNEL_ID channel) {
  if (volume_base == NULL) {
    return -1;
  }

  if (channel == CHANNEL_ID_L) {
    WriteReg (volume_base, VOLUME_CONTROL_REG0_OFFSET, (gain*10));
  }
  else if (channel == CHANNEL_ID_R) {
    WriteReg (volume_base, VOLUME_CONTROL_REG1_OFFSET, (gain*10));
  }
  else {
    return -1;
  }

  return 0;
}
