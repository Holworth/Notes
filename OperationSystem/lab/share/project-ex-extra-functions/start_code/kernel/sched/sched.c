#include "lock.h"
#include "time.h"
#include "stdio.h"
#include "sched.h"
#include "queue.h"
#include "screen.h"
#include "lock.h"
#include "test.h"
#include "mm.h"

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
queue_t wait_queue;

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

void prepare_proc(pcb_t* pcbp, struct task_info * task)
{
    printk("\n");
    pcbp->valid=1;
    pcbp->pid=new_pid();
    pcbp->type=task->type;
    pcbp->status=TASK_READY;
    pcbp->entry=task->entry_point;
    pcbp->first_run=1;
    //TODO
    // pcbp->priority_level_set=priority_set;
    pcbp->priority_level_set=task->priority;
    // pcbp->timeslice_set=timeslice_set;
    pcbp->timeslice_set=task->timeslice;

    pcbp->kernel_stack_top=alloc_stack();
    if((pcbp->type==KERNEL_PROCESS)|(pcbp->type==KERNEL_THREAD))
    {
        pcbp->user_stack_top=alloc_stack();
    }else
    {
        // pcbp->user_stack_top=alloc_stack();
        pcbp->user_stack_top=0x70000000; 
    }

    pcbp->priority_level=pcbp->priority_level_set;
    pcbp->timeslice=pcbp->timeslice_set;
    pcbp->timeslice_left=pcbp->timeslice_set;
    pcbp->block_time=time_elapsed;

    pcbp->kernel_context.cp0_status=0x0;//close interrupt
    pcbp->kernel_context.cp0_cause=0x0;
    // pcbp->user_context.cp0_status=0x1000ff02;
    pcbp->user_context.cp0_status=0x10008002;
    pcbp->user_context.cp0_cause=0x0;

    pcbp->kernel_context.regs[31]=fake_scene_addr;
    pcbp->user_context.regs[31]=pcbp->entry;
    pcbp->kernel_context.regs[29]=pcbp->kernel_stack_top;
    pcbp->user_context.regs[29]=pcbp->user_stack_top;
    pcbp->user_context.cp0_epc=pcbp->entry;//set entry

    pcbp->name=task->name;

    queue_init(&pcbp->wait_queue);

    queue_push(&ready_queue,(void*)(pcbp));

    vector_init(&pcbp->lock_vector);

    check(pcbp);
    check(pcbp->pid);
    check(pcbp->entry);
    check(pcbp->name);

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
    check(current_running->user_context.cp0_status);
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

    if(current_running->first_run)
    {
        current_running->first_run=0;
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
    set_CP0_ENTRYHI_with_cpid();
    check(current_running->kernel_context.regs[31]);
    check(current_running->kernel_context.regs[29]);
    check(current_running->user_context.regs[31]);
    check(current_running->user_context.regs[29]);
    check(current_running->user_context.cp0_epc);
    check(current_running->user_context.cp0_status);
    return;
}

int do_sleep(uint32_t sleep_time)
{
    current_running->sleep_time=sleep_time;
    do_block(&sleep_queue);
}

int do_block(queue_t *queue)
{
    // block the current_running task into the queue
    current_running->status=TASK_BLOCKED;
    current_running->block_time=time_elapsed;
    current_running->sys_int_cnt++;
    queue_push(queue, current_running);
    do_scheduler();
}

int do_unblock(queue_t *queue, pcb_t* pcbp)
{
    // unblock the head task from the queue
    if(queue_is_empty(queue))
    {
        panic("UNBLOCK_EMPTY_QUEUE");
    }
    pcb_t* unblock_proc=pcbp;
    queue_remove(queue, pcbp);
    unblock_proc->status=TASK_READY;
    //Newly added in 2-4
    // unblock_proc->kernel_context.cp0_epc=unblock_proc->kernel_context.regs[31];
    //----------------------------------
    queue_push(&ready_queue, unblock_proc);
    return 0;
}

int do_unblock_one(queue_t *queue)
{
    // unblock the head task from the queue
    if(queue_is_empty(queue))
    {
        panic("UNBLOCK_EMPTY_QUEUE");
    }
    pcb_t* unblock_proc=queue->head;
    queue_dequeue(queue);
    unblock_proc->status=TASK_READY;
    //Newly added in 2-4
    // unblock_proc->kernel_context.cp0_epc=unblock_proc->kernel_context.regs[31];
    //----------------------------------
    queue_push(&ready_queue, unblock_proc);
    return 0;
}

//TODO
int do_unblock_high_priority(queue_t *queue)
{
    // unblock the task from the queue
    if(queue_is_empty(queue))
    {
        panic("UNBLOCK_EMPTY_QUEUE");
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
    queue_push(&ready_queue, max_priority_proc);
    return 0;
}

int 
do_unblock_all(queue_t *queue)
{
    // unblock all task in the queue
    if(queue_is_empty(queue))
    {
        // printk("> [INFO] do_unblock_all() an empty queue\n");
        return 0;
    }
    while(!queue_is_empty(queue))
    {
        pcb_t* unblock_proc=queue->head;
        unblock_proc->status=TASK_READY;
        queue_dequeue(queue);
        queue_push(&ready_queue, unblock_proc);
    }
    return 0;
}

inline void free_proc_resource(pcb_t* pcbp)
{
    //free stack
    if((pcbp->kernel_stack_top&0x80000000))
    {
        // printk("boom1, %x, %x \n", pcbp->kernel_stack_top, pcbp->kernel_stack_top&0x80000000);
        stack_push(&freed_stack, pcbp->kernel_stack_top);
    }
    if((pcbp->user_stack_top&0x80000000))
    {
        // printk("boom2, %x, %x \n", pcbp->user_stack_top, pcbp->user_stack_top&0x80000000);
        stack_push(&freed_stack, pcbp->user_stack_top);
    }

    //free current queues
    queue_t* queuei = pcbp->current_queue;
    if(queue_exist(queuei, pcbp))
    {
        queue_remove(queuei, pcbp);
    }

    //set status
    pcbp->status=TASK_EXITED;
    //free pcb
    pcbp->valid=0;

    //free proc waiting for it to end
    do_unblock_all(&pcbp->wait_queue);

    //free all locks it holds
    while(!vector_is_empty(&pcbp->lock_vector))
    {
        do_other_mutex_lock_release(pcbp, pcbp->lock_vector.head->data);//bug fixed: 2018.11.14
    }
}

int find_free_pcb()
{
    int i;
    for(i=0;i<NUM_MAX_TASK;i++)
    {
        if(!pcb[i].valid)return i;
    }
    return -1;
}

//TODO
int do_spawn(struct task_info * task)
{
    int i=-1;
    i=find_free_pcb();
    if(i==-1)
    {
        printsys("panic: pcb full.\n");
        return -1;
    }

    prepare_proc(&pcb[i],task);
    return 0;
}

// void wakeup_wait(pid_t pid)
// {
//     pcb_t* i=wait_queue.head;
//     while(i)
//     {
//         if(i->wait_pid==pid)do_unblock_one();
//         i=i->next;
//     }
// }

int do_kill(pid_t pid)
{
    pcb_t * tgt_pcb=0;
    int i;
    for(i=0;i<NUM_MAX_TASK;i++)
    {
        if(pcb[i].pid==pid)tgt_pcb=&pcb[i];
    }
    if(tgt_pcb)
    {
        free_proc_resource(tgt_pcb);
    }
    else
        printsys("DO_KILL FAILED.\n");
}

int do_exit()
{
    free_proc_resource(current_running);
    do_scheduler();
}

int do_wait(pid_t pid)
{
    //If pid not running: just run;
    int i;
    for(i=0;i<NUM_MAX_TASK;i++)
    {
        if(pcb[i].valid&&(pcb[i].pid==pid))
        {
            current_running->wait_pid=pid;
            do_block(&pcb[i].wait_queue);
            current_running->wait_pid=NULL;
            return;
        }
    }
    printsys("error: pid %d does not exist.\n", pid);
    return;
    
}

pid_t new_pid()
{
    return (++last_used_process_id);
}

int panic(char* error_name)
{

    printk("# [ERROR] %s\n",error_name);
    other_check(current_running->pid);
    // other_check(current_running->status);
    // other_check(current_running->kernel_context.cp0_epc);
    // other_check(current_running->kernel_context.cp0_status);
    // other_check(current_running->user_context.cp0_epc);
    other_check(current_running->user_context.cp0_status);
    // other_check(current_running->user_context.cp0_cause);
    // other_check(current_running->user_context.cp0_badvaddr);
    other_check(get_CP0_EPC());
    other_check(get_CP0_BADVADDR());
    other_check(get_CP0_CAUSE());
    other_check(get_cp0_status());
    error_ps();
    printk("ze:%x at:%x v0:%x v1:%x\n",
        current_running->kernel_context.regs[0],
        current_running->kernel_context.regs[1],
        current_running->kernel_context.regs[2],
        current_running->kernel_context.regs[3]
        );
    printk("a0:%x a1:%x a2:%x a3:%x\n",
        current_running->kernel_context.regs[4],
        current_running->kernel_context.regs[5],
        current_running->kernel_context.regs[6],
        current_running->kernel_context.regs[7]
        );
    printk("t0:%x t1:%x t2:%x t3:%x\n",
        current_running->kernel_context.regs[8],
        current_running->kernel_context.regs[9],
        current_running->kernel_context.regs[10],
        current_running->kernel_context.regs[11]
        );
    printk("t4:%x t5:%x t6:%x t7:%x\n",
        current_running->kernel_context.regs[12],
        current_running->kernel_context.regs[13],
        current_running->kernel_context.regs[14],
        current_running->kernel_context.regs[15]
        );
    printk("s0:%x s1:%x s2:%x s3:%x\n",
        current_running->kernel_context.regs[16],
        current_running->kernel_context.regs[17],
        current_running->kernel_context.regs[18],
        current_running->kernel_context.regs[19]
        );
    printk("s4:%x s5:%x s6:%x s7:%x\n",
        current_running->kernel_context.regs[20],
        current_running->kernel_context.regs[21],
        current_running->kernel_context.regs[22],
        current_running->kernel_context.regs[23]
        );
    printk("t8:%x t9:%x k0:%x k1:%x\n",
        current_running->kernel_context.regs[24],
        current_running->kernel_context.regs[25],
        current_running->kernel_context.regs[26],
        current_running->kernel_context.regs[27]
        );
    printk("gp:%x sp:%x fp:%x ra:%x\n",
        current_running->kernel_context.regs[28],
        current_running->kernel_context.regs[29],
        current_running->kernel_context.regs[30],
        current_running->kernel_context.regs[31]
        );
    while(1);
    return;
}


void other_helper()
{
    tlb_info();
    // other_check(current_running->pid);
    // other_check(current_running->status);
    // other_check(current_running->kernel_context.cp0_epc);
    // other_check(current_running->kernel_context.cp0_status);
    // other_check(current_running->user_context.cp0_epc);
    // other_check(current_running->user_context.cp0_status);
    // other_check(current_running->user_context.cp0_cause);
    // error_ps();
    panic("OTHER_HELPER");
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

int proc_exist(pid_t pid)
{
    if (pid==0)return 0;
    int i;
    for(i=0;i<NUM_MAX_TASK;i++)
    {
        if(pcb[i].status!=TASK_EXITED)
        {
            if(pcb[i].pid==pid)return 1;
        }
    }
    return 0;
}


char* str_running="RUNNING";
char* str_ready="READY";
char* str_blocked="BLOCKED";
char* str_sleep="SLEEPING";
char* str_exit="EXITED";
char* str_unknown="UNKNOWN";

inline char* status_to_str(task_status_t status)
{
    switch(status)
    {
        case TASK_RUNNING: return str_running;
        case TASK_READY: return str_ready;
        case TASK_BLOCKED: return str_blocked;
        case TASK_EXITED: return str_exit;
        return str_unknown;
    }
}

int do_ps()
{
    printsys("[Process Table] --------------------\n");
    int i=0;
    int cnt=0;
    for(;i<NUM_MAX_TASK;i++)
    {
        if(pcb[i].valid)
        {
            printsys("[%d] PID: %d  STATUS: %s  NAME: %s\n",cnt++,pcb[i].pid,status_to_str(pcb[i].status), pcb[i].name);
        }
    }
}


void error_ps()
{
    printk("\n[Process Table] --------------------\n");
    int i=0;
    int cnt=0;
    for(;i<NUM_MAX_TASK;i++)
    {
        if(pcb[i].valid)
        {
            printk("[%d] PID: %d  STATUS: %s  NAME: %s\n",cnt++,pcb[i].pid,status_to_str(pcb[i].status), pcb[i].name);
            // printk("[%d]\n",cnt++);
            // printk("NAME: %s\n", pcb[i].name);
            // printk("PID: %d\n",pcb[i].pid);
            // printk("STATUS: %s\n",status_to_str(pcb[i].status));
            // check(pcb[i].user_context.cp0_epc);
        }
    }
}


int do_getpid()
{
    return current_running->pid;
}

void set_CP0_ENTRYHI_with_cpid()
{
    set_CP0_ENTRYHI(current_running->pid&0xff);
}

void set_breakpoint()
{
    printk("BP");
    return;
}
