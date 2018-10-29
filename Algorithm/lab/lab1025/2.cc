// #include<bits/stdc++>
#include <iostream>  
#include <algorithm>  
#include <vector>  
#include <string.h>
#define SIZE 1000000
using namespace std;
int array[SIZE];
int los[SIZE];
// int last[SIZE];

inline int get_los(int i)
{
    int maxfind=0;
    int tmp;
    for(int l=0;l<i;l++)
    {
        if(array[l]<array[i])
        {
            if (los[l]>maxfind)
            {
                maxfind=los[l];
            }
        }
    }
    return maxfind+1;
}

int main()
{
    int L;
    cin >> L;
    int p;
    for (p = 0; p < L; p++)
    {
        cin >> array[p];
    }
    // sort(array,array+L);

    for(int i=0;i<L;i++)
    {
        los[i]=get_los(i);//以这个数结尾的最长子串的长度
    }

    int mm=-1;
    for(int i=0;i<L;i++)
    {
        if(los[i]>mm)mm=los[i];
    }
    cout<<mm;
    return 0;
}