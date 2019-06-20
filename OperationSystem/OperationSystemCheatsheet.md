Operation System Cheat Sheet
======================

* wanghuaqiang16@mails.ucas.ac.cn
* Based on slides of OS class in UCAS by Yungang Bao and Dejun Jiang
* Ref: Modern Operation System

---

[TOC]

课程结构

* 操作系统结构
    * 处理器：进程和线程
    * 并发：同步、通信
    * 内存：虚存管理
    * 设备：中断与驱动
    * 存储：文件系统
* 主流操作系统实例
    * XV6 实例分析（报告和讨论）

---

# 1. Introduction

## 1.1. 保护机制

体系结构的支持：特权（privileged）态, 特权指令

## 1.2. 操作系统结构

X86 Protection Rings

* 层次结构(不同层之间隐藏信息)
* 一体结构(宏内核，Monolithic)
* 微内核(microkernel)
    * 操作系统服务作为常规的进程
    * 用户通过消息获取服务进程的服务
* 库操作系统（LibOS）
* VM

## 1.3. 系统调用和库函数

系统调用/中断/异常: user level -> kernel level

### 1.3.1. 系统调用

来源: 用户代码调用

* 操作系统的A*I

    * 应用和操作系统之间的接口


* 系统调用参数传递
* 系统模式从用户态切换到核心态
* 执行系统调用功能
* 返回结果，切换到用户态

```
System Call Entry Point
switch to kernel stack
save context
check R0
call the real code pointed by R0
place result in Rresult
restore context
switch to user stack
iret (change to user mode and rejudge)

//(Assume passing parameters in registers)
```

#### 1.3.1.1. 系统调用与库函数

设计考虑: 何时系统调用? 何时设计为库函数?

例子下:

```
内核:

* 分配带硬件保护的页面
* 分配一大块（多个页面)给库
    * 不关心小粒度的分配

库:
* 提供 malloc/free 函数用于分配/释放
* 应用使用这些函数细粒度管理内存
    * 当页面用完后，库函数会向内核批量请求更多的页面
```

### 1.3.2. 中断和异常

来源: 硬件/软件

中断, 例外, 异常 TODO

操作系统通知用户程序的机制? TODO

---

# 2. Process and Thread

## 2.1. Process

进程是指一个具有一定独立功能的程序在一个数据集合上的一次动态执行过程

应用并发性的抽象

* PCB
* Content switch

## 2.2. Thread

应用内部并发性的抽象

* TCB
* 线程上下文切换


1. 用户线程（User Thread） (Pthread，Java)由一组用户级的线程库函数来完成线程的管理，包括线程的创建、终止、同步和调度等
1. 内核线程（Kernel Thread）由内核通过系统调用实现的线程机制，由内核完成线程的创建、终止和管理
1. 轻量级进程（Lightweight Process）内核支持的用户线程。一个进程可有一个或多个轻量级进程，每个轻权进程由一个单独的内核线程来支持。（Solaris/Linux）

轻量级进程 TODO

## 2.3. Process vs. Thread

```
* 地址空间
* 进程之间一般不会共享内存
* 进程切换会切换页表和其他内存机制
    * 进程中的线程共享整个地址空间
* 权限
* 进程拥有自己的权限（如，文件访问权限）
    * 进程中的线程共享所有的权限
* 问题
    * 真的希望线程共享“整个”地址空间吗？
```

## 2.4. Kernel Thread vs. User Thread

* 主要的区别是所选择的调度器

```
* 用户级线程
* 用户级线程库实现线程上下文切换
* 时间中断会引入抢占
    * 当用户级线程被I/O事件阻塞时，整个进程都会被阻塞
* 内核级线程
* 内核级线程被内核调度器调度
    * 由于跨越了保护边界，内核级线程的上下文切换开销远大于用户级线程
* 混合
    * 有可能实现一个混合的调度器，但是会很复杂
```

## 2.5. CPU调度

    * 响应时间：从提交第一个请求到产生第一个响应所用*间

    * 周转时间：从作业提交到作业完成的时间间隔

### 2.5.1. 调度的设计原则

```
* 保证公平性
* 每个作业都有机会运行； 没有人会“饥饿”
    * 最大化CPU资源利用率
* 不包括idle进程
    * 最大化吞吐率
* 操作数/秒（最小化开销，最大化资源利用率）
    * 最小化周转时间
* 批处理作业：执行时间（从提交到完成）
    * 缩短响应时间
* 交互式作业：响应时间（e.g. 键盘打字）
    * 均衡性
    * 满足用户需求
```

### 2.5.2. 调度算法

1. 先到先服务（FCFS*算法
    1. 最短时间优先（STCF）**非抢占  -->可以获得较小的平均响应时间
    1. 最短剩余时间优先（SRTCF）* 抢占  -->可以获得较小的平均响应时间
1. 时间片轮转算法（RR，Round Robin）
1. 虚拟轮转算法（Virtual Round Robin）: 引入虚拟队列, 优先级, 区分IO密集型进程和计算密集型进程
1. 多级队列（MQ）与优先级 每个队列可以有自己的调度算法
1. 多级反馈队列(MLFQ)算法 进程可在不同队列间移动的多级队列算法, 时间片大小随优先级级别增加而增加, 进程在当前的时间片没有完成，则降到下一个优先级, CPU密集型进程的优先级下降很快，I/O密集型进程停留在高优先级
1. 彩票调度 (为了近似SRTCF，给短作业更多的彩票, 相互合作的进程可以交换彩票)
1. 公平共享调度(FSS, Fair ShareScheduling) 按用户组调度, 没有达到资源使用率目标的组获得更高的优先级

RR经验规则：选择一个合适的时间片，使上下文切换开销处于1%以内

### 2.5.3. 多处理器与集群调度

### 2.5.4. 实时调度

* 硬实时（hard deadline）* 必须满足，否则会导致错误
* 软实时（soft deadline）* 大多时候满足，没有强制性

实时调度依赖于接纳控制（admission control）

可以实时调度的条件:

$$\sum^{每个进程} \frac{计算时间}{周期} \le 1$$

1. 速率单调调度: (对理想进程)给每个进程分配一个固定的优先级=出现频率, 运行最高优先级的进程
1. 最早最终时限优先调度（EDS）
1. BSD多队列调度 TODO

BSD多队列调度 TODO

### 2.5.5. 现代操作系统中的调度

#### 2.5.5.1. Linux

* 分时共享调度
    * 每个进程都会有优先级和credits
    * I/O事件会提升优先级
    * 拥有最多credits的进程会优先运行
    * 时间中断会减少进程的credits
    * 如果所有进程的credits都耗尽了，内核会重新给进程分配：credits = credits/2 + priority
* 实时调度
    * 软实时
    * 内核不会被用户代码抢占

#### 2.5.5.2. Windows

* 类和优先级
    * 实时类： 16个静态优先级
    * 可变类： 16个变化的优先级，
* 如果进程用完了所分配的额度，降低其优先级
* 如果进程在等待I/O，增高其优先级
* 先级驱动的调度器
    * 对于实时类，用轮转算法进行调度（within each priority）
    * 对于可变类，用多队列进行调度
* 处理器调度
    * 有N个处理器，将N-1个最高优先级的线程运行在N-1个处理器上，剩下的*程运行在1个处理器上
    * 线程会等待属于它亲和力集合（affinity set）的处理器

实时类和可变类?

#### 2.5.5.3. 前沿调度研究

---

# 3. 同步与通信(Sync)

临界区的保障

* 基于软件
* 硬件中断 (问题: 无法处理多核处理器的情况)
* 原子操作指令与互斥锁

## 3.1. Peterson算法

```
共享变量
int judge;
boolean in_progress[];
//表示该谁进入临界区
//表示进程是否准备好进入临界区

// 进入区代码
in_progress[i] = true;
judge = j;
while (in_progress[j] && judge ==j)

CRITICAL SECTION

// 退出区代码
in_progress[i] = false;
```

## 3.2. 原子操作指令

Test-and-Set ，TAS/TS
exchange
Fetch-and-Add 或 Fetch-and-Op
Load linked 和 Conditional store (LL-SC)

Load linked 和 Conditional store (LL-SC)
* 在一条指令中读一个值(Load linked)
* 做一些操作
* Store 时，检查 load linked 之后，值是否被修改过。如果没有，则 OK，否则，从头再来

```c
// 忙等待
Lock::Acquire() {
    while (test-and-set(value))
    ; //spin
}

Lock::Release() {
    value = 0;
}

// 无忙等待
class Lock {
    int value = 0;
    WaitQueue q;
}

Lock::Acquire() {
    while (test-and-set(value)) {
        add this TCB to wait queue q;
        schedule();
    }
}

Lock::Release() {
    value = 0;
    remove one thread t from q;
    wakeup(t);
}
```

## 3.3. Deadlock

资源分配图中的圈

### 3.3.1. 死锁的条件

* 互斥
    * 所有资源都被分配给恰好一个进程
* 占有和等待
    * 持有资源的进程可以请求新资源
* 不可抢占 (No Preemption)
    * 资源不可被夺走
* 环路等待
    * 进程以环路的方式进行等待

### 3.3.2. 避免死锁的策略

* 忽略问题
    * 是用户的错
    * 重启/重置运行环境
* 检测并恢复 (Detection & recovery)
    * 发现圈
    * 事后修复问题: 很难, 杀死进程或回滚造成死锁的操作
* 动态避免 (Avoidance)
    * 小心地分配资源
    * 银行家算法: 已分配矩阵和仍然需要矩阵, 剩余空闲量向量 TODO
* 预防 (Prevention)
    * 破坏四个条件中的一个, 按四个条件的顺序距离如下
    * 使用假脱机进行虚拟化: 如为打印机添加调度队列
    * 两阶段加锁 (如果失败, 放弃所有资源, 并从头加锁)
    * 允许抢占 (比如, 将资源复制到一个缓冲区，以释放资源)
    * 对所有资源制定请求顺序, 为资源分配id, 所有请求按升序提出.

对于用户应用: OS提供打破死锁的机制.
对于系统内核: 使用预防方法, 在所有位置避免环路等待.

## 3.4. 信号量、管程与条件变量 

### 3.4.1. 信号量 Semaphores

信号量组成
– 一个整形变量，表示系统资源的数量
– 两个**原子操作**组成

* P/Down/Wait 等待信号量为正, 信号量-1
* V/Up/Signal 信号量+1

```java
//生产者/消费者问题, 使用信号量
Class BoundedBuffer {
    mutex = new Semaphore(1);
    fullBuffers = new Semaphore(0);
    emptyBuffers = new Semaphore(n);
}

BoundedBuffer::Deposit(c) {
    emptyBuffers->P();
    mutex->P();
    Add c to the buffer;
    mutex->V();
    fullBuffers->V();
}

BoundedBuffer::Remove(c) {
    fullBuffers->P();
    mutex->P();
    Remove c from buffer;
    mutex->V();
    emptyBuffers->V();
}
```

### 3.4.2. 管程 (Monitors)

• 一个锁
    – 控制管程代码的互斥访问
• 0或者多个条件变量(Condition Variables)
    – 管理共享数据的并发访问

重点: 使用锁来控制管程自身代码的互斥访问, 使用条件变量来控制唤醒条件

```java
Class BoundedBuffer {
…
    Lock lock;
    int count = 0;
    Condition notFull, notEmpty;
}

BoundedBuffer::Deposit(c) {
    lock->Acquire();
    while (count == n)
        notFull.Wait(&lock);
    Add c to the buffer;
    count++;
    notEmpty.Signal();
    lock->Release();
}

BoundedBuffer::Remove(c) {
    lock->Acquire();
    while (count == 0)
        notEmpty.Wait(&lock);
    Remove c from buffer;
    count--;
    notFull.Signal();
    lock->Release();
}
```

#### 3.4.2.1. Signal 之后的选择

* 让被唤醒的线程立即执行，并挂起发送方(Hoare)
* 退出管程 (Hansen)
* 继续执行 (Mesa)

#### 3.4.2.2. Mesa 风格管程 Mesa-style Monitor

```
• 将条件变量与一个互斥量(mutex)关联
• Wait(mutex, condition)
– 原子解锁 mutex 并加入condition对应的队列 (阻塞该线程)
– 被唤醒时，重新锁定 mutex
• Signal(condition)
– 当没有线程阻塞于该条件变量时，什么也不做
– 如有被阻塞的线程，唤醒至少一个
• Broadcast(condition)
– 唤醒所有等待的线程
```

### 3.4.3. 屏障原语（Barrier）

### 3.4.4. 读者-写者问题: 对共享数据的读写

– “读－读”允许
• 同一时刻，允许有多个读者同时读
– “读－写”互斥
• 没有写者时读者才能读
• 没有读者时写者才能写
– “写－写”互斥
• 没有其他写者时写者才能写

## 3.5. 进程间通信 

两个原语：
– Send（message）
– Receive（message）

### 3.5.1. 消息队列

相关的系统调用:

• msgget ( key, flags）
– 获取消息队列标识
• msgsnd ( QID, buf, size, flags ）
– 发送消息
• msgrcv ( QID, buf, size, type, flags ）
– 接收消息
• msgctl( … ）
– 消息队列控制

### 3.5.2. 共享内存

相关系统调用:

• shmget( key, size, flags）
– 创建共享段
• shmat( shmid, *shmaddr, flags）
– 把共享段映射到进程地址空间
• shmdt( *shmaddr）
– 取消共享段到进程地址空间的映射
• shmctl( …）
– 共享段控制

### 3.5.3. 管道（Pipe）

进程间基于内存文件的通信机制
– 子进程从父进程继承文件描述符
– 缺省文件描述符：0 stdin, 1 stdout, 2 stderr

相关系统调用:

• 读管道：read(fd, buffer, nbytes)
– C语言中的scanf()是基于它实现的
• 写管道： write(fd, buffer, nbytes)
– printf()是基于它实现的
• 创建管道：pipe(rgfd)
– rgfd是2个文件描述符组成的数组
– rgfd[0]是读文件描述符
– rgfd[1]是写文件描述符

### 3.5.4. 信号（Signal）

– 如：SIGKILL, SIGSTOP, SIGCONT等

• 信号的接收处理
– 捕获(catch)：执行进程指定的信号处理函数被调用
– 忽略(Ignore)：执行操作系统指定的缺省处理
• 例如：进程终止、进程挂起等
– 屏蔽（Mask）：禁止进程接收和处理信号
• 可能是暂时的(当处理同样类型的信号)


### 3.5.5. 进程间通信的设计考虑

#### 3.5.5.1. 缓冲消息

无缓冲(每个消息都要握手)
有界缓冲(使用一个管程)
无界缓冲(发送方永远不阻塞)

#### 3.5.5.2. 直接通信 vs. 间接通信

* 直接通信
    * 只有接收端有缓冲
    * 每个发送者有一个缓冲区
* 间接通信
    * 允许多对多通信
    * 需要打开/关闭信箱

#### 3.5.5.3. 同步 vs. 异步

#### 3.5.5.4. 例外处理

* 进程结束
* 信息丢失
* 信息损坏

---

# 4. Virtual Memory

## 4.1. 地址映射机制

略

## 4.2. 页替换

### 4.2.1. 替换算法

• 随机选一页
• 最优算法（MIN） – 替换在未来最长一段时间里不用的页, 前提：知道未来所有的访问
• NRU (Not Recently Used)
• FIFO (First-In-First-Out)
• FIFO with second chance
• Clock
• LRU (Least Recently Used)
• NFU (Not Frequently Used)
• Aging (approximate LRU)
• Working Set
• WSClock

```
Aging:
消除过去访问的影响
– 每个时钟中断时，先将所有页计数器右移1位，再将每页计数器最高位与该
页的R位相加
– 替换时，选择计数器值最小的页
- 实际使用中，8位就工作得很好
```

```
wsclock:
• 将页框组织成环形链表（类似Clock）
• 按表针走动的顺序来检查页
• 如果R位为1
– 将R位置为0，该页的上次访问时间设置为当前时间
– 检查下一页
• 如果R位为0
– Δ = 当前时间 – 上次访问时间
– 如果Δ<=T，该页在过去T秒里访问过，检查下一页
– 如果Δ>T，该页在T秒里没有访问过，而且M位为1
• 将该页写回加入写回链表（异步进行写回），并检查下一页
– 如果Δ>T，该页在T秒里没有访问过， 且M位为0
• 替换该页
```

## 4.3. 虚存设计问题

### 4.3.1. 颠簸与工作集

颠簸: 频繁发生缺页，运行速度很慢

解决方式: 工作集

• 进程分为两组
– 活跃组：工作集加载进内存
– 不活跃组：工作集不加载进内存
• 如何确定哪些进程是不活跃的
– 等待事件（敲键盘、点击鼠标、…）
– 等待资源
– 典型方法是等待时间上的一个阈值
• 两个调度器
– 长期调度器决定
• 哪些进程可以同时运行（CPU vs I/O，工作集之和，…）
• 哪些是不活跃的进程，把它们换出到磁盘
• 哪些是活跃进程，把它们换入到内存
– 短期调度器决定把CPU分配给哪个活跃进程

### 4.3.2. Page 分配

多个进程同时运行时，替换哪个进程的页框？

• 全局分配
– 从所有进程的所有页框中选择
– 可替换其它进程的页框
– 每个进程运行期间，其内存大小是动态变化的
– 好处：简单
– 坏处：没有隔离，受其它进程的页替换干扰
• 不能控制各个进程的内存使用量

• 局部分配
– 只从本进程（发生缺页的进程）自己的页框中选择
– 一个进程运行期间，其内存大小是不变的
• 页框池：分配给进程的页框的集合，进程间池大小可不同
– 好处：隔离，不影响其它进程
– 坏处：不灵活
• 进程增大会出现颠簸
• 难以充分利用内存：每个进程对内存的需求不一样

• 平衡分配
• 局部分配 + 池大小动态调整
– 每个进程有自己的页框池（pool）
– 从自己的池中分配页，且从自己的工作集中替换页
– 用一种机制来运行时动态调整每个池的大小
• 设计问题
– 每个池多大？
– 什么样的调整机制？
– 什么时候迁移？
• 进程加载方式：进程 换入时
– 纯粹的按需加载页：加载慢
– 预加载：先加载部分页 → 初始池大小
– 初始池大小~工作集
• 动态调整池大小：进程大小变化
– PFF算法（page fault frequency）
• 缺页率PFR：进程每秒产生多少次缺页
• 对于大多数替换策略，PFR随分配给进程的内存增加而减少
• 两个阈值：A和B
• 当PFR高于A，就增加其内存（pool增大）
• 当PFR低于B，就缩小其内存（pool减小）
• PFR计算
• 方法1：只看当前1秒钟内的缺页次数Ri
• 方法2：求滑动均值
– 例：𝑃𝐹𝑅𝑖 = (𝑅𝑖+𝑃𝐹𝑅𝑖−1)/2

### 4.3.3. 交换空间管理

• 静态分配
– 创建进程时分配，进程结束时回收
– 大小：进程映像（process image）
– 进程控制表记录交换空间的磁盘地址
– 绑定：一个虚存页→一个磁盘页
• 磁盘页称为shadow page
– 初始化：两种方法
1. 按需换入：进程映像拷贝到交换区
2. 按需换出：进程映像加载进内存
– 缺点：难以增长：数据段、栈段

• 动态分配
– 创建进程时不分配
– 页换出时分配，页换入时回收
– 虚页与磁盘页不绑定
• 多次换出，分配不同的磁盘页
– PTE中记录页的磁盘地址
• 一个优化：程序代码段
– 直接用磁盘上的可执行文件作为交换区

### 4.3.4. 后备存储
### 4.3.5. 页大小

• 大页
– 好处：页表小 &
磁盘I/O高效
– 坏处：内部碎片
• 最后一页不满
• 进程执行不需要的部分也放进了内存

• 小页
– 好处：减少内部碎片
– 坏处：页表大
• 占用更多的内存
• 加载时间更长
• 查找虚页的时间更长
– 坏处：磁盘I/O不高效
• 进程加载、页替换

### 4.3.6. pin/lock

• 为什么需要？
– DMA进行过程中，需要传输的页不能被换出，否则CPU就会把新内容写入这些页
• 系统调用接口
– pin：把虚页钉在内存，使它们不会被换出
– unpin：取消pin，使它们可以被换出
• 如何设计？
– 用一个数据结构来记录所有钉住 的页
– 换页算法在替换页时检查该数据结构
• 如果页被钉住，则不替换它，重新再选择一页

### 4.3.7. 清零

• 将页清零
– 把页置成全0
– 堆和栈的数据都要初始化
• 如何实现
– 对于数据段或栈段中的页，当它们第一次发生page fault时，将它
们清零
– 有一个专门的线程来做清零

### 4.3.8. 共享

• 牵涉问题
– 有共享页的进程结束
– 共享页的换入换出
– 钉住和解钉共享页
– 有共享页的进程的工作集

### 4.3.9. 写时复制 (Copy-on-write)

• 该技术用于创建子进程（fork系统调用）
• 原理
– 子进程的地址空间使用其父进程相同的映射
– 将所有的页置成 read-only
– 将子进程置成 ready
– 对于读，没有问题
– 对于写，产生page fault
• 修改PTE，映射到一个新的物理页
• 将页内容全部拷贝到新物理页
• 重运行发生缺页的指令

### 4.3.10. 分布式共享内存

• 一致性问题
– 规则：排它写 & N个reader
– PTE控制位根据规则来设置
– Read fault：将writer变成只读，并拷贝页内容
– Write fault：将writer或者所有reader置成无效，拷贝页内容


## 4.4. UNIX和Linux的虚存

• 伙伴算法
– 初始时：只有1个段，含全部可用空间
– 分配空间，m页：找size>=m且size最小的段，假设其size为n
– 如果n>=2m，则将该段对分为两个size=n/2的段，
– 重复对分，直到n/2 < m =< n
– 释放空间，m页：若释放段的”伙伴”也是空闲的，则合并它们，重复合并

---

# 5. I/O Device

## 5.1. 寻址

• I/O端口： I/O地址空间
– 端口号：8位或16位的数值
– I/O指令in/out：特权指令
– 控制线：指示CPU发出的地址是内存空间还是I/O空间
• 内存映射I/O：统一地址空间
– 预留一部分将内存地址空间
– 内存地址与I/O地址无重叠
– CPU发出的地址，所有内存模块和所有设备都要解析
• 两者结合
– 控制寄存器采用I/O端口寻址，数据缓冲区采用内存映射I/O

## 5.2. 数据传输方式

• PIO（Programmed I/O） Need Polling
• 中断（Interrupt）
• DMA（Direct Memory Access）

## 5.3. 设备驱动

### 5.3.1. 操作接口

• Init (deviceNumber)
– 初始化硬件
• Open (deviceNumber)
– 初始化驱动，并分配资源
• Close (deviceNumber)
– 清除，回收资源，关闭设备（可选）
• 设备驱动的类型
– 字符设备：可变长度的数据传输
• 几个字节，e.g. 鼠标
• 很多字节，e.g.网卡
– 块设备：以固定大小的块为粒度的数据传输
• 字符设备接口
– read (deviceNumber, bufferAddr, size)
• 从字节流设备上读“size”字节数据
– write (deviceNumber, bufferAddr, size)
• 将“bufferAddr”中size字节数据写入字节流设备
• 块设备接口
– read (deviceNumber, deviceAddr, bufferAddr)
• 从设备传输1个块的数据到内存
– write (deviceNumber, deviceAddr, bufferAddr)
• 从内存传输1个块的数据到设备
– seek (deviceNumber, deviceAddr)
• 将磁头移动到指定块
• 现在的设备磁头移动是控制器来控制，对设备驱动透明

### 5.3.2. UNIX设备驱动接口

• init()
– 初始化硬件
• start()
– 开机时初始化，需要系统服务
• halt()
– 在系统关机前要调用
• open(dev, flag, id) 和 close(dev, flag, id)
– 初始化资源和释放资源
• intr(vector)
– 在发生硬件中断时由内核调用
• read(…) 和 write(…)
– 数据传输
• poll(pri)
– 内核每秒调用25次~100次
• ioctl(dev, cmd, arg, mode)
– 特殊请求处理

### 5.3.3. 设计思路

• 静态安装设备驱动
– 新设备的使用需要重启OS
• 动态挂载设备驱动
– 不需要重启，而是采用间接指针
– 将驱动加载进内核空间
– 安装入口点，维护相关的数据结构
– 初始化设备驱动


---

# 6. File System

## 6.1. 磁盘(Hard Disk)

### 6.1.1. 寻道算法

* FIFO
* SSF (Shortest Seek First) 产生饥饿
* 电梯调度 (SCAN): 磁头按一个方向到另一端，再折回，按反方向回到这端，不断往返, 只服务当前移动方向上寻道距离最近的请求, 如果磁盘移动方向上没有请求，就折回
* C-SCAN (Circular SCAN) 折回时不服务请求, 服务时间趋于一致

## 6.2. SSD

## 6.3. RAID

### 6.3.1. RAID-0

‒ 以条带为粒度映射到N块磁盘（轮转）
‒ 1 strip = N个块
‒ 无冗余

### 6.3.2. RAID-1

‒ 镜像
‒ 镜像级别R：数据存R份
‒ 通常与RAID-0结合使用: RAID-01或RAID-10

### 6.3.3. RAID-4

‒ 条带化 + 1个校验块
‒ 所有校验块在同一块磁盘上(校验盘)
‒ 缺点：校验盘为写性能瓶颈，易坏
‒ 条带化: 数据分布在N-1个盘上, 校验位在一个盘上

### 6.3.4. RAID-5

‒ 条带粒度映射 + 1个校验块
‒ 校验块分散在不同磁盘上
‒ Rebuild：复杂 & 速度慢

区分: Raid4校验块集中在一个磁盘, Raid5校验块分散在不同磁盘上

---

# 7. File System

## 7.1. 目录：一种特殊的文件

## 7.2. VFS

## 7.3. mount

## 7.4. 文件块索引

* 连续分配
* 链表结构
* 文件分配表（FAT）
* 单/多级索引
* Extents

FAT:

• 一张有N个项的表，假设磁盘有N块
– 每个磁盘块有一个表项：要么为空，要么为该文件下一块的地址
– 位于磁盘分区的头部

XFS::Extent:

• Extent是若干个连续磁盘块（长度不固定）
– 同一extent中的所有块：要么都是空闲块，要么都属于某个文件
– extent：<starting block, length>
• XFS提出的方法
– 无论文件块还是空闲块都采用extents来组织
• 块大小为8KB
• Extent的大小 <= 2M个块
– 文件块索引： extent的映射关系
• <文件块号, 块数 > → <磁盘块号, 块数>
• 采用B树
– 文件元数据
• 记录B树的根节点地址

## 7.5. 目录项索引

线性表
– <文件名，ino>线性存储
• 每一项不定长：<ino, 名字长度, 下一项起始偏移，名字>

B树
• 原理
– 用B树来存储<文件名，ino>，以文件名排序(字典序)
– 创建/删除/查找：在B树中进行

哈希
• 原理
– 用哈希表将文件名映射到ino

## 7.6. 文件系统带宽优化

考虑给文件分配连续磁盘块, 减少长距离寻道
调整磁盘块的大小

## 7.7. 文件系统缓存替换策略

LRU策略
– 哈希表+双向链表

## 7.8. 宕机保护: 一致性修改

• 通用方法：按自底向上顺序进行修改
– 文件的数据块→文件的i-node→目录的数据块→目录i-node…
– 仍然需要时不时地运行fsck来清理垃圾块

## 7.9. 文件系统实例

### 7.9.1. 日志文件系统
### 7.9.2. LFS: Log-Structured File System
### 7.9.3. 闪存控制逻辑

不同映射方式
磨损均衡

### 7.9.4. NFS
### 7.9.5. WAFL
### 7.9.6. GFS

## 快照机制

TODO 1day

---

# 8. 数据保护

---

# 9. 操作系统实例分析

---

# 10. Homework
