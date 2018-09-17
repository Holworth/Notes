# 操作系统 作业2

* 王华强
* 2016K8009929035

***

## 作业指导
 
Linux 下常见的3种系统调用方法包括有：
1. 通过glibc提供的库函数
2. 使用syscall函数直接调用相应的系统调用
3. 通过 int 80指令陷入（32bit）或者通过syscall指令陷入（64bit）

请研究Linux(kernel>=2.6.24) gettimeofday这一系统调用的用法，并且选择上述3种系统调用方法中的2种来执行，记录其运行时间。

提示：请思考一次系统调用的时间开销的量级，对比结果，并尝试解释其中原因。

提交内容： 程序、执行结果、结果分析、系统环境（uname -a) ，本人学号。

## 实验背景: Linux系统调用

ref: https://www.cnblogs.com/yiyide266/p/5538079.html

库函数
汇编
syscall

它在<内核源码目录>/kernel/entry.S，Entry(system_call)的下一行。