---
title: OS Homework6
---


# 操作系统 作业6(勘误)

* 王华强
* 2016K8009929035

***

## 1. 

A system has four processes and five allocatable resources. The current allocation and maximum needs are as follows:

```
            Allocated        Maximum        Available
Process A    1 0 2 1 1        1 1 2 1 3        0 0 x 1 1
Process B    2 0 1 1 0        2 2 2 1 0
Process C    1 1 0 1 0        2 1 3 1 0
Process D    1 1 1 1 0        1 1 2 2 1
```
What is the smallest value of x for which this is a safe state?

此题中进程A需要资源5的最大值为5, 超过了资源5的最大可用值(1+1=2), 因此只要进程A在等待队列中, 任何x的值此状态都是不安全的.

不考虑资源5的解法如下:

```
Process A    1 0 2 1        1 1 2 1        0 0 x 1
Process B    2 0 1 1        2 2 2 1
Process C    1 1 0 1        2 1 3 1
Process D    1 1 1 1        1 1 2 2
```

资源1,2,3,4的总值为(5,2,4+x,5), 当前可用资源向量为(0,0,x,1), 当前需求矩阵为:

```
Process A    0 1 0 0
Process B    0 2 1 0
Process C    1 0 3 0
Process D    0 0 1 1
```

当前没有可以安全执行的进程, 因此设定x至少为1. 

当x=1时, 安全队列为:(Process D, Process A, Process C, Process B), 对应可用资源向量为:(1,1,2,2)->(2,1,4,3)->(3,2,4,4)->(5,2,5,5).

因此x=1即满足要求, $x_{min}$=1;

***

## 2.

The processes, A and B, each need three records, 1, 2, and 3, in a database. If A asks for them in the order 1, 2, 3, and B asks for them in the same order, deadlock is not possible. However, if B asks for them in the order 3, 2, 1, then deadlock is possible. With three resources, there are 3! or six possible combinations each process can request the resources. What fraction of all the combinations is guaranteed to be deadlock free?

两个进程请求锁顺序的组合共计$3!*3!=36$种.

在两个进程请求的第一个锁相同的情况下, 不会出现死锁. 举例来说:
```
A 1,2,3
B 1,3,2
实际执行顺序比如:A1(B1failed)->A2->A3->B1->B3->B2

A 1,2,3
B 1,2,3
实际执行顺序比如:A1(B1failed)->A2->A3->B1->B2->B3
```
这种情况共有12种.

其余的情况下, 两个进程请求的第一个锁不同, 有以下两类情况:

```
A 1,2,3
B 3,2,1
可能会引起死锁: 比如A1->B3->A2->A3failed

A 1,2,3
B 3,1,2
可能会引起死锁: 比如A1->B3->A2->A3failed
```

综上, 不会引起死锁的情况占$\frac{1}{3}$