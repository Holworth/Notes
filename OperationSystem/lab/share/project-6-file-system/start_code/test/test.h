/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
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

#ifndef INCLUDE_TEST_H_
#define INCLUDE_TEST_H_

#include "test3.h"
#include "test4.h"
#include "test_net.h"
#include "sched.h"


extern struct task_info *sched1_tasks[16];
extern int num_sched1_tasks;

extern struct task_info *lock_tasks[16];
extern int num_lock_tasks;

extern struct task_info *timer_tasks[16];
extern int num_timer_tasks;

extern struct task_info *sched2_tasks[16];
extern int num_sched2_tasks;

extern struct task_info *task4_tasks[16];
extern int num_task4_tasks;

extern struct task_info *task5_tasks[16];
extern int num_task5_tasks;

extern struct task_info *shell_tasks[16];
extern int num_shell_tasks;

// extern int timeslice_set[NUM_MAX_TASK];
// extern int priority_set[NUM_MAX_TASK];

// ------------------------------------------


// LAB3
// struct task_info task1 = {"ready_to_exit_task", (uint32_t)&ready_to_exit_task, USER_PROCESS, 1, 1};
// struct task_info task2 = {"wait_lock_task", (uint32_t)&wait_lock_task, USER_PROCESS, 1, 1};
// struct task_info task3 = {"wait_exit_task", (uint32_t)&wait_exit_task, USER_PROCESS, 1, 1};

// struct task_info task4 = {"semaphore_add_task1", (uint32_t)&semaphore_add_task1, USER_PROCESS, 1, 1};
// struct task_info task5 = {"semaphore_add_task2", (uint32_t)&semaphore_add_task2, USER_PROCESS, 1, 1};
// struct task_info task6 = {"semaphore_add_task3", (uint32_t)&semaphore_add_task3, USER_PROCESS, 1, 1};

// struct task_info task7 = {"producer_task", (uint32_t)&producer_task, USER_PROCESS, 1, 1};
// struct task_info task8 = {"consumer_task1", (uint32_t)&consumer_task1, USER_PROCESS, 1, 1};
// struct task_info task9 = {"consumer_task2", (uint32_t)&consumer_task2, USER_PROCESS, 1, 1};

// struct task_info task10 = {"barrier_task1", (uint32_t)&barrier_task1, USER_PROCESS, 1, 1};
// struct task_info task11 = {"barrier_task2", (uint32_t)&barrier_task2, USER_PROCESS, 1, 1};
// struct task_info task12 = {"barrier_task3", (uint32_t)&barrier_task3, USER_PROCESS, 1, 1};

// struct task_info task13 = {"SunQuan", (uint32_t)&SunQuan, USER_PROCESS, 1, 1};
// struct task_info task14 = {"LiuBei", (uint32_t)&LiuBei, USER_PROCESS, 1, 1};
// struct task_info task15 = {"CaoCao", (uint32_t)&CaoCao, USER_PROCESS, 1, 1};

// static struct task_info *test_tasks[16] = {&task1, &task2, &task3,
//                                            &task4, &task5, &task6,
//                                            &task7, &task8, &task9,
//                                            &task10, &task11, &task12,
//                                            &task13, &task14, &task15};
// static int num_test_tasks = 15;


//-------------------------------------

extern struct task_info task1;
extern struct task_info task2;
extern struct task_info vm_deamon;
extern struct task_info pressure_test_task;
extern struct task_info pressure_test_task2;
extern struct task_info mem_swap_test_task;
extern struct task_info L2_swap_test_task;
extern struct task_info phy_regs_test1_task;
extern struct task_info phy_regs_test2_task;
extern struct task_info phy_regs_test3_task;
extern struct task_info phy_regs_bonus_task;

extern struct task_info *test_tasks[16];
extern int num_test_tasks;

#endif