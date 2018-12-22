// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <map>
#include <queue>
#include <cstring>

using namespace std;
#define VMAX 10000
#define INF  0x3f3f3f3f

//EK algorithm.

typedef struct Edge
{
    int from;
    int to;
    long long cap;
    long long flow;
    Edge(int from, int to, long long cap, long long flow):
    from(from), to(to), cap(cap), flow(flow)
    {

    }
}edge_t;

vector<edge_t> E;
vector<int> V[VMAX];
long long res[VMAX];
int Vin[VMAX];

int newedge(int from, int to, long long cap)
{
    V[from].push_back(E.size());
    V[to].push_back(E.size()+1);
    E.push_back(Edge(from,to,cap,0));//from
    E.push_back(Edge(to,from,0,0));//to
    return 0;
}

// int reset()
// {
//     memset(res,0,sizeof(res));
//     memset(Vin,0,sizeof(Vin));
// }

long long maxflow(int s, int t)
{
    long long flow=0;
    //BFS
    while(1)
    {
        memset(res,0,sizeof(res));
        res[s]=INF;
        queue<int> Q;
        Q.push(s);
        while(!Q.empty())
        {
            int now=Q.front();
            Q.pop();
            int k=V[now].size();
            for(int i=0;i<k;i++)
            {
                Edge &e=E[V[now][i]];
                // if((e.cap>e.flow)&&(res[e.to]==0))
                if((e.from==now)&&(e.cap>e.flow)&&(res[e.to]==0))
                {
                    // cout<<e.from<<" "<<e.to<<" "<<e.cap<<" "<<e.flow<<endl;
                    Q.push(e.to);
                    res[e.to]=min((e.cap-e.flow),res[now]);
                    // cout<<e.to<<" "<<res[e.to]<<endl;
                    Vin[e.to]=V[now][i];
                }

            }
            //loop until t is reached.
            if(res[t])
            {
                // cout<<"111\n";
                break;
            }
        }

        //check if t is reached
        if(!res[t])break;
        
        //update flow
        // cout<<"111111111: "<<res[t]<<endl;
        flow+=res[t];
        //backtrace, mod edge.flow
        int now=t;
        while(now!=s)
        {
            Edge &e=E[Vin[now]];
            e.flow+=res[t];
            // cout<<"-----------"<<e.from<<endl;

            Edge &nege=E[Vin[now]^1];
            nege.flow-=res[t];

            now=e.from;
        }
    }
    return flow;
}

int main()
{
    int Vnum,Enum,s,t;
    cin>>Vnum>>Enum>>s>>t;
    int el=Enum;
    while(el--)
    {
        int i,j;
        long long c;
        cin>>i>>j>>c;
        newedge(i,j,c);
    }
    cout<<maxflow(s,t);
    return 0;
}