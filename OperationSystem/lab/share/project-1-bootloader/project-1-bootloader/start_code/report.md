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

注: 这里的想法在实际测试中存在问题. 这里BIOS函数似乎无法正确完成kernel的复制.

在使用BIOS函数将kernel移动到内存中之后, 函数将会返回`$ra`寄存器中的地址. 这里我们在调用函数之前修改`$ra`寄存器的值到`0`, 这样在复制函数返回之后就会自动从kernel的开头开始执行. 

修改`$ra`也会引起一个问题, 在kernel返回的时候返回地址是`0`, 可能引发问题. 为了解决这个问题可以考虑在kernel中嵌入汇编.

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

---

## 补充: 关于连接器脚本

研究思路: 加连接器脚本/不加连接器脚本编译, 之后比较objdump结果.