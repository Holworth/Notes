/* NUS - CS3211 AY2015/2016 Sem 2
 *
 * This program shows the accuracy issue when adding floating
 * point numbers on different number of threads.
 */

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main(int argc, char **argv) {
  srand(time(NULL));

	int size = 100000;
	int repeats = 5;
	int threads = -1;
	int i, j, tid;
	float *a, part, sum;
        #pragma omp parallel
	{
	  threads = omp_get_num_threads();
	}
	printf("Adding %d randomly generated floating point numbers using %d threads\n\n", size, threads);

	// allocate FP array	
	a = (float*)malloc(size * sizeof(float));
	if (!a)
	{
		perror("Allocating FP array");
		return -1;
	}

	// generate FP numbers
	for (i = 0; i < size; i++)
		a[i] = rand() % 100 / 1.6180339887498948482;

	for (j = 0; j < repeats; j++)
	{	
		sum = 0.0;

		#pragma omp parallel shared(a, sum, size) private(part, tid, i)
		{
			// tid = omp_get_thread_num();
			part = 0.0;
			#pragma omp for
			for (i = 0; i < size; i++)
				part += a[i];

			// printf("Local sum thread %d is %e\n", tid, part);
			
			#pragma omp critical
			sum += part;
		}

		printf("Final sum is %10.6f\n", sum);
	}
	printf("\n");

	free(a);

	return 0;
}
