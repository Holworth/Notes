#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include <omp.h>
#include <xmmintrin.h>


int size;
int threads;

typedef struct
{
  float ** element;
} matrix;


long long wall_clock_time()
{
#ifdef LINUX
  struct timespec tp;
  clock_gettime(CLOCK_REALTIME, &tp);
  return (long long)(tp.tv_nsec + (long long)tp.tv_sec * 1000000000ll);
#else
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return (long long)(tv.tv_usec * 1000 + (long long)tv.tv_sec * 1000000000ll);
#endif
}

/**
 * Allocates memory for a matrix of size SIZE
 * The memory is allocated row-major order, i.e. 
 *  elements from the same row are allocated at contiguous 
 *  memory addresses.
 **/
void allocate_matrix(matrix* m)
{
  int i, j;
	
  // allocate array for all the rows
  m->element = (float**)malloc(sizeof(float*) * size);
  if (m->element == NULL)
    {
      fprintf(stderr, "Out of memory\n");
      exit(1);
    }
	
  // allocate an array for each row of the matrix
  for	(i = 0; i < size; i++)
    {
      m->element[i] = (float*)malloc(sizeof(float) * size);
      if (m->element[i] == NULL)
	{
	  fprintf(stderr, "Out of memory\n");
	  exit(1);
	}
    }
}

/**
 * Initializes the elements of the matrix with
 * random values between 0 and 9
 **/
void init_matrix(matrix m)
{
  int i, j;
	
  for (i = 0; i < size; i++)
    for (j = 0; j < size; j++)
      {
	m.element[i][j] = rand() % 10;
      }
}

/**
 * Initializes the elements of the matrix with
 * element 0.
 **/
void init_matrix_zero(matrix m)
{
  int i, j;
	
  for (i = 0; i < size; i++)
    for (j = 0; j < size; j++)
      {
	m.element[i][j] = 0.0;
      }
}


/**
 * Multiplies matrix @a with matrix @b storing
 * the result in matrix @result
 * 
 * The multiplication algorithm is the O(n^3) 
 * algorithm
 */
void mm(matrix a, matrix b, matrix result)
{
  int i, j, k;
  long long before, after;

  before = wall_clock_time();
  // Parallelize the multiplication
  // Each thread will work on one iteration of the outer-most loop
  // Variables are either shared among threads (a, b, result)
  // or each thread has its own private copy (i, j, k)
  #pragma omp parallel for shared(a, b, result) private (i, j, k)
  for (i = 0; i < size; i++)
    for (j = 0; j < size; j++)
      for(k = 0; k < size; k++)
	result.element[i][j] += a.element[i][k] * b.element[k][j];
    
  after = wall_clock_time();
  fprintf(stderr, "Matrix multiplication took %2.4f seconds\n", ((float)(after - before))/1000000000);
}


void print_matrix(matrix m)
{
  int i, j;
	
  for (i = 0; i < size; i++)
    {
      printf("row =%4d: ", i);
      for (j = 0; j < size; j++)
	printf("%6.2f  ", m.element[i][j]);
      printf("\n");
    }
}



void work()
{
  matrix a, b, result;

  // Allocate memory for matrices
  allocate_matrix(&a);
  allocate_matrix(&b);
  allocate_matrix(&result);

  // Initialize matrix elements
  init_matrix(a);
  init_matrix(b);
  init_matrix(result);

  // Perform parallel matrix multiplication
  mm(a, b, result);

  // Print the result matrix
  /* print_matrix(result); */

}


int main(int argc, char ** argv)
{
  srand(0);
    
  if (argc >= 2)
    size = atoi(argv[1]);
  else
    size = 1024;
		
  if (argc >= 3)
    threads = atoi(argv[2]);
  else
    threads = -1;
		
  if (argc >=4){
    printf("Incorrect number of arguments.");
    return 0;
  }
		
  // Multiply the matrices
  if (threads != -1)
    {
      omp_set_num_threads(threads);
    }
    
  #pragma omp parallel
  {
    threads = omp_get_num_threads();
  }
    
  printf("Matrix multiplication of size %d using %d threads\n", size, threads);
    
  work();
  return 0;
}
