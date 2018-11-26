// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;
#define rep(x, a, b) for (int x = a; x <= b; x++)
#define size 10001
int n;
int m;
int s;
int t;
#define INF 0x3f3f3f3f
int dis[size][size];
int reached[size];
int sdis[size];

int main()
{
    cin >> n >> m >> s >> t;
    int ni = m;

    rep(a, 0, n) rep(b, 0, n)
        dis[a][b] = INF;

    while (ni--)
    {
        int a, b, c;
        cin >> a >> b >> c;
        dis[a][b] = c;
    }
    for (int i = 0; i <= n; i++)
    {
        sdis[i] = INF;
    }
    reached[s] = 0;
    sdis[s] = 0;
    while (!reached[t])
    {
        int min = INF;
        int mfind = -1;
        for (int i = 1; i <= n; i++)
        {
            if ((sdis[i] < min) && (!reached[i]))
            {
                mfind = i;
                min = sdis[i];
                // cout << min << " " << mfind << " ";
            }
        }

        if (mfind == -1)
        {
            break;
        }

        reached[mfind] = 1;
        rep(i, 1, n)
        {
            if ((sdis[mfind] + dis[mfind][i]) < sdis[i])
            {
                sdis[i] = (sdis[mfind] + dis[mfind][i]);
            }
        }

    }
    if (!reached[t])
    {
        cout << -1;
    }
    else
    {
        cout << sdis[t];
    }
    return 0;
}