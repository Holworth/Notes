#include "lock.h"
#include "sync.h"
#include "sched.h"
#include "common.h"
#include "screen.h"
#include "syscall.h"

// int (*syscall[NUM_SYSCALLS])();

int system_call_helper(int fn, int arg1, int arg2, int arg3)
{
    // syscall[fn](arg1, arg2, arg3)
    // if(current_running->sys_int_cnt<100000)current_running->sys_int_cnt++;
    // current_running->sys_int_cnt++;
    syscall[fn](arg1, arg2, arg3);
}

int sys_nop()
{
    return;
}

int sys_sleep(uint32_t time)
{
    invoke_syscall(SYSCALL_SLEEP, time, IGNORE, IGNORE);
}

int sys_block(queue_t *queue)
{
    invoke_syscall(SYSCALL_BLOCK, (int)queue, IGNORE, IGNORE);
}

int sys_unblock_one(queue_t *queue)
{
    invoke_syscall(SYSCALL_UNBLOCK_ONE, (int)queue, IGNORE, IGNORE);
}

int sys_unblock_all(queue_t *queue)
{
    invoke_syscall(SYSCALL_UNBLOCK_ALL, (int)queue, IGNORE, IGNORE);
}

int sys_write(char *buff)
{
    invoke_syscall(SYSCALL_WRITE, (int)buff, IGNORE, IGNORE);
}

int sys_reflush()
{
    invoke_syscall(SYSCALL_REFLUSH, IGNORE, IGNORE, IGNORE);
}

int sys_move_cursor(int x, int y)
{
    invoke_syscall(SYSCALL_CURSOR, x, y, IGNORE);
}

int mutex_lock_init(mutex_lock_t *lock)
{
    invoke_syscall(SYSCALL_MUTEX_LOCK_INIT, (int)lock, IGNORE, IGNORE);
}

int mutex_lock_acquire(mutex_lock_t *lock)
{
    invoke_syscall(SYSCALL_MUTEX_LOCK_ACQUIRE, (int)lock, IGNORE, IGNORE);
}

int mutex_lock_release(mutex_lock_t *lock)
{
    invoke_syscall(SYSCALL_MUTEX_LOCK_RELEASE, (int)lock, IGNORE, IGNORE);
}

int sys_spawn(struct task_info * task)
{
    invoke_syscall(SYSCALL_SPAWN, (int)task, IGNORE, IGNORE);
}

int sys_kill(pid_t pid)
{
    invoke_syscall(SYSCALL_KILL, (int)pid, IGNORE, IGNORE);
}

int sys_exit()
{
    invoke_syscall(SYSCALL_EXIT, IGNORE, IGNORE, IGNORE);
}

int sys_wait(pid_t pid)
{
    invoke_syscall(SYSCALL_WAIT, (int)pid, IGNORE, IGNORE);
}

int sys_semaphore_init(semaphore_t *s, int val)
{
    invoke_syscall(SYSCALL_SEMAPHORE_INIT, (int)s, (int)val, IGNORE);
}

int sys_semaphore_up(semaphore_t *s)
{
    invoke_syscall(SYSCALL_SEMAPHORE_UP, (int)s, IGNORE, IGNORE);
}

int sys_semaphore_down(semaphore_t *s)
{
    invoke_syscall(SYSCALL_SEMAPHORE_DOWN, (int)s, IGNORE, IGNORE);
}

int sys_condition_init(condition_t *condition)
{
    invoke_syscall(SYSCALL_CONDITION_INIT, (int)condition, IGNORE, IGNORE);
}

int sys_condition_wait(mutex_lock_t *lock, condition_t *condition)
{
    invoke_syscall(SYSCALL_CONDITION_WAIT, (int)lock, (int)condition, IGNORE);
}

int sys_condition_signal(condition_t *condition)
{
    invoke_syscall(SYSCALL_CONDITION_SIGNAL, (int)condition, IGNORE, IGNORE);
}

int sys_condition_broadcast(condition_t *condition)
{
    invoke_syscall(SYSCALL_CONDITION_BROADCAST, (int)condition, IGNORE, IGNORE);
}

int sys_barrier_init(barrier_t *barrier, int goal)
{
    invoke_syscall(SYSCALL_BARRIER_INIT, (int)barrier, (int)goal, IGNORE);
}

int sys_barrier_wait(barrier_t *barrier)
{
    invoke_syscall(SYSCALL_BARRIER_WAIT, (int)barrier, IGNORE, IGNORE);
}

int sys_ps()
{
    invoke_syscall(SYSCALL_PS, IGNORE, IGNORE, IGNORE);
}

int sys_getpid()
{
    invoke_syscall(SYSCALL_GETPID, IGNORE, IGNORE, IGNORE);
}


int sys_init_mac()
{
    invoke_syscall(SYSCALL_INIT_MAC, IGNORE, IGNORE, IGNORE);
}


// int sys_net_send(uint32_t tgt DMA send desc, uint32_t td_phy)
int sys_net_send(uint32_t td, uint32_t td_phy)
{
    invoke_syscall(SYSCALL_NET_SEND, (int)td, (int)td_phy, IGNORE);
}

// int sys_net_recv(uint32_t, uint32_t, uint32_t)
int sys_net_recv(uint32_t rd, uint32_t rd_phy, uint32_t daddr)
{
    invoke_syscall(SYSCALL_NET_RECV, (int)rd, (int)rd_phy, (int)daddr);
}

int sys_wait_recv_package()
{
    invoke_syscall(SYSCALL_WAIT_RECV_PACKAGE, IGNORE, IGNORE, IGNORE);
}

int sys_net_fast_recv(uint32_t rd, uint32_t rd_phy, uint32_t daddr)
{
    invoke_syscall(SYSCALL_NET_FAST_RECV, (int)rd, (int)rd_phy, (int)daddr);
}

int sys_ftouch(char *name)
{
    return invoke_syscall(SYSCALL_FTOUCH, (int)name,IGNORE,IGNORE);
}
int sys_fcat(char *name)
{
    return invoke_syscall(SYSCALL_FCAT, (int)name,IGNORE,IGNORE);
}
int sys_fopen(char *name, int access)
{
    return invoke_syscall(SYSCALL_FOPEN, (int)name, (int)access,IGNORE);
}
int sys_fclose(int fd)
{
    return invoke_syscall(SYSCALL_FCLOSE, (int)fd,IGNORE,IGNORE);
}
int sys_fread(int fd, char *buff, int size)
{
    return invoke_syscall(SYSCALL_FREAD, (int)fd, (int)buff, (int)size);
}
int sys_fwrite(int fd, char *buff, int size)
{
    return invoke_syscall(SYSCALL_FWRITE, (int)fd, (int)buff, (int)size);
}
int sys_ffind(char *path, char *name)
{
    return invoke_syscall(SYSCALL_FFIND, (int)path, (int)name,IGNORE);
}
int sys_frename(char *old_name, char *new_name)
{
    return invoke_syscall(SYSCALL_FRENAME, (int)old_name, (int)new_name,IGNORE);
}
int sys_fln(char *target, char *linkname, char *para)
{
    return invoke_syscall(SYSCALL_FLN, (int)target, (int)linkname, (int)para);
}
int sys_fseek(int fd, uint32_t offset)
{
    return invoke_syscall(SYSCALL_FSEEK, (int)fd, (int)offset,IGNORE);
}
