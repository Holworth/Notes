// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;
#define rep(x, a, b) for (int x = a; x <= b; x++)
#define size 1001
int n;

#define INF 0x3f3f3f3f

int a[size];
int b[size];
int seq[size];
int pick[size];

int mcmp(int m, int p)
{
    return (a[m]+b[m])>(a[p]+b[p]);
}

int main()
{
    cin >> n;
    int ni=n;
    while(ni--)
    {
        cin>>a[ni]>>b[ni];
    }

    for(int i=0;i<n;i++)
    {
        seq[i]=i;
    }
    sort(seq,seq+n,mcmp);
    
    int sum=0;
    for(int i=0;i<n;i++)
    {
        sum+=b[i];
        // cout<<seq[i]<<" ";
    }

    cout<<a[seq[0]]-sum+b[seq[0]];
    return 0;
}
