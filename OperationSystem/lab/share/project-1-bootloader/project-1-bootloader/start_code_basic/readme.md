# Project1-Bootloader

## Seminars of Operating System

* 王华强
* 2016K8009929035

---

## 实验简述

实验要求: 调用BIOS函数完成bootblock, 打印字符串并般移kernel. 编写kernel调用BIOS函数打印字符串. 编写creatimage来生成启动镜像.

Bootblock是写在磁盘头部的一段特殊程序, BIOS在完成启动自检等等流程之后会将PC跳转到Bootblock处. 其主要作用是将操作系统内核从外存搬运到内存之中, 之后将控制权移交给操作系统(跳转到操作系统内核之中).

<!-- Bootblock主要完成的功能 -->

Createimage是镜像生成程序, 它的作用是从ELF文件中取出实际的可执行汇编代码, 并按照位置要求生成反映实际外存内容的文件: 磁盘镜像.

## 目录结构

* bootblock.s
* createimage.c
* kernel.c
* bootblock
* createimage
* createimage_old
* kernel
* report.md
* Makefile
* ld.script