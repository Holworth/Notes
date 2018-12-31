// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <string.h>
#include <map>
#include <queue>
#include <cstring>

using namespace std;
#define VMAX 5000
#define STARTPOINT 0
#define ENDPOINT 4999

#define POINTID(x, y) ((x) + 32 * (y))
#define POINTID2(x, y) (((x) + 32 * (y)) + 2000)

#define PBASE 100

#define INF 0x3f3f3f3f
// #define INF  10000000001
#define rep(a, b, c) for (int a = b; a <= c; a++)

//首先判断点的个数 (size-point)%2==0

//流量=覆盖量
//判断最大流量是否能够达到全覆盖值
//起点?
//终点?
//各种可能的排列?
//余下的点全部都作为第二级的点
//如何区分出: 这个点与哪个点一组?
//每个点只能使用一次: 从源点到每个点有一条边
//每个点只有与一个相邻的点一同才能走到终点??? 如何表示?
//s--1-->1--1-->1_2
//s--1-->1--1-->1_3
//s--1-->3--1-->1_3--2-->end

//问题: 判断:孤独点(OK)
//问题: 写出点的合理邻居

//Dinic algorithm.

typedef struct Edge
{
    int from;
    int to;
    int cap;
    int flow;
    Edge(int from, int to, int cap, int flow) : from(from), to(to), cap(cap), flow(flow)
    {
    }
} edge_t;

vector<edge_t> E;
vector<int> V[VMAX];
int res[VMAX];
int Vin[VMAX];
int Vlevel[VMAX];

int board[33][33];

int newedge(int from, int to, int cap)
{
    V[from].push_back(E.size());
    V[to].push_back(E.size() + 1);
    E.push_back(Edge(from, to, cap, 0)); //from
    E.push_back(Edge(to, from, 0, 0));   //to
    return 0;
}

int reset()
{
    E.clear();
    for (int i = 0; i < VMAX; i++)
    {
        V[i].clear();
        res[i] = 0;
        Vin[i] = 0;
        Vlevel[i] = 0;
    }
    rep(a, 1, 32)
        rep(b, 1, 32)
            board[a][b] = 0;
}

int D_DFS(int s, int t, int upperbound)
{
    //recursion version
    int flow = 0;
    int k = V[s].size();
    if (s == t)
        return upperbound;
    for (int i = 0; i < k; i++)
    {
        Edge &e = E[V[s][i]];
        Edge &nege = E[V[s][i] ^ 1];
        if (((e.cap - e.flow) > 0) && (Vlevel[e.to] == (Vlevel[s] + 1)) && (e.from == s))
        {
            //DFS in
            int this_flow = D_DFS(e.to, t, min(upperbound - flow, (e.cap - e.flow)));
            flow += this_flow;
            e.flow += this_flow;
            nege.flow -= this_flow;
        }

    }
    return flow;
}

int D_BFS(int s, int t)
{
    memset(Vlevel, -1, sizeof(Vlevel));
    queue<int> Q;
    Vlevel[s] = 0;
    Q.push(s);
    while (!Q.empty())
    {
        int now = Q.front();
        Q.pop();
        int k = V[now].size();
        for (int i = 0; i < k; i++)
        {
            Edge &e = E[V[now][i]];
            if (((e.cap - e.flow) > 0) && (Vlevel[e.to] < 0) && (e.from == now))
            {
                Vlevel[e.to] = Vlevel[now] + 1;
                Q.push(e.to);
            }
        }
    }
    return Vlevel[t] != -1; //t must be reachable
}

int Dinic(int s, int t)
{
    int flow = 0;
    while (D_BFS(s, t))
    {
        flow += D_DFS(s, t, INF);
    }
    return flow;
}

int main()
{
    ios::sync_with_stdio(false);

    int cases, m, n, k, a, b;
    cin >> cases;

    while (cases--)
    {
        cin >> m >> n >> k;
        int space = m * n - k;
        int points = k;

        //gen board
        while (k--)
        {
            cin >> a >> b;
            board[a][b] = 1;
        }

        //add points
        //add edges
        int edge = 100;
        rep(a, 1, m)
            rep(b, 1, n)
        {
            if (!board[a][b])
            {
                if ((a + b) % 2 == 0)
                {
                    newedge(STARTPOINT, POINTID(a, b), 1);

                    if (((a + 1) <= m) && (!board[a + 1][b]))
                    {
                        newedge(POINTID(a, b), POINTID(a + 1, b), 1);
                    }
                    if (((a - 1) > 0) && (!board[a - 1][b]))
                    {
                        newedge(POINTID(a, b), POINTID(a - 1, b), 1);
                    }
                    if (((b + 1) <= n) && (!board[a][b + 1]))
                    {
                        newedge(POINTID(a, b), POINTID(a, b + 1), 1);
                    }
                    if (((b - 1) > 0) && (!board[a][b - 1]))
                    {
                        newedge(POINTID(a, b), POINTID(a, b - 1), 1);
                    }
                }
                else
                {
                    newedge(POINTID(a, b), ENDPOINT,1);
                }
            }
        }

        // for(int i=0;i<E.size();i++)
        // {
        //     cout<<E[i].from<<" "
        //         <<E[i].to<<" "
        //         <<E[i].cap<<" "
        //         <<E[i].flow<<" "
        //         <<endl;
        // }

        // if (space % 2 == 1)
        // {
        //     cout << "NO" << endl;
        //     continue;
        // }
        // else
        // {
        //     // cout<<"YES"<<endl;
        //     // continue;
        // }

        int flow;
        flow = Dinic(STARTPOINT, ENDPOINT);
        // cout<<flow<<" "<<space<<endl;
        reset();
        if (flow*2 < space)
        {
            cout << "NO" << endl;
            continue;
        }
        else
        {
            cout << "YES" << endl;
            continue;
        }
    }
    return 0;

    // int Vnum,Enum,s,t;
    // cin>>Vnum>>Enum>>s>>t;
    // int el=Enum;
    // while(el--)
    // {
    //     int i,j;
    //     int c;
    //     cin>>i>>j>>c;
    //     newedge(i,j,c);
    // }
    return 0;
}