#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <stdlib.h>
#include <errno.h>

#define show(x) printf("" #x "=%ld\n", x)
#define RUN_TIME 10
#define UPPERBOUND 10000000

long sum1;
long sum2;
int array[UPPERBOUND];

void *thread_function(void *arg)
{
    int i;
    for (i = 0; i < UPPERBOUND; i += 2)
    {
        sum2 += array[i];
    }
    return NULL;
}
void *thread_function2(void *arg)
{
    int i;
    for (i = 1; i < UPPERBOUND; i += 2)
    {
        sum1 += array[i];
    }
    return NULL;
}

int main(void)
{

    show((long)RUN_TIME);
    long int time1 = clock();

    pthread_t mythread;

    int k = RUN_TIME;
    int l;
    for(l=0;l<10000000;l++)
    {
        array[l]=l;
    }
    while (k-- > 0)
    {   
        if (pthread_create(&mythread, NULL, thread_function, NULL))
        {
            printf("error creating thread.");
            abort();
        }
        if (pthread_create(&mythread, NULL, thread_function, NULL))
        {
            printf("error creating thread.");
            abort();
        }
        // int i;
        // for (i = 0; i < UPPERBOUND; i += 1)
        // {
        //     sum1 += array[i];
        // }
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
        show((sum1));
    }
    long int time2 = clock();
    show((time2-time1));
    exit(0);
}