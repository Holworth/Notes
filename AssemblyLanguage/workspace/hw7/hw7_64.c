// 设计一个x86-linux-abi的子函数readint：
// 利用读文件系统调用（sys_read)从终端读入一个十进制整数，除前导的‘+’和‘-’字符外，非数字字符为结束符。
// 例：-123=-123， +123=123， -123c=-123，0123=123
// 实现纯汇编的子函数和嵌入式汇编的C函数，C函数的实现可以调用atoi之类的库函数。

// C语言主函数如下：
// #include <stdio.h>
// int readint(void);
// int main(void)
// {
//   int num;
//   num = readint();
//   printf("Read num = %d\n", num);
//   return 0;
// }

// 读文件系统调用（sys_read）的定义如下：
// 32位：    int $0x80
//         系统调用号：3 （%eax）
//         参数1-文件描述符：1 （%ebx）
//         参数2-输入缓冲区地址：char *buffer (%ecx)
//         参数3-输入字节数：size_t count (%edx)
//         返回值-实际输入字节数：size_t count (%eax)
// 64位： syscall
//         系统调用号：0 （%rax）
//         参数1-文件描述符：1 （%rdi）
//         参数2-输入缓冲区地址：char *buffer (%rsi)
//         参数3-输入字节数：size_t count (%rdx)
//         返回值-实际输入字节数：size_t count (%rax)
#include<stdio.h>
#include<stdlib.h>

char buffer[512];

// 纯汇编实现:

// linux-32-abi:

//in c part
__asm__(
    "readint:\n"
    "#保存三个寄存器，首个参数地址16(%esp)\n"
    // "push %ebx\n"
    // "push %esi\n"
    // "push %edi\n"
    "#rax as result\n"
    "#rdx as result2\n"
    "mov $0,%rax\n"
    "mov $1,%rdi\n"
    "mov $buffer,%rsi\n"
    "mov $16,%rdx\n"
    "syscall\n"
    // "int $0x80\n"
    "mov $buffer,%rcx\n"
    "#buffer* is in ecx\n"
    "mov %rax, %rbx\n"
    "mov $0,%rax\n"
    "mov $0,%rdx\n"
    "#%rbx as str length\n"
    "#%rsi as sign\n"
    "mov $1,%rsi\n"
    "setend:\n"
    "lea (%rcx,%rbx),%rdi\n"
    "#%rdi as end position\n"
    "sign:\n"
    "movb (%rcx), %dl\n"
    "cmp $'+',%dl\n"
    "je positive\n"
    "cmp $'-',%dl\n"
    "je negative\n"
    "positive:\n"
    "mov $1,%rsi\n"
    "inc %rcx\n"
    "jmp numstart\n"
    "negative:\n"
    "mov $(-1),%rsi\n"
    "inc %rcx\n"
    "jmp numstart\n"
    "numstart:\n"
    "endtest:\n"
    "cmp %rcx,%rdi\n"
    "je end\n"
    "debug1:\n"
    "mov $0,%rdx\n"
    "movb (%rcx), %dl\n"
    "cmp $'0',%dl\n"
    "jb end\n"
    "cmp $'9',%dl\n"
    "ja end\n"
    "#not end yet\n"
    "accumulate:\n"
    "push %rdx\n"
    "mov $0,%rdx\n"
    "inc %rcx\n"
    "push %rcx\n"
    "mov $10,%rcx\n"
    "imul %rcx\n"
    "pop %rcx\n"
    "pop %rdx\n"
    "#%rax*=10\n"
    "add %rdx,%rax\n"
    "sub $'0',%rax\n"
    "jmp numstart\n"
    "end:\n"
    "imul %rsi\n"
    "ret\n"
    // "pop %edi\n"
    // "pop %esi\n"
    // "pop %ebx\n"
);

int readint2(char* the_buffer)
{ 
    __asm__(
        "mov $0,%%rax\n"
        "mov $1,%%rdi\n"
        "mov %0,%%rsi\n"
        "mov $16,%%rdx\n"
        "syscall\n"::"r" (the_buffer)
        :"rax","rdx","rdi","rsi"
    );
    return atoi(the_buffer);
}


int main()
{
    printf("%d\n", readint());
    printf("%d\n", readint2(buffer));
}