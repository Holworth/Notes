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

// static __inline__ void asm_gettime(struct timeval *tv)
// {
//     __asm__(
//         "mov %%rax,96\n\t"
//         "mov %%rdi,%0\n\t"
//         "mov %%rsi,0\n\t"
//         "syscall \n\t"
//         : "=m"(tv)
//     );
// }

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
    long int time_start = clock();
    for (int i = 1000000; i-- > 0;)
        syscall(SYS_gettimeofday, &tvs, 0);
    long int time1 = clock();
    for (int i = 1000000; i-- > 0;)
        gettimeofday(tv, 0);
    long int time2 = clock();
    for (int i = 1000000; i-- > 0;)
    asm_gettime2();
    // asm_gettime(tv);
    long int time3 = clock();

    //SYS_gettimeofday(tv, tz);
    long int time_end = clock();

    printf("time_start:%ld\n", time_start);
    printf("time_end:%ld\n", time_end);
    printf("time_macro:%ld\n", time1 - time_start);
    printf("time_glibc:%ld\n", time2 - time1);
    printf("time_asm:%ld\n", time3 - time2);

    return 0;
}