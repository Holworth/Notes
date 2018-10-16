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
#define ARRSZ 50000
// #define ARRSZ 20
int in_array[ARRSZ + 1];
int array[ARRSZ + 1];
int sub[ARRSZ + 1];

int test(int midval, int N, int M)
{
    int len = 0;
    int cnt = 0;
    int minfind = 1000000000;
    for (int i = 0; i < (N + 1); i++)
    {
        if ((len + sub[i]) < midval)
        {
            len += sub[i];
            cnt++;
            //skip
        }
        else
        {
            len = 0;
            //land
        }
    }
    //the last jump
    return cnt;
}

int binsearch(int start, int end, int N, int M)
{
    if (start == end)
        return start;
    int mid = (start + end) / 2;
    int res = test(mid, N, M);
    if (start == (end - 1))
    {
        int k = test(mid + 1, N, M);
        if (k < M)
            return (mid + 1);
        if(k==(M))return (mid+1);
        return mid;
        // if (res < M)
        // {
        //     return end;
        // }
    }
    if (res <= M)
        return binsearch(mid, end, N, M);
    if (res > M)
        return binsearch(start, mid - 1, N, M);
}

int main(int argc, char const *argv[])
{
    int L;
    int N;
    int M;
    cin >> L >> N >> M;
    int p;
    for (p = 0; p < N; p++)
    {
        cin >> in_array[p];
    }
    sort(in_array, in_array + N);
    array[0] = 0;
    for (p = 0; p++ < N;)
    {
        array[p] = in_array[p - 1];
        sub[p - 1] = array[p] - array[p - 1];
    }
    sub[N] = L - array[N];
    // int max = 0;
    // for (int i = 0; i <= N; i++)
    // {
    //     if (sub[i] > max)
    //         max = sub[i];
    // }
    cout << binsearch(1, L, N, M);
}