// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <map>

using namespace std;
#define rep(x, a, b) for (int x = a; x <= b; x++)
#define SIZE 100
int n;
int m;
int k;

#define INF 0x3f3f3f3f

int mcmp(int m, int p)
{
}


typedef struct arec{
    int ax;
    int ay;
    int bx;
    int by;
    int valid;
    arec(int ax, int ay, int bx, int by):ax(ax),ay(ay),bx(bx),by(by)
    {
        valid=1;
    }
}arec_t;

typedef pair<int,int> adot;
vector<pair<int,int> > dot;
vector<arec_t> rec;

int main()
{
    cin >> n>>m>>k;
    pair<int,int> tmp;
    rep(i,1,k)
    {
        cin>>tmp.first>>tmp.second;
        dot.push_back(tmp);
    }
    arec_t tr=arec(0,0,n,m);
    rec.push_back(tr);

    while(!dot.empty())
    {
        adot d=dot.back();
        dot.pop_back();
        int end=rec.size();
        for(int i=0;i<end;i++)
        {
            if(!rec[i].valid)continue;
            if((d.first>rec[i].ax)&&(d.first<rec[i].bx)&&(d.second>rec[i].ay)&&(d.second<rec[i].by))
            {
                rec[i].valid=0;
                arec_t tr=arec(rec[i].ax,rec[i].ay,d.first,rec[i].by);
                rec.push_back(tr);
                tr=arec(rec[i].ax,rec[i].ay,rec[i].bx,d.second);
                rec.push_back(tr);
                tr=arec(d.first,rec[i].ay,rec[i].bx,rec[i].by);
                rec.push_back(tr);
                tr=arec(rec[i].ax,d.second,rec[i].bx,rec[i].by);
                rec.push_back(tr);
            }
        }

        // for(auto &i: rec)
        // {
        //     if(!i.valid)continue;
        //     if((d.first>i.ax)&&(d.first<i.bx)&&(d.second>i.ay)&&(d.second<i.by))
        //     {
        //         i.valid=0;
        //         arec_t tr=arec(i.ax,i.ay,d.first,i.by);
        //         rec.push_back(tr);
        //         tr=arec(i.ax,i.ay,i.bx,d.second);
        //         rec.push_back(tr);
        //         tr=arec(d.first,i.ay,i.bx,i.by);
        //         rec.push_back(tr);
        //         tr=arec(i.ax,d.second,i.bx,i.by);
        //         rec.push_back(tr);
        //     }
        // }
    }

    long long max=0;
    int e=rec.size();
    for(int i=0;i<e;i++)
    {
        if(rec[i].valid)
        {
            long long msize=(rec[i].bx-rec[i].ax)*(rec[i].by-rec[i].ay); 
            if(msize>max)max=msize;
            // cout<<msize<<endl;
        }
    }
    cout<<max;
}
