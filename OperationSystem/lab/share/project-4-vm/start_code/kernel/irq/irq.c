#include "irq.h"
#include "time.h"
#include "sched.h"
#include "string.h"
#include "screen.h"

// #define AUTO_UPDATE_PRIORITY

uint32_t preemptive_cnt;

static int timeslice_runout()
{
    current_running->timeslice_left--;
    if(current_running->timeslice_left>0)
    {
        return 0;
    }
    current_running->timeslice_left=current_running->timeslice;
    return 1;
}

static void wakeup_sleep()
{
// check_sleeping();
    if(queue_is_empty(&sleep_queue))
    {
        //do nothing
    }else
    {
        pcb_t* proc=sleep_queue.head;
        pcb_t* temp_pcb_p=0;
        uint32_t timepassed=0;
        do
        {
            timepassed=time_elapsed-proc->block_time;
            if(timepassed>proc->sleep_time)
            {
                proc->status=TASK_READY;
                temp_pcb_p=proc;
                proc=proc->next;
                queue_remove(&sleep_queue, temp_pcb_p);
                queue_push(&ready_queue, temp_pcb_p);
            }else
            {
                proc=proc->next;
            }
        }while(proc!=NULL);
    }
}

static void auto_update_priority()
{
    if(current_running->sys_int_cnt>2*(current_running->time_int_cnt))
    {
        current_running->priority_level=current_running->priority_level_set+1;
    }
    if(current_running->sys_int_cnt*2<(current_running->time_int_cnt))
    {
        current_running->timeslice=current_running->timeslice_set+1;
    }
    return;
}

static void irq_timer()
{
    // TODO clock interrupt handler.
    // scheduler, time counter in here to do, emmmmmm maybe.
    // 时钟中断的触发涉及 CP0_COUNT、CP0_COMPARE 寄存器，CP0_COUNT 寄存器的值每个时钟周期会自动增加， 当 CP0_COUNT 和 CP0_COMPARE 寄存器的值相等时会触发一个时钟中断
    time_elapsed++;

    wakeup_sleep();
    screen_reflush();

    if(timeslice_runout())
    {
        current_running->time_int_cnt++;
        current_running->cursor_x=screen_cursor_x;
        current_running->cursor_y=screen_cursor_y;
        #ifdef AUTO_UPDATE_PRIORITY
        auto_update_priority();
        #endif
        do_scheduler();//FIXIT
        screen_cursor_x=current_running->cursor_x;
        screen_cursor_y=current_running->cursor_y;
    }
    // set_CP0_COMPARE(TIMER_INTERVAL) in preemptive_scheduler();
    return;
}

void interrupt_helper(uint32_t status, uint32_t cause)
{
    // TODO interrupt handler.
    // Leve3 exception Handler.
    // read CP0 register to analyze the type of interrupt.
    uint32_t ip=status>>8;
    ip&=0x000000FF;
    if(ip==(1<<7))//ip[7]==1
    {
        irq_timer();
        return;
    }
}

void other_exception_handler()
{
    // TODO other exception handler
}