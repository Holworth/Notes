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