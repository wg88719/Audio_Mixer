/*
 * =====================================================================================
 *
 *       Filename:  ui_control.c
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

#include "include/ui_control.h"


/**
 * =======================================================
 * reads audio data from axi and writes it into axi
 * @param   : data  : thread specific data
 * @return  : returns NULL
 * =======================================================
 */
void *loopback (void *data) {
  unsigned l_buff = 0;
  unsigned r_buff = 0;
  while (1) {
    l_buff = read_stream (audio_to_axi_base_0, CHANNEL_ID_L);
    if (write_stream (axi_to_audio_base_0, CHANNEL_ID_L, l_buff) != 0) {
      fprintf (stderr, "loopback : write_stream(axi_to_audio_base_0, CHANNEL_ID_L)");
      return NULL;
    }
    r_buff = read_stream (audio_to_axi_base_0, CHANNEL_ID_R);
    if (write_stream (axi_to_audio_base_0, CHANNEL_ID_R, r_buff) != 0) {
      fprintf (stderr, "loopback : write_stream(axi_to_audio_base_0, CHANNEL_ID_R)");
      return NULL;
    }

  }

  return NULL;
}

/**
 * =======================================================
 * reads audio data from network and writes it into fifo
 * @param   : data  : thread specific data
 * @return  : returns NULL
 * =======================================================
 */
void *network_reader_stream (void *data) {
  unsigned buffer = 0;
  while (1) {
    if (mq_receive(msgq_id_r, (char *)&buffer, attr_r.mq_msgsize+1, 0) == -1) {
      perror ("network_reader_stream : mq_receive(msgq_id_r)\n");
    }

    if (write_stream (axi_to_audio_base_1, CHANNEL_ID_L, buffer) != 0) {
      fprintf (stderr, "network_stream : write_stream(axi_to_audio_base_1, CHANNEL_ID_L)");
      return NULL;
    }
    if (write_stream (axi_to_audio_base_1, CHANNEL_ID_R, buffer) != 0) {
      fprintf (stderr, "network_stream : write_stream(axi_to_audio_base_1, CHANNEL_ID_R)");
      return NULL;
    }

  }

  return NULL;
}

/**
 * =======================================================
 * reads audio data from fifo and writes it into axi
 * @param   : data  : thread specific data
 * @return  : returns NULL
 * =======================================================
 */
void *network_writer_stream (void *data) {
  unsigned buffer = 0;
  while (1) {
    if (udp_client_recv(&buffer, 4) != 0) {
      fprintf (stderr, "udp_recv\n");
    }
    if (mq_send(msgq_id_w, (char *)&buffer, 4, 0) != 0) {
      perror ("network_writer_stream : mq_send");
    }

  }

  return NULL;
}

/**
 * =======================================================
 * read and parse user input
 * @param   : data  : thread specific data
 * @return  : returns NULL
 * =======================================================
 */
void *ui_input_reader (void *data) {
  char c[8];
  unsigned int gain = 0;
  while (1) {
    SET_STATUS("Enter Command\n");
    ui_draw();
    scanf ("%s",c);
      if(strcmp (c,"vll") == 0) {
        SET_STATUS("Enter gain\n");
        ui_draw();
        scanf ("%d",&gain);
        set_volume (volume_control_base_0, gain, CHANNEL_ID_L);
        params.vl_lpbk = gain;
        ui_draw();
      }
      else if(strcmp (c,"vlr") == 0) {
        SET_STATUS("Enter gain\n");
        ui_draw();
        scanf ("%d",&gain);
        set_volume (volume_control_base_0, gain, CHANNEL_ID_R);
        params.vr_lpbk = gain;
        ui_draw();
      }
      else if(strcmp (c,"nll") == 0) {
        SET_STATUS("Enter gain\n");
        ui_draw();
        scanf ("%d",&gain);
        set_volume (volume_control_base_1, gain, CHANNEL_ID_L);
        params.vl_net = gain;
        ui_draw();
      }
      else if(strcmp (c,"nlr") == 0) {
        SET_STATUS("Enter gain\n");
        ui_draw();
        scanf ("%d",&gain);
        set_volume (volume_control_base_1, gain, CHANNEL_ID_R);
        params.vr_net = gain;
        ui_draw();
      }
      else if ( strcmp (c, "lfhe") == 0){
          set_filter_type (filter_control_base_0, FILTER_HIGH_PASS, 1);
          params.filter_h_lpbk = 1;
          ui_draw();
      }
      else if ( strcmp (c, "lfhd") == 0){
          set_filter_type (filter_control_base_0, FILTER_HIGH_PASS, 0);
          params.filter_h_lpbk = 0;
          ui_draw();
      }
      else if ( strcmp (c, "lfbe") == 0){
          set_filter_type (filter_control_base_0, FILTER_BAND_PASS, 1);
          params.filter_b_lpbk = 1;
          ui_draw();
      }
      else if ( strcmp (c, "lfbd") == 0){
          set_filter_type (filter_control_base_0, FILTER_BAND_PASS, 0);
          params.filter_b_lpbk = 0;
          ui_draw();
      }
      else if ( strcmp (c, "lfle") == 0){
          set_filter_type (filter_control_base_0, FILTER_LOW_PASS, 1);
          params.filter_l_lpbk = 1;
          ui_draw();
      }
      else if ( strcmp (c, "lfld") == 0){
          set_filter_type (filter_control_base_0, FILTER_LOW_PASS, 0);
          params.filter_l_lpbk = 0;
          ui_draw();
      }
      else if ( strcmp (c, "nfhe") == 0){
          set_filter_type (filter_control_base_1, FILTER_HIGH_PASS, 1);
          params.filter_h_net = 1;
          ui_draw();
      }
      else if ( strcmp (c, "nfhd") == 0){
          set_filter_type (filter_control_base_1, FILTER_HIGH_PASS, 0);
          params.filter_h_net = 0;
          ui_draw();
      }
      else if ( strcmp (c, "nfbe") == 0){
          set_filter_type (filter_control_base_1, FILTER_BAND_PASS, 1);
          params.filter_b_net = 1;
          ui_draw();
      }
      else if ( strcmp (c, "nfbd") == 0){
          set_filter_type (filter_control_base_1, FILTER_BAND_PASS, 0);
          params.filter_b_net = 0;
          ui_draw();
      }
      else if ( strcmp (c, "nfle") == 0){
          set_filter_type (filter_control_base_1, FILTER_LOW_PASS, 1);
          params.filter_l_net = 1;
          ui_draw();
      }
      else if ( strcmp (c, "nfld") == 0){
          set_filter_type (filter_control_base_1, FILTER_LOW_PASS, 0);
          params.filter_l_net = 0;
          ui_draw();
      }
      else if (strcmp (c, "help") == 0) {
        printf ("|==================+================================================|\n");
        printf ("|Command           |Description                                     |\n");
        printf ("|==================+================================================|\n");
        printf ("|vll <gain value>  |volume gain for left channel of loopback stream |\n");
        printf ("|------------------+------------------------------------------------|\n");
        printf ("|vlr <gain value>  |volume gain for right channel of loopback stream|\n");
        printf ("|------------------+------------------------------------------------|\n");
        printf ("|nll <gain value>  |volume gain for left channel of network stream  |\n");
        printf ("|------------------+------------------------------------------------|\n");
        printf ("|nlr <gain value>  |volume gain for right channel of network stream |\n");
        printf ("|------------------+------------------------------------------------|\n");
        printf ("|    lfhe/lfhd     |High pass enable/Disable for loopback           |\n");
        printf ("|------------------+------------------------------------------------|\n");
        printf ("|    lfbe/lfbd     |Band pass enable/Disable for loopback           |\n");
        printf ("|------------------+------------------------------------------------|\n");
        printf ("|    lfle/lfld     |Low pass enable/Disable for loopback            |\n");
        printf ("|------------------+------------------------------------------------|\n");
        printf ("|    nfhe/nfhd     |High pass enable/Disable for network            |\n");
        printf ("|------------------+------------------------------------------------|\n");
        printf ("|    nfbe/nfbd     |Band pass enable/Disable for network            |\n");
        printf ("|------------------+------------------------------------------------|\n");
        printf ("|    nfle/nfld     |Low pass enable/Disable for network             |\n");
        printf ("|==================+================================================|\n");
        getchar ();
        getchar ();
      }
      else {
        SET_STATUS("Invalid Command\n");
        ui_draw();
      }
  }
  return NULL;
}

/**
 * =======================================================
 * draw the user interface
 * @param   : data  : thread specific data
 * @return  : returns NULL
 * =======================================================
 */
void ui_draw () {
    system ("clear");
    printf ("|============+============+============|\n");
    printf ("| Parameters +  Loopback  +   Network  |\n");
    printf ("|============+============+============|\n");
    printf ("|  Volume_L  +    %4d    +    %4d    |\n", params.vl_lpbk, params.vl_net);
    printf ("|------------+------------+------------|\n");
    printf ("|  Volume_R  +    %4d    +    %4d    |\n", params.vr_lpbk, params.vr_net);
    printf ("|------------+------------+------------|\n");
    printf ("|  FILTER_B  +    %-4s    +    %-4s    |\n", (params.filter_b_lpbk ? "On":"Off"), (params.filter_b_net ? "On":"Off"));
    printf ("|------------+------------+------------|\n");
    printf ("|  FILTER_L  +    %-4s    +    %-4s    |\n",(params.filter_l_lpbk ? "On":"Off"), (params.filter_l_net ? "On":"Off"));
    printf ("|------------+------------+------------|\n");
    printf ("|  FILTER_H  +    %-4s    +    %-4s    |\n", (params.filter_h_lpbk ? "On":"Off"), (params.filter_h_net ? "On":"Off"));
    printf ("|============+============+============|\n");
    printf ("\n%s\n", params.status);
  return NULL;
}

/**
 * =======================================================
 * ui_init initialize the user interface
 * @return  : returns 0 upon success
 *            -1 otherwise
 * =======================================================
 */
int ui_init (int argc, char *argv[]) {

  audio_to_axi_base_0 = map_device (AUDIO_TO_AXI_DEVICE_0);
  if (audio_to_axi_base_0 == NULL) {
     perror ("ui_init : audio_to_axi_base_0");
     return -1;
  }

  axi_to_audio_base_0 = map_device (AXI_TO_AUDIO_DEVICE_0);
  if (axi_to_audio_base_0 == NULL) {
     perror ("ui_init : axi_to_audio_base_0");
     return -1;
  }
  axi_to_audio_base_1 = map_device(AXI_TO_AUDIO_DEVICE_1);
  if (axi_to_audio_base_1 == NULL) {
     perror ("ui_init : axi_to_audio_base_1");
     return -1;
  }

  filter_control_base_0 = map_device(FILTER_DEVICE_0);
  if (filter_control_base_0 == NULL) {
     perror ("ui_init : filter_control_base_0");
     return -1;
  }

  filter_control_base_1 = map_device(FILTER_DEVICE_1);
  if (filter_control_base_1 == NULL) {
     perror ("ui_init : filter_control_base_1");
     return -1;
  }

  volume_control_base_0 = map_device(VOLUME_DEVICE_0);
  if (volume_control_base_0 == NULL) {
     perror ("ui_init : volume_control_base_0");
     return -1;
  }

  volume_control_base_1 = map_device(VOLUME_DEVICE_1);
  if (volume_control_base_1 == NULL) {
     perror ("ui_init : volume_control_base_1");
     return -1;
  }

  if (udp_client_setup( argv[1], atoi(argv[2])) != 0) {
    fprintf (stderr, "udp_client_setup\n");
    return -1;
  }

  attr_w.mq_flags = 0;
  attr_w.mq_maxmsg = 256;
  attr_w.mq_msgsize = 4;
  attr_w.mq_curmsgs = 0;

  msgq_id_w = mq_open(MSGQOBJ_NAME, O_RDWR | O_CREAT | O_EXCL, S_IRWXU | S_IRWXG, &attr_w);
  if (msgq_id_w == (mqd_t)-1) {
    perror("ui_init : mq_open(msq_id_w)\n");
    return -1;
  }

  msgq_id_r = mq_open(MSGQOBJ_NAME, O_RDWR);
  if (msgq_id_r == (mqd_t)-1) {
    perror("ui_init : mq_open(msq_id_r)\n");
    return -1;
  }

  if (mq_getattr(msgq_id_r, &attr_r) != 0) {
    perror ("ui_init : mq_getattr(msg_id_r)");
    return -1;
  }

  filter_coefficients coefficients;
  unsigned int filter_coefficients[15] = { 0x00002CB6, 0x0000596C, 0x00002CB6, 0x8097A63A, 0x3F690C9D, \
                                           0x074D9236, 0x00000000, 0xF8B26DCA, 0x9464B81B, 0x3164DB93, \
                                           0x12BEC333, 0xDA82799A, 0x12BEC333, 0x00000000, 0x0AFB0CCC };

  for (int i = 0; i < 15; i++) {
    coefficients.coefficients[i] = filter_coefficients[i];
  }

  if (set_coefficients (filter_control_base_0, coefficients) != 0) {
    fprintf (stderr, "set_coefficients\n");
  }

  if (set_coefficients (filter_control_base_1, coefficients) != 0) {
    fprintf (stderr, "set_coefficients\n");
  }
set_volume (volume_control_base_0, 30, CHANNEL_ID_L);
set_volume (volume_control_base_0, 30, CHANNEL_ID_R);
set_volume (volume_control_base_1, 30, CHANNEL_ID_L);
set_volume (volume_control_base_1, 30, CHANNEL_ID_R);
params.vl_lpbk = 30;
params.vr_lpbk = 30;
params.vl_net  = 30;
params.vr_net  = 30;
  return 0;
}

/**
 * =======================================================
 * ui_run starts the user interface
 * @return  : returns 0 upon success
 *            -1 otherwise
 * =======================================================
 */
int ui_run () {

  if (pthread_create (&loopback_thread, NULL, loopback, NULL) != 0) {
    perror ("ui_init : pthread_create(&loopback_thread)");
    return -1;
  }

  if (pthread_create (&network_reader_stream_thread, NULL, network_reader_stream, NULL) != 0) {
    perror ("ui_init : pthread_create(&network_reader_stream_thread)");
    return -1;
  }

  if (pthread_create (&network_writer_stream_thread, NULL, network_writer_stream, NULL) != 0) {
    perror ("ui_init : pthread_create(&network_writer_stream_thread)");
    return -1;
  }

  if (pthread_create (&ui_input_reader_thread, NULL, ui_input_reader, NULL) != 0) {
    perror ("ui_init : pthread_create(&ui_input_reader_thread)");
    return -1;
  }
/*
  if (pthread_create (&ui_draw_thread, NULL, ui_draw, NULL) != 0) {
    perror ("ui_init : pthread_create(&ui_draw_thread)");
    return -1;
  }

  if`dd (pthread_join(ui_draw_thread, NULL) != 0) {
    perror ("(pthread_join(ui_draw_thread");
    return -1;
  }
*/
  if (pthread_join(loopback_thread, NULL) != 0) {
    perror ("pthread_join(loopback_thread)");
    return -1;
  }

  if (pthread_join(network_reader_stream_thread, NULL) != 0) {
    perror ("pthread_join(network_reader_stream_thread)");
    return -1;
  }

  if (pthread_join(network_writer_stream_thread, NULL) != 0) {
    perror ("pthread_join(network_writer_stream_thread)");
    return -1;
  }

  if (pthread_join(ui_input_reader_thread, NULL) != 0) {
    perror ("(pthread_join(ui_input_reader_thread)");
    return -1;
  }

  return 0;
}

/**
 * =======================================================
 * ui_exit will do clean up routines and
 * do safe termination the application
 * =======================================================
 */
void ui_exit () {
  printf ("Exiting from Audio Mixer\n");
  sleep (2);
  unmap_device (audio_to_axi_base_0);
  unmap_device (axi_to_audio_base_0);
  unmap_device (axi_to_audio_base_1);
  unmap_device (filter_control_base_0);
  unmap_device (filter_control_base_1);
  unmap_device (volume_control_base_0);
  unmap_device (volume_control_base_1);
}
