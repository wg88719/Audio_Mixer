/**
 * =====================================================================================
 *
 *       Filename:  stream_control.c
 *
 *    Description:  audio stream control functions and macros
 *
 *        Version:  1.0
 *        Created:  16/05/16 01:07:23
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Harsha Chaitanya Manam
 *   Organization:  FOSS
 *
 * =====================================================================================
 */

#include "include/stream_control.h"

/**
 * =======================================================
 * read_stream reads 4 bytes unsigned data
 * from the specified channel
 * @param   : stream_base  : base address of the stream
 * @param   : channel      : channel ID
 * @return  : returns 4 bytes unsigned data
 * =======================================================
 */
unsigned read_stream (void *stream_base, CHANNEL_ID channel) {
  unsigned buffer = 0;
  if (stream_base == NULL) {
    return -1;
  }

  if (channel == CHANNEL_ID_L) {
    buffer = ReadReg(stream_base, AUDIO_TO_AXI_INTERFACE_REG0_OFFSET);
  }
  else if (channel == CHANNEL_ID_R) {
    buffer = ReadReg(stream_base, AUDIO_TO_AXI_INTERFACE_REG1_OFFSET);
  }
  else {
    return -1;
  }
  return buffer;
}

/**
 * =======================================================
 * write_stream writes 4 bytes unsigned data
 * to the spicified channel
 * @param  stream_base  : base address of the stream
 * @param  channel      : channel ID
 * @param  data         : 4 bytes unsigned data
 * @return  : returns 0 upon success
 *            -1 otherwise
 * =======================================================
 */
int write_stream (void *stream_base, CHANNEL_ID channel, unsigned data) {
  if (stream_base == NULL) {
    return -1;
  }

  if (channel == CHANNEL_ID_L) {
    WriteReg(stream_base, AXI_TO_AUDIO_INTERFACE_REG0_OFFSET, data);
  }
  else if (channel == CHANNEL_ID_R) {
    WriteReg(stream_base, AXI_TO_AUDIO_INTERFACE_REG1_OFFSET, data);
  }
  else {
    return -1;
  }
  return 0;
}
