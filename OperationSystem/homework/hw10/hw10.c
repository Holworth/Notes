// ----------------------------------------------------------------
//                          OS HW10
// ----------------------------------------------------------------
//              Copyright (C) 2018 Wang Huaqiang 
//           email : wanghuaqiang16@mails.ucas.ac.cn
// ----------------------------------------------------------------
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
// -----------------------------------------------------------------

// ## 2. 请在 Unix 环境下实现如下功能，提交程序和执行结果：

// > 1. 申请一个 uint32_t 类型 65536（64K）项的数组（4B * 64K = 256KB, 我们相信各位同学的笔记本使用的页大小为 4KB，而没有使用 linux 的大页机制）。
// > 2. 使用 mprotect 函数对申请的页设置只读。
// > 3. 连续将数组中随机的 100 项元素设置为 1-100。
// > 4. 注册 SIGSEGV 信号处理函数，在数据访问发生错误时，让程序继续执行，并且打印这 100 次访存的 trace。
// > 提示： siginfo_t 包含了地址信息

// ref: linux manpage

#include <ctype.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <setjmp.h>
#include <sys/mman.h>
// int mprotect(void *addr, size_t len, int prot);
// PROT_READ  
#define rep(a,b,c) for(int a=b;i<=c;a++)

// typedef void (*sighandler_t)(int);

uint32_t *array;
static jmp_buf exit_sig;

void msighandler(int signo, siginfo_t *info, void *context)
{
    // printf("SIGINT catched\n");
    printf("SIGINT: %p\n",(info->si_addr));
    siglongjmp(exit_sig,1);
}

// IMPORTANT //
// The following code does not work. In fact, I don't even know why it does not work.
// To pass the test, the sigaction struct must be set in main. 
struct sigaction sigact=
{
    // void     (*sa_handler)(int);
    NULL,
    // void     (*sa_sigaction)(int, siginfo_t *, void *);
    msighandler,
    // sigset_t   sa_mask;
    NULL,
    // int        sa_flags;
    SA_SIGINFO,
    // void     (*sa_restorer)(void);
    NULL
};

int main()
{
    int pagesize = sysconf(_SC_PAGE_SIZE);
    printf("pagesize: %d\n", pagesize);
    sigact.sa_flags=SA_SIGINFO;
    sigact.sa_sigaction=msighandler;
    posix_memalign((void**)&array, pagesize, 65536*sizeof(uint32_t));
    printf("array_addr: %llx\n", (unsigned long long)array);
    sigemptyset(&sigact.sa_mask);//???
    mprotect((void*)array, 65536*sizeof(uint32_t), PROT_READ);//read only
    int i=0;
    while(1)
    {
        sigsetjmp(exit_sig,1);
        if(i>=100)break;
        i++;
        sigaction(SIGSEGV,&sigact,NULL);
        int randvar=rand()%65536;
        printf("\n%d: write to %d\n",i,randvar);
        printf("ADDRESS should be: %p\n",&(array[randvar]));
        array[randvar]=i;
    }
    return 0;
}
