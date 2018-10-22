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