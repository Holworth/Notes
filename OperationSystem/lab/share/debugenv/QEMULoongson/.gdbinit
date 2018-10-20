# Author: Huaqiang Wang
# Last Mod: 2018.10.18
# .gdbinit for OS lab of UCAS 

# 保存历史命令
set history filename ~/.gdb_history
set history save on

# 按照派生类型打印对象
set print object on

# 打印数组的索引下标
set print array-indexes on

# 每行打印一个结构体成员
set print pretty on

# 显示源码/汇编/寄存器值
# layout src
 layout asm
 layout regs
# layout split

# 连接QEMU
set arch mips
target remote localhost:50010

# 调试准备
# b *main
b *0xa0800000
display /i $pc
symbol-file main

# 手动从头开始
# set $pc=0xa0800000

# 附注
# 可以用“disas /m fun”（disas是disassemble命令缩写）命令将函数代码和汇编指令映射起来
# 使用 focus asm/... 来切换焦点