/* NUS - CS3211 AY2015/2016 Sem 2
 *
 * This program shows overflow when adding integers
 *
 */

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {

	int i,j,k;
        long count=0;
	int a=0;

	printf("Adding 1 to 0, lots of times...\n");

        for (i=1; i<30; i++) {
	    for (k=1; k<=100000000; k++) {
	      a=a+1;
              count=count+1;
	    }
          printf( "Adding %ld 1s to 0 gives this result: %d\n", count, a);
	}

	return 0;
}