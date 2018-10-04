#include "lock.h"
#include "time.h"
#include "stdio.h"
#include "sched.h"
#include "queue.h"
#include "screen.h"

pcb_t pcb[NUM_MAX_TASK];

/* current running task PCB */
pcb_t *current_running;

/* global process id */
pid_t process_id = 1;

static void check_sleeping()
{
}

void scheduler(void)
{
    // TODO schedule
    // Modify the current_running pointer.
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
