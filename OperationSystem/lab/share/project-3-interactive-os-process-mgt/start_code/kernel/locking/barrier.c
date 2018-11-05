#include "barrier.h"

void do_barrier_init(barrier_t *barrier, int goal)
{
    barrier->goal=goal;
    barrier->waiting=0;
    queue_init(&barrier->queue);
}

void do_barrier_wait(barrier_t *barrier)
{
    barrier->waiting++;
    if(barrier->waiting==barrier->goal)
    {
        barrier->waiting=0;
        do_unblock_all(&barrier->queue);
    }
    else
    {
        do_block(&barrier->queue);
    }
}