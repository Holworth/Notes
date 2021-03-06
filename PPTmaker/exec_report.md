﻿#### Operation System Instance Analyze Report
# 第三部分

王华强 张丽玮 刘蕴哲

---

```
exec/usys.S
sys_exec/sysfiles.c->argstr, fetchstr, argint, fetchint/syscall.c
 ->exec/exec.c
```

---

## 背景介绍

* proc
```c
struct proc {
  char *mem;                   // Start of process memory (kernel address)
  uint sz;                     // Size of process memory (bytes)
  char *kstack;                // Bottom of kernel stack for this process
  enum procstate state;       // Process state
  volatile int pid;            // Process ID
  struct proc *parent;         // Parent process
  struct trapframe *tf;        // Trap frame for current syscall
  struct context *context;     // Switch here to run process
  void *chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)
  };
```

--

* cpu
```c
struct cpu {
  uchar apicid;                // Local APIC ID
  struct context *context;     // Switch here to enter scheduler
  struct taskstate ts;         // Used by x86 to find stack for interrupt
  struct segdesc gdt[NSEGS];   // x86 global descriptor table
  volatile uint booted;        // Has the CPU started?
  int ncli;                    // Depth of pushcli nesting.
  int intena;                  // Were interrupts enabled before pushcli?
  void *tls[2];
};
```

存储当前的cpu信息

--

* inode

inode包含文件的元信息，具体来说有以下内容：

* 文件的字节数
* 文件拥有者的User ID
* 文件的Group ID
* 文件的读、写、执行权限
* 文件的时间戳，共有三个：ctime指inode上一次变动的时间，mtime指文件内容上一次变动的时间，atime指文件上一次打开的时间。
* 链接数，即有多少文件名指向这个inode
* 文件数据block的位置

--

* pgdir

指向unsigned int的指针

--

* trapframe

Trapframe保存的都是一些系统关键的寄存器。这里我们只需要特别关注4个寄存器，涉及到程序执行的控制流问题：

EFLAGS：状态寄存器,这个我们暂时用不到

EIP：Instruction Pointer，当前执行的汇编指令的地址

ESP：当前的栈底

EBP：栈顶，当前过程的帧在栈中的开始地址(高地址)

--

* CPL

CPL（Current Privilege Level）。当前执行任务的或程序的特权级。常与DPL（Description Privilege Level）一起用来仲裁下一中断是否可以执行，如果DPL的值小于CPL，则产生一个General protection异常。

cs寄存器的最后两位是标志特权状态的寄存器，当为0是为系统态，为3是为用户态

---

## 代码分析

```c
int
exec(char *path, char **argv)
{
//划分临时存储空间

  char *s, *last;
  int i, off;
  uint argc, sz, sp, ustack[3+MAXARG+1];//ustack[3+MAXARG+1]是用于参数保存等的哟个临时数组, 在栈的建立过程中发挥作用 ustack[3+MAXARG+1]的声明划分了所需的临时空间.
//#define MAXARG       32  // max exec arguments
  struct elfhdr elf;// ELF File header
  struct inode *ip;// in-memory copy of an inode
// inode: 索引节点 ref: https://baike.baidu.com/item/inode/16194?fr=aladdin
  struct proghdr ph;//Program section header
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();//read proc from cpu;

// myproc(): 
// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
```
--

```c
// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}
```

--

```c
//文件读取操作

  begin_op();// called at the start of each FS system call.

  if((ip = namei(path)) == 0){//传入文件路径，打开文件，传入ip标志符
    end_op();// called at the end of each FS system call.
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);// Lock the given inode.
  // Lock the given inode for readi();
  pgdir = 0;
```
--

```c
//ELF头合法性检查, 如果合法则将其加载进页表pgdir

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))// Read data from inode.
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
    //判断是否是ELF文件头，根据魔数检查，参见魔数定义

  if((pgdir = setupkvm()) == 0)// Set up kernel part of a page table.创建一个在核心态使用的页表
    goto bad;//If failed.

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){// Program section header
  //phnum定义：程序头的项数
  // for(i=0, off=Program header table file offset; i<Program header table entrycount; i++, off+=sizeof(Program section header))
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)// Values for Proghdr type := (Program section header).type

  //p_type - only copy if it is ELF_PROG_LOAD
      continue;
    if(ph.memsz < ph.filesz)//TODO
    //关于memsz：内存镜像中的大小
    //filesz:文件中的大小
    /*程序段头中的 `filesz` 可能比 `memsz` 小，这表示中间相差的地方应该用 0 填充（对于 C的全局变量）而不是继续从文件中读数据。对于`/init`，`filesz` 是 2240 字节而 `memsz` 是 2252 字节。所以`allocuvm` 会分配足够的内存来装 2252 字节的内容，但只从文件 `/init` 中读取 2240 字节的内容。
*/
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)// check if data is valid, in case there is invalid elf or spiteful elf
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
      // allocuvm():=
      // Allocate page tables and physical memory to grow process from oldsz to
      // newsz, which need not be page aligned.  Returns new size or 0 on error.
    if(ph.vaddr % PGSIZE != 0)//if not aligned
      goto bad;//prepare aligned addr for loaduvm
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
    // loaduvm():=
    // Load a program segment into pgdir.  addr must be page-aligned
    // and the pages from addr to addr+sz must already be mapped.

    //TODO: pagetable
  }
  iunlockput(ip);
  // Unlock the given inode.
  // Drop a reference to an in-memory inode.
  end_op();// called at the end of each FS system call.
  ip = 0;
  //文件系统调用结束
```
--

```c
  // Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
```

--

```c
//分配内存空间, 创建用户栈

  // TODO: 了解关于page管理的相关说明
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);//寻找页边界, 一个移位操作
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)//用户虚拟内存分配: 两个page
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  // clearpteu() :=
  // Clear PTE_U on a page. Used to create an inaccessible权限不可访问
  // page beneath the user stack.
  sp = sz;//放置新的页指针位置 (TODO)
```

--

它只为栈分配一页内存。`exec` 一次性把参数字符串拷贝到栈顶，然后把指向它们的指针保存在`ustack` 中。它还会在 `main` 参数列表 `argv` 的最后放一个空指针。这样，`ustack` 中的前三项就是伪造的返回PC，`argc` 和 `argv` 指针了

`exec` 会在栈的页下方放一个无法访问的页，这样当程序尝试使用超过一个页的栈时就会出错。另外，这个无法访问的页也让 `exec`能够处理那些过于庞大的参数；当参数过于庞大时，`exec` 用于将参数拷贝到栈上的函数 `copyout` 会发现目标页无法访问，并且返回-1。

--

逻辑地址：CPU所生成的地址。CPU产生的逻辑地址被分为 :p （页号） 它包含每个页在物理内存中的基址，用来作为页表的索引；d （页偏移），同基址相结合，用来确定送入内存设备的物理内存地址。

物理地址：内存单元所看到的地址。逻辑地址空间为2^m，且页大小为2^n，那么逻辑地址的高m－n位表示页号，低n位表示页偏移。

--

逻辑地址空间:由程序所生成的所有逻辑地址的集合。

物理地址空间:与逻辑地址相对应的内存中所有物理地址的集合,用户程序看不见真正的物理地址。

注：用户只生成逻辑地址，且认为进程的地址空间为0到max。物理地址范围从R+0到R+max，R为基地址,地址映射－将程序地址空间中使用的逻辑地址变换成内存中的物理地址的过程。由内存管理单元（MMU）来完成。

--

分页逻辑地址 =P(页号).d(页内位移)

分页物理地址=f(页帧号).d(同上)

P = 线性逻辑地址/页面大小

d= 线性逻辑地址-P*页面大小

--

```c
//扩展用户栈, 向栈中写入程序运行所需信息

//复制参数列表

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    //argv[]的约定: 最后一个位置留空-->0
    //一个数组，前面的指向参数列表
    if(argc >= MAXARG)//32
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;//~3->111111111100 => 抹去低2位以对齐
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    // if(copyout(目标用户地址所在页表, 目标用户地址, 来源, copy数据大小(byte))
      goto bad;
    // copyout() :=
    // Copy len bytes from p to user address va in page table pgdir.
    // Most useful when pgdir is not the current page table.
    // uva2ka ensures this only works for PTE_U pages.
    // Return 0 if succeed.
    ustack[3+argc] = sp;//当前指针写入ustak
    //ustak前3位用途见下文
    //ustack[3+MAXARG+1];//ustack[3+MAXARG+1]是用于参数保存等的哟个临时数组, 在栈的建立过程中发挥作用 ustack[3+MAXARG+1]的声明划分了所需的临时空间.
  }
  ustack[3+argc] = 0;//argv[]中最后一个元素, 按照约定置0

//生成在C语言调用中所见的argc, argv

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
  //sp - (argc+1)*4是未来的(执行下一个copyout之后的)argv pointer的所在位置.

//写入栈中

  sp -= (3+argc+1) * 4;//划分空间, 准备将ustack复制进栈空间
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

// Save program name for debugging.
  for(last=s=path; *s; s++)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
```
--

```c
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
```

---

```c
//最后提交


// Commit to the user image.
// TODO switchuvm(curproc)?
  //将当前的所有信息提交到curproc传递给switchuvm()
  //之后关闭旧的页表
  //ie: 用新的程序来填充当前进程
  //返回0
  oldpgdir = curproc->pgdir;//旧进程内容的页表
  //使用新进程的信息来覆盖旧的
  curproc->pgdir = pgdir;
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
  curproc->tf->esp = sp;//栈底指针，指向用户栈
  //
  switchuvm(curproc);// Switch TSS任务状态段 and h/w page table to correspond to process p. TODO: 需要详细注释
  freevm(oldpgdir);//释放旧进程内容的页表
  return 0;
```

--

switchkvm简单地将kpgdir设置为cr3寄存器的值，这个页表仅仅在 scheduler内核线程中使用。

页表和内核栈都是每个进程独有的，xv6使用结构体proc将它们统一起来，在进程切换的时候，他们也往往随着进程切换而切换，内核中模拟出了一个内核线程，它独占内核栈和内核页表kpgdir，它是所有进程调度的基础。

--

switchuvm通过传入的proc结构负责切换相关的进程独有的数据结构，其中包括TSS相关的操作，然后将进程特有的页表载入cr3寄存器，完成设置进程相关的虚拟地址空间环境。cr3是存储页目录表物理内存基地址的寄存器。

进程的页表在使用前往往需要初始化，其中必须包含内核代码的映射，这样进程在进入内核时便不需要再次切换页表，进程使用虚拟地址空间的低地址部分，高地址部分留给内核，设置页表时通过调用setupkvm、allocuvm、deallocuvm接口完成相关操作

---

```c

//通用错误处理


 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
    end_op();
  }
  //关闭页表
  //unlock, then put inode
  return -1;
}
```

---

## 问题解答

### 用户态的 exec 是在哪里定义的？和一般的函数定义有什么区别。

A：在exec.c中定义的。区别？

---

### 第一次进行 exec 系统调用的位置在哪里？加载的程序是哪个？参数是什么？

A：在initcode.s中。加载的程序是init，参数是$argv，$init，0作为参数项的结尾,但并非参数。

--

```asm

# exec(init, argv)
.globl start
start:
  pushl $argv
  pushl $init
  pushl $0  // where caller pc would be
  movl $SYS_exec, %eax
  int $T_SYSCALL

```

---

### sys_exec 是如何获取到从用户态传递过来的参数的？

A：在 initcode.S 中调用了一个系统调用。这个进程将 exec 所需的参数压栈，然后把系统调用号存在 %eax 中。这个系统调用号和 syscalls 数组中的条目匹配，因此通过argint,argstr和argptr，分别获取x相应的整数、字符串、指针参数。syscalls的系统调用函数来获得相应的参数。

---

### argint 的功能是什么？它在调用 fetchint时第一个参数是什么含义？其中proc->tf->esp指向的栈是用户栈还是内核栈？proc->tf->esp+4+4*n中为什么要加 4？

--

* argint 利用用户空间的 %esp 寄存器定位第 n 个参数. 第一个参数是process的进程结构体。
* 指向的是用户态。
* 因为%esp 指向系统调用结束后的返回地址。参数地址就恰好在 %esp 之上（%esp+4），因此要+4.

--

A：
```c
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
}
```

---


### exec/exec.c 加载用户程序用到的 struct elfhdr 数据结构，其中 magic,phnum,phoff 等字段的作用是什么？以及 struct proghd 的数据结构，其中 vaddr, memsz, filesz等字段的作用是什么？


* magic
* phnum-	number of program headers,程序头表中的项数。
* phoff-start of program headers，程序头表的文件偏移（以字节为单位）。如果文件没有程序头表，则此成员值为零。
* vaddr-该字段指明该段中内容的起始位置在进程地址空间中的虚拟地址;
* memsz-该字段指明该段中内容在内存镜像中的大小,也可以是0;单位是字节;
* filesz-该字段指明该段中内容在文件中的大小,也可以是0;单位是字节;

--

> Magic： 7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 7f
> 、45、4c、46分别对应ascii码的Del(删除)、字母E、字母L、字母F。这四个字节被称为ELF文件的魔数，操作系统在加载可执行文件时会确认魔数是否正确，如果不正确则拒绝加载。 第五个字节标识ELF文件是32位（01）还是64位（02）的。 第六个字节标识该ELF文件字节序是小端（01）还是大端（02）的。 第七个字节指示ELF文件的版本号，一般是01。 后九个字节ELF标准未做定义。一般为00.

---


### exec/exec/c 执行完以后，返回的地址是什么？为什么？

返回地址为eip寄存器内容。
调用失败返回的地址为原程序调用exec之后的下一条指令地址。
调用成功返回地址为新进程的起始地址。

---

### 进阶题

> 请结合代码详细分析 Linux 中 elf 文件格式(利用 readelf 命令)，以及链接和加载的机制。

可执行和可链接格式(Executable and Linkable Format，缩写为ELF)，常被称为ELF格式，在计算机科学中，是一种用于执行档、目的档、共享库和核心转储的标准文件格式。

--

```c
typedef struct {
Elf32_Half e_type;//Elf文件类型 
Elf32_Half e_machine;//ELF文件的CPU平台属性 
Elf32_Word e_version;//ELF版本信息 
Elf32_Addr e_entry;//入口地址 
Elf32_Off e_phoff;//程序头表的文件偏移（以字节为单位）。如果文件没有程序头表，则此成员值为零。 
Elf32_Off e_shoff;//节头表的文件偏移（以字节为单位）。如果文件没有节头表，则此成员值为零。 
Elf32_Word e_flags;//与文件关联的特定于处理器的标志。标志名称采用 EF_machine_flag 形式。 
Elf32_Half e_ehsize;//ELF 头的大小（以字节为单位） 
Elf32_Half e_phentsize;//文件的程序头表中某一项的大小（以字节为单位）。所有项的大小都相同 
Elf32_Half e_phnum;//程序头表中的项数。 
Elf32_Half e_shentsize;//节头的大小（以字节为单位）。节头是节头表中的一项。所有项的大小都相同 
Elf32_Half e_shnum;//节头表中的项数 
Elf32_Half e_shstrndx;//与节名称字符串表关联的项的节头表索引。
} Elf32_Ehdr;
```

--

```c
ELF 头：  
  Magic：   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00  
  类别:                              ELF32 
  数据:                               2 补码，小端序 (little endian)  
  版本:                               1 (current) 
   OS/ABI:                            UNIX - System V  ABI 
   版本:                              0  
   类型:                              REL (可重定位文件)  
   系统架构:                          Intel 80386  
   版本:                              0x1  
   入口点地址：                        0x0  
   程序头起点：          0 (bytes into file)  
   Start of section headers:          916 (bytes into file)  
   标志：             0x0  本头的大小：       52 (字节)  程序头大小：       0 (字节)  Number of program headers:         0  
   节头大小：         40 (字节)  节头数量：         14  
   字符串表索引节头： 11

```
--

* elf文件格式的链接

对于连接器而言，其连接的基本单位为各个可重定位文件的节区，也就是说连接器可以为可重定位文件的节区（section）指定其在连接后生成的目标文件（可执行文件）中的位置，包括其在文件内的位置和当其载入到内存后的位置，当确定好各个节区的位置后，连接器便可根据其位置和符号表，重定位表等信息，填入确定的地址信息，变生成可执行文件。这也就是连接器的工作。

--

对于ld来说，在linux下可用lds文件来指定连接具体过程，例：

```asm
ENTRY(_start) 
SECTIONS { 
  firtst    0x10000000 :{ leds.o }
  second    0xB0004000 :  AT(2048) {  init.o head.o}
}
```

--

这里指定了文件的入口点为_start，它表示在这几个可重定位文件的源文件内有一个_start的标号，当载入生成的可执行文件后，其入口点便为_start处的地址，这一点体现在elf文件的elf header里的e_entry，该值便指定了入口地址，至于该值的得出，是由于当指定好了各个区段的位置后，_start处代码载入到内存的位置可以计算得出。

在SECTIONS里面，指定了两项，便是可执行文件一共有两个程序段，并且也指定了，载入到内存后的地址和文件内部偏移，意味着，把该文件的所有需要在“内存申请空间”的节区放在一起，接下来又放第二个文件的节区。

将各个文件的节区任意摆布，只要正确的设置了入口点，那么程序都会正确按照程序逻辑执行，这是因为无论节区如何摆布，连接器总会用根据指定的地址，计算出应该跳转到的地址，也即是说，只要按照程序段头的信息载入该程序，然后设置正确的入口点，那么程序便可以正确执行。

---

#### elf文件格式的加载

源文件 Trunk/System/ElfLoader/dll/elfloader.c

LoadElfExec() 函数

---

#### 加载的具体过程

---

> Slides finished here.

---


1. 打开文件 open_library(char* filename)

       系统调用 open(): 创建 File 结构体 , 放入进程打开文件表 , 返回 ( 打开文件表 ) 下标

2. 读出文件头和程序头表 IsElfFormat(FILE)

       读出 ELF 文件头 ( 同时读出了程序头表 Program Header Table), 判断 ELF 格式根据文件头中的e_ident 来比较判断 .

3. 加载文件 load_library(char * filename,int fd)

       (1) 计算所有 segment 占用内存大小 get_lib_extents()

        通过遍历程序头表 (Program Header Table), 算出所有 segment 将占用的内存大小extents_size

        (2) 分配内存 alloc_mem_region(extents_size)

       匿名映射一块非共享的私有内存 ( 不涉及文件 )

        (3) 分配 soinfo 结构体 alloc_info(char *filename)

       从全局静态 soinfo 结构体数组中分配 soinfo 结构体 ( 描述整个 ELF 文件 )

        (4) 加载 segment

        load_segment(int fd,void* header,soinfo*si)

            (1) 可加载段 (PT_LOAD): 映射到内存

             mmap(void * start,size_t len, int prot,int flags,int fd,off_t offsize)

             把 ELF 文件 offsize 处的 segment 映射到已分配内存的 start 处

            (2) 动态链接段

                     由动态链接节设置 soinfo 中的动态链接信息

       (5) 设置 soinfo 结构体

4. 加载依赖的动态链接库

5. 重定位（自身符号）

   重定位表项:   Elf32_Addr     r_offset   (重定位)内存地址(offset of relocation)

                            Elf32_Word    r_info      符号表下标和类型(symbol table index and type)

      

   符号表项:      Elf32_Word    st_name  符号名(name - index into string table)

                            Elf32_Addr     st_value   符号值(symbol value)

                            Elf32_Word    st_size                 symbol size

                            unsigned char st_info                  type and binding

                            unsigned char st_other               0 - no defined meaning

                            Elf32_Half      st_shndx;                     section header index

 

       根据重定位表(表项)查符号表,得到符号内存地址,修改(重定位)内存值

 

最后得到soinfo结构体数组描述了所有加载的文件

6. 如果入口地址不为零，调用入口函数



## 参考资料——xv6中文手册

> #### 第一个系统调用：exec
> 
> `initcode.S` 干的第一件事是触发 `exec` 系统调用。就像我们在第0章看到的一样，`exec`
> 用一个新的程序来代替当前进程的内存和寄存器，但是其文件描述符、进程 id 和父进程都是不变的。
> 
> `initcode.S`（7708）刚开始会将 `$argv，$init，$0` 三个值推入栈中，接下来把 `%eax` 设置为
> `SYS_exec` 然后执行 `int T_SYSCALL`：这样做是告诉内核运行 `exec`
> 这个系统调用。如果运行正常的话，`exec` 不会返回：它会运行名为 `$init` 的程序，`$init` 是一个以空字符结尾的字符串，即
> `/init`（7721-7723）。如果 `exec` 失败并且返回了，`initcode` 会循环调用一个不会返回的系统调用
> `exit` 。
> 
> 系统调用 `exec` 的参数是
> `$init、$argv`。最后的`0`让这个手动构建的系统调用看起来就像普通的系统调用一样，我们会在第3章详细讨论这个问题。和之前的代码一样，xv6
> 努力避免为第一个进程的运行单独写一段代码，而是尽量使用通用于普通操作的代码。
> 
> 第2章讲了 `exec` 的具体实现，概括地讲，它会从文件中获取的 `/init` 的二进制代码代替 `initcode` 的代码。现在
> `initcode` 已经执行完了，进程将要运行 `/init`。
> `init`（7810）会在需要的情况下创建一个新的控制台设备文件，然后把它作为描述符0，1，2打开。接下来它将不断循环，开启控制台
> shell，处理没有父进程的僵尸进程，直到 shell 退出，然后再反复。系统就这样运行起来了。
> 
> #### 现实情况
> 
> 大多操作系统都采用了进程这个概念，而大多的进程都和 xv6 的进程类似。但是真正的操作系统会利用一个显式的链表在常数时间内找到空闲的
> `proc`，而不像 `allocproc` 中那样花费线性时间；xv6 使用的是朴素的线性搜索（找第一个空闲的 `proc`）。
> 
> xv6 的地址空间结构有一个缺点，即无法使用超过 2GB 的物理 RAM。当然我们可以解决这个问题，不过最好的解决方法还是使用64位的机器。
> 


----------

> #### 代码：`exec`
> 
> `exec` 是创建地址空间中用户部分的系统调用。它根据文件系统中保存的某个文件来初始化用户部分。`exec`（5910）通过
> `namei`（5920）打开二进制文件，这一点将在第 6 章进行解释。然后，它读取 ELF 头。xv6 应用程序以通行的 ELF
> 格式来描述，该格式在 `elf.h` 中定义。一个 ELF 二进制文件包括了一个 ELF 头，即结构体 `struct
> elfhdr`（0955），然后是连续几个程序段的头，即结构体 `struct proghdr`（0974）。每个 `proghdr`
> 都描述了需要载入到内存中的程序段。xv6 中的程序只有一个程序段的头，但其他操作系统中可能有多个。
> 
> `exec` 第一步是检查文件是否包含 ELF 二进制代码。一个 ELF 二进制文件是以4个“魔法数字”开头的，即
> 0x7F，“E”，“L”，“F”，或者写为宏 `ELF_MAGIC`（0952）。如果 ELF 头中包含正确的魔法数字，`exec`
> 就会认为该二进制文件的结构是正确的。
> 
> `exec` 通过 `setupkvm`（5931）分配了一个没有用户部分映射的页表，再通过 `allocuvm`（5943）为每个 ELF
> 段分配内存，然后通过 `loaduvm`（5945）把段的内容载入内存中。`allocuvm` 会检查请求分配的虚拟地址是否是在
> `KERNBASE` 之下。 `loaduvm`（1818） 通过 `walkpgdir` 来找到写入 ELF 段的内存的物理地址；通过
> `readi` 来将段的内容从文件中读出。
> 
> `exec` 创建的第一个用户程序 `/init` 程序段的头是这样的：
> 
> ~~~
> #objdump -p _init
> 
> _init:    file format elf32-i386
> 
> Program Header:
>     LOAD off    0x00000054 vaddr 0x00000000 paddr 0x00000000 align 2**2
>          filesz 0x000008c0 memsz 0x000008cc flags ~~~
> 
> 程序段头中的 `filesz` 可能比 `memsz` 小，这表示中间相差的地方应该用 0 填充（对于 C
> 的全局变量）而不是继续从文件中读数据。对于 `/init`，`filesz` 是 2240 字节而 `memsz` 是 2252 字节。所以
> `allocuvm` 会分配足够的内存来装 2252 字节的内容，但只从文件 `/init` 中读取 2240 字节的内容。
> 
> 现在 `exec` 要分配以及初始化用户栈了。它只为栈分配一页内存。`exec` 一次性把参数字符串拷贝到栈顶，然后把指向它们的指针保存在
> `ustack` 中。它还会在 `main` 参数列表 `argv` 的最后放一个空指针。这样，`ustack` 中的前三项就是伪造的返回
> PC，`argc` 和 `argv` 指针了。
> 
> `exec` 会在栈的页下方放一个无法访问的页，这样当程序尝试使用超过一个页的栈时就会出错。另外，这个无法访问的页也让 `exec`
> 能够处理那些过于庞大的参数；当参数过于庞大时，`exec` 用于将参数拷贝到栈上的函数 `copyout` 会发现目标页无法访问，并且返回
> -1。
> 
> 在创建新的内存映像时，如果 `exec` 发现了错误，比如一个无效的程序段，它就会跳转到标记 `bad` 处，释放这段内存映像，然后返回
> -1。`exec` 必须在确认该调用可以成功后才能释放原来的内存映像，否则，若原来的内存映像被释放，`exec` 甚至都无法向它返回 -1 了。`exec` 中的错误只可能发生在新建内存映像时。一旦新的内存映像建立完成，`exec`
> 就能装载新映像（5989）而把旧映像释放（5990）。最后，`exec` 成功地返回 0。


----------


> ### 代码：第一个系统调用
> 
> 第一章的最后在 `initcode.S` 中调用了一个系统调用。让我们再看一遍（7713）。这个进程将 `exec`
> 所需的参数压栈，然后把系统调用号存在 %eax 中。这个系统调用号和 syscalls 数组中的条目匹配，（syscall
> 是一个函数指针的数组）（3350）。我们需要设法使得 int 指令将处理器的状态从用户模式切换到内核模式，调用适当的内核函数（例如在这里是
> `sys_exec`），并且使内核可以取出 `sys_exec` 的参数。接下来的几个小节将描述 xv6
> 是如何做到这一点的，你会发现我们可以用同样的代码来实现中断和异常。


----------

> ### 代码：系统调用
> 
> 对于系统调用，`trap` 调用 `syscall`（3375）。`syscall` 从中断帧中读出系统调用号，中断帧也包括被保存的
> %eax，以及到系统调用函数表的索引。对第一个系统调用而言，%eax 保存的是 SYS_exec（3207），并且 `syscall`
> 会调用第 `SYS_exec` 个系统调用函数表的表项，相应地也就调用了 `sys_exec`。
> 
> `syscall` 在 %eax 保存系统调用函数的返回值。当 `trap` 返回用户空间时，它会从 `cp->tf`
> 中加载其值到寄存器中。因此，当 `exec`
> 返回时，它会返回系统调用处理函数返回的返回值（3381）。系统调用按照惯例会在发生错误的时候返回一个小于 0
> 的数，成功执行时返回正数。如果系统调用号是非法的，syscall 会打印错误并且返回 -1。
> 
> 之后的章节会讲解系统调用的实现。这一章关心的是系统调用的机制。还有一点点的机制没有说到：如何获得系统调用的参数。工具函数
> `argint`、`argptr` 和 `argstr` 获得第 n
> 个系统调用参数，他们分别用于获取整数，指针和字符串起始地址。argint 利用用户空间的 %esp 寄存器定位第 n 个参数：%esp
> 指向系统调用结束后的返回地址。参数就恰好在 %esp 之上（%esp+4）。因此第 n 个参数就在 %esp+4+4*n。
> 
> `argint` 调用 `fetchint` 从用户内存地址读取值到 `*ip`。`fetchint`
> 可以简单地将这个地址直接转换成一个指针，因为用户和内核共享同一个页表，但是内核必须检验这个指针的确指向的是用户内存空间的一部分。内核已经设置好了页表来保证本进程无法访问它的私有地址以外的内存：如果一个用户尝试读或者写高于（包含）p->sz的地址，处理器会产生一个段中断，这个中断会杀死此进程，正如我们之前所见。但是现在，我们在内核态中执行，用户提供的任何地址都是有权访问的，因此必须要检查这个地址是在
> p->sz 之下的。
> 
> `argptr` 和 `argint` 的目标是相似的：它解析第 n 个系统调用参数。`argptr` 调用 `argint` 来把第 n
> 个参数当做是整数来获取，然后把这个整数看做指针，检查它的确指向的是用户地址空间。注意 `argptr`
> 的源码中有两次检查。首先，用户的栈指针在获取参数的时候被检查。然后这个获取到得参数作为用户指针又经过了一次检查。
> 
> `argstr` 是最后一个用于获取系统调用参数的函数。它将第 n 个系统调用参数解析为指针。它确保这个指针是一个 NUL
> 结尾的字符串并且整个完整的字符串都在用户地址空间中。
> 
> 系统调用的实现（例如，sysproc.c 和 sysfile.c）仅仅是封装而已：他们用 `argint`，`argptr` 和
> `argstr` 来解析参数，然后调用真正的实现。在第一章，`sys_exec` 利用这些函数来获取参数。