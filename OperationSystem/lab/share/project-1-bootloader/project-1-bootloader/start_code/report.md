#### 操作系统研讨课实验报告

# Project1-Bootloader

* 王华强
* 2016K8009929035

---

## 实验简述

### Stage1 调用BIOS函数

```
	la  $a0, msg
	jal 0x8007b980
```

遵循MIPsO32函数调用规则, 调用函数分成两个部分: 准备参数, 用`jal`指令跳转到地址.

--

### Stage2 

在bootblock.s中进行函数调用, 将kernel读取到内存中.

```
	li  $a0, 0xa0800200
	li  $a1, 0x00000200
	li  $a2, 0x00000200
	jal 0x8007b1cc
```

--

在kernel中利用强制类型转换, 使用函数地址直接调用函数, 完成字符串的打印.

```c
	char hello_os[]="Hello OS!\n";
	void (*call_printstr)(char* string) = bios_printstr;
	call_printstr(hello_os);
	return;
```

--

### Stage2 附加题

#### Idea1

注: 这里的想法在实际测试中存在问题. 这里BIOS函数似乎无法正确完成kernel的复制.

在使用BIOS函数将kernel移动到内存中之后, 函数将会返回`$ra`寄存器中的地址. 这里我们在调用函数之前修改`$ra`寄存器的值到`0`, 这样在复制函数返回之后就会自动从kernel的开头开始执行. 

修改`$ra`也会引起一个问题, 在kernel返回的时候返回地址是`0`, 可能引发问题. 为了解决这个问题可以考虑在kernel中嵌入汇编. 比如, 将kernel的第一条指令写成`li $ra, 0x000xxxxxx(返回地址))`

经过进一步测试, 发现这种写法只有在kernel采用特定写法的情况下才能够正常工作. 具体正常工作的条件未知.

#### Idea2

在kernel之前人为添加汇编代码, 汇编代码的作用是将汇编代码之后的kernel块移动到0xa0800000处. 在将kernel移到内存之后执行这些汇编指令, 来将kernel移动到对应位置. 注意移动kernel不能覆盖这些汇编代码, 因此可以将这些代码先复制到内存中稍靠后的位置.

Idea2 实现起来比较复杂, 提交时采用第一种写法.

#### 解决问题

在第一周的实验总结中提示了kernel代码基地址设置的问题. 为此, 修改Makefile文件将kernel的基地址设置为`0x0a000000`. TODO 在解决问题之后

--

### Stage3

简述Stage3中crateimage的行为如下:

```
读取kernel;
读取bootloader;
//两者都为可执行文件
通过Elf头找出两者的`program header`, 并且确认kernel的大小;
通过`program header`找到实际可执行代码地址;
复制实际可执行代码到image中, 其中bootloader在文件开头, 而kernel在第0扇区之后;
return;

```

Createimage的行为在P1反馈汇总.pdf中亦有描述.

---

## 代码实现

请参见实际代码.

---

## 细节讨论与实验心得

### Stage1 常见错误

这样的写法会导致跳转到储存printstr的数据段.

```
	la  $a0, msg
	jal printstr
```

--

### Stage2 设计问题

定义字符串字面量"Hello OS"的位置(全局变量/在main中定义)是否会对结果产生影响.

---

## 思考题解答

* Where do you place your bootblock
* How to move kernel from disk to memory
* Where do you place your kernel in the memory
* Where is your kernel entry point
* How to create disk image

这些问题在汇报时已经解答.

---

## 补充: 关于连接器脚本

研究思路: 加连接器脚本/不加连接器脚本编译, 之后比较objdump结果.

2018.9.25更新: 在P1反馈汇总中已经详细解释了连接器脚本的作用, 因此不再展开.