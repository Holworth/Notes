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
layout src
# layout asm
layout regs
# layout split

# 设置虚拟盘
shell dd if=/dev/zero of=disk bs=512 count=1M
# shell ./createimage –extended bootblock kernel
shell make all
dd if=image of=disk conv=notrunc

# 启动QEMU
shell sh run_pmon.sh

# 连接QEMU
set arch mips
target remote localhost:50010

# 调试准备
# b *main

# 附注
# 可以用“disas /m fun”（disas是disassemble命令缩写）命令将函数代码和汇编指令映射起来