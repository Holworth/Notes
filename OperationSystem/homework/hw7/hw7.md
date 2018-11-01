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
    free_teller=n;//空闲的柜员数
    free_customer=0;//等待服务的顾客数
    number=0;//给顾客编号用的全局变量
    current_service_number=0;//当前服务到的顾客号码
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


程序设计如下:

```c
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>
#include <sys/time.h>
#include <stdlib.h>
#include <errno.h>
#include <utility>
#include <vector>
#include <iostream>
// #include <ctime>

#define show(x) printf("" #x "=%ld\n", x)
using namespace std;

static pthread_mutex_t mutex=PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t cond=PTHREAD_COND_INITIALIZER;

class monitor
{
    public:
        vector<int> intlist;
        int counter;
        pair<int, int> get_task();
        int put_result(int i);
        int finish();
        int is_finished();
        int check_result();
        
        monitor()
        {
            srand((unsigned)time(NULL));
            for(int i=0;i<16;i++)
            {
                int t=rand();
                intlist.push_back(t);
                cout<<t<<" ";
            }
            cout<<endl;
            counter=16;
        }
}M;

pair<int, int> monitor::get_task()
{
    pthread_mutex_lock(&mutex);
    while(intlist.size()<2)
    {
        if(is_finished())
        {
            pthread_mutex_unlock(&mutex);
        }
        pthread_cond_wait(&cond, &mutex); 
    }
    int i,p;
    i=intlist.back();
    intlist.pop_back();
    p=intlist.back();
    intlist.pop_back();
    counter-=2;
    cout<<"Get "<<i<<" "<<p<<" from monitor.\n";
    pthread_mutex_unlock(&mutex);//解互斥锁
    return pair<int,int>(i,p);
}

int monitor::put_result(int i)
{
    pthread_mutex_lock(&mutex);
        cout<<"Add "<<i<<" to intlist in monitor.\n";
    intlist.push_back(i);
    counter++;
    if(intlist.size()>=2)
        pthread_cond_signal(&cond); 

    pthread_mutex_unlock(&mutex);//解互斥锁
    return 0;
}

int monitor::check_result()
{
    int sum=0;
    for(int i=0;i<16;i++)
    {
        sum+=intlist[i];
    }
    cout<<"The result should be "<<sum<<".\n";
    return 0;
}


int monitor::finish()
{
    cout<<"The result is "<<intlist[0]<<endl;
}

int monitor::is_finished()
{
    return counter==1;
}

       

int do_add(int a, int b)
{
    clock_t delay = CLOCKS_PER_SEC/1000*(rand()%990+10);
    clock_t start=clock();
    while((clock()-start)<delay);
    return a+b;
}


void *thread_function(void *arg)
{
    while(!M.is_finished())
    {
        auto p=M.get_task();
        auto s=do_add(p.first,p.second);
        M.put_result(s);
    }
    return NULL;
}

int main(void)
{
    M.check_result();
    long int time1 = clock();

    pthread_t mythread[8];

    // monitor M;
    for(int i=0;i<8;i++)
    {
        if (pthread_create(&mythread[i], NULL, thread_function, NULL))
        {
            printf("error creating thread.");
            abort();
        }

    }

    for(int i=0;i<8;i++){
        if (pthread_join(mythread[i], NULL))
        {
            printf("error joining thread.");
            abort();
        }
    }

    M.finish();

    long int time2 = clock();
    show((time2 - time1));
    exit(0);
}
```

正确的运行结果如下:

```c
20466 7150 19557 5677 7675 13071 6793 11107 12463 4145 7851 15018 25878 11403 31793 27806
The result should be 227853.
Get 27806 31793 from monitor.
Get 11403 25878 from monitor.
Get 15018 7851 from monitor.
Get 4145 12463 from monitor.
Get 11107 6793 from monitor.
Get 13071 7675 from monitor.
Get 5677 19557 from monitor.
Get 7150 20466 from monitor.
Add 37281 to intlist in monitor.
Add 59599 to intlist in monitor.
Get 59599 37281 from monitor.
Add 16608 to intlist in monitor.
Add 17900 to intlist in monitor.
Get 17900 16608 from monitor.
Add 22869 to intlist in monitor.
Add 20746 to intlist in monitor.
Get 20746 22869 from monitor.
Add 25234 to intlist in monitor.
Add 27616 to intlist in monitor.
Get 27616 25234 from monitor.
Add 96880 to intlist in monitor.
Add 34508 to intlist in monitor.
Get 34508 96880 from monitor.
Add 43615 to intlist in monitor.
Add 52850 to intlist in monitor.
Get 52850 43615 from monitor.
Add 131388 to intlist in monitor.
Add 96465 to intlist in monitor.
Get 96465 131388 from monitor.
Add 227853 to intlist in monitor.
The result is 227853
(time2 - time1)=1945
```

附: 错误的结果.

```c
19208 30549 23131 14645 1492 8608 20916 23996 12493 11855 32027 30828 22091 30827 7491 4545
Get Get Get 30549 Get 1920830827 from monitor.
 22091 from monitor.
Get 30828Get  454532027 from monitor.
2399611855 Get 124938608 from monitor.
Get 14645  7491 from monitor.
 1492 from monitor.
 20916 from monitor.
23131 from monitor.
Add Add 49757 to intlist in monitor.
Add 5291862855 to intlist in monitor.
 to intlist in monitor.
Get 52918 49757 from monitor.
Add 24348 to intlist in monitor.
Add Get 24348Add  1203662855 to intlist in monitor.
 from monitor.
10100 to intlist in monitor.
Get 10100 12036 from monitor.
Add 44912 to intlist in monitor.
Add 37776 to intlist in monitor.
Get 37776 44912 from monitor.
Add 102675 to intlist in monitor.
Add 87203 to intlist in monitor.
Get 87203 102675 from monitor.
Add 22136 to intlist in monitor.
Add 82688 to intlist in monitor.
Get 82688 22136 from monitor.
Add 189878 to intlist in monitor.
Add 104824 to intlist in monitor.
Get 104824 189878 from monitor.
Add 294702 to intlist in monitor.
The result is 294702
(time2 - time1)=1927
```