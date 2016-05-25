/*
 * =====================================================================================
 *
 *       Filename:  app_main.c
 *
 *    Description:  application initialization functions
 *
 *        Version:  1.0
 *        Created:  16/05/16 01:54:38
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Harsha Chaitanya Manam
 *   Organization:  FOSS
 *
 * =====================================================================================
 */

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include "include/ui_control.h"

int main (int argc, char *argv[]) {

	int ret = 0;

	ret = ui_init (argc, argv);

	if (ret != 0) {
		fprintf (stderr, "ui_init failed\n");
		return EXIT_FAILURE;
	}

	ret = ui_run ();

	if (ret != 0) {
		fprintf (stderr, "ui_run failed\n");
		return EXIT_FAILURE;
	}

	ui_exit();

	return EXIT_SUCCESS;

}
