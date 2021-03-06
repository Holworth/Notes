---
title: OS Homework8
---


# 操作系统 作业8

* 王华强
* 2016K8009929035

***

## 1.

某机器提供 128KB 的地址空间，4 个段，代码段位于最低地址空间，其次是数据段、
堆和栈，且栈位于最高地址空间，向下增长，如图所示。
1) 虚地址为多少二进制位？每个段最大为多少 KB？每个段的起始虚地址
2) 假设一个进程被加载到物理内存，其段表如图所示，请问以下虚地址对应的物理地址分别是多少？

1-1) 17位 $(2^7+2^{10})$

1-2) 32KB (128/4)

1-3) 在每个段取32KB的前提下, 各段起始虚地址为:

* 代码段: 0x0
* 数据段: 0_1000_0000_0000_0000(b) (0x08000)
* 堆: 1_0000_0000_0000_0000(b) (0x10000)
* 栈: 1_1111_1111_1111_1111(b) (0x1FFFF) (栈空间从上到下增长)

栈空间对应的虚地址范围是: 0x0C00-0x0FFF


2) ???

seg|size(KB)|vbaseaddr
-|-|-
0|2|0_0000_0000_0000_0000(0x0)
1|2|0_0000_0100_0000_0000(0x0400)
2|3|0_0000_1100_0000_0000(0x0c00)
3|4|(0x1fff负增长, 到0x1efff)

2-1) 越界
2-2) 0x1ff363
2-3) 越界
2-4) 越界


## 2.

一台机器虚存采用分段机制，物理内存当前的空闲空间如下（按物理地址由小到大的顺序）：10MB, 4MB, 20MB, 18MB, 7MB, 9MB, 12MB 和15MB。此时要为三个段分配空间（按时间先后顺序）：段A 申请 12MB，段B 申请10MB，段 C 申请 9MB。分别给出采用Best Fit，Worst Fit，First Fit 和 Next Fit 算法下，每次分配成的空闲空间状态（按物理地址由小到大顺序），以及每次分配所需的比较次数。

1) Best Fit


10MB|4MB|20MB|18MB|7MB|9MB|12MB|15MB
-|-|-|-|-|-|-|-
B|-|-|-|-|C|A|-

13次比较

2) Worst Fit

10MB|4MB|12MB|8MB|10MB|8MB|7MB|9MB|12MB|9MB|6MB
-|-|-|-|-|-|-|-|-|-|-
-|-|A|-|B|-|-|-|-|C|-

24次比较

3) First Fit 

10MB|4MB|12MB|8MB|9MB|9MB|7MB|9MB|12MB|15MB
B|-|A|-|C|-|-|-|-|-

7次比较

4) Next Fit

10MB|4MB|12MB|8MB|10MB|8MB|7MB|9MB|12MB|15MB
-|-|A|-|B|-|-|C|-|-

8次比较

## 3.

一个4KB的Page对应2^10个int(设C中一个int对应4Byte)

1)

因为这个数组是第一次被使用:

因此M>=1024, N>=M;

2)

答案不同, 如果循环被重复运行, 则在循环第二次被执行时之前的虚地址映射已经被装入过TLB. 因此, 为了触发TLBmiss, 需要使得之前已经使用过的虚地址映射被后面装入TLB的映射覆盖. 因此, 一个内层循环内需要至少填充两次TLB, 才能使得每次都发生TLBmiss:

因此M>=1024, N>=128*M

## 4.

虚地址: 48bit-页面大小4K(offset12bit)=36bit(页表编号)

1) 为了用单层页表映射整个虚地址空间, 需要$2^36$个PTE

2) 程序体占用一个TLB项, 之后的数组读取过程中, 每次TLBmiss之后, 一个页中的内容全部可以TLB命中, 所以TLB命中率约为: (页中long int的个数 -1)/页中long int的个数. 若机器上 long int 长为 4Byte, 则每1024次访问有一次TLBmiss.

## 5. 

9+11+12

页面大小: 2^12Byte=4096Byte

地址空间中页的个数: 2^20个

地址空间大小: 2^32

## 6. 

4KB->2^12B

2^32B / 2^12B -> 2^20 页

单级页表: 2^20个PTE(全部地址空间的映射)

二级页表: 第二级页表有 2^20个PTE, 一共有2^10个二级页表, 所以第一级页表中有2^10个PTE, 共计2^20+2^10个PTE(完整情况下). 但是在一般情况下, 设栈的页面个数为k, 则总的页表项的个数为: 1(1+2^10) (程序段的1,2级页表) + ceil(k/2^10)(1+2^10) (stack对应的1,2级页表)1. 

## 7.

$$hitrate*1+(1-hirate)*5<=2$$

75%