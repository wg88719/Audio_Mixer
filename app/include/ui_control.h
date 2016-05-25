/*
 * =====================================================================================
 *
 *       Filename:  ui_control.h
 *
 *    Description:  User interface functions
 *
 *        Version:  1.0
 *        Created:  15/05/16 05:14:41
 *       Revision:  none
 *       Compiler:  arm-xilinx-linux-gnueabi-gcc
 *
 *         Author:  Harsha Chaitanya Manam
 *   Organization:  FOSS
 *
 * =====================================================================================
 */

#ifndef UI_CONTROL_H
#define UI_CONTROL_H
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <termios.h>
#include <string.h>
#include <mqueue.h>
#include "reg_io.h"
#include "stream_control.h"
#include "filter_control.h"
#include "volume_control.h"
#include "udpclient.h"


#define MSGQOBJ_NAME    "/network_stream" // name of the fifo

/**
 * =======================================================
 * Macro to set the status of the current command
 * @param   : status_msg  : status message
 * @return  : none
 * =======================================================
 */
#define SET_STATUS(status_msg) sprintf(params.status, status_msg)

/**
 * =======================================================
 * Device base address pointers
 * =======================================================
 */
void *audio_to_axi_base_0;
void *axi_to_audio_base_0;
void *axi_to_audio_base_1;
void *filter_control_base_0;
void *filter_control_base_1;
void *volume_control_base_0;
void *volume_control_base_1;

pthread_t network_reader_stream_thread; // thread to write network audio data to fifo
pthread_t network_writer_stream_thread; // thread to write fifo audio data to axi audio
pthread_t loopback_thread; // thread to loop back audio in to out through axi
pthread_t ui_input_reader_thread; //main ui input reading thread
pthread_t ui_draw_thread; // ui draw thread

/**
 * =======================================================
 * structure to hold ui parameters
 * =======================================================
 */
typedef struct _ui_parameters {
    int vl_lpbk;
    int vl_net;
    int vr_lpbk;
    int vr_net;
    char filter_b_lpbk;
    char filter_b_net;
    char filter_l_lpbk;
    char filter_l_net;
    char filter_h_lpbk;
    char filter_h_net;
    char status[30];
}ui_parameters;

ui_parameters params; //shared structure variable to ui_parameters structure

int quit_flag; // flag to control the threads

mqd_t msgq_id_r; // reader fifo descripter
mqd_t msgq_id_w; // writer fifo descripter
struct mq_attr attr_r; // reader fifo attributes
struct mq_attr attr_w; // writer fifo attributes

/**
 * =======================================================
 * read_raw function reads raw input from standard input
 * @return  : returns the charecter read from stdin
 * =======================================================
 */
int read_raw();

/**
 * =======================================================
 * reads audio data from axi and writes it into axi
 * @param   : data  : thread specific data
 * @return  : returns NULL
 * =======================================================
 */
void *loopback (void *data);

/**
 * =======================================================
 * reads audio data from network and writes it into axi
 * @param   : data  : thread specific data
 * @return  : returns NULL
 * =======================================================
 */
void *network_reader_stream (void *data);

/**
 * =======================================================
 * reads audio data from network and writes it into axi
 * @param   : data  : thread specific data
 * @return  : returns NULL
 * =======================================================
 */
void *network_writer_stream (void *data);

/**
 * =======================================================
 * read and parse user input
 * @param   : data  : thread specific data
 * @return  : returns NULL
 * =======================================================
 */
void *ui_input_reader (void *data);

/**
 * =======================================================
 * draw the user interface
 * @param   : data  : thread specific data
 * @return  : returns NULL
 * =======================================================
 */
 void ui_draw ();

/**
 * =======================================================
 * ui_init initialize the user interface
 * @return  : returns 0 upon success
 *            -1 otherwise
 * =======================================================
 */
int ui_init (int argc, char *argv[]);

/**
 * =======================================================
 * ui_run starts the user interface
 * @return  : returns 0 upon success
 *            -1 otherwise
 * =======================================================
 */
int ui_run ();

/**
 * =======================================================
 * ui_exit will do clean up routines and
 * do safe termination the application
 * =======================================================
 */
void ui_exit ();
#endif //UI_CONTROL_H
