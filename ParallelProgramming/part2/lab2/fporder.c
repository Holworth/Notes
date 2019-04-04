/* NUS - CS3211 AY2015/2016 Sem 2
 *
 * This program shows another accuracy issue when adding floating
 * point numbers
 */

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  srand(time(NULL));

	int size = 20;
	int i;
	float a[20], sum;

	printf("Adding %d (pseudo)randomly generated floating point numbers for 1 to %d and %d down to 1\n\n", size, size, size);

	// generate FP numbers
	for (i = 0; i < size; i++)
		a[i] = rand() % 100 / 1.6180339887498948482;

	sum = 0.0;
	for (i = 0; i < size; i++)
		sum += a[i];
	printf("Sum from 1 to %d is %10.6f\n", size, sum);

	sum = 0.0;
        for (i = size-1; i >= 0; i--)
                sum += a[i];
        printf("Sum from %d to 1 is %10.6f\n", size, sum);

	return 0;
}
