// Copyright (C) 2019 Wang Huaqiang

#include <bits/stdc++.h>

using namespace std;
#define TIMES 1000000
#define ASM_STEP 13

int main()
{
    int a[10000];
    int t=0;
    clock_t start, end;
    start=clock();
    while(t++<TIMES)
    {
        for(int i=0;i<10000;i+=2)
        {
            a[i+1]+=a[i];
        } 
    }
    end=clock();
    cout<<"start:"<<start<<" end:"<<end<<" CLOCKS_PER_SEC:"<<CLOCKS_PER_SEC<<endl;
    cout<<"ips:"<<(double)((double)ASM_STEP*(double)TIMES*5000)/((double)(end-start)/(double)CLOCKS_PER_SEC)<<endl;
    return 0;
}