/* NUS - CS3211 AY2015/2016 Sem 2
 *
 * This program shows an accuracy issue when adding floating
 * point numbers 
 */

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <gmp.h>

int main(int argc, char **argv) {

	int i,j,k;
        long count=0;
	float a=0;

	printf("Adding 1 to 0, lots of times...\n");

        for (i=1; i<40; i++) {
	  for (j=1; j<=i; j++) {
	    for (k=1; k<=500000; k++) {
	      a=a+1;
              count=count+1;
	    }
	  }
          printf( "Adding %ld 1s to 0 gives this result: %10.1f\n", count, a);
          a=0;
          count=0;
	}

	// ref:
	// https://zh.wikipedia.org/wiki/IEEE_754
	// 以单精度浮点数为例，它的指数域是8个比特 exponent bias only 8 bits: 2^7-1  fraction part 23 bits: about 2^-23 level -> can not represent 2^-24
	// https://stackoverflow.com/questions/12596695/why-does-a-float-variable-stop-incrementing-at-16777216-in-c
	// 0 10010111 00000000000000000000000: 16777216
	return 0;
}
