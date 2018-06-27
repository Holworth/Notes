#include<stdio.h>
#include<stddef.h>

char buffer[200];

int built_in_asm(unsigned int fd, char* buffer, size_t count, int* tgtp)
{
    __asm__(
        "mov 0,%%rax;\n"
        "mov fd,%%rdi;\n"
        "mov buffer,%%rsi;\n"
        "mov count,%%rdx;\n"
        "syscall\n"
        :
        "a+" (count)
        :
        "r" (fd),"r" (buffer),"r"(tgtp)
        :
        "rdx", "rsi", "rdi"
    );

    return atoi(buffer);
}

asm(
    "pure_asm:"
    "mov 0,%rax;\n"
    "mov 16(rsp), %rdi;\n"
    "mov 24(rsp), %rsi;\n"
    "mov 32(rsp), %rdx;\n"
    "syscall;\n"



    )


int main()
{

}