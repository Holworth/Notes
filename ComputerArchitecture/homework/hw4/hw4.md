# 计算机体系结构

## 作业四

* 王华强
* 2016K8009929035

***

## 1. 网络包的处理应采用何种中断处理

应该分成上下两部分来处理. 网络包接收到网卡的时间比较长, 不可能使用中断来发送数据本身或者通过CPU来发送数据本身, 这样会浪费大量的CPU时间. 网络包的处理通过DMA直接由网卡搬运到内存. 因此需要采用上下两片DMA中断. 上片配置DMA参数, 下片报告DMA操作完成.

## 2. MIPS线程同步

```
#critical zone: 0xa0808000 (lock) 
.function

acquire_mutex_lock:
loop:
lw      v0 ,(0xa0808000) <==thread2_currrent_pc
bnez    v0, loop 
addiu   v0, 1
sw      v0 ,(0xa0808000) <==thread1_next_pc
jr      ra
nop

#thread1
jal     acquire_mutex_lock

......

#thread2
jal     acquire_mutex_lock
```

在这种情况下, 若两个线程的运行状态如图中所显示, 则线程1,2 均可获取锁. 但实际上应该是线程1获取锁, 线程2被阻塞.

```
#critical zone: 0xa0808000 (lock) 
.function

acquire_mutex_lock_llsc:
loop:
ll      v0 ,(0xa0808000)
addiu   v0, 1
sc      v0 ,(0xa0808000)
beqz    v0, loop
jr      ra
nop

#thread1
jal     acquire_mutex_lock_llsc

......

#thread2
jal     acquire_mutex_lock_llsc
```

这样的话临界区访问正确.

## 3. MIPS函数调用

测试共分为6种情况: 叶子函数和非叶子函数, 0, 1, 5个参数, 共计6种组合.

使用MIPS O32 ABI, 因此0, 1, 5个参数分别对应无参数, 寄存器传参, 寄存器+栈传参.

测试程序如下:

```c
int global_var;

int leaf0()
{
    return global_var;
}

int nest0()
{
    return leaf0();
}

int leaf1(int v1)
{
    return global_var+v1;
}

int nest1(int v1)
{
    return leaf0(v1);
}

int leaf5(int v1, int v2, int v3, int v4, int v5)
{
    return global_var+v1+v2+v3+v4+v5;
}

int nest5(int v1, int v2, int v3, int v4, int v5)
{
    return leaf0(v1, v2, v3, v4, v5);
}
```

### O0:

```
00400620 <leaf0>:
  400620:	27bdfff8 	addiu	sp,sp,-8
  400624:	afbe0004 	sw	s8,4(sp)
  400628:	03a0f021 	move	s8,sp
  40062c:	3c1c0042 	lui	gp,0x42
  400630:	279c8a60 	addiu	gp,gp,-30112
  400634:	8f828034 	lw	v0,-32716(gp)
  400638:	00000000 	nop
  40063c:	8c420000 	lw	v0,0(v0)
  400640:	03c0e821 	move	sp,s8
  400644:	8fbe0004 	lw	s8,4(sp)
  400648:	27bd0008 	addiu	sp,sp,8
  40064c:	03e00008 	jr	ra
  400650:	00000000 	nop

00400654 <nest0>:
  400654:	27bdffe0 	addiu	sp,sp,-32
  400658:	afbf001c 	sw	ra,28(sp)
  40065c:	afbe0018 	sw	s8,24(sp)
  400660:	03a0f021 	move	s8,sp
  400664:	afbc0010 	sw	gp,16(sp)
  400668:	0c100188 	jal	400620 <leaf0>
  40066c:	00000000 	nop
  400670:	8fdc0010 	lw	gp,16(s8)
  400674:	03c0e821 	move	sp,s8
  400678:	8fbf001c 	lw	ra,28(sp)
  40067c:	8fbe0018 	lw	s8,24(sp)
  400680:	27bd0020 	addiu	sp,sp,32
  400684:	03e00008 	jr	ra
  400688:	00000000 	nop

0040068c <leaf1>:
  40068c:	27bdfff8 	addiu	sp,sp,-8
  400690:	afbe0004 	sw	s8,4(sp)
  400694:	03a0f021 	move	s8,sp
  400698:	3c1c0042 	lui	gp,0x42
  40069c:	279c8a60 	addiu	gp,gp,-30112
  4006a0:	afc40008 	sw	a0,8(s8)
  4006a4:	8f828034 	lw	v0,-32716(gp)
  4006a8:	00000000 	nop
  4006ac:	8c430000 	lw	v1,0(v0)
  4006b0:	8fc20008 	lw	v0,8(s8)
  4006b4:	00000000 	nop
  4006b8:	00621021 	addu	v0,v1,v0
  4006bc:	03c0e821 	move	sp,s8
  4006c0:	8fbe0004 	lw	s8,4(sp)
  4006c4:	27bd0008 	addiu	sp,sp,8
  4006c8:	03e00008 	jr	ra
  4006cc:	00000000 	nop

004006d0 <nest1>:
  4006d0:	27bdffe0 	addiu	sp,sp,-32
  4006d4:	afbf001c 	sw	ra,28(sp)
  4006d8:	afbe0018 	sw	s8,24(sp)
  4006dc:	03a0f021 	move	s8,sp
  4006e0:	afbc0010 	sw	gp,16(sp)
  4006e4:	afc40020 	sw	a0,32(s8)
  4006e8:	8fc40020 	lw	a0,32(s8)
  4006ec:	0c100188 	jal	400620 <leaf0>
  4006f0:	00000000 	nop
  4006f4:	8fdc0010 	lw	gp,16(s8)
  4006f8:	03c0e821 	move	sp,s8
  4006fc:	8fbf001c 	lw	ra,28(sp)
  400700:	8fbe0018 	lw	s8,24(sp)
  400704:	27bd0020 	addiu	sp,sp,32
  400708:	03e00008 	jr	ra
  40070c:	00000000 	nop

00400710 <leaf5>:
  400710:	27bdfff8 	addiu	sp,sp,-8
  400714:	afbe0004 	sw	s8,4(sp)
  400718:	03a0f021 	move	s8,sp
  40071c:	3c1c0042 	lui	gp,0x42
  400720:	279c8a60 	addiu	gp,gp,-30112
  400724:	afc40008 	sw	a0,8(s8)
  400728:	afc5000c 	sw	a1,12(s8)
  40072c:	afc60010 	sw	a2,16(s8)
  400730:	afc70014 	sw	a3,20(s8)
  400734:	8f828034 	lw	v0,-32716(gp)
  400738:	00000000 	nop
  40073c:	8c430000 	lw	v1,0(v0)
  400740:	8fc20008 	lw	v0,8(s8)
  400744:	00000000 	nop
  400748:	00621821 	addu	v1,v1,v0
  40074c:	8fc2000c 	lw	v0,12(s8)
  400750:	00000000 	nop
  400754:	00621821 	addu	v1,v1,v0
  400758:	8fc20010 	lw	v0,16(s8)
  40075c:	00000000 	nop
  400760:	00621821 	addu	v1,v1,v0
  400764:	8fc20014 	lw	v0,20(s8)
  400768:	00000000 	nop
  40076c:	00621821 	addu	v1,v1,v0
  400770:	8fc20018 	lw	v0,24(s8)
  400774:	00000000 	nop
  400778:	00621021 	addu	v0,v1,v0
  40077c:	03c0e821 	move	sp,s8
  400780:	8fbe0004 	lw	s8,4(sp)
  400784:	27bd0008 	addiu	sp,sp,8
  400788:	03e00008 	jr	ra
  40078c:	00000000 	nop

00400790 <nest5>:
  400790:	27bdffd8 	addiu	sp,sp,-40
  400794:	afbf0024 	sw	ra,36(sp)
  400798:	afbe0020 	sw	s8,32(sp)
  40079c:	03a0f021 	move	s8,sp
  4007a0:	afbc0018 	sw	gp,24(sp)
  4007a4:	afc40028 	sw	a0,40(s8)
  4007a8:	afc5002c 	sw	a1,44(s8)
  4007ac:	afc60030 	sw	a2,48(s8)
  4007b0:	afc70034 	sw	a3,52(s8)
  4007b4:	8fc20038 	lw	v0,56(s8)
  4007b8:	00000000 	nop
  4007bc:	afa20010 	sw	v0,16(sp)
  4007c0:	8fc40028 	lw	a0,40(s8)
  4007c4:	8fc5002c 	lw	a1,44(s8)
  4007c8:	8fc60030 	lw	a2,48(s8)
  4007cc:	8fc70034 	lw	a3,52(s8)
  4007d0:	0c100188 	jal	400620 <leaf0>
  4007d4:	00000000 	nop
  4007d8:	8fdc0018 	lw	gp,24(s8)
  4007dc:	03c0e821 	move	sp,s8
  4007e0:	8fbf0024 	lw	ra,36(sp)
  4007e4:	8fbe0020 	lw	s8,32(sp)
  4007e8:	27bd0028 	addiu	sp,sp,40
  4007ec:	03e00008 	jr	ra
  4007f0:	00000000 	nop
```

### O2:

```
00400620 <leaf0>:
  400620:	3c1c0042 	lui	gp,0x42
  400624:	279c88b0 	addiu	gp,gp,-30544
  400628:	8f838034 	lw	v1,-32716(gp)
  40062c:	00000000 	nop
  400630:	8c620000 	lw	v0,0(v1)
  400634:	03e00008 	jr	ra
  400638:	00000000 	nop

0040063c <nest0>:
  40063c:	3c1c0042 	lui	gp,0x42
  400640:	279c88b0 	addiu	gp,gp,-30544
  400644:	8f838034 	lw	v1,-32716(gp)
  400648:	00000000 	nop
  40064c:	8c620000 	lw	v0,0(v1)
  400650:	03e00008 	jr	ra
  400654:	00000000 	nop

00400658 <leaf1>:
  400658:	3c1c0042 	lui	gp,0x42
  40065c:	279c88b0 	addiu	gp,gp,-30544
  400660:	8f838034 	lw	v1,-32716(gp)
  400664:	00000000 	nop
  400668:	8c620000 	lw	v0,0(v1)
  40066c:	03e00008 	jr	ra
  400670:	00821021 	addu	v0,a0,v0

00400674 <nest1>:
  400674:	3c1c0042 	lui	gp,0x42
  400678:	279c88b0 	addiu	gp,gp,-30544
  40067c:	8f838034 	lw	v1,-32716(gp)
  400680:	00000000 	nop
  400684:	8c620000 	lw	v0,0(v1)
  400688:	03e00008 	jr	ra
  40068c:	00000000 	nop

00400690 <leaf5>:
  400690:	3c1c0042 	lui	gp,0x42
  400694:	279c88b0 	addiu	gp,gp,-30544
  400698:	8f828034 	lw	v0,-32716(gp)
  40069c:	00000000 	nop
  4006a0:	8c430000 	lw	v1,0(v0)
  4006a4:	8fa20010 	lw	v0,16(sp)
  4006a8:	00832021 	addu	a0,a0,v1
  4006ac:	00852021 	addu	a0,a0,a1
  4006b0:	00862021 	addu	a0,a0,a2
  4006b4:	00872021 	addu	a0,a0,a3
  4006b8:	03e00008 	jr	ra
  4006bc:	00821021 	addu	v0,a0,v0

004006c0 <nest5>:
  4006c0:	3c1c0042 	lui	gp,0x42
  4006c4:	279c88b0 	addiu	gp,gp,-30544
  4006c8:	8f838034 	lw	v1,-32716(gp)
  4006cc:	00000000 	nop
  4006d0:	8c620000 	lw	v0,0(v1)
  4006d4:	03e00008 	jr	ra
  4006d8:	00000000 	nop

```

### O3:

```

00400620 <leaf0>:
  400620:	3c1c0042 	lui	gp,0x42
  400624:	279c88b0 	addiu	gp,gp,-30544
  400628:	8f838034 	lw	v1,-32716(gp)
  40062c:	00000000 	nop
  400630:	8c620000 	lw	v0,0(v1)
  400634:	03e00008 	jr	ra
  400638:	00000000 	nop

0040063c <nest0>:
  40063c:	3c1c0042 	lui	gp,0x42
  400640:	279c88b0 	addiu	gp,gp,-30544
  400644:	8f838034 	lw	v1,-32716(gp)
  400648:	00000000 	nop
  40064c:	8c620000 	lw	v0,0(v1)
  400650:	03e00008 	jr	ra
  400654:	00000000 	nop

00400658 <leaf1>:
  400658:	3c1c0042 	lui	gp,0x42
  40065c:	279c88b0 	addiu	gp,gp,-30544
  400660:	8f838034 	lw	v1,-32716(gp)
  400664:	00000000 	nop
  400668:	8c620000 	lw	v0,0(v1)
  40066c:	03e00008 	jr	ra
  400670:	00821021 	addu	v0,a0,v0

00400674 <nest1>:
  400674:	3c1c0042 	lui	gp,0x42
  400678:	279c88b0 	addiu	gp,gp,-30544
  40067c:	8f838034 	lw	v1,-32716(gp)
  400680:	00000000 	nop
  400684:	8c620000 	lw	v0,0(v1)
  400688:	03e00008 	jr	ra
  40068c:	00000000 	nop

00400690 <leaf5>:
  400690:	3c1c0042 	lui	gp,0x42
  400694:	279c88b0 	addiu	gp,gp,-30544
  400698:	8f828034 	lw	v0,-32716(gp)
  40069c:	00000000 	nop
  4006a0:	8c430000 	lw	v1,0(v0)
  4006a4:	8fa20010 	lw	v0,16(sp)
  4006a8:	00832021 	addu	a0,a0,v1
  4006ac:	00852021 	addu	a0,a0,a1
  4006b0:	00862021 	addu	a0,a0,a2
  4006b4:	00872021 	addu	a0,a0,a3
  4006b8:	03e00008 	jr	ra
  4006bc:	00821021 	addu	v0,a0,v0

004006c0 <nest5>:
  4006c0:	3c1c0042 	lui	gp,0x42
  4006c4:	279c88b0 	addiu	gp,gp,-30544
  4006c8:	8f838034 	lw	v1,-32716(gp)
  4006cc:	00000000 	nop
  4006d0:	8c620000 	lw	v0,0(v1)
  4006d4:	03e00008 	jr	ra
  4006d8:	00000000 	nop

```

### 分析部分

在O0下, 函数调用严格遵守 MIPS O32 规范

O0-->O2中, 多余的栈操作被优化掉. 不再按照完整的 MIPS O32 保存和回复现场, 只是处理函数中用到的部分. 并且在此例中, O2操作用到了MIPS分支延迟槽的特性.

O2-->O3对于这个简单的函数变化不大, 但是对于更复杂的函数会有效果. O3优化使用激进的向量化算法来使得代码并行度提高, 以适应现代CPU结构.

## 4. ABI与结构体对齐

x86-64ABI Microsoft Windows [版本 10.0.17713.1002]

```c
#include<stdio.h>
#include<stdlib.h>

#define psize(x) printf("Sizeof "#x" is %d\n",sizeof(x))

struct dic{
    double d;
    int i;
    char c;
};

struct dci{
    double d;
    char c;
    int i;
};
struct dc4i{
    double d;
    char c[4];
    int i;
};
struct dc5i{
    double d;
    char c[5];
    int i;
};
struct dc8i{
    double d;
    char c[5];
    int i;
};
struct dc9i{
    double d;
    char c[5];
    int i;
};

struct idc{
    int i;
    double d;
    char c;
};

struct cdi{
    char c;
    double d;
    int i;
};

struct cid{
    char c;
    int i;
    double d;
};

struct ccid{
    char c1;
    char c2;
    int i;
    double d;
};

struct ic{
    int i;
    char c;
};
struct ic4{
    int i;
    char c[4];
};
struct ic5{
    int i;
    char c[5];
};
struct ci{
    char c;
    int i;
};
struct c4i{
    char c[4];
    int i;
};
struct c5i{
    char c[5];
    int i;
};
struct c8i{
    char c[8];
    int i;
};

struct icd{
    int a1;
    char a2;
    double a0;
};

int main()
{
    psize(struct dic);
    psize(struct dci);
    psize(struct idc);
    psize(struct cdi);
    psize(struct icd);
    psize(struct cid);
    psize(struct ic);
    psize(struct ic4);
    psize(struct ic5);
    psize(struct ci);
    psize(struct c4i);
    psize(struct c5i);
    psize(struct c8i);
}
```

结果如下:

```
Sizeof struct dic is 16
Sizeof struct dci is 16
Sizeof struct idc is 24
Sizeof struct cdi is 24
Sizeof struct icd is 16
Sizeof struct cid is 16
Sizeof struct ic is 8
Sizeof struct ic4 is 8
Sizeof struct ic5 is 12
Sizeof struct ci is 8
Sizeof struct c4i is 8
Sizeof struct c5i is 12
Sizeof struct c8i is 12
```

对齐方式如下:

1. 结构总大小为其中最大元素的整数倍.
1. 每个元素对齐在其大小的整数倍.
1. 每个成员按顺序排列.

例如:

```
ic: iiiic--- (8)
ic4: iiiicccc (8)
ic5: iiiiccccc--- (12)
dic: ddddddddiiiic--- (16)
idc: iiii----ddddddddc------- (24)
```

## 5. MIPS O32 ABI 下函数调用, 系统调用, 中断处理上下文切换的区别

区别点|函数调用|系统调用|中断处理
-|-|-|-
返回地址|ra|epc+4|epc
返回指令|jr|eret|eret
现场保存内容|调用者保存的寄存器, 多余的参数, 当前函数的返回地址进栈|部分现场(s0-s7)|整个现场
现场保存位置|用户栈|内核栈|内核栈

<!-- 内核态现场保存内容|部分寄存器,之前返回地址等进栈(函数调用ABI)|整个内核现场(全regs)|整个内核现场 -->

注: 函数调用时调用者保存的寄存器, 多余的参数, 当前函数的返回地址进栈, 子函数开始时可能需要保持被调用者保存的寄存器.
 