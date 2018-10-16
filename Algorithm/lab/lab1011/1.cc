// #include<bits/stdc++>
#include <iostream>  
#include <algorithm>  
#include <vector>  
#include <string.h>

// Problem Description
// Recall the problem of finding the number of inversions. As in the course, we are given a sequence of n numbers a1,a2,⋯,an, and we define an inversion to be a pair i<j such that ai>aj.

// We motivated the problem of counting inversions as a good measure of how different two orderings are. However, one might feel that this measure is too sensitive. Let's call a pair a significant inversion if i<j and ai>3aj. Give an O(nlogn) algorithm to count the number of significant inversions between two orderings.

// The array contains N elements (1<=N<=100,000). All elements are in the range from 1 to 1,000,000,000.

// Input
// The first line contains one longeger N, indicating the size of the array. The second line contains N elements in the array.

// 50% test cases guarantee that N < 1000.
// Output
// Output a single longeger which is the number of pairs of significant inversions.

using namespace std;
#define ARRSZ 100000
// #define ARRSZ 10
long array[ARRSZ];
long tmp_array[ARRSZ];
// long tmp_array2[100000];
long res=0;

void msort(long start, long end)
{
    if(start<end)
    {
        long mid=(start+end)/2;
        msort(start, mid);
        msort(mid+1,end);
        memcpy(tmp_array+start,array+start,(end-start+1)*sizeof(long));
        long lnow=start;
        long rnow=mid+1;
        long anow=start;
        while((lnow<=(mid))&&(rnow<=(end)))
        {
            if(tmp_array[lnow]<tmp_array[rnow])
            {
                array[start++]=tmp_array[lnow++];
            }else{//左大于右, 可能有逆序对
                long i=lnow;
                while(i<=mid)
                {
                    if((tmp_array[i])>3*tmp_array[rnow])
                    {
                        res+=(mid-i+1);
                        break;
                        // cout<<"a"<<(tmp_array[lnow])<<"--"<<tmp_array[rnow]<<endl;
                    }
                    i++;
                }
                array[start++]=tmp_array[rnow++];
            }
        }
        while(lnow<=(mid))
        {
            array[start++]=tmp_array[lnow++];
        }
        while(rnow<=(end))
        {
            array[start++]=tmp_array[rnow++];
        }
    }
    return;
}

int main(long argc, char const *argv[])
{
    long N;
    cin>>N;
    long p;
    for(p=0;p<N;p++)
    {
        cin>>array[p];
    }
    msort(0,N-1);
    // for(p=0;p<N;p++)
    // {
    //     cout<<array[p]<<" ";
    // }
    cout<<res;
    return 0;
}
