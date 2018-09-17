# CPU设计日志

* Huaqiang Wang (c) 2018

***

## 流水线结构设计 9.15

ref: 计算机组成与设计-硬件软件接口

单个ALU, 多个加法器.

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
//???TODO

分支预测逻辑接口: 引入"这是预测指令"标记?

### 流水线控制设计

取址: +4结果写入PC, 写入流水线寄存器

取址/译码: 控制逻辑固定
EX: ALU_op, ALU_src, REG_dst
MEM: MEM_read, MEM_write, branch, branch_cond
WB: MEM_or_ALU_to_REG, REG_write

跳转发生在MEM? 用EX/MEM的branch, branch_cond, test_result组合逻辑生成PC_src?
PC_src ???TODO

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

TODO: 计算机组成与设计-硬件软件接口 P205

***

## 流水线结构设计 9.17

之前的设计考虑了寄存器冲突, 没有考虑访存冲突.

访存冲突可能发生的条件:

* sw(MEM) lw(EX)
* sw(WB) lw(MEM)

因此不会有访存冲突.