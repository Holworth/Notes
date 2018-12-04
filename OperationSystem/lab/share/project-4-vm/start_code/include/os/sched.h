/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *        Process scheduling related content, such as: scheduler, process blocking, 
 *                 process wakeup, process creation, process kill, etc.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE. 
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * */

#ifndef INCLUDE_SCHEDULER_H_
#define INCLUDE_SCHEDULER_H_

#include "type.h"
#include "queue.h"
#include "vector.h"
#include "stack.h"
#include "mm.h"

#define NUM_MAX_TASK 16
#define ASM_USER 156

/* used to save register infomation */
typedef struct regs_context
{
    /* Saved main processor registers.*/
    /* 32 * 4B = 128B */
    uint32_t regs[32];

    /* Saved special registers. */
    /* 7 * 4B = 28B */
    uint32_t cp0_status;
    uint32_t hi;
    uint32_t lo;
    uint32_t cp0_badvaddr;
    uint32_t cp0_cause;
    uint32_t cp0_epc;
    uint32_t pc;

} regs_context_t; /* 128 + 28 = 156B */

typedef enum {
    TASK_BLOCKED,
    TASK_RUNNING,
    TASK_READY,
    TASK_EXITED,
} task_status_t;

typedef enum {
    KERNEL_PROCESS,
    KERNEL_THREAD,
    USER_PROCESS,
    USER_THREAD,
} task_type_t;

/* Process Control Block */
typedef struct pcb
{
    /* register context */
    regs_context_t kernel_context;
    regs_context_t user_context;
    
    uint32_t kernel_stack_top;
    uint32_t user_stack_top;

    /* previous, next pointer */
    void *prev;
    void *next;
    //used in algo queue

    /* process id */
    pid_t pid;

    /* kernel/user thread/process */
    task_type_t type;

    /* BLOCK | READY | RUNNING */
    task_status_t status;

    /* cursor position */
    int cursor_x;
    int cursor_y;

    // newly added struct contents are as following:

    /* parent process id */
    pid_t parent_pid;

    /* process priority level */
    int priority_level;

    /* process timeslice */
    int timeslice;

    /* process timeslice left */
    int timeslice_left;

    /* data saved for original priority_level and timeslice */
    //--------------------------------------
    /* process priority level */
    int priority_level_set;
    /* process timeslice */
    int timeslice_set;
    //--------------------------------------

    /* data saved for atuomatically get priority_level and timeslice */
    //---------------------------------------
    int time_int_cnt;
    int sys_int_cnt;
    //---------------------------------------


    /* block time */
    uint32_t block_time;

    /* sleep time */
    uint32_t sleep_time;

    /* process lock conut */
    int lock_cnt;

    /* entry position (for debug) */
    uint32_t entry;

    /* PCB valid */
    int valid;

    /* Process first run */
    int first_run;

    /* Process run counter */
    int run_cnt;

    /* Reserved for debug */
    int reserved;

    /* Wait PID */
    pid_t wait_pid;

    /* Current Queue */
    queue_t* current_queue;
    
    /* Lock Stack */
    vector_t lock_vector;

    /* Wait Queue */
    queue_t wait_queue;
    //Process waiting for current process to end;

    /* Process Name */
    char* name;

    // Virtual Memory Part //

    /* pte_L1p */
    pte_L1* pte_L1p;

    /* pte_L2p */
    pte_L2 (* pte_L2p)[256];

    /* pte_L2 used */
    int pte_L2_count;
    // char pte_L2_used[4];
    int pte_L2_clock;

    /* info used to do swap */
    swap_request_t swap_request;
} pcb_t;

/* task information, used to init PCB */
typedef struct task_info
{
    char* name;
    uint32_t entry_point;
    task_type_t type;
    int priority;
    int timeslice;
} task_info_t;

/* task information, used to init PCB */
// typedef struct task_info_with_name
// {
//     uint32_t entry_point;
//     task_type_t type;
//     char* name;
// } task_info_name_t;

/* ready queue to run */
extern queue_t ready_queue;

/* block queue to wait */
extern queue_t block_queue;

/* sleep queue to sleep */
extern queue_t sleep_queue;

/* wait for pid queue */
extern queue_t wait_queue;

/* current running task PCB */
extern pcb_t *current_running;
extern pid_t process_id;

/* last used process id */
extern pid_t last_used_process_id;

extern pcb_t pcb[NUM_MAX_TASK];
extern pcb_t empty_pcb_for_init;
extern pcb_t pcb_idle;
extern uint32_t initial_cp0_status;
extern uint32_t fake_scene_addr;

void do_scheduler(void);
int  do_sleep(uint32_t);

int do_block(queue_t *);
int do_unblock_one(queue_t *);
int do_unblock_all(queue_t *);

int do_spawn(struct task_info * task);
int do_kill(pid_t pid);
int do_exit();
int do_wait(pid_t pid);

int do_ps();
int do_getpid();

#include "sync.h"

extern void other_helper();
extern void idle();

// Newly introduced:

// void copy_pcb(pcb_t* tgt, pcb_t* src);
pid_t new_pid();

// extern pid_t last_used_process_id;
// extern queue_t ready_queue; //deled, use ready_queue instead
// extern queue_t block_queue;

void prepare_proc(pcb_t* pcbp, struct task_info * task);

void set_CP0_ENTRYHI_with_cpid();

#endif