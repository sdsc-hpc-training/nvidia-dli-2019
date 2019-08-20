/*
* simple_hello.cu
* Copyright 1993-2010 NVIDIA Corporation. 
*    All right reserved
*/
#include <stdio.h> 
#include <stdlib.h>
int main( void ) 
{ 
   int deviceCount;
   cudaGetDeviceCount( &deviceCount ); 
   printf("Hello, NVIDIA DLI Workshop! You have %d devices\n", deviceCount ); 
   return 0;
}
