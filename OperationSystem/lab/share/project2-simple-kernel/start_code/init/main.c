/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *         The kernel's entry, where most of the initialization work is done.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this 
 * software and associated documentation files (the "Software"), to deal in the Software 
 * without restriction, including without limitation the rights to use, copy, modify, 
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit 
 * persons to whom the Software is furnished to do so, subject to the following conditions:
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

#include "irq.h"
#include "test.h"
#include "stdio.h"
#include "sched.h"
#include "screen.h"
#include "common.h"
#include "syscall.h"

#define PORT 0xbfe48000
#define bios_printstr 0x8007b980
#define STACK_BASE 0xa0f00000
#define STACK_SIZE 0x10000 
// current_running
// ready_queue

// #define PRIORITY_SCH

uint32_t stack_base_now = STACK_BASE;

uint32_t alloc_stack()
{
    // uint32_t t=stack_base_now;
    stack_base_now-=STACK_SIZE;
    return stack_base_now;
}

static void init_pcb()
{
    // For now, the func init_pcb will load the pcb list in test.c into pcb table;
    // Or you can say, what init_pcb is doing now is to use the pcb list in test.c as pcb table;
    // Firstly, it will init pcb as null, then load task list. Finally use pcb table to start up process queue.

    // Load task list.
    queue_init(&ready_queue);
    queue_init(&block_queue);
    queue_init(&sleep_queue);
	last_used_process_id=0;
	exception_handler_p=&exception_handler;
	fake_scene_addr=set_fake_scene();

	//task1
    // int task_num=num_sched1_tasks;
    // struct task_info **tasks_used =sched1_tasks;
	
	//task2
    // int task_num=num_lock_tasks;
    // struct task_info **tasks_used =lock_tasks;

	//task3
    // int task_num=num_sched1_tasks;
    // struct task_info **tasks_used =sched1_tasks;

	//task4-1
    // int task_num=num_timer_tasks;
    // struct task_info **tasks_used =timer_tasks;

	//task4-2
    // int task_num=num_sched2_tasks;
    // struct task_info **tasks_used =sched2_tasks;
	
	//task4-3
	//need to change Makefile
    // int task_num=num_lock_tasks;
    // struct task_info **tasks_used =lock_tasks;
	
	//task4-all
	//need to change Makefile
    // int task_num=num_task4_tasks;
    // struct task_info **tasks_used =task4_tasks;

	//task_extra
	//need to change Makefile
    int task_num=num_task5_tasks;
    struct task_info **tasks_used =task5_tasks;

	//task_shell
	//need to change Makefile
    // int task_num=1;
    // struct task_info **tasks_used =shell_tasks;


	int i;
    for(i=0;i<task_num;i++)
    {
		printk("\n");
        pcb[i].valid=1;
        pcb[i].pid=new_pid();
        pcb[i].type=tasks_used[i]->type;
        pcb[i].status=TASK_READY;
        pcb[i].entry=tasks_used[i]->entry_point;
        pcb[i].first_run=1;
        pcb[i].priority_level_set=priority_set[i];
        pcb[i].timeslice_set=timeslice_set[i];
        queue_push(&ready_queue,(void*)&(pcb[i]));
		//alloc stack in scheduler if 1st run
        // pcb[i].kernel_stack_top=alloc_stack();
        // pcb[i].user_stack_top=alloc_stack();
		check(i);
		check(&pcb[i]);
		check(pcb[i].pid);
		check(pcb[i].entry);
    }

	//init empty_pcb_for_init
	current_running=&empty_pcb_for_init;
	current_running->pid=0;
	current_running->timeslice=1;
	current_running->timeslice_left=1;
	current_running->priority_level=1;
	process_id=0;
	current_running->status=TASK_EXITED;
	printk("\n");

	//init pcb_idle
	pcb_idle.pid=0;
	pcb_idle.status=TASK_EXITED;
	pcb_idle.entry=idle;
	pcb_idle.first_run=1;
}

static void init_exception_handler()
{
	int i=0;
	for(i=0;i<32;i++)
	{
		exception_handler[i]=&handle_other;
	}
	exception_handler[0]=&handle_int;
	exception_handler[8]=&handle_syscall;
	memcpy(0x80000180,exception_handler_entry,(exception_handler_end-exception_handler_begin));
}

static void init_exception()
{
	//ref: P57
	//http://course.ucas.ac.cn/access/content/group/149542/%E4%BD%9C%E4%B8%9A%E8%B5%84%E6%96%99%E6%9B%B4%E6%96%B0/%E9%BE%99%E8%8A%AF2F%E5%A4%84%E7%90%86%E5%99%A8%E6%89%8B%E5%86%8C_v0.1.pdf
	// 将例外处理代码拷贝到例外处理入口、 初始化例外向量表，初始化 CP0_STATUS、CP0_COUNT、CP0_COMPARE 等异常处理相关寄存

	// 1. Get CP0_STATUS
	uint32_t cp0_status=get_CP0_STATUS();

	// 2. Disable all interrupt
	set_CP0_STATUS(cp0_status&0xFFFFFFFE);

	// 3. Copy the level 2 exception handling code to 0x80000180
	init_exception_handler();
	
	// 4. reset CP0_COMPARE & CP0_COUNT register
	// reset_count_compare();//TODO
	// set_CP0_COMPARE(0);
	set_CP0_COUNT(0);

}

static void init_syscall(void)
{
	// init system call table.

	syscall[SYSCALL_SLEEP]=&do_sleep;
	syscall[SYSCALL_BLOCK]=&do_block;
	syscall[SYSCALL_UNBLOCK_ONE]=&do_unblock_one;
	syscall[SYSCALL_UNBLOCK_ALL]=&do_unblock_all;

	// FIXIT:
	syscall[SYSCALL_WRITE]=&screen_write;
	// syscall[SYSCALL_READ]=&sys_read;???
	syscall[SYSCALL_CURSOR]=&screen_move_cursor;
	syscall[SYSCALL_REFLUSH]=&screen_reflush;
	syscall[SYSCALL_MUTEX_LOCK_INIT]=&do_mutex_lock_init;
	syscall[SYSCALL_MUTEX_LOCK_ACQUIRE]=&do_mutex_lock_acquire;
	syscall[SYSCALL_MUTEX_LOCK_RELEASE]=&do_mutex_lock_release;

	return;
}

// jump from bootloader.
// The beginning of everything >_< ~~~~~~~~~~~~~~
void __attribute__((section(".entry_function"))) _start(void)
{
	// Call PMON BIOS printstr to print message "Kernel: main.c called."
	// char hello_os[]="---------------------------\nOS Kernel by AW\n> [INIT] main.c called.\n";
	// asm("li $sp,0xa0f00000\n");
	char hello_os[]="> [INIT] main.c called.\n";
	char critical_point[]="> [TEST] critical_point.\n";
	void (*call_printstr)(char* ) = bios_printstr;
	call_printstr(hello_os);
	breakpoint=1;

	// Close the cache, no longer refresh the cache 
	// when making the exception vector entry copy
	asm_start();
	// interrupt_disable();
	printk("> [INIT] asm_start() succeeded.\n");
	// printk("> [INIT] printk() working nornally.\n");

	// init interrupt (^_^)
	init_exception();
	printk("> [INIT] Interrupt processing initialization succeeded.\n");

	// init system call table (0_0)
	init_syscall();
	printk("> [INIT] System call initialized successfully.\n");

	// init Process Control Block (-_-!)
	init_pcb();
	printk("> [INIT] PCB initialization succeeded.\n");

	// init screen (QAQ)
	#ifdef DEBUG
		printk("> [INIT] init_screen() closed for debugging.\n");
	#else
		init_screen();
		// printk("> [INIT] SCREEN initialization succeeded.\n");
	#endif

	printk("> Lagenaria siceraria OS\n");
	printk("> Copyright (C) 2018 Huaqiang Wang\n");

	// Enable interrupt
	// interrupt_enable_init();

	// uint32_t cp0_status=get_CP0_STATUS();
	// set_CP0_STATUS(cp0_status&0x10008001);
	// set_CP0_COMPARE(TIMER_INTERVAL);
	// set_CP0_COUNT(0);
	// while(breakpoint);
	
	while (1)
	{
		// (QAQQQQQQQQQQQ)
		// If you do non-preemptive scheduling, you need to use it to surrender control
		// printk("> [INIT] in while() loop.\n");
		do_scheduler();
		info("init_scheduler() called more than 1");
		// do_scheduler();
	};
	return;
}
