---
title: OS Homework7
---


# 操作系统 作业7

* 王华强
* 2016K8009929035

***

## 1. 设有两个优先级相同的进程P1，P2如下。令信号S1，S2的初值为0，已知z=2，试问P1，P2并发运行结束后x=？y=？z=？
 
进程P1               进程P2
y:=1;                    x:=1;
y:=y+2;                x:=x+1;
V(S1);                  P(S1);
z:=y+1;                 x:=x+y;
P(S2);                  V(S2);
y:=z+y;                z:=x+z;
 
执行流程(不唯一)如下:
```
P1: y:=1;
P1: y:=y+2;//y=3
P2: x:=1;
P2: x:=x+1;//x=2
P1: V(S1);//S1=1
P1: z:=y+1;//z=4
//----------------
P2: P(S1);//S1=0
P2: x:=x+y;//x=5
P2: V(S2);//S2=1
P1: P(S2);//S2=0
//-----------------
//顺序不定:
P1: y:=z+y; 
P2: z:=x+z;
```

可能的结果如下:
x=5, y=7, z=9
x=5, y=12, z=9

## 2.

2. 银行有n个柜员,每个顾客进入银行后先取一个号,并且等着叫号,当一个柜员空闲后,就叫下一个号.
请使用PV操作分别实现：
//顾客取号操作Customer_Service
//柜员服务操作Teller_Service

```
Service_Init()
{
    free_teller=n;
    free_customer=0;
    number=0;
    current_service_number=0;
}

Customer_Service()
{
    customer_number=number++;
    V(free_customer);
    P(free_teller);
    do_business;
    return;
}

Teller_Service()
{
    P(free_customer);
    customer_number=current_service_number++;
    do_business;
    V(free_teller);
    return;
}

main
{
    Service_Init();
    Thread1
    {
        while(1)Customer_Service();
    }

    Thread1
    {
        while(1)Teller_Service();
    }
}


```

## 3.

3. 多个线程的规约(Reduce)操作是把每个线程的结果按照某种运算（符合交换律和结合律）两两合并直到得到最终结果的过程。

试设计管程monitor实现一个8线程规约的过程，随机初始化16个整数，每个线程通过调用 monitor.getTask 获得2个数，相加后，返回一个数monitor.putResult ，然后再getTask（） 直到全部完成退出，最后打印归约过程和结果。
	要求：
 为了模拟不均衡性，每个加法操作要加上随机的时间扰动，变动区间1~10ms。
		 
提示： 使用pthread_系列的 cond_wait, cond_signal, mutex 实现管程
		使用rand（）函数产生随机数，和随机执行时间。
