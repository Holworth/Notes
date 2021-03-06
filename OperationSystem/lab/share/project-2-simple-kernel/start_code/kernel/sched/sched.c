#include "lock.h"
#include "time.h"
#include "stdio.h"
#include "sched.h"
#include "queue.h"
#include "screen.h"

// #define PRIORITY_SCH

pcb_t pcb[NUM_MAX_TASK];
pcb_t empty_pcb_for_init;
pcb_t pcb_idle;

/* current running task PCB */
pcb_t *current_running=0;

/* global process id */
pid_t process_id = 0;// will switch to 1 when the 1st porc is called.

/* last used process id */
pid_t last_used_process_id = 0;

/* process queue */
queue_t ready_queue;
queue_t block_queue;
queue_t sleep_queue;

/* addr for fake scene for the 1st proc*/
uint32_t fake_scene_addr;

static void check_sleeping()
{
    if(queue_is_empty(&sleep_queue))
    {
        return;
    }
    pcb_t* proc=sleep_queue.head;
    uint32_t timepassed;
    do
    {
        timepassed=time_elapsed-proc->block_time;
        if(timepassed>proc->sleep_time)
        {
            proc->status=TASK_READY;
            queue_remove(&sleep_queue,proc);
            queue_push(&ready_queue, proc);
        }
        proc=proc->next;
    }while(proc!=NULL);
    return;
}

void scheduler(void)
{
    // while(1);//STOP HERE TO DEBUG
    // Called after SAVE_CONTEXT(KERNEL)
    // Modify the current_running pointer.
    // Start the process at the head of the queue;

    //if proc==0, blocked, ready, etc.
    //TASK_RUNNING---> not in queue
    info("scheduler(void) called");
    check(current_running->pid);
    check(current_running->status==TASK_RUNNING);
    check(current_running->kernel_context.cp0_epc);
    check(current_running->user_context.cp0_epc);
    if(current_running->status==TASK_RUNNING)
    {
        current_running->status=TASK_READY;
        current_running->block_time=time_elapsed;
        queue_push(&ready_queue, current_running);//add old proc into ready queue;
    }
    // status mod will happen before do_scheduler()
    // current_running->status=TASK_BLOCKED, etc;//TODO
    current_running->run_cnt++;


    pcb_t* new_proc;
    check(queue_is_empty(&ready_queue));    
    //wait for a ready proc
    if(queue_is_empty(&ready_queue))
    {
        // printk("queue_is_empty(&ready_queue)\n");
        new_proc=&pcb_idle;
    }else
    {
    #ifdef PRIORITY_SCH
    //TODO: priority
        new_proc=ready_queue.head;
        pcb_t *now_proc=ready_queue.head;
        uint32_t priority_plus_wait_time_max=
            new_proc->priority_level
            -new_proc->block_time
            +time_elapsed;
        if(now_proc!=NULL)
        {
            while(now_proc->next)
            {
                now_proc=now_proc->next;
                uint32_t priority_plus_wait_time_now=
                now_proc->priority_level
                -now_proc->block_time
                +time_elapsed;
                if(priority_plus_wait_time_now>priority_plus_wait_time_max)
                {
                    priority_plus_wait_time_max=priority_plus_wait_time_now;
                    new_proc=now_proc;
                }
            }
        }
    #else
        new_proc=ready_queue.head;
    #endif
    }

    process_id=new_proc->pid;
    check(new_proc);
    check(new_proc->pid);
    check(new_proc->entry);
    current_running=new_proc;

    // SAVE_CONTEXT(ASM_USER);??
    // RESTORE_CONTEXT(ASM_USER);??
    if(current_running->first_run)
    {
        current_running->first_run=0;
        current_running->kernel_stack_top=alloc_stack();
        current_running->user_stack_top=alloc_stack();
        current_running->priority_level=current_running->priority_level_set;
        current_running->timeslice=current_running->timeslice_set;
        current_running->timeslice_left=current_running->timeslice_set;
        current_running->block_time=time_elapsed;
        //pc(useless)
        // current_running->kernel_context.pc=current_running->entry;
        // current_running->kernel_context.cp0_status=0x30400004;//disable interrupt
        current_running->kernel_context.cp0_status=0x0;//close interrupt
        current_running->kernel_context.cp0_cause=0x0;
        current_running->user_context.cp0_status=0x0;
        current_running->user_context.cp0_cause=0x0;

        current_running->kernel_context.regs[31]=fake_scene_addr;
        current_running->user_context.regs[31]=current_running->entry;
        current_running->kernel_context.regs[29]=current_running->kernel_stack_top;
        current_running->user_context.regs[29]=current_running->user_stack_top;
        current_running->user_context.cp0_epc=current_running->entry;//set entry

        //if kernel: disable interrupt
        //if user:   enable interrupt
        // current_running->user_context.cp0_status=(((current_running->type==USER_PROCESS)|(current_running->type==USER_THREAD))?
            // 0x10008001:0x0);//set cp0_status
    }
    if(new_proc->status==TASK_READY)//NOT IDLE
    {
        new_proc->status=TASK_RUNNING;
        check(current_running->next);
        check(current_running->prev);
        check(current_running);
        // queue_remove(&ready_queue, new_proc);
        // If need faster speed, use the following code:
        #ifdef PRIORITY_SCH
            queue_remove(&ready_queue, new_proc);
        #else
            queue_dequeue(&ready_queue);
        #endif
    }
    current_running->user_context.cp0_cause=0x0;
    check(current_running->kernel_context.regs[31]);
    check(current_running->kernel_context.regs[29]);
    check(current_running->user_context.regs[31]);
    check(current_running->user_context.regs[29]);
    check(current_running->user_context.cp0_epc);
    return;
}

void do_sleep(uint32_t sleep_time)
{
    current_running->sleep_time=sleep_time;
    do_block(&sleep_queue);
}

void do_block(queue_t *queue)
{
    // block the current_running task into the queue
    current_running->status=TASK_BLOCKED;
    current_running->block_time=time_elapsed;
    current_running->sys_int_cnt++;
    queue_push(queue, current_running);
    do_scheduler();
}

void do_unblock_one(queue_t *queue)
{
    // unblock the head task from the queue
    if(queue_is_empty(queue))
    {
        printk("> [INFO] do_unblock_one() an empty queue\n");
        return;
        while(queue_is_empty(queue));
    }
    pcb_t* unblock_proc=queue->head;
    queue_dequeue(queue);
    unblock_proc->status=TASK_READY;
    //Newly added in 2-4
    // unblock_proc->kernel_context.cp0_epc=unblock_proc->kernel_context.regs[31];
    //----------------------------------
    queue_push(&ready_queue, unblock_proc);
    return;
}

//TODO
void do_unblock_high_priority(queue_t *queue)
{
    // unblock the task from the queue
    if(queue_is_empty(queue))
    {
        printk("> [INFO] do_unblock_high_priority() an empty queue\n");
        while(queue_is_empty(queue));
        return;
    }
    pcb_t* unblock_proc=queue->head;
    pcb_t* max_priority_proc=queue->head;
    int max_priority_level=
        ((pcb_t*)queue->head)->priority_level
        +time_elapsed
        -((pcb_t*)queue->head)->block_time;
    while(unblock_proc->next!=NULL)
    {
        unblock_proc=unblock_proc->next;
        int total_level=
            unblock_proc->priority_level
            +time_elapsed
            -unblock_proc->block_time;

        if(total_level>max_priority_level)
        {
            max_priority_level=total_level;
            max_priority_proc=unblock_proc;
        }
    }
    max_priority_proc->status=TASK_READY;
    queue_remove(queue, max_priority_proc);
    // Newly added in 2-4s
    // max_priority_proc->kernel_context.cp0_epc=max_priority_proc->kernel_context.regs[31];
    //----------------------------------
    queue_push(&ready_queue, max_priority_proc);
    return;
}

void do_unblock_all(queue_t *queue)
{
    // unblock all task in the queue
    if(queue_is_empty(queue))
    {
        printk("> [INFO] do_unblock_all() an empty queue\n");
        return;
        while(queue_is_empty(queue));
    }
    while(!queue_is_empty(queue))
    {
        pcb_t* unblock_proc=queue->head;
        unblock_proc->status=TASK_READY;
        // Newly added in 2-4s
        unblock_proc->kernel_context.cp0_epc=unblock_proc->kernel_context.regs[31];
        //----------------------------------
        queue_dequeue(queue);
        queue_push(&ready_queue, unblock_proc);
    }
    return;
}

pid_t new_pid()
{
    return (++last_used_process_id);
}


void other_helper()
{
    printk("other_helper(int epc, int status) called.\n");
    other_check(current_running->kernel_context.cp0_epc);
    other_check(current_running->kernel_context.cp0_status);
    other_check(current_running->user_context.cp0_epc);
    other_check(current_running->user_context.cp0_status);
    other_check(current_running->user_context.cp0_cause);
    other_check(current_running->pid);
    other_check(current_running->block_time);
    other_check(current_running->run_cnt);
    other_check(current_running->reserved);
    other_check(current_running->sys_int_cnt);
    other_check(current_running->time_int_cnt);
    other_check(current_running->status);
    while(1);
    return;
}

extern mutex_lock_t mutex_lock;

void idle()
{
    printk("> [IDLE] ZzzZZZZZZZZZZZZZZZZZzzzZZZZZ.....\n");
    other_check(mutex_lock.lock_current);
    other_check(mutex_lock.lock_queue.head);
    other_check(mutex_lock.lock_queue.tail);
    other_check(mutex_lock.status);
    while(1)
    {
    }
}
