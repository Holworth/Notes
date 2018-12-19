#ifndef INCLUDE_BARRIER_H_
#define INCLUDE_BARRIER_H_

#include "queue.h"

typedef struct barrier
{
    queue_t queue;
    int goal;
    int waiting;
} barrier_t;

void do_barrier_init(barrier_t *, int);
void do_barrier_wait(barrier_t *);

#endif