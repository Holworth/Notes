// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;
int X, Y;
int n;
int food[1002][3];
#define xi(x) (food[x][0])
#define yi(x) (food[x][1])
#define zi(x) (food[x][2])

int opt[1001][22][80];

int main()
{

    // cout<<val('-','-');
    // cout<<val('-','A');
    // cout<<val('A','C');
    // cout<<val('C','C');
    // cout<<val('G','C');
    // cout<<val('C','G');
    cin >> X >> Y;
    cin >> n;
    int xsum = 0;
    int ysum = 0;
    int zsum = 0;
    for (int i = 1; i <= n; i++)
    {
        cin >> food[i][0] >> food[i][1] >> food[i][2];
    }
    // cout << A << endl
    //      << B;
    for (int i = 0; i <= n; i++)
    {
        for (int x = 0; x <= X; x++)
        {
            for (int y = 0; y <= Y; y++)
            {
                opt[i][x][y]=10000000;
            }
        }
    }
    opt[0][0][0]=0;
    for (int i = 1; i <= n; i++)
    {
        for (int x = 0; x <= X; x++)
        {
            for (int y = 0; y <= Y; y++)
            {
                int result = 10000000;
                int rpx = x+xi(i);
                int rpy = y+yi(i);
                if(rpx>X)rpx=X;
                if(rpy>Y)rpy=Y;

                int rpac = -1;
                int rpbc = -1;


                int res=opt[i-1][x][y]+zi(i);
                if(res<opt[i][rpx][rpy])
                    opt[i][rpx][rpy] = res;
                if(opt[i-1][x][y]<opt[i][x][y])
                    opt[i][x][y]=opt[i-1][x][y];
            }
        }
    }
    // for(int i=0; i<=n;i++)
    // {
    // cout<<opt[n][X][Y]<<endl;
    // }
    cout<<opt[n][X][Y]<<endl;
    return 0;
}