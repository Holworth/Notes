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