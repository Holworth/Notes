// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;
int x, y;
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
    cin >> x >> y;
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
    for (int i = 1; i <= n; i++)
    {
        for (int x = 0; x <= 21; x++)
        {
            for (int y = 0; y <= 79; y++)
            {
                int result = 10000000;
                int rpa=0;
                int rpb=0;
                int rw=0;
                
                int rpac=-1;
                int rpbc=-1;

                for (int a = 0; x <= 21; a++)
                {
                    for (int b = 0; b <= 79; b++)
                    {
                        rpa=a+xi(i);
                        if((rpa>21))rpa=21;  
                        rpb=b+xi(i);
                        if((rpb>79))rpb=79;  
                        rw=opt[i-1][a][b]+zi(i);
                        if(rw<result)
                        {
                            result=rw;
                            rpac=rpa;
                            rpbc=rpb;
                        }
                    }
                }
                opt[i][x][y] = result;
            }
        }
    }
    return 0;
}