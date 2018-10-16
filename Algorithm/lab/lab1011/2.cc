// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string.h>
#define DEBUG

// Description
// Two lovely frogs Alice and Bob live by a river. There are several stones in this river. Every morning, they will go to the other side of the river to have fun. They cross the river by jumping from one stone to another. One day, Alice decides to play tricks on Bob. She plans to remove some stones so that there is no “easy jump” for Bob to across the river any more. But she has no idea which stones she should remove. She needs your help.

// The width of the river is an integer L((1≤L≤1,000,000,000). We treat the river as a one-dimensional line segment,with two endpoints A (two frog’s home) and B (the other side of the river). Among the river, there are N stones (0≤N≤50,000). The distance from the i-th stone to side A is Di (0<Di<L). Alice would like to remove M stones in the river (0≤M≤N) so that with the rest of the stones, the minimum distance among all possible jumps for Bob is the largest.

// Input
// Each instance contains two lines. The first line contains three integers L, N and M. The second line gives the positions of M stones. No two stones share the same position.

// 30% test cases guarantee that N < 20.
// Output
// For each instance, output a single line with a single integer which is the maximum of the minimum distance among all possible jumps after removing M stones. In the example, Alice should remove stones with distance 2 and 14. After removing these two stones, the minimum distance of jumps is 4, and there are two jumps with distance 4: from 17 to 21, and from 21 to 25.
using namespace std;
// #define ARRSZ 50000
#define ARRSZ 20
int in_array[ARRSZ + 1];
int array[ARRSZ + 1];
int sub[ARRSZ + 1];
int valid[ARRSZ + 1];
// int tmp_array2[100000];
int res = 0;
int csub[ARRSZ+1];

int findmin(int N)
{
    int i;
    int minfind = -1;
    int minvalue = 1000000000;
    for (i = 0; i < (N+1); i++)
    {
        if (valid[i])
        {
            if (sub[i] < minvalue)
            {
                minvalue = sub[i];
                minfind = i;
            }
        }
    }
    return minfind;
}

int mergenear(int i, int N)
{
    int l = i - 1;
    int r = i + 1;
    int lfind = -1;
    int lval = 1000000000;
    int rfind = -1;
    int rval = 1000000000;
    while (l >= 0)
    {
        if (valid[l])
        {
            // if (sub[l] < lval)
            // {
                lfind = l;
                lval = sub[l];
                break;
            // }
        }
        l--;
    }
    while (r <= (N))
    {
        if (valid[r])
        {
            // if (sub[l] < lval)
            // {
                rfind = r;
                rval = sub[r];
                break;
            // }
        }
        r++;
    }
    if(lval<rval)
    {
        //l
        sub[l]+=sub[i];
    }else
    {
        sub[r]+=sub[i];
    }
    valid[i]=0;
    return 0;
}

int test_mergenear(int i, int N)
{
    int l = i - 1;
    int r = i + 1;
    int lfind = -1;
    int lval = 1000000000;
    int rfind = -1;
    int rval = 1000000000;
    while (l >= 0)
    {
        if (valid[l])
        {
            // if (sub[l] < lval)
            // {
                lfind = l;
                lval = sub[l];
                break;
            // }
        }
        l--;
    }
    while (r <= (N))
    {
        if (valid[r])
        {
            // if (sub[l] < lval)
            // {
                rfind = r;
                rval = sub[r];
                break;
            // }
        }
        r++;
    }
    if(lval<rval)
    {
        //l
        return sub[l]+sub[i];
    }else
    {
        return sub[r]+sub[i];
    }
    cout<<"ERROR";
    return -1;
}

int merge_below(int midval, int N)
{
    for(int i=0;i<(N+1);i++)
    {
        if(sub[i]<midval)
        {
            mergenear(i,N);
        }
    }
}

int merge_rest(int midval, int N, int M)
{
    
}

// int find_real_min()

void check(int N)
{
    #ifdef DEBUG
        int p;
    for (p = 0; p < (N+1);p++)
    {
        cout << sub[p]<<" ";
    }
    cout<<endl;
    for (p = 0; p < (N+1);p++)
    {
        cout << valid[p]<<" ";
    }
    cout<<"------\n";
    #endif
}

int getcount(int mid, int N)
{

    int midval=csub[mid];
    int count=0;
    for(int i=0;i<=N;i++)
    {
        if(sub[i]>=midval)
        {
            // morethan[i]=1;
        }
        else
        {
            count++;
        }
    }
    return count;
}

int algo(int start, int end, int N, int M)
{
    if(start>end)return -1;
    int mid=(start+end)/2;
    int count=getcount(mid, N);
    if(count<M)
    {
        int count2=getcount(mid+1, N);
        if(count2>M)return mid;
        return algo(mid+1,end,N,M);
    }else
    {
        if(count>M)
        {
            return algo(start,mid-1,N,M);
            
        }else
        {
            return mid;
        }
    }
}

int main(int argc, char const *argv[])
{
    int L;
    int N;
    int M;
    cin >> L >> N >> M;
    int p;
    for (p = 0; p < N;p++)
    {
        cin >> in_array[p];
    }
    sort(in_array,in_array+N);

    for (p = 0; p++ < N;)
    {
        array[p]=in_array[p-1];
        sub[p - 1] = array[p] - array[p - 1];
        valid[p - 1] = 1;
    }



    sub[N] = L - array[N];
    valid[N]=1;


    for(p=0;p<=N;p++)
    {
        csub[p]=sub[p];
    }
    sort(csub,csub+N+1);
    int lcnt=0;
    int lnow=-1;
    for(p=0;p<(N+1);p++)
    {
        if(csub[p]>lnow)
        {
            csub[lcnt++]=csub[p];
            lnow=csub[p];
        }
    }
    // check(N);


    // while(M-->0)
    // {
    //     mergenear(findmin(N),N);
    //     check(N);
    // }

    // cout << sub[findmin(N)];

    cout<<csub[algo(0,lcnt-1,N,M)];
    return 0;
}
