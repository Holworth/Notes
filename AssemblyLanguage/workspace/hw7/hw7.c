#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>

char buffer[200];

//fd=0;

int built_in_asm(unsigned int fd, char *buffer, size_t count)
{
    __asm__(
        "mov $0,%%rax\n"
        "mov fd,%%rdi\n"
        "mov buffer,%%rsi\n"
        "mov count,%%rdx\n"
        "syscall\n"
        "mov buffer,%%rbx\n"
        "mov buffer,%%rsi\n"

        "lea (%%rsi,%%rax),%%rdi\n"
        "mov (%%rbx),%%rcx\n"

        "sign:\n"
        "cmp %%rcx,'+'\n"
        "jne 1b\n"
        "inc %%rbx\n"
        "j   num\n"

        "1:\n"
        "cmp %%rcx,'-'\n"
        "jne num\n"
        //neg
        "inc %%rbx\n"

        "num:\n"
        //while %rax<%rdx
        //getchar()
        "cmp %%rdi,%%rbx\n"
        "jae end\n"
        "mov (%%rbx),%%rcx\n"
        //cmp 0-9
        "cmp $'0',%%rcx\n"
        "jb end\n"
        "cmp $'9',%%rcx\n"
        "ja end\n"
        //is 0-9
        "inc %%rbx\n"
        "j num\n"

        "end:\n"
        "mov $0,(%%rbx)\n"
        "mov %%rsi,%%rax\n"
        : "+a"(count)
        : "r"(fd), "r"(buffer)
        : "rdx", "rsi", "rdi");

    return atoi(buffer);
}

asm(
    "pure_asm:\n"
    "#using linux x64 abi\n"
    "push %rbx \n"
    "#前6个参数通过寄存器传递(rdi, rsi, rdx, rcx ,r8, r9)\n"
    "mov $0,%rax\n"
    "#mov 16(rsp), %rdi\n #fd\n"
    "#mov 24(rsp), %rsi\n #buffer\n"
    "#mov 32(rsp), %rdx\n #count\n"
    "syscall\n"
    "#set %rdi to %rax\n"
    "lea (%rsi,%rax),%rdi\n"
    "#%rdi is the loop end\n"
    "#%rax,%rdi as accumulater\n"
    "mov $0,%rax\n"
    "mov $0,%rdx\n"
    "#%rdi as counter\n"
    "#%rbx as sign\n"
    "#%rcx as char reached\n"
    "#getchar\n"
    "mov (%rsi),% rcx\n"
    "sign:\n"
    "mov $(1),%rbx\n"
    "cmp %rcx,'+'\n"
    "jne 1b\n"
    "inc rsi\n"
    "j   num\n"
    "1:\n"
    "cmp %rcx,'-'\n"
    "jne num\n"
    "#neg\n"
    "mov $(-1),%rbx\n"
    "inc %rsi\n"
    "num:\n"
    "#while %rax<%rdx\n"
    "#getchar()\n"
    "cmp %rdi,%rsi\n"
    "jae end \n"
    "mov (%rsi),% rcx\n"
    "#cmp 0-9\n"
    "cmp $'0',%rcx\n"
    "jb end\n"
    "cmp $'9',%rcx\n"
    "ja end\n"
    "#is 0-9\n"
    "mul $10\n"
    "add %rcx,%rax\n"
    "sub $'0',%rax\n"
    "inc %rsi\n"
    "j num\n"
    "end:\n"
    "#result is in %rax\n"
    "mul %rbx\n"
    "pop %rbx\n");

int main()
{
    printf("%d\n", built_in_asm(0, buffer, 10));
    printf("%d\n", pure_asm(0, buffer, 10));
}