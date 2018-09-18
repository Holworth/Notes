# CPU设计日志

* Huaqiang Wang (c) 2018

***

## 设计日程安排

1. DONE: ALU重写 9.16
1. DONE: REGfile重写 9.16
1. DONE: 流水线逻辑, 旁路逻辑设计 9.17
1. DONE: CPU架构图 书上已有, 改为原图上修改添加控制信号
1. TODO: 控制信号整理(excel) in-progress 9.18 之前多周期已经实现过的迁移完成
1. TODO: 基本架构代码实现 in-progress
1. TODO: 测试
1. TODO: 优化设计
***

## 流水线结构设计 9.15

ref: 计算机组成与设计-硬件软件接口

与多周期不同的是, 流水线需要引入单个ALU, 多个加法器.

利用执行级计算访存地址.

### 冒险问题: 

#### 结构冒险(没有)

#### 数据冒险(数据被使用:在解析出有wb指令之后增加寄存器锁:直到成功wb)
* 寄存器锁跟随流水线流动
* 前推/旁路设计(forwarding/bypassing)-->在ALU之后, 如果访问寄存器访问到寄存器锁的位置-->前提:不需要锁住
* load系指令: 必须锁定, 锁定到load成功为止-->**设计可前提/不可前提控制**
* 流水线阻塞/气泡 bubble / pipeline stall

* 寄存器访问部分修改: 访问: 与MEM,WB级寄存器锁比较, 判断可否前提

```verilog
//代码存在问题!
//ALU访存部分修改设计
assign 寄存器访问结果=mux{寄存器结果,bypassing_result};
//选择条件MEM_bypass_hit|WB_bypass_hit
assign 寄存器访问成功=
    MEM_no_bypass&MEM_bypass_hit|
    WB_no_bypass&WB_bypass_hit;
assign bypassing_result=
    32{MEM_bypass_hit}&MEM_bypass_value|
    32{WB_bypass_hit}&WB_bypass_value;
assign ALU_pipeline_valid=寄存器1访问成功&寄存器1=2访问成功; 
```

9.17修正: 这部分应该采用优先级编码器!
```verilog
控制信号RegWrite在流水级中
by_pass_hit=这一级RegWrite&(Write_Reg==Read_Reg_Now)
读出的数据= EX_MEM_by_pass_hit?...:
            MEM_WB_by_pass_hit?...:
            Reg_data;
```


### 控制冒险

跳转指令的处理: 单独比较逻辑, 在ALU级与ALU操作同步进行, **在ALU级结束进行跳转**?(比较快) 在MEM级跳转?

分支预测逻辑接口: 引入"这是预测指令"标记?

这里控制逻辑比较复杂, 留到以后设计.

### 流水线控制设计

* 取址: +4结果写入PC, 写入流水线寄存器.
* 取址/译码: 控制逻辑固定.

之后的三个流水级涉及不同的控制信号.

* EX: ALU_op, ALU_src, REG_dst
* MEM: MEM_read, MEM_write, branch, branch_cond
* WB: MEM_or_ALU_to_REG, REG_write

TODO: 跳转逻辑如何设计?

* 跳转发生在MEM? 
* 用EX/MEM的branch, branch_cond, test_result组合逻辑生成PC_src?


控制信号/阶段/指令表-->excel TODO

### 流水线寄存器统计

reg_name|IF_ID|ID_EX|EX_MEM|MEM_WB
-|-|-|-|-
PC|1|1|1|1
PC_plus4|1|1|0|0
instruction|1|1|1|1
ALU_control|0|1|0|0
MEM_control|0|1|1|0
WB_control|0|1|1|1
WB_address|0|1|1|1
A|0|1|1|0
B|0|1|1|0
A_B_sign_ext|0|1|0|0
ALU_out|0|0|1|0
MEM_out|0|0|0|1
rb,rt,rs|1|1|1|1


以及:

* control_EX
* control_MEM
* control_WB

(控制码在这三个部分有差别)

在ID阶段使用ALU_control译码获得ALU控制码.

DONE: 阅读到计算机组成与设计-硬件软件接口 P205

***

## 流水线结构设计 9.17

之前的设计考虑了寄存器冲突, 没有考虑访存冲突.

访存冲突可能发生的条件:

* sw(MEM) lw(EX)
* sw(WB) lw(MEM)

先写后读不会引起冲突

* lw(MEM) sw(EX)

先读(写寄存器)后写会引发冲突:旁路配置相同.

<!-- 因此不会有访存冲突. -->

### 处理器优化: LW和SW

ref: 计算机组成与设计_硬件软件接口P211

优化连续的LW与SW指令, 在存储器访问阶段加入旁路暂存来提高复制指令的速度.

~~这里的旁路直接添加到之前的旁路中即可. 因为LW指令在EX阶段不会更改寄存器中的内容. 特殊点是: 这个旁路最早发生在MEM/WB级.~~

分析结果: SW会引起大规模的流水线阻塞. 一旦检测到LW写寄存器, 在MEM级之前都无法得到可用的数据, 需要在流水线中添加气泡. 在MEM级读取出数据的同时, 可以影响到之前SW的EX级, 和R指令的EX级. SW指令可以简单地加入旁路来解决. R指令的ALU结果则必须重做. 由此, 在LW和ALU指令之间必然存在一级气泡. 先在LW, SW之间插入一级气泡, 之后再考虑能否消去气泡. 这样, 旁路控制还需要引入新的`旁路值_vaild`控制寄存器.

设计思路:

```verilog
//流水线中旁路寄存器: 
reg XX_YY_bypass_valid;
//对于R类型指令(REG_write&&(!MEM_write)&&((!MEM_read))), vaild在EX_MEM级开始置1; 否则在MEM_WB级开始置1;
reg [31:0]XX_YY_bypass_addr;

//流水线控制逻辑:
//ID/EX访问寄存器时的旁路
assign EX_MEM_bypass_hit=(REG_read_addr!=EX_MEM_bypass_addr)&&(EX_MEM_bypass_addr!=0);
assign MEM_WB_bypass_hit=(REG_read_addr!=MEM_WB_bypass_addr)&&(MEM_WB_bypass_addr!=0);

//assign ID_EX_bypass_replace=(EX_MEM_bypass_hit&EX_MEM_bypass_valid)|((MEM_WB_bypass_hit&MEM_WB_bypass_valid)); 
assign ID_EX_bubble_reg1=(EX_MEM_bypass_hit_reg1&(!EX_MEM_bypass_valid_reg1))
                        |(MEM_WB_bypass_hit_reg1&(!_MEM_WB_bypass_valid_reg1));
assign ID_EX_bubble_reg2=(EX_MEM_bypass_hit_reg2&(!EX_MEM_bypass_valid_reg2))
                        |(MEM_WB_bypass_hit_reg2&(!_MEM_WB_bypass_valid_reg2));
assign ID_EX_bubble=ID_EX_bubble_reg1|ID_EX_bubble_reg2;
assign real_data_reg1=(EX_MEM_bypass_hit_reg1?EX_MEM_bypass_data:
                      (MEM_WB_bypass_hit_reg1?MEM_WB_bypass_data:
                       A_reg));//A是从寄存器堆中读出的数据;
assign real_data_reg2=(EX_MEM_bypass_hit_reg2?EX_MEM_bypass_data:
                      (MEM_WB_bypass_hit_reg2?MEM_WB_bypass_data:
                       B_reg));//B是从寄存器堆中读出的数据;

//旁路数据连线
assign EX_MEM_bypass_data=EX_result_reg;
assign MEM_WB_bypass_data=MEM_result_reg;

```

但是对于连续的LW, SW两条指令, 还可以进行优化.

考虑以下指令:

```
LW $a0, 0x233
SW $a0, 0x233
SW $a0, 0x233
```

指令的时空关系如下:

指令|ID|EX|MEM|WB
-|-|-|-|-
LW|||真实的数据在MEM_result_reg中|
SW||过期数据在EX_result_reg中||
SW|过期数据在X_reg中|||

因此, 在EX级可以直接放行SW指令, 在EX, MEM级分别检查当前指令是否为SW指令, SW的操作源是否与MEM级的结果相关. 如果相关, 则触发旁路, 用旁路中的数据来代替正常流水中的数据.

**注意: 目前尚没有分析这种加速方法与其他各种访存指令的兼容性, 比如lwr, lwl, swr, swl等.**

TODO: 这里连续LW, SW加速的实现比较复杂, 等到CPU指令添加完成之后再进行实现.

### 对于LUI系列立即数指令的影响

首个MUX选择REG结果/立即数, bypass只影响REG结果.
为了防止立即数指令时被白白阻塞, 建议添加IMM_ins控制寄存器或在译码时将IMM指令的访存地址设成0; 准备采用后面一种实现方式.

### 冒险检测单元

TODO: 设置在ID级还是EX级? 是否需要在ID级就暂停流水线?

暂定使用之前的在EX级暂停流水线的方案.

如果要在ID级暂停流水线, 需要在ID级引入前后两条指令比较逻辑:

```
//读取ID/EX控制寄存器, 结合当前指令给出控制
LW->SW: 继续
LW+指令相关: bubble
```

### 插入气泡的结构设计

* 将后面3级的所有控制信号置0;
* 如果在EX级处理, 需要在EX级改变控制信号.
* 如果在ID级处理, 控制逻辑相对比较集中.

***

## 控制冒险的解决

### 采用控制指令在MEM级决定是否发生跳转/执行分支的方式

ref: 计算机组成与设计-硬件软件接口 P233

我们先按教科书上常见的写法, 在MEM级跳转进行设计.

采用假定分支不发生的解决办法. 分支在MEM级触发跳转的话, 之后多读取了3条指令. 考虑分支延迟槽的一条指令(假设全为nop), 我们可以在EX/MEM设置计数器, 清除之后3条指令的控制信号, 遮阳它们不会对寄存器和内存产生任何影响.

### 提前跳转判断的尝试

为了加速跳转的发生, 可以尝试在MEM级之前进行跳转判断. 但是与多周期处理器可以直接提前比较不同, 流水线处理器需要引入新的数据旁路.

但是这个数据旁路相对比较简单. 只要注意数据无效时应该在这里(ID或EX)插入气泡即可.

将分支控制提前到ID级可以正好只剩下一条多取的指令, 恰好为分支延迟槽中的指令. 如果分支预测错误且不引入分支延迟槽, 只需要将IF/ID的结果置为nop即可.

分支预测机制在初步设计阶段不做展开.

处理器结构初步设计到此结束, 异常处理将在后面考虑.

***

## 处理器设计表

参见`PL.xlsx`. 其中不同子表的内容为:

* PIPELINE DESIGN 流水线主体设计
* CONTROL 译码逻辑设计
* ALU CONTROL ALU译码逻辑设计

TODO: 还是没有决定到底是使用ID+bubble还是EX+bubble

## 控制逻辑设计 9.18

TODO:

add
addi
sub
div
divu
mult
multu
lui
bgtz
bgezal
bltzal
mfhi
mflo
mthi
mtlo

eret
mfc0
mtc0
break
syscall
