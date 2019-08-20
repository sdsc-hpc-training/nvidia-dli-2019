/*
 * Copyright 1993-2010 NVIDIA 
 *     Corporation.  
 *     All rights reserved.
  */
#include <stdio.h>

__global__ void mykernel( void ) {
}

int main( void ) {
    mykernel<<<1,1>>>();
    printf( "Hello, GPU World!\n" );
    return 0;
}

