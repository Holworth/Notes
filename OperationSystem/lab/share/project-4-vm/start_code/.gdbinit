# Author: Huaqiang Wang
# Last Mod: 2018.10.20
# .gdbinit for OS lab of UCAS 

# 关闭命令确认
set confirm off

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
display /i $pc
symbol-file main

# 等待连接
#b *0xa0800200
# TODO: 在这里设置断点:
#b sleep_task
#b *0x80000180
#b scheduler
#b *0xa0800200
#b TLB_set_global
#b test_shell
#b deamon_vm
#b handle_int
#b do_TLB_Refill
#b *0x80000000
#b cmd_set
#b cmd_dump
#b *0xa080a59c
#b fake_scene
#b set_CP0_ENTRYHI_with_cpid
#b scheduler
#b mutex_lock_init
#b enable_interrupt
#b do_L2_swap
b set_breakpoint
#b sdwrite
#b *0x80085690
#b clock_findnext
b do_swap
#b *0x80079cd8
#b read_asm  
#b *0x800856a8
c

# 附注
# 可以用“disas /m fun”（disas是disassemble命令缩写）命令将函数代码和汇编指令映射起来
# 使用 focus asm/... 来切换焦点