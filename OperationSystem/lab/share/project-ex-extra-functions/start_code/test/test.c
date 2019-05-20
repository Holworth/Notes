#include "test.h"//has test 3
#include "test2.h"
#include "test3.h"

// This file setup tasks for non-shell test

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

//------------------------------------------------------------
// Lab 4+
//------------------------------------------------------------


// LAB 4,5

struct task_info task1 = {"lab4_drawing_task1", (uint32_t)&lab4_drawing_task1, USER_PROCESS,1,1};
struct task_info task2 = {"rw_task1", (uint32_t)&rw_task1, USER_PROCESS,1,1};
struct task_info vm_deamon = {"vm_deamon", (uint32_t)&deamon_vm, KERNEL_PROCESS,1,1};
struct task_info pressure_test_task = {"pressure_test1", (uint32_t)&pressure_test, USER_PROCESS,1,1};
struct task_info pressure_test_task2 = {"pressure_test2", (uint32_t)&pressure_test2, USER_PROCESS,1,1};
struct task_info mem_swap_test_task = {"mem_swap_test", (uint32_t)&mem_swap_test, USER_PROCESS,1,1};
struct task_info L2_swap_test_task = {"L2_swap_test", (uint32_t)&L2_swap_test, USER_PROCESS,1,1};
struct task_info phy_regs_test1_task = {"phy_regs_task1", (uint32_t)&phy_regs_task1, USER_PROCESS,1,1};
struct task_info phy_regs_test2_task = {"phy_regs_task2", (uint32_t)&phy_regs_task2, USER_PROCESS,1,1};
struct task_info phy_regs_test3_task = {"phy_regs_task3", (uint32_t)&phy_regs_task3, USER_PROCESS,1,1};
struct task_info phy_regs_bonus_task = {"phy_regs_task_bonus", (uint32_t)&phy_regs_task_bonus, KERNEL_PROCESS,10,10};
// struct task_info phy_regs_test1_task = {"phy_regs_task1", (uint32_t)&phy_regs_task1, KERNEL_PROCESS,1,1};
// struct task_info phy_regs_test2_task = {"phy_regs_task2", (uint32_t)&phy_regs_task2, KERNEL_PROCESS,1,1};
// struct task_info phy_regs_test3_task = {"phy_regs_task3", (uint32_t)&phy_regs_task3, KERNEL_PROCESS,1,1};
// struct task_info phy_regs_bonus_task = {"phy_regs_task_bonus", (uint32_t)&phy_regs_task_bonus, KERNEL_PROCESS,10,10};

// static struct task_info *test_tasks[16] = 
//     {
//         &task1, &task2, 
//         &vm_deamon,//2 
//         &pressure_test_task,//3
//         &pressure_test_task2,//4 
//         &mem_swap_test_task,//5
//         &L2_swap_test_task,//6
//         &phy_regs_test1_task,//7
//         &phy_regs_test2_task,//8
//         &phy_regs_test3_task,//9
//         &phy_regs_bonus_task//10
//     };

struct task_info *test_tasks[16] = 
    {
        &task1, &task2, 
        &vm_deamon,//2 
        &pressure_test_task,//3
        &pressure_test_task2,//4 
        &mem_swap_test_task,//5
        &L2_swap_test_task,//6
        &phy_regs_test1_task,//7
        &phy_regs_test2_task,//8
        &phy_regs_test3_task,//9
        &phy_regs_bonus_task//10
    };
int num_test_tasks = 10;
// static int num_test_tasks = 10;
