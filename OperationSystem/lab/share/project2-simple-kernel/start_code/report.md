#### 0.0.0.1. 操作系统研讨课实验

# 1. Project2-A Simple Kernel

* 王华强
* 2016K8009929035
* wanghuaqiang16@mails.ucas.ac.cn

---

# 2. 目录

<!-- TOC -->

            - [0.0.0.1. 操作系统研讨课实验](#0001-操作系统研讨课实验)
- [1. Project2-A Simple Kernel](#1-project2-a-simple-kernel)
- [2. 目录](#2-目录)
- [3. 实验简述](#3-实验简述)
- [4. 系统整体设计](#4-系统整体设计)
- [5. 实验相关建议](#5-实验相关建议)
- [6. 实验实现细节](#6-实验实现细节)
    - [6.1. 开发环境与工具配置](#61-开发环境与工具配置)
    - [6.2. 任务启动与Context Switching设计](#62-任务启动与context-switching设计)
        - [6.2.1. PCB设计](#621-pcb设计)
        - [6.2.2. 第一个TASK的启动](#622-第一个task的启动)
        - [6.2.3. 上下文切换](#623-上下文切换)
        - [6.2.4. 调度器逻辑](#624-调度器逻辑)
        - [6.2.5. 补充](#625-补充)
    - [6.3. 时钟中断、系统调用与blocking sleep设计](#63-时钟中断系统调用与blocking-sleep设计)
        - [6.3.1. 一般例外处理流程](#631-一般例外处理流程)
        - [6.3.2. 标准中断处理](#632-标准中断处理)
        - [6.3.3. 时钟中断处理流程](#633-时钟中断处理流程)
            - [6.3.3.1. 例外入口函数拷贝](#6331-例外入口函数拷贝)
        - [6.3.4. sleep()及时钟中断](#634-sleep及时钟中断)
            - [6.3.4.1. 时钟中断触发时的工作](#6341-时钟中断触发时的工作)
            - [6.3.4.2. sleep()实现](#6342-sleep实现)
        - [sleep唤醒的优化](#sleep唤醒的优化)
        - [6.3.6. 时钟中断处理流程与系统调用处理流程的比较](#636-时钟中断处理流程与系统调用处理流程的比较)
            - [相同步骤](#相同步骤)
            - [不同步骤](#不同步骤)
    - [6.4. 优先级调度器](#64-优先级调度器)
        - [6.4.1. 基于优先级的调度器设计思考](#641-基于优先级的调度器设计思考)
        - [6.4.2. priority-based scheduler的设计思路，包括在你实现的调度策略中优先级是怎么定义的，何时给task赋予优先级，测试结果如何体现优先级的差别](#642-priority-based-scheduler的设计思路包括在你实现的调度策略中优先级是怎么定义的何时给task赋予优先级测试结果如何体现优先级的差别)
    - [6.5. 锁设计](#65-锁设计)
        - [6.5.1. spin-lock和mutual lock的区别](#651-spin-lock和mutual-lock的区别)
        - [6.5.2. 能获取到锁和获取不到锁时各自的处理流程](#652-能获取到锁和获取不到锁时各自的处理流程)
            - [6.5.2.1. 获取锁时的动作](#6521-获取锁时的动作)
            - [6.5.2.2. 释放锁时的动作](#6522-释放锁时的动作)
        - [6.5.3. Mutex Lock 实现](#653-mutex-lock-实现)
        - [6.5.4. Task的阻塞](#654-task的阻塞)
        - [6.5.5. 设计、实现或调试过程中遇到的问题和得到的经验（如果有的话可以写下来，不是必需项）](#655-设计实现或调试过程中遇到的问题和得到的经验如果有的话可以写下来不是必需项)
        - [6.5.6. 如何处理一个进程获取多把锁](#656-如何处理一个进程获取多把锁)
        - [6.5.7. 如何处理多个进程获取一把锁](#657-如何处理多个进程获取一把锁)
        - [6.5.8. 你的测试用例和结果介绍](#658-你的测试用例和结果介绍)
- [7. 额外讨论](#7-额外讨论)
    - [7.0.9. 龙芯处理器的异常处理机制](#709-龙芯处理器的异常处理机制)
    - [7.0.10. 调度器的两种实现方式](#7010-调度器的两种实现方式)
    - [7.0.11. 死锁](#7011-死锁)
    - [7.0.12. IDLE(处理器空闲状态)](#7012-idle处理器空闲状态)
    - [整体设计的两种方式及思考](#整体设计的两种方式及思考)
- [8. 参考文献](#8-参考文献)
- [9. 致谢](#9-致谢)

<!-- /TOC -->

---

# 3. 实验简述

实验要求: 

设计一个简单的操作系统内核和工具栈, 实现任务的抢占式调度, 非抢占式调度, 互斥锁的实现, 系统调用的实现, 基于优先级的调度器设计.

完成优先级设置逻辑, 设计优先级相关的测试用例并给出结果.

设计更加复杂的锁机制并进行测试.

---

# 4. 系统整体设计

工具链架构如下:

```mermaid
graph TD;

subgraph toolchain
Makefile-->createimage
.gdbinit-->gdb
shellscript-->debug_env
gdb-->debug_env
qemu_simulator-->debug_env
createimage-->image
image-->qemu_simulator
image-->make_floppy
end

kernel


```

--

系统整体架构如下:

```mermaid
graph LR;

subgraph kernel

scheduler

    bootblock.S-->system_init
    system_init-->fake_scene_for_1st_proc
    fake_scene_for_1st_proc-->scheduler

    system_init-->global_vars_:_pcb,queue,etc

    subgraph interrupt
        subgraph clock_interrupt
            clock_interrupt-->scheduler
        end
    
        subgraph syscall
            lock_syscall-->scheduler
            print_syscall
            sleep_syscall-->scheduler
        end
    
        subgraph others
            debug_func
        end
    end

end


subgraph task
test_sch_etc.
end

```

--

系统启动流程如下:

```mermaid
graph LR;
系统启动-->初始化例外处理
初始化例外处理-->初始化syscall
初始化syscall-->初始化PCB表
初始化PCB表-->调度器
调度器-->第一个进程的虚拟现场
第一个进程的虚拟现场--开中断-->进程
调度器-->进程
进程-->中断
中断-->调度器
```

--

进程运行状态转移图如下:

```mermaid
graph TD;

进程启动状态-->进程等待队列
进程等待队列--需要运行下一个进程-->进程运行状态
进程运行状态--非抢占式调度触发-->进程等待队列
进程运行状态-->进程退出
进程运行状态-->进程获取Mutex_lock
进程运行状态-->进程获取Spin_lock
进程获取Spin_lock-->进程运行状态
进程获取Mutex_lock--直接成功-->进程运行状态
进程获取Mutex_lock--锁不可用-->进程阻塞队列
进程运行状态--时间片用尽-->进程等待队列
进程阻塞队列--Mutex_lock允许进程运行,进程所有锁都满足要求-->进程等待队列
进程睡眠队列--时间中断时等待时间已到-->进程等待队列
进程运行状态--sleep函数-->进程睡眠队列
```


---

# 5. 实验相关建议

汇编相关的语法
特殊寄存器的设置
实现的详细描述

---

# 6. 实验实现细节

## 6.1. 开发环境与工具配置

针对操作系统实验的内容, 开发环境可以优化如下:

debug时使用`.gdbinit`来简化gdb的操作. 具体实现参见代码.

---

## 6.2. 任务启动与Context Switching设计

### 6.2.1. PCB设计

PCB(Process Control Block)作为全局变量, 在本实验中位于与内核代码段靠近的全局变量区. 在`init_pcb()`时其中的内容根据task被首次初始化.

在一个进程被第一次调度时, 调度函数对这个进程对应的PCB进行二次初始化, 填充pid等等内容.

除了正常进程的PCB表, 还存在特殊的PCB表项用于IDLE进程.

在本实验内, 进程上下文切换的现场保存在PCB中.

PCB的内容如下:

```c
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

    /* block time */
    uint32_t block_time;

    /* sleep time */
    uint32_t sleep_time;

    /* process lock conut */
    int lock_cnt;

    /* entry position (for debug) */
    uint32_t entry;

    /* PCB valid */
    int valid;//保留位, 暂无意义

    /* Process first run */
    int first_run;

    //进程锁设计说明
    //进程唤醒按照不同的优先级进行, 同时进程锁在被触发之后, 对应不同的锁建立不同锁的等待队列. 如果锁解除时当前进程的剩余锁数为0, 则会将其设法加入运行队列中.

    //补充: 进程时间片耗尽之后和进程被block(sleep/acquire lock failed)的处理方式略有区别(返回地址的处理)

} pcb_t;
```

### 6.2.2. 第一个TASK的启动

<!-- 如何启动第一个task，例如如何获得task的入口地址，启动时需要设置哪些寄存器等 -->

在本实验中, 要执行的任务定义位于`test.c`中, 结构类似:

```c
struct task_info task2_2 = {(uint32_t)&printk_task2, KERNEL_THREAD};
```

因此从此全局变量中读出任务起始地址printk_task2和进程类型KERNEL_THREAD, 在初始化PCB时写入到PCB表项中.

如果手动定义了任务优先级, 任务优先级也会在此时写入.

在一个进程第一次被调度时(包括首个进程被调度时), 为了复用通用的的调度代码, 伪造一个中断现场, 将其epc置为任务的起始地址. 这样可以通过eret指令来启动任务.

为关键寄存器赋值如下所示: 设置两个栈的基址以及设置入口地址.

```c
current_running->kernel_context.regs[29]=current_running->kernel_stack_top;
current_running->user_context.regs[29]=current_running->user_stack_top;
current_running->user_context.cp0_epc=current_running->entry;//set entry
```

### 6.2.3. 上下文切换

在正常的上下文切换过程中, 几乎全部的通用寄存器需要保存, 除了zero, k1, k0这些特殊的寄存器. 其中k0, k1在保存现场过程中作为临时寄存器使用.

除此之外, 特殊寄存器的状态也要进行保存. 例如Hi, Lo, EPC等等.

CP0.Compare 寄存器的状态: 如果发生的是时钟中断, 时钟中断处理程序会修改保存的现场该寄存器的值. 在时钟中断的结尾部分, CP0.Compare的值被更新以重置计时器.

CP0.Status 寄存器比较特殊. 在中断发生时其中的数据即被修改. 在上下文切换中, 涉及到此寄存器的操作有: 在中断过程中维持status以关闭中断. 在修改EPC之前修改这个值以允许对EPC的写入. 中断返回时修改末位到0x3接eret指令. eret指令会修改EXL位到1, 从而允许中断.

CP0.Cause 寄存器是只读寄存器, 无需专门操作.

上下文切换逻辑如下: 保存现场-使用scheduler确认是否要进行切换-恢复现场(旧进程的或新进程的)

### 6.2.4. 调度器逻辑

使用先进先出队列(queue)来实现基本的调度器.

对于ready队列中的每个进程, 最基本的做法就是, 当轮到这个进程时给它一个时间片来运行, 时间片结束时终止. 

带有优先级的调度器设计将在下文中说明.

考虑过的3种优先级处理方式如下:

1. FIFO+不同长度的时间片.
1. 按照优先级排布的多个FIFO.
1. 遍历队列, 按优先级+等待时间选出要执行的任务.

彩票算法之类实现比较复杂, 暂时不在考虑范围内.

> 问题: 优先级和等待时长的优先度

### 6.2.5. 补充

<!-- 设计、实现或调试过程中遇到的问题和得到的经验（如果有的话可以写下来，不是必需项） -->

调度器`scheduler`的操作在内核态进行. 对其进行调试时使用`printk`调试法会取的比较好的效果.

在引入系统调用以后, 调度器的另一种写法如下.//TODO

---

## 6.3. 时钟中断、系统调用与blocking sleep设计

### 6.3.1. 一般例外处理流程

```mermaid
graph LR;
exception_handler_entry-->exception_handler
exception_handler-->handle_int
exception_handler-->handle_syscall
exception_handler-->handle_other
handle_int-->interrupt_helper
interrupt_helper-->irq_timer
handle_syscall-->system_call_helper
system_call_helper-->do_syscall_func
```

在cause寄存器被层层解析之后, 例外交由对应的函数处理.

### 6.3.2. 标准中断处理

开关中断通过调整寄存器CP0_Status来实现(mfc0, mtc0).

处理中断的流程如下:

```
（1）接收中断信号
（2）关闭中断响应(自动)
（3）保护现场（save context）
（4）确定中断原因
（5）跳转到对应中断处理入口地址
（6）处理中断
（8）restore context
（7）打开中断响应
（9）继续执行原进程
```

### 6.3.3. 时钟中断处理流程

流程图如下:

```mermaid
graph TD;
exception_handler_entry--保存现场-->exception_handler
exception_handler-->handle_int
handle_int-->interrupt_helper
interrupt_helper-->irq_timer
irq_timer-->检查所有sleep_queue中的进程
检查所有sleep_queue中的进程-->检查当前进程是否时间片已用完
检查当前进程是否时间片已用完-->形成新的ready_queue
形成新的ready_queue-->选取下一个进程
选取下一个进程--恢复现场-->重置计时器
重置计时器-->时钟中断结束
```

* 附注: "选取下一个进程"结果有可能当前进程(时间片未用尽)

#### 6.3.3.1. 例外入口函数拷贝

各个例外处理函数的入口地址在内核初始化时被拷贝到全局数组中. 需要拷贝的函数入口包括`syscall`全局数组中的内容, 以及`exception_handler`中的内容. 两者分别对应syscall的处理函数, 以及不同类型例外的handler入口.

最开始的例外处理函数`exception_handler_entry`一开始在内核中. 初始化时内核通过`memcpy()`来将其拷贝到0x80000180(例外处理初始地址). 拷贝的长度通过汇编中的全局标识符`exception_handler_end-exception_handler_begin`来获得.

### 6.3.4. sleep()及时钟中断

#### 6.3.4.1. 时钟中断触发时的工作

时钟中断的过程中进行以下操作

对于全局计时器变量: 计时器+=1

对于正在运行的进程: 比较PCB中的信息与计时器, 判断其时间片是否已经用尽, 是否需要进入等待队列.

对于睡眠状态中的进程: 比较PCB中的信息与计时器, 判断是否需要唤醒, 如果唤醒则进入等待队列.

#### 6.3.4.2. sleep()实现

`sleep()`的实现依赖于可遍历的`sleeping_queue`全局队列.

`sleep()`通过直接调用`do_block(&sleep_queue)`来实现睡眠. 睡眠之前要保存睡眠相关的信息到PCB表中. 每个时钟中断时检查睡眠队列来确定是否有要唤醒的进程.

进程sleep操作的调用通过系统调用进行. 在进行期间关闭中断确保鲁棒性.

相关代码如下:

```c
void do_sleep(uint32_t sleep_time)
{
    current_running->sleep_time=sleep_time;
    do_block(&sleep_queue);
}

void do_block(queue_t *queue)
{
    // block the current_running task into the queue
    current_running->status=TASK_BLOCKED;
    current_running->block_time=time_elapsed;
    queue_push(queue, current_running);
    do_scheduler();
}
```
<!-- 你所实现的时钟中断的处理流程中，如何处理blocking  -->

### sleep唤醒的优化

在每次时钟中断时检查所有处在睡眠状态的进程虽然简单, 但在每次中断时进行检查有很大的开销. 因此可以维护一个唤醒队列, 以及"下次唤醒触发时间"的变量. 在每次触发睡眠时更新唤醒队列. 每次时钟中断时只要判断是否到达"下次唤醒触发时间"即可判断是否需要执行唤醒.

代码如下: //TODO

### 6.3.6. 时钟中断处理流程与系统调用处理流程的比较

#### 相同步骤

两者前期的处理基本一致, 都是从相同的例外入口分别进入到对应的处理函数. 都是通过中断机制来提交给系统.

#### 不同步骤

时钟中断执行的任务内容相对固定. 而系统调用根据寄存器中的参数不同执行不同的函数. 

```mermaid
graph LR;
exception_handler_entry-->exception_handler
exception_handler-->handle_int
exception_handler-->handle_syscall
exception_handler-->handle_other
handle_int-->interrupt_helper
interrupt_helper-->irq_timer
handle_syscall-->system_call_helper
system_call_helper-->do_syscall_func
```

//TODO 图

<!-- ### 6.3.7. 设计、实现或调试过程中遇到的问题和得到的经验（如果有的话可以写下来，不是必需项） -->

---

## 6.4. 优先级调度器

### 6.4.1. 基于优先级的调度器设计思考

带优先级的do_scheduler: 3种实现方法


### 6.4.2. priority-based scheduler的设计思路，包括在你实现的调度策略中优先级是怎么定义的，何时给task赋予优先级，测试结果如何体现优先级的差别

手工定义优先级

IO密集型进程/计算密集型进程

测试结果: 将task4中的任务一起运行

<!-- ### 6.4.3. 设计、实现或调试过程中遇到的问题和得到的经验（如果有的话可以写下来，不是必需项） -->

---

## 6.5. 锁设计

### 6.5.1. spin-lock和mutual lock的区别



### 6.5.2. 能获取到锁和获取不到锁时各自的处理流程

spin-lock

mutual lock

#### 6.5.2.1. 获取锁时的动作
#### 6.5.2.2. 释放锁时的动作

### 6.5.3. Mutex Lock 实现

为每个 Mutex Lock 分配一个单独的阻塞队列.

<!-- 为每个进程设置一个当前等待解锁的锁的数目的计数器, 保存在PCB中. 每当这个进程进入一个锁的等待队列, 这个值加1. 每当进程进入一个锁的可用状态时, 这个计数器减1.  -->

这个进程进入等待队列(Ready_queue).

### 6.5.4. Task的阻塞

之前使用某个锁的进程放弃之后, 位于
被阻塞的task在

### 6.5.5. 设计、实现或调试过程中遇到的问题和得到的经验（如果有的话可以写下来，不是必需项）


### 6.5.6. 如何处理一个进程获取多把锁
### 6.5.7. 如何处理多个进程获取一把锁
### 6.5.8. 你的测试用例和结果介绍



---

# 7. 额外讨论

<!-- 请列出你觉得重要的代码片段、函数或模块（可以是开发的重要功能，也可以是调试时遇到问题的片段/函数/模块） -->

## 7.0.9. 龙芯处理器的异常处理机制

## 7.0.10. 调度器的两种实现方式

## 7.0.11. 死锁

## 7.0.12. IDLE(处理器空闲状态)

## 整体设计的两种方式及思考

---

# 8. 参考文献

[1] [讲义]

# 9. 致谢

感谢提前踩坑的段江飞.

---

Huaqiang Wang (c) 2018