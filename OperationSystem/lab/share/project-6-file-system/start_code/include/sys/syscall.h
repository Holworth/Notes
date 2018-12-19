/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *                       System call related processing
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

#ifndef INCLUDE_SYSCALL_H_
#define INCLUDE_SYSCALL_H_

#include "type.h"
#include "sync.h"
#include "queue.h"
#include "sched.h"

#define IGNORE 0
#define NUM_SYSCALLS 64

/* define */
// #define IGNORE 0
#define SYSCALL_SLEEP 2

#define SYSCALL_BLOCK 10
#define SYSCALL_UNBLOCK_ONE 11
#define SYSCALL_UNBLOCK_ALL 12

#define SYSCALL_WRITE 20
#define SYSCALL_READ 21
#define SYSCALL_CURSOR 22
#define SYSCALL_REFLUSH 23

#define SYSCALL_SPAWN 24
#define SYSCALL_KILL 25
#define SYSCALL_EXIT 26
#define SYSCALL_WAIT 27

#define SYSCALL_MUTEX_LOCK_INIT 30
#define SYSCALL_MUTEX_LOCK_ACQUIRE 31
#define SYSCALL_MUTEX_LOCK_RELEASE 32

#define SYSCALL_SEMAPHORE_INIT 33
#define SYSCALL_SEMAPHORE_UP 34
#define SYSCALL_SEMAPHORE_DOWN 35
#define SYSCALL_CONDITION_INIT 36
#define SYSCALL_CONDITION_WAIT 37
#define SYSCALL_CONDITION_SIGNAL 38
#define SYSCALL_CONDITION_BROADCAST 39
#define SYSCALL_BARRIER_INIT 40
#define SYSCALL_BARRIER_WAIT 41

#define SYSCALL_PS 42
#define SYSCALL_GETPID 43

#define SYSCALL_INIT_MAC 44
#define SYSCALL_NET_SEND 45
#define SYSCALL_NET_RECV 46
#define SYSCALL_WAIT_RECV_PACKAGE 47
#define SYSCALL_NET_FAST_RECV 48


/* syscall function pointer */
int (*syscall[NUM_SYSCALLS])();

int system_call_helper(int, int, int, int);
extern int invoke_syscall(int, int, int, int);

int sys_nop();
int sys_sleep(uint32_t);

int sys_block(queue_t *);
int sys_unblock_one(queue_t *);
int sys_unblock_all(queue_t *);

int sys_write(char *);
int sys_move_cursor(int, int);
int sys_reflush();

int mutex_lock_init(mutex_lock_t *);
int mutex_lock_acquire(mutex_lock_t *);
int mutex_lock_release(mutex_lock_t *);

int sys_spawn(struct task_info * task);
int sys_kill(pid_t pid);
int sys_exit();
int sys_wait(pid_t pid);

int sys_semaphore_init(semaphore_t *s, int val);
int sys_semaphore_up(semaphore_t *s);
int sys_semaphore_down(semaphore_t *s);
int sys_condition_init(condition_t *condition);
int sys_condition_wait(mutex_lock_t *lock, condition_t *condition);
int sys_condition_signal(condition_t *condition);
int sys_condition_broadcast(condition_t *condition);
int sys_barrier_init(barrier_t *barrier, int goal);
int sys_barrier_wait(barrier_t *barrier);
int sys_ps();
int sys_getpid();

int sys_init_mac();
int sys_net_send(uint32_t td, uint32_t td_phy);
int sys_net_recv(uint32_t rd, uint32_t rd_phy, uint32_t daddr);
int sys_wait_recv_package();
int sys_net_fast_recv(uint32_t rd, uint32_t rd_phy, uint32_t daddr);


#endif