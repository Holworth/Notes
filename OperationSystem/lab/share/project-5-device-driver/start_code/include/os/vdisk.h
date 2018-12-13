#include "stdio.h"

#ifndef INCLUDE_VDISK_H_
#define INCLUDE_VDISK_H_

#define VDISK_BASE 0xa1200000
#define VDISK_UPPER_BOUND 0xa1d00000

int vdiskinit();
int  vdiskread(unsigned char* , unsigned int , int );
int  vdiskwrite(unsigned char* , unsigned int , int );

#endif