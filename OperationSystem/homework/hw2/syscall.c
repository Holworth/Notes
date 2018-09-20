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

void asm_gettime2()
{
    __asm__(
        "push %rax\n\t"
        "push %rdi\n\t"
        "push %rsi\n\t"
        "mov $96,%rax\n\t"
        "mov tv,%rdi\n\t"
        "mov tz,%rsi\n\t"
        "syscall \n\t"
        "pop %rsi\n\t"
        "pop %rdi\n\t"
        "pop %rax\n\t");
}

// __asm__("\
    //     mov %rax,96\n\t\
    //     mov %rdi,0\n\t\
    //     mov %rsi,0\n\t\
    //     syscall \n\t\
    // ");

int main()
{
    syscall(SYS_gettimeofday, &tvs, 0);
    // gettimeofday(tv, 0);
    // asm_gettime2();
}