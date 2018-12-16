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

int mcmp(pair<int,int>a, pair<int,int>b)
{
    return a.first<b.first;
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
    dot.push_back(pair<int,int>(0,0));
    dot.push_back(pair<int,int>(n,0));
    dot.push_back(pair<int,int>(0,m));
    dot.push_back(pair<int,int>(n,m));


    sort(dot.begin(),dot.end(),mcmp);

    long long max=0;
    int end=dot.size();
    for(int i=0;i<end;i++)
    {
        int ub=0;
        int lb=m;
        int start=dot[i].first;
        int now=0;
        for(int j=i+1;j<=end;j++)
        {
            if(dot[j].first=start)continue;
            if(j==end)
            {
                long long msize=(m-start)*(lb-ub); 
                if(msize>max)max=msize;
                cout<<msize<<endl;
            }
            if(dot[j].first>now)
            {
                now=dot[j].first;
                long long msize=(dot[j-1].first-start)*(lb-ub); 
                if(msize>max)max=msize;
                cout<<msize<<endl;

            }else
            {
                if(dot[j].second<dot[i].second)
                {
                    if(dot[j].second>ub)
                    {
                        ub=dot[j].second;
                    }
                }
                if(dot[j].second>dot[i].second)
                {
                    if(dot[j].second<lb)
                    {
                        lb=dot[j].second;
                    }
                }
            }
        }
    }

    cout<<max;
}

