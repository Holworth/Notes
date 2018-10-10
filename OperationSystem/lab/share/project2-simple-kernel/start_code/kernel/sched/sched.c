#include "lock.h"
#include "time.h"
#include "stdio.h"
#include "sched.h"
#include "queue.h"
#include "screen.h"

pcb_t pcb[NUM_MAX_TASK];

/* current running task PCB */
pcb_t *current_running=0;

/* global process id */
pid_t process_id = 0;// will switch to 1 when the 1st porc is called.

/* last used process id */
pid_t last_used_process_id = 0;

/* process queue */
queue_t process_queue;
queue_t block_queue;

static void check_sleeping()
{
}

void scheduler(void)
{
    // Called after SAVE_CONTEXT(KERNEL)
    // Modify the current_running pointer.
    // Start the process at the head of the queue;
    if(current_running)// not the first process
    {
        current_running->status=TASK_EXITED;//TODO

    }
    pcb_t* new_proc = queue_dequeue(&process_queue);
    current_running=new_proc->pid;
    // SAVE_CONTEXT(ASM_USER);
    new_proc->status=TASK_RUNNING;

    // RESTORE_CONTEXT(ASM_USER);
    return;
    // After return, do_scheduler will:
    // RESTORE_CONTEXT(KERNEL)
    // jr      ra
}

void do_sleep(uint32_t sleep_time)
{
    // TODO sleep(seconds)
}

void do_block(queue_t *queue)
{
    // block the current_running task into the queue
}

void do_unblock_one(queue_t *queue)
{
    // unblock the head task from the queue
}

void do_unblock_all(queue_t *queue)
{
    // unblock all task in the queue
}

void copy_pcb(pcb_t* tgt, pcb_t* src)
{
    for(int i=0;i<NUM_MAX_TASK;i++)
    {
        tgt[i]=src[i];
    }
    return;
}

pid_t new_pid()
{
    return (++last_used_process_id);
}
