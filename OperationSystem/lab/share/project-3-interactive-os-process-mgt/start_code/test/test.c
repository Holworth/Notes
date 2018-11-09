#include "test.h"//has test 3
#include "test2.h"
#include "test3.h"

//------------------------------------------------------------
// Priority set
//------------------------------------------------------------
// int timeslice_set[NUM_MAX_TASK]={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
// int priority_set[NUM_MAX_TASK]= {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
// int timeslice_set[NUM_MAX_TASK]={1,2,1,3,2,1,2,1,1,1,1,1,1,1,1,1};
// int priority_set[NUM_MAX_TASK]= {1,1,1,3,2,1,1,1,1,1,1,1,1,1,1,1};

//------------------------------------------------------------
// Lab 2
//------------------------------------------------------------

/* [TASK1] [TASK3] task group to test do_scheduler() */
// do_scheduler() annotations are required for non-robbed scheduling
struct task_info task2_1 = {"printk_task1",(uint32_t)&printk_task1, KERNEL_THREAD,1,1};
struct task_info task2_2 = {"printk_task2",(uint32_t)&printk_task2, KERNEL_THREAD,1,1};
struct task_info task2_3 = {"drawing_task1",(uint32_t)&drawing_task1, KERNEL_THREAD,1,1};
struct task_info *sched1_tasks[16] = {&task2_1, &task2_2, &task2_3};
int num_sched1_tasks = 3;

/* [TASK2] task group to test lock */
// test_lock1.c : Kernel space lock test
// test_lock2.c : User space lock test
struct task_info task2_4 = {"lock_task1",(uint32_t)&lock_task1, KERNEL_THREAD,1,1};
struct task_info task2_5 = {"lock_task2",(uint32_t)&lock_task2, KERNEL_THREAD,1,1};
struct task_info *lock_tasks[16] = {&task2_4, &task2_5};
int num_lock_tasks = 2;

/* [TASK4] task group to test interrupt */
// When the task is running, please implement the following system call :
// (1) sys_sleep()
// (2) sys_move_cursor()
// (3) sys_write()
struct task_info task2_6 = {"sleep_task",(uint32_t)&sleep_task, USER_PROCESS,1,1};
struct task_info task2_7 = {"timer_task",(uint32_t)&timer_task, USER_PROCESS,1,1};
struct task_info *timer_tasks[16] = {&task2_6, &task2_7};
int num_timer_tasks = 2;

struct task_info task2_8 = {"printf_task1",(uint32_t)&printf_task1, USER_PROCESS,1,1};
struct task_info task2_9 = {"printf_task2",(uint32_t)&printf_task2, USER_PROCESS,1,1};
struct task_info task2_10 = {"drawing_task2",(uint32_t)&drawing_task2, USER_PROCESS,1,1};
struct task_info *sched2_tasks[16] = {&task2_8, &task2_9, &task2_10};
int num_sched2_tasks = 3;

struct task_info *task4_tasks[16] = {&task2_8, &task2_9, &task2_10, &task2_6, &task2_7, &task2_4, &task2_5};
int num_task4_tasks = (3+2+2);

struct task_info task2_e1={"task2_e1", (uint32_t)&lock_task3, USER_PROCESS,1,1};
struct task_info task2_e2={"task2_e2", (uint32_t)&lock_task4, USER_PROCESS,1,1};
struct task_info task2_e3={"task2_e3", (uint32_t)&lock_task5, USER_PROCESS,1,1};

struct task_info *task5_tasks[16] = {&task2_8, &task2_9, &task2_10, &task2_6, &task2_7, &task2_4, &task2_5, &task2_e1, &task2_e2, &task2_e3};
int num_task5_tasks = (3+2+2+3);

//------------------------------------------------------------
// Lab 3
//------------------------------------------------------------

struct task_info shell_task={"Shell", (uint32_t)&test_shell, USER_PROCESS,1,1};
struct task_info *shell_tasks[16] = {&shell_task};
int num_shell_tasks= 1;
