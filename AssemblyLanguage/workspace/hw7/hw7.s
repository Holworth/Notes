设计一个x86-linux-abi的子函数readint：
利用读文件系统调用（sys_read)从终端读入一个十进制整数，除前导的‘+’和‘-’字符外，非数字字符为结束符。
例：-123=-123， +123=123， -123c=-123，0123=123
实现纯汇编的子函数和嵌入式汇编的C函数，C函数的实现可以调用atoi之类的库函数。

C语言主函数如下：
#include <stdio.h>
int readint(void);
int main(void)
{
  int num;
  num = readint();
  printf("Read num = %d\n", num);
  return 0;
}

读文件系统调用（sys_read）的定义如下：
32位：    int $0x80
        系统调用号：3 （%eax）
        参数1-文件描述符：1 （%ebx）
        参数2-输入缓冲区地址：char *buffer (%ecx)
        参数3-输入字节数：size_t count (%edx)
        返回值-实际输入字节数：size_t count (%eax)
64位： syscall
        系统调用号：0 （%rax）
        参数1-文件描述符：1 （%rdi）
        参数2-输入缓冲区地址：char *buffer (%rsi)
        参数3-输入字节数：size_t count (%rdx)
        返回值-实际输入字节数：size_t count (%rax)

纯汇编实现:

linux-32-abi:

//in c part
char buffer[512];

readint:

#保存三个寄存器，首个参数地址16（%esp）
push %ebx
push %esi
push %edi
#rax as result
#rdx as result2

mov $3,%eax
mov $1,%ebx
mov buffer,%ecx
mov $16,%edx
int $0x80

mov buffer,%ecx
#buffer* is in ecx
mov %eax, %ebx
mov $0,%eax
mov $0,%edx
#%ebx as str length
#%esi as sign
mov $0,%esi

setend:
lea (%ecx,%ebx),%edi
#%edi as end position

sign:
cmp $'+',(%ecx)
je positive
cmp $'-',(%ecx)
je negative
positive:
mov $0,%esi
dec %ebx
jmp numstart
negative:
mov $1,%esi
dec %ebx
jmp numstart
numstart:
endtest:
cmp %ecx,%edi
je end
cmp $'0',(%ecx)
jb end
cmp $'9',(%ecx)
ja end
#not end yet
accumulate:
inc %ecx
imul $10
#%eax*=10
add (%ecx),%eax
sub $'0',%eax
jmp numstart
end:
pop %edi
pop %esi
pop %ebx

int readint2(char* thebuffer)
{ 
    __asm__(
        "mov $3,%%eax\n"
        "mov $1,%%ebx\n"
        "mov %0,%%ecx"
        "mov $16,%%edx\n"
        "int $0x80\n"::"r" (the_buffer)
        "eax","ebx","ecx","edx"
    );
    return atoi(the_buffer);
}
