// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;
#define rep(x, a, b) for (int x = a; x <= b; x++)
#define size 10
int n;

#define INF 0x3f3f3f3f

int a[size];
int b[size];
int seq[size];
int pick[size];

int findmax()
{
    int sum = 0;
    int max1 = -9999;
    int max2 = -9999;
    for (int i = 0; i < n; i++)
    {
        if (!pick[i])
        {
            if (a[i] > max1)
            {
                max1 = a[i];
            }
            else if (a[i] > max2)
            {
                max2 = a[i];
            }
            sum += b[i];
        }
    }

    int find = -1;
    int maxv = -1;
    for (int i = 0; i < n; i++)
    {
        int val;
        if (!pick[i])
        {
            if (a[i] == max1)
            {
                val = max2 - sum + b[i];
            }
            else
            {
                val = max1 - sum + b[i];
            }
            if (val > maxv)
            {
                maxv = val;
                find = i;
            }
            pick[find] = 1;
        }
    }
    return find;
}

int mcmp(int m, int p)
{
    // return (a[m]+b[m])>(a[p]+b[p]);
}

int main()
{
    cin >> n;
    int ni = n;
    while (ni--)
    {
        cin >> a[ni] >> b[ni];
    }

    // for(int i=0;i<n;i++)
    // {
    //     seq[i]=i;
    // }
    // sort(seq,seq+n,mcmp);
    // int sum=0;
    // for(int i=0;i<n;i++)
    // {
    //     sum+=b[i];
    // }

    // cout<<a[seq[0]]-sum;
    ni = n;
    while (ni--)
    {
        cout << findmax();
    }

    return 0;
}
