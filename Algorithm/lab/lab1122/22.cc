// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;
#define rep(x, a, b) for (int x = a; x <= b; x++)
#define size 1002
int n;

string num[size];

int sacmp(string a, string b)
{
    string sa=a+b;
    string sb=b+a;
    return sa>sb;
}

int main()
{
    cin >> n;
    int ni = n;
    rep(i, 1, n)
        cin >>num[i];

    // rep(i,1,n)
    // {
    //     if(num[i]=="0")while(1);
    // }

    sort(&num[1],&num[1]+n,sacmp);
    rep(i,1,n)cout<<num[i];
}