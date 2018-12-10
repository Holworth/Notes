#include "sem.h"
#include "stdio.h"

void do_semaphore_init(semaphore_t *s, int val)
{
    s->value=val;
    queue_init(&s->queue);
}

void do_semaphore_up(semaphore_t *s)
{
    if(queue_is_empty(&s->queue))
        s->value++;
    else
    {
        do_unblock_one(&s->queue);
    }
}

void do_semaphore_down(semaphore_t *s)
{
    if(s->value>0)s->value--;
    else
    {
        do_block(&s->queue);
    }
}