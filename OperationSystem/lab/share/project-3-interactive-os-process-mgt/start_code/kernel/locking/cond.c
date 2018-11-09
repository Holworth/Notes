#include "cond.h"
#include "lock.h"

void do_condition_init(condition_t *condition)
{
    queue_init(&condition->queue);
}

void do_condition_wait(mutex_lock_t *lock, condition_t *condition)
{
    do_mutex_lock_release(lock);
    do_block(&condition->queue);
    do_mutex_lock_acquire(lock);
}

void do_condition_signal(condition_t *condition)
{
    // int i;
    // int queue_num=queue_stack.point;
    // for(i=0;i<queue_num;i++)
    // {
    //     if(queue_stack.data[i]==condition)
    //     {
    //         do_unblock_one()
    //     }
    // }
    do_unblock_one(&condition->queue);
}

void do_condition_broadcast(condition_t *condition)
{
    do_unblock_all(&condition->queue);
}