/* Copyright (c) 2019 Huaqiang Wang. */
/* Copyright (c) 2010-2014 Christopher Swenson. */

#include <sys/time.h>
#include <sys/types.h>
#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define SORT_NAME sorter
#define SORT_TYPE int64_t
/* You can redefine the comparison operator.
   The default is
#define SORT_CMP(x, y)  ((x) < (y) ? -1 : ((x) == (y) ? 0 : 1))
   but the one below is often faster for integer types.
*/
#define SORT_CMP(x, y) (x - y)
#include "sort.h"

/*
   We now have the following functions defined
   * sorter_shell_sort
   * sorter_binary_insertion_sort
   * sorter_heap_sort
   * sorter_quick_sort
   * sorter_merge_sort
   * sorter_selection_sort
   * sorter_tim_sort

   Each takes two arguments: int64_t *array, size_t size
*/

int64_t array[10000];

int main()
{

    for (int i = 0; i < 10000; i++)
    {
        array[i] = rand();
    }

    sorter_shell_sort(array, 10000);
    sorter_binary_insertion_sort(array, 10000);
    sorter_heap_sort(array, 10000);
    sorter_quick_sort(array, 10000);
    sorter_merge_sort(array, 10000);
    sorter_selection_sort(array, 10000);
    sorter_tim_sort(array, 10000);

    return 0;
}