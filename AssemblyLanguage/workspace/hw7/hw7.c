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
    "mov $3,%eax\n"
    "mov $1,%ebx\n"
    "mov buffer,%ecx\n"
    "mov $16,%edx\n"
    "int $0x80\n"
    "mov buffer,%ecx\n"
    "#buffer* is in ecx\n"
    "mov %eax, %ebx\n"
    "mov $0,%eax\n"
    "mov $0,%edx\n"
    "#%ebx as str length\n"
    "#%esi as sign\n"
    "mov $0,%esi\n"
    "setend:\n"
    "lea (%ecx,%ebx),%edi\n"
    "#%edi as end position\n"
    "sign:\n"
    "cmp $'+',(%ecx)\n"
    "je positive\n"
    "cmp $'-',(%ecx)\n"
    "je negative\n"
    "positive:\n"
    "mov $0,%esi\n"
    "dec %ebx\n"
    "jmp numstart\n"
    "negative:\n"
    "mov $1,%esi\n"
    "dec %ebx\n"
    "jmp numstart\n"
    "numstart:\n"
    "endtest:\n"
    "cmp %ecx,%edi\n"
    "je end\n"
    "cmp $'0',(%ecx)\n"
    "jb end\n"
    "cmp $'9',(%ecx)\n"
    "ja end\n"
    "#not end yet\n"
    "accumulate:\n"
    "inc %ecx\n"
    "push %rcx\n"
    "mov $10,%rcx\n"
    "imul %rcx\n"
    "pop %rcx\n"
    "#%eax*=10\n"
    "add (%ecx),%eax\n"
    "sub $'0',%eax\n"
    "jmp numstart\n"
    "end:\n"
    // "pop %edi\n"
    // "pop %esi\n"
    // "pop %ebx\n"
);

int readint2(char* the_buffer)
{ 
    __asm__(
        "mov $3,%%eax\n"
        "mov $1,%%ebx\n"
        "mov %0,%%ecx\n"
        "mov $16,%%edx\n"
        "int $0x80\n"::"r" (the_buffer)
        :"eax","ebx","ecx","edx"
    );
    return atoi(the_buffer);
}


int main()
{
    printf("%d\n", readint());
    printf("%d\n", readint2(buffer));
}