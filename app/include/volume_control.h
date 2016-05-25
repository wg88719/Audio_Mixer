/**
 * =====================================================================================
 *
 *       Filename:  volume_control.h
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

#ifndef VOLUME_CONTROL_H
#define VOLUME_CONTROL_H

#include "reg_io.h"

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
int set_volume (void *volume_base, unsigned int gain, CHANNEL_ID channel);

#endif //VOLUME_CONTROL_H
