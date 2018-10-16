# 计算机体系结构

## 作业三

* 王华强
* 2016K8009929035

***

## 1. MIPS与X86在异常处理上的区别

阶段|补充描述|MIPS|X86
-|-|-|-
异常处理准备|`EPTR`位置|`EPTR`存储于EPC寄存器|`CS`,`EPTR`存储在栈中
确定异常来源|硬件操作|异常状态存储在Cause寄存器中|由硬件进行异常和中断号的查询, 查询中断描述符表得到异常处理地址, 进行`CS/EIP`压栈操作
确定异常来源|软件操作|异常处理程序查询Cause寄存器做进一步的处理|
确定异常来源||异常状态存储在Cause寄存器中|由硬件进行异常和中断号的查询, 查询中断描述符表得到异常处理地址, 进行`CS/EIP`压栈操作
保存执行状态|类似
处理异常|类似
恢复执行状态并返回||ERET/IRET指令有类似的效果

*EPTR是被异常打断的指令 

## 2. MIPS的LLbit在发生异常之后会如何处理

LLbit是用于维护原子性的标志位. 在LL指令访问一个地址之后, 若此地址上的值被改写则改变LLbit, 在SC指令执行时检查LLbit, 若LLbit值被改变, 则说明原子操作失败, 需要重复原子操作.

在发生异常时, 如果异常是由中断引起的, MIPS的中断控制依赖于SR寄存器, 而SR寄存器的改写需要通过软件实现. 这段汇编实现是原子操作, 因此需要使用LL/SC保证其原子性. 每次SR寄存器被修改时, LLbit被设置, 并被检查, 来保证这段操作的原子性.

在LL和SC指令之间发生异常时, 如果异常改写了LL/SC保护的地址的值, 则会反映在SC指令的结果上.

## 3. 精确异常与非精确异常的区别, 找出一个使用非精确异常的处理器

在乱序执行处理器中, 指令的运行顺序不一定按顺序执行. 精确异常会保证在触发异常的指令之后的指令都不被执行. EPTR中保存触发异常的指令的精确位置. 异常处理程序可以忽略硬件带来的异常发生位置问题. 而非精确异常中, 后面的指令可能被执行, EPTR中保存的是真正触发异常指令的指令的后面的某个指令. 因此, 需要异常处理程序来解决这些问题. 

使用非精确异常的处理器:

MPC7450, 属于 PowerPC G4 系列:

> PowerPC G4 is a designation used by Apple Computer and Eyetech to describe a fourth generation of 32-bit PowerPC microprocessors. Apple has applied this name to various (though closely related) processor models from Freescale, a former part of Motorola. Motorola and Freescale's proper name of this family of processors is PowerPC 74xx.

以及年代久远的 IBM360/91 Series

## 4. 判断异常次数

```c
void cycle(double* a)
{
    int i;
    double b[65536];
    for(int i=0;i<3;i++)
    {
        memcpy(a,b,sizeof(b));
    }
}
```

> 前提假定: a对应的数据保存在硬盘中且之前没有被读取进内存

在a,b首次被使用时, 需要触发TLB_refill异常. 

$$65536*8Byte=2^9KB=2^7PAGE$$

MIPS架构下的TLB_refill()每次将两个连续的虚拟页装入TLB, 因此在A, B首次被使用时, 需要TLB_refill()的次数为:

$$2^7*2\div 2=128次$$

但是, A, B首次被使用需要TLB_invaild()异常, TLB_invaild()每次填充一个Page, 因此需要:

$$2*2^7=256$$

在此之后, A, B的内容均处在内存中, 且在TLB表中有登记过, 之后的复制(i=1,2)不再触发异常. 因此共计触发异常:

$$64*2+256=384次$$

## 5. C语言描述TLB页式存储管理过程

```c
//所有涉及移位的操作因为太过繁杂略过不表
#define TCBSIZE (1024*1024)//32位系统: 1M
//宏定义, 取出地址中的对应位以及移位操作
#define ASID(x) ......
#define VPN(x) ......
#define OFFSET(x) ......

#define proc_asid regs.EntryHi; 
//当前进程的ASID

uint32_t virtual_address;
uint32_t write;

struct tlb_t{
    uint_t MASK,
    uint32_t VPN_2,
    bool G,//Global
    uint32_t ASID,

    uint32_t PFN1,
    uint32_t C1,//Cache Algorithm
    uint32_t D1, //Dirty
    uint32_t V1 //Valid

    uint32_t PFN2,
    uint32_t C2,//Cache Algorithm
    uint32_t D2, //Dirty
    uint32_t V2 //Valid
};

struct tlb_t TLB[TCBSIZE];

struct tlb_related_regs_t{
    uint32_t EntryHi,
    uint32_t Pagemask,
    uint32_t EntryLo0,
    uint32_t EntryLo1,
    uint32_t Content,
    // uint32_t Index,
    // uint32_t Random,
    // uint32_t Wired,
}regs;

void tlb_refill_exception();
void tlb_invalid_exception();
void tlb_modify_exception();

uint32_t get_real_address(uint32_t vaddr)
{
get_read_address_start:
    uint32_t tlb_match;
    if(tlb_match=match(ASID(regs.EntryHi))//Match ASID succeed
    {
        if(write&&(!TLB[tlb_match].Dx))
        {
            tlb_modify_exception();
            goto get_read_address_start;
        }
        if(!TLB[tlb_match].Vx)
        {
            tlb_invalid_exception();
            goto get_read_address_start;

        }
        return TLB[tlb_match].PFNx+OFFSET(vaddr);
    }
    else
    {
        tlb_refill_exception();
        goto get_read_address_start;
    }
}

void tlb_refill_exception()
{
    //Hardware
    Set(regs.EntryHi);
    //Asm
    asm(
        "mfc0 $k1, regs.Content",
        "nop",
        "lw $k0, 0($k1)",
        "lw $k1, 4($k1)",
        "mtc0 $k0, regs.EntryLo0",
        "mtc0 $k1, regs.EntryLo1",
        "nop",
        "tlbwr",
        "eret"
    )
}

```