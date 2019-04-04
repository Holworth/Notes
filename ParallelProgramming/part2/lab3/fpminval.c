/* NUS - CS3211 AY2017/2018 Sem 2
 *
 * This program attempts to find the minimum value of the function
 *    f(x) =  -1.0/abs(3*((1.0-(10000000.0*(x-1.3))))) + x*x + 1.0
 * between 1 and 2
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MIN(x, y) (((x) < (y)) ? (x) : (y))

#define LARGEINT 10000000.0
// #define LARGEINT 1000000000.0

float f(float x) {
  return -1.0/fabs(3*((1.0-(LARGEINT*(x-1.3))))) + x*x + 1.0;
}

int main(int argc, char **argv) {

	int i,k;
        int slices = 10000;
        long count=0;
        float minval=1000.0;
	float thisval=0.0;
        float start=1.299999;
        float end  =1.300001;
	float x=start;
        float interval=end-start;

	printf("Large int: %f\n",LARGEINT);
	printf("Trying %d slices between %f and %f\n",slices, start, end);

        for (i=1; i<slices; i++) {
	    thisval = f(x);
            minval = MIN(thisval,minval);
            x = x+(interval/slices);
	}
        printf( "Minimum value is %10.1f, range 1.0 to %10.1f\n",minval,x);

	return 0;
}
