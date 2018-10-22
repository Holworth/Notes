---
title: OS Homework5
---


# 操作系统 作业5

* 王华强
* 2016K8009929035

***

## 同步作业1：

写一个两线程程序,两线程同时向一个数组分别写入1000万以内的奇数和偶数，过程中共用一个偏移量。写完后打印出数组相邻两个数的最大绝对差值*。

```c
int MAX=10000000;
index = 0

//thread1
       for(i=0;i<MAX;i+=2) {
        data[index] = i; //even ( i+1 for thread 2)
        index++;
}

//thread2
       for(i=0;i<MAX;i+=2) {
        data[index] = i+1; //odd
        index++;
}
```

请分别按下列方法完成一个不会丢失数据的程序：

1. 请用Peterson算法实现上述功能。
1. 学习了解 pthread_mutex_lock/unlock()函数的功能，并实现上述程序功能。
1. 学习了解 atomic_add()(  _sync_fetch_and_add（）for gcc 4.1+) 函数，实现上述程序功能。

作业要求：

1. 要求方法1和方法2 每次进入临界区之后，执行一百次操作后离开临界区。
2. 请找一个双核系统测试，分别列出三种方式的执行时间。

## 三种方法的实现

### Peterson算法

```c
#define PETERSON_START(id)                   \
    {                                        \
        flag[id] = 1;                        \
        turn = id;                           \
        while ((turn == id) && flag[1 - id]) \
            ;

// Critical Section

#define PETERSON_END(id) \
    flag[id] = 0;        \
    }

```

### 其他实现参见源码


## 测试结果

方法一:
```
cod@cod-VirtualBox:~$ ./p
max_sub=5697
(time2 - time1)=370146
cod@cod-VirtualBox:~$ ./p
max_sub=3097
(time2 - time1)=300381
cod@cod-VirtualBox:~$ ./p
max_sub=4797
(time2 - time1)=405531
```

方法二:

```
cod@cod-VirtualBox:~$ ./m
max_sub=664999
(time2 - time1)=159914
cod@cod-VirtualBox:~$ ./m
max_sub=2597897
(time2 - time1)=141086
cod@cod-VirtualBox:~$ ./m
max_sub=768097
(time2 - time1)=129780
```

方法三:

```
cod@cod-VirtualBox:~$ ./g
max_sub=1582387
(time2 - time1)=547407
cod@cod-VirtualBox:~$ ./g
max_sub=800557
(time2 - time1)=620196
cod@cod-VirtualBox:~$ ./g
max_sub=528105
(time2 - time1)=506671
```

作业上没有要求分析, 就不详细分析了...

## 解答源码

### PETERSON

```c
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <stdlib.h>
#include <errno.h>

#define show(x) printf("" #x "=%ld\n", x)
#define RUN_TIME 10
#define MAX 10000000

int flag[2];
int turn;

int mindex;
int data[MAX];

#define PETERSON_START(id)                   \
    {                                        \
        flag[id] = 1;                        \
        turn = id;                           \
        while ((turn == id) && flag[1 - id]) \
            ;

// Critical Section

#define PETERSON_END(id) \
    flag[id] = 0;        \
    }

void *thread_function(void *arg)
{
    int cnt = 0;
    for (int i = 0; i < MAX;)
    {
        PETERSON_START(1)
        while (cnt++ < 100)
        {
            data[mindex] = i; //even ( i+1 for thread 2)
            mindex++;
            cnt++;
            i += 2;
        }
        cnt=0;
        PETERSON_END(1)
    }
    return NULL;
}
void *thread_function2(void *arg)
{
    int cnt = 0;
    for (int i = 0; i < MAX;)
    {
        PETERSON_START(0)
        while (cnt++ < 100)
        {
            data[mindex] = i+1; //even ( i+1 for thread 2)
            mindex++;
            cnt++;
            i += 2;
        }
        cnt=0;
        PETERSON_END(0)
    }
    return NULL;
}

int main(void)
{

    show((long)RUN_TIME);
    long int time1 = clock();
    pthread_mutex_t mymutex = PTHREAD_MUTEX_INITIALIZER;
    pthread_t mythread;
    pthread_t mythread2;

    int k = RUN_TIME;

    if (pthread_create(&mythread, NULL, thread_function, NULL))
    {
        printf("error creating thread.");
        abort();
    }
    if (pthread_create(&mythread2, NULL, thread_function2, NULL))
    {
        printf("error creating thread.");
        abort();
    }

    if (pthread_join(mythread, NULL))
    {
        printf("error joining thread.");
        abort();
    }
    if (pthread_join(mythread2, NULL))
    {
        printf("error joining thread.");
        abort();
    }
    // show((sum1 + sum2));

    int max_sub = -1;
    for (int i = 1; i < MAX; i++)
    {
        int a = data[i] - data[i - 1];
        if (a < 0)
            a = -a;
        if (a > max_sub)
            max_sub = a;
    }
    long int time2 = clock();
    show(max_sub);
    show((time2 - time1));
    exit(0);
}
```

### MUTEX

```c
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <stdlib.h>
#include <errno.h>

#define show(x) printf("" #x "=%ld\n", x)
#define MAX 10000000

int mindex;
int data[MAX];

pthread_mutex_t mymutex=PTHREAD_MUTEX_INITIALIZER;

void *thread_function(void *arg)
{
    int cnt = 0;
    for (int i = 0; i < MAX;)
    {
        pthread_mutex_lock(&mymutex);
        while (cnt++ < 100)
        {
            data[mindex] = i; //even ( i+1 for thread 2)
            mindex++;
            cnt++;
            i += 2;
        }
        cnt=0;
        pthread_mutex_unlock(&mymutex);
    }
    return NULL;
}
void *thread_function2(void *arg)
{
    int cnt = 0;
    for (int i = 0; i < MAX;)
    {
        pthread_mutex_lock(&mymutex);
        while (cnt++ < 100)
        {
            data[mindex] = i+1; //even ( i+1 for thread 2)
            mindex++;
            cnt++;
            i += 2;
        }
        cnt=0;
        pthread_mutex_unlock(&mymutex);
    }
    return NULL;
}

int main(void)
{

    long int time1 = clock();
    pthread_t mythread;
    pthread_t mythread2;

    if (pthread_create(&mythread, NULL, thread_function, NULL))
    {
        printf("error creating thread.");
        abort();
    }
    if (pthread_create(&mythread2, NULL, thread_function2, NULL))
    {
        printf("error creating thread.");
        abort();
    }

    if (pthread_join(mythread, NULL))
    {
        printf("error joining thread.");
        abort();
    }
    if (pthread_join(mythread2, NULL))
    {
        printf("error joining thread.");
        abort();
    }
    // show((sum1 + sum2));

    int max_sub = -1;
    for (int i = 1; i < MAX; i++)
    {
        int a = data[i] - data[i - 1];
        if (a < 0)
            a = -a;
        if (a > max_sub)
            max_sub = a;
    }
    long int time2 = clock();
    show(max_sub);
    show((time2 - time1));
    exit(0);
}
```

### GNU_ATOMIC

```c

#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <stdlib.h>
#include <errno.h>

#define show(x) printf("" #x "=%ld\n", x)
#define MAX 10000000

int mindex;
int data[MAX];


void *thread_function(void *arg)
{
    for (int i = 0; i < MAX;)
    {
        data[__sync_fetch_and_add(&mindex,1)] = i; //even ( i+1 for thread 2)
        i += 2;
    }
    return NULL;
}
void *thread_function2(void *arg)
{
    for (int i = 0; i < MAX;)
    {
        data[__sync_fetch_and_add(&mindex,1)] = i+1; //even ( i+1 for thread 2)
        i += 2;
    }
    return NULL;
}

int main(void)
{

    long int time1 = clock();

    pthread_t mythread;
    pthread_t mythread2;

    if (pthread_create(&mythread, NULL, thread_function, NULL))
    {
        printf("error creating thread.");
        abort();
    }
    if (pthread_create(&mythread2, NULL, thread_function2, NULL))
    {
        printf("error creating thread.");
        abort();
    }

    if (pthread_join(mythread, NULL))
    {
        printf("error joining thread.");
        abort();
    }
    if (pthread_join(mythread2, NULL))
    {
        printf("error joining thread.");
        abort();
    }
    // show((sum1 + sum2));

    int max_sub = -1;
    for (int i = 1; i < MAX; i++)
    {
        int a = data[i] - data[i - 1];
        if (a < 0)
            a = -a;
        if (a > max_sub)
            max_sub = a;
    }
    long int time2 = clock();
    show(max_sub);
    show((time2 - time1));
    exit(0);
}

```

***

Huaqiang Wang (c) 2018
