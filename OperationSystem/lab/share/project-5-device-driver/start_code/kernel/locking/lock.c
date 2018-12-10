#include "lock.h"
#include "sched.h"
#include "syscall.h"

void spin_lock_init(spin_lock_t *lock)
{
    lock->status = UNLOCKED;
}

void spin_lock_acquire(spin_lock_t *lock)
{
    while (LOCKED == lock->status)
    {
    };
    lock->status = LOCKED;
}

void spin_lock_release(spin_lock_t *lock)
{
    lock->status = UNLOCKED;
}

void do_mutex_lock_init(mutex_lock_t *lock)
{
    queue_init(&(lock->lock_queue));
    lock->lock_current=0;
    lock->status=UNLOCKED;
    vector_node_init(&lock->vector_node,lock);
}

void do_mutex_lock_acquire(mutex_lock_t *lock)
{
    if(lock->status==LOCKED)
    {
        //failed
        do_block(&(lock->lock_queue));
    }
    //succeed
    lock->status=LOCKED;
    lock->lock_current=current_running;
    current_running->status=TASK_RUNNING;
    vector_push(&current_running->lock_vector, &lock->vector_node);
}

void do_mutex_lock_release(mutex_lock_t *lock)
{
    if(lock->status==LOCKED)
    {
        //for debug
        lock->lock_current=0;
        //for resource recycle
        if(vector_exist(&current_running->lock_vector,&lock->vector_node))
        {
            vector_remove(&current_running->lock_vector, &lock->vector_node);
        }

        //

        if(!queue_is_empty(&(lock->lock_queue)))
        {
            do_unblock_one(&(lock->lock_queue));
            // do_unblock_high_priority(&(lock->lock_queue));
            //lock->status==LOCKED;
            //this lock is still locked.
        }else
        {
            lock->status=UNLOCKED;
        }
    }else
    {
        //do nothing;
        // printk("> [ERROR] release empty mutex lock.\n");
    }
}

void do_other_mutex_lock_release(pcb_t * pcbp,mutex_lock_t *lock)
{
    if(lock->status==LOCKED)
    {
        //for debug
        lock->lock_current=0;
        //for resource recycle
        if(vector_exist(&pcbp->lock_vector,&lock->vector_node))
        {
            vector_remove(&pcbp->lock_vector, &lock->vector_node);
        }

        //

        if(!queue_is_empty(&(lock->lock_queue)))
        {
            do_unblock_one(&(lock->lock_queue));
            // do_unblock_high_priority(&(lock->lock_queue));
            //lock->status==LOCKED;
            //this lock is still locked.
        }else
        {
            lock->status=UNLOCKED;
        }
    }else
    {
        //do nothing;
        // printk("> [ERROR] release empty mutex lock.\n");
    }
}
