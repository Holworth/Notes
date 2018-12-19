#### 计算机体系结构

作业九
============

* 王华强
* 2016K8009929035

***

为以下语句定义标号:

```c
    t0:=100         (1)
loop:
    loop if t0!=0   (2)
    t0--            (3)
```

---

## 1. 五级多周期流水线


共计:

$$5 \times (1+200(不满足条件)+2(满足条件))=1015 $$

时空图:

```
(1)

(2)

(3)

(2)

(3)

(2)

(3)
```

---

## 2. 五级静态流水

$$ 5 + 5 \times 101(寄存器操作,跳转两条指令的组合) = 510 $$

时空图:

```
(1)

(2)

(3)

(2)

(3)

(2)

(3)
```

---

## 3. 五级静态流水, 执行结果到译码前递, 单发射, EX级跳转

$$ 5 + 101 \times 3 = 308 $$

时空图:

```
(1)

(2)

(3)

(2)

(3)

(2)

(3)
```

---

## 4. 五级静态流水, 执行结果到译码前递, 双发射, EX级跳转

TODO

时空图:

```
(1)

(2)

(3)

(2)

(3)

(2)

(3)
```
---

## 5. 单发射五级静态流水改进

因为无论跳转指令的结果为何, 分支延迟槽中的指令永远被正常执行(由编译器实现).

所以在译码级加入跳转地址计算逻辑, 直接在这一级计算出跳转地址. 这样在当前指令之后紧跟着就可以取出延迟槽指令, 避免了控制相关.

ADDR|IF|ID
-|-|-
跳转目标|延迟槽指令|跳转指令

---

## 6. 精确异常添加

图9.13

```










```

在译码级和执行级设置异常捕获逻辑.

在访存级设置CP0寄存器以及异常处理逻辑.

在异常处理逻辑捕获到异常时, 清空流水线中访存级之前的部分, 并重设PC.

---

## 7. 异步读转同步读

图9.13

```










```

在取址级发出PC信号, 在执行级发出内存地址.

在译码级直接译码传回的指令, 在访存级处理Load指令返回的数据.

这样可以不使用寄存器保存中间结果, 下一级直接使用sram中传回的数据即可.

---

## 8. 数据相关

数据相关分为:

1. RAW 后面指令要用到前面指令所写的数据
1. WAW 前后两条指令写同一个地址(出现在乱序执行中)
1. WAR 后面的指令覆盖前面的指令所读的单元

处理器|RAW|WAW|WAR
-|-|-|-
静态流水线|数据前递或阻塞|不存在|不存在
动态流水线|发射队列和ROB|前面的加上寄存器重命名|前面的加上寄存器重命名

---

## 9. 静态分支预测

$$ 5 + 101 \times 3 = 308 $$

时空图:

```
(1)

(2)

(3)

(2)

(3)

(2)

(3)
```

---
  
## 10. Cache性能分析

设Cache命中只需要一个时钟周期即可取回指令.

第一种方案:

$$CPI1 = 0.6 + 0.4 \times (0.85+0.15\times 100)=6.94$$

$$单位时间执行指令数 = 1/CPI1 = 0.144$$

第二种方案:

$$CPI2 = 0.6 + 0.4 \times (0.95+0.05\times 100)=2.98$$

$$单位时间执行指令数 = 0.9/CPI2 = 0.302$$

显然第二种方案更好.