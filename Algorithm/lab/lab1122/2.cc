// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;
#define rep(x, a, b) for (int x = a; x <= b; x++)
#define size 1001
int n;

int num[size][5];
int used[size];
int result[size*4];

int main()
{
    cin >> n;
    int ni = n;
    rep(i, 1, n)
            cin >>
        num[i][0];

    int tmp[4];
    rep(i, 1, n)
    {
        int p = 0;
        int nump = num[i][0];
        rep(a, 1, 4)
        {
            tmp[p++] = nump % 10;
            if (nump /= 10) //not 0
            {
                continue;
            }
            break;
        }
        rep(b,1,4)
        {
            if(p>0)
            num[i][b]=tmp[--p];
            else
            num[i][b]=-1;
        }
        // rep(c,0,3)
        //     cout<<tmp[c]<<" ";
        // cout<<endl;

        // rep(c,0,4)
        //     cout<<num[i][c]<<" ";
        // cout<<endl;
    }

    rep(i,0,size*4)
    {
        result[i]=-1;
    }

    //solve
    int unused=n;
    int result_pos=0;
    int cp[size];
    while(unused)
    {
        int max=-1;
        rep(i,1,n)
        {
            if(!used[i])
            {
                if((num[i][cp[i]+1])>max)
                {
                    max=(num[i][cp[i]+1]);
                }
            }
        }
        result[result_pos++]=max;
        int mark[size];
        int cnt=0;
        rep(i,1,n)
        {
            if(((num[i][cp[i]+1])==max)&&(!used[i]))
            {
                mark[i]=1;
                cnt++;
            }
        }
    }
}