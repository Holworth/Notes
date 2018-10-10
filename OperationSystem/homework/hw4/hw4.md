---
title: OS Homework4
---


# 操作系统 作业4

* 王华强
* 2016K8009929035

***

## 1

1.（程序题）写一个2线程的程序，首先生成一个从1到1000万的整数数组，然后用两个线程分别计算数组奇数部分和偶数部分的和，并打印出总的和。分别在单核和双核系统上运行该程序，计算加速比。（采用pthread API）

提示：单核和双核可在虚拟机上配置；pthread调用方法网上有大量资料，比如https://www.ibm.com/developerworks/cn/linux/thread/posix_thread1/index.html

程序:

```c
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <stdlib.h>
#include <errno.h>

#define show(x) printf("" #x "=%ld\n", x)
#define RUN_TIME 1
#define UPPERBOUND 10000000

long sum1;
long sum2;
int array[UPPERBOUND];

void *thread_function(void *arg)
{
    int i;
    for (i = 0; i < UPPERBOUND; i += 2)
    {
        sum2 += array[i];
    }
    return NULL;
}

int main(void)
{

    show((long)RUN_TIME);
    long int time1 = clock();

    pthread_t mythread;

    int k = RUN_TIME;
    while (k-- > 0)
    {   
        int l;
        for(l=0;l<10000000;l++)
        {
            array[l]=l;
        }
        if (pthread_create(&mythread, NULL, thread_function, NULL))
        {
            printf("error creating thread.");
            abort();
        }
        int i;
        for (i = 1; i < UPPERBOUND; i += 2)
        {
            sum1 += array[i];
        }
        if (pthread_join(mythread, NULL))
        {
            printf("error joining thread.");
            abort();
        }
        show((sum1 + sum2));
    }
    long int time2 = clock();
    show((time2-time1));
    exit(0);
}
```

```
grep "model name" /proc/cpuinfo | cut -f2 -d:
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz

(long)RUN_TIME=1
(sum1 + sum2)=49999995000000
(time2-time1)=89297
```

```
grep "model name" /proc/cpuinfo | cut -f2 -d:
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
(long)RUN_TIME=1
(sum1 + sum2)=49999995000000
(time2-time1)=204994

```

当然理论上加速比不可能超过2, 这可能和当时虚拟机外运行的程序有关.

但是, 有时的测试结果两种做法会得出相似的结果, 此时加速比接近1.

补充:

在测试中出现了意料之外的结果:
```
grep "model name" /proc/cpuinfo | cut -f2 -d:
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz

(long)RUN_TIME=10
(sum1 + sum2)=49999995000000
(sum1 + sum2)=99999990000000
(sum1 + sum2)=149999985000000
(sum1 + sum2)=199999980000000
(sum1 + sum2)=249999975000000
(sum1 + sum2)=299999970000000
(sum1 + sum2)=349999965000000
(sum1 + sum2)=399999960000000
(sum1 + sum2)=449999955000000
(sum1 + sum2)=499999950000000
(time2-time1)=1493230
```

```
grep "model name" /proc/cpuinfo | cut -f2 -d:
 Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
(long)RUN_TIME=10
(sum1 + sum2)=49999995000000
(sum1 + sum2)=99999990000000
(sum1 + sum2)=149999985000000
(sum1 + sum2)=199999980000000
(sum1 + sum2)=249999975000000
(sum1 + sum2)=299999970000000
(sum1 + sum2)=349999965000000
(sum1 + sum2)=399999960000000
(sum1 + sum2)=449999955000000
(sum1 + sum2)=499999950000000
(time2-time1)=724629

```

具体机制未知. 是否是由于重复创建进程的开销太大?

## 2

2. Five jobs are waiting to be run. Their expected run times are 9, 6, 3, 5, and X. In what order should they be run to minimize average response time? (Your answer will depend on X.)

设5个任务的运行顺序分别为(从0开始)0,1,2,3,4

$$平均响应时间*5=0*第五个任务时长+1*第四个任务时长+...+4*第一个任务时长$$

要使得平均响应时间最小, 要尽量将最长的任务放到最后:

因此, 只要考察X与余下数据的大小并将其从小到大排序, 这就是取得最小响应时长时的运行顺序.

比如, 若$X<3<5<6<9$, 则有

$$ART=\frac{X*4+3*3+5*2+6*1}{5}$$

若$$3<X<5<6<9$$

$$ART=\frac{3*4+X*3+5*2+6*1}{5}$$

余下情况同理可得;

## 3

3. Five batch jobs A through E, arrive at a computer center at almost the same time. They have estimated running times of 10, 6, 2, 4, and 8 minutes. Their (externally determined) priorities are 3, 5, 2, 1, and 4, respectively, with 5 being the highest priority. For each of the following scheduling algorithms, determine the mean process turn-around time. Ignore process switching overhead.
(a) Round robin.
(b) Priority scheduling
(c) First-come, first-served (run in order 10, 6, 2, 4, 8).
(d) Shortest job first.

For (a), assume that the system is multiprogrammed, and that each job gets its fair share of the CPU. For (b) through (d) assume that only one job at a time runs, until it finishes. All jobs are completely CPU bound.

#### (a) Round robin. 时间片轮转调度.

因为`each job gets its fair share of the CPU`, (这里假定fair share是指完全平均分配不考虑优先级), 所以:

任务时间|10|6|2|4|8
-|-|-|-|-|-
任务用时|30|24|10|18|28

平均周转时间:22min

#### (b) Priority scheduling

时间|6|14|24|26|30
结束的任务用时|6|8|10|2|4

平均周转时间:20min

#### (c) First-come, first-served (run in order 10, 6, 2, 4, 8).

时间|10|16|18|22|30
结束的任务用时|10|6|2|4|8

平均周转时间:19.2min

#### (d) Shortest job first.


时间|2|6|12|20|30
结束的任务用时|2|4|6|8|10

平均周转时间:14min

## 4

4. A real-time system needs to handle two voice calls that each run every 5 msec and consume 1 msec of CPU time per burst, plus one video at 24 frames/sec, with each frame requiring 20 msec of CPU time. Is this system schedulable?

2/5+20/(1000/24)=0.88

是可调度的.