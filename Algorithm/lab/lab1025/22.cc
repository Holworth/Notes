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

    int result=0;
    for(int i=0;i<L;i++)
    {

        int start=0;
        int end=result;
        int mid;
        while(start!=end)
        {
            mid=(start+end)/2;
            if(los[mid]<array[i])
            {
                start=mid+1;
            }else{
                end=mid;
            }
        }
        los[start]=array[i];
        if(start==result)result++;
        // if(array[i]>los[result])los[++result]=array[i];
        // else{
        //     for(int k=0;k<result;k++){
        //         if((los[k]<array[i])&&(los[k+1]>=array[i]))
        //         {
        //             los[k+1]=array[i];
        //         }
        //     }
        // }
    }

    cout<<result;
    return 0;
}