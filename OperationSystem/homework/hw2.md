# 操作系统 作业2

* 王华强
* 2016K8009929035

***

## 作业指导
 
Linux 下常见的3种系统调用方法包括有：
1. 通过glibc提供的库函数
2. 使用syscall函数直接调用相应的系统调用
3. 通过 int 80指令陷入（32bit）或者通过syscall指令陷入（64bit）

请研究Linux(kernel>=2.6.24) gettimeofday这一系统调用的用法，并且选择上述3种系统调用方法中的2种来执行，记录其运行时间。

提示：请思考一次系统调用的时间开销的量级，对比结果，并尝试解释其中原因。

提交内容： 程序、执行结果、结果分析、系统环境（uname -a) ，本人学号。

## 实验背景: Linux系统调用

ref: https://www.cnblogs.com/yiyide266/p/5538079.html

库函数
汇编
syscall

它在<内核源码目录>/kernel/entry.S，Entry(system_call)的下一行。

```
cat `locate unistd_64` > log.log
```

```
    eval 'sub __NR_gettimeofday () {96;}' unless defined(&__NR_gettimeofday);
```

http://man7.org/linux/man-pages/man2/gettimeofday.2.html


Linux AW-OMEN 4.4.0-17713-Microsoft #1000-Microsoft Fri Jul 06 15:51:00 PST 2018 x86_64 x86_64 x86_64 GNU/Linux

```
time_start:15625
time_end:2328125
time_macro:1171875
time_glibc:1140625
time_asm:0
```


Linux cod-VirtualBox 4.15.0-25-generic #27~16.04.1-Ubuntu SMP Mon Jul 2 17:05:41 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux


```
time_start:1356
time_end:436897
time_macro:395468
time_glibc:39869
time_asm:203

```

```
#include <bits/stdc++.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

struct timeval tvs;
struct timeval *tv = &tvs;
struct timezone tzs;
struct timezone *tz = &tzs;

static __inline__ void asm_gettime(struct timeval *tv)
{
    __asm__(
        "mov %%rax,96\n\t"
        "mov %%rdi,%0\n\t"
        "mov %%rsi,0\n\t"
        "syscall \n\t"
        : "=m"(tv)
    );
}

    // __asm__("\
    //     mov %rax,96\n\t\
    //     mov %rdi,0\n\t\
    //     mov %rsi,0\n\t\
    //     syscall \n\t\
    // ");

int main()
{
    long int time_start = clock();
    for (int i = 1000000; i-- > 0;)
        syscall(SYS_gettimeofday, &tvs, 0);
    long int time1 = clock();
    for (int i = 1000000; i-- > 0;)
        gettimeofday(tv, 0);
    long int time2 = clock();
    for (int i = 100000; i-- > 0;);
        // asm_gettime(tv);
    long int time3 = clock();

    //SYS_gettimeofday(tv, tz);
    long int time_end = clock();

    printf("time_start:%ld\n", time_start);
    printf("time_end:%ld\n", time_end);
    printf("time_macro:%ld\n", time1-time_start);
    printf("time_glibc:%ld\n", time2-time1);
    printf("time_asm:%ld\n", time3-time2);

    return 0;
}
```