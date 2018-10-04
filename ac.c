#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <ctype.h>

//rand select

#define SIZE 5

void swap(long long *a, long long pa, long long pb)
{
    long long t = a[pa];
    a[pa] = a[pb];
    a[pb] = a[pa];
    return;
}

int smallerthan(const void *a, const void *b)
{
    return (*(long long *)b > *(long long *)a);
}

int randsort(long long *a, long long k, long long len)
{
    if (len < 5)
    {
        qsort(a, len, sizeof(long long int), smallerthan);
        printf("%lld", a[k - 1]);
        return 0;
    }

    long long sz = SIZE;
    int step = len / sz;
    int pick = ((double)k / (double)len + 0.15) * (double)sz;

    long long tmp[SIZE];
    {
        int i = 0;
        int k = 0;
        for (; i < sz; i++)
        {
            tmp[i] = a[k];
            k += step;
        }
    }

    qsort(tmp, sz, sizeof(long long int), smallerthan);
    long long picked = tmp[pick];

repick:
    if (pick < 0)
        pick = 0;
    if (pick >= len)
        pick = len - 1;

    int b = 0;
    {
        int i = 0;
        while (i < len)
        {
            if (a[i] > picked)
            {
                swap(a, i, b);
                b++;
            }
            i++;
        }
    }
    //b is num of bigger

    if (b < k)
    {
        picked++;
        goto repick;
    }
    return randsort(a, k, b);
}

int findk(long long start, long long end, long long k)
{
    long long res = -1;

    int i = start;
    while (0)
        ;

    printf("%ld\n", res);
}

int smallsort(long long *a, long long start, long long end, int inter) //size=5;
{
    // int be=0;
    // int en=4;
    // long long m=a[be];
    // while(a<b)
    // {
    //     if(a[en]<b[en])
    //     {

    //     }
    // }
    int i;
    int n;
    for (i = 4 * inter; i >= 0; i -= inter)
    {
        for (n = 0; n <= i; n += inter)
        {
            if (a[start + n] < a[start + n + inter])
            {
                swap(a, start + n, start + n + inter);
            }
        }
    }
}

//let size=5;
int p(long long *a, int len)
{
    int i = 0;
    while (i < len)
    {
        printf("%lld ", a[i]);
        i++;
    }
    return 0;
}

// long long a[5000000];
long long a[5000000];

int main()
{
    // Find the kth largest element in an unsorted array A . Note that it is the kth largest element in the sorted order, not the kth distinct element. The range of length of A is N(1â‰¤Nâ‰¤5,000,000) and the element (integer) in A is no bigger than 10,000,00000.

    long long len;
    long long find;
    scanf("%lld", &len);
    scanf("%lld", &find);
    int i = 0;
    while (i < len)
    {
        scanf("%lld", &a[i]);
        i++;
    }

    // qsort(a,len,sizeof(long long int),smallerthan);
    // printf("%lld",a[find-1]);

    // randsort(a, find, len);
    // p(a, 5);
    // findk();

    if (len < 10000)
    {
        qsort(a, len, sizeof(long long int), smallerthan);
        printf("%lld", a[find - 1]);

        return 0;
    }

    int k;
    double dk = (double)find;
    long long pick = dk / (double)len * 1000.0 + 0.05;
    int size = 1000;
    qsort(a, 1000, sizeof(long long int), smallerthan);

    int ll = (int)pick;
    long long xx = a[ll];

    long long oldm = len;

    while (1)
    {

        long long n = 0;
        long long m = 0;
        while (n < len)
        {
            if (a[n] > ll)
            {
                swap(a, m, n);
                m++;
            }
            n++;
        }
        if(m<find)break;
        oldm=m;
    }

    qsort(a, oldm, sizeof(long long int), smallerthan);
    printf("%lld", a[find - 1]);

    return 0;
}