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

//KEY POINTS//
//1. left->right right->left
//2. "the whole line"
//3. Points at edge

#define INF 0x3f3f3f3f

int mcmp(pair<int, int> a, pair<int, int> b)
{
    return a.first < b.first;
}

int mcmp2(pair<int, int> a, pair<int, int> b)
{
    return a.second < b.second;
}

typedef struct arec
{
    int ax;
    int ay;
    int bx;
    int by;
    int valid;
    arec(int ax, int ay, int bx, int by) : ax(ax), ay(ay), bx(bx), by(by)
    {
        valid = 1;
    }
} arec_t;

typedef pair<int, int> adot;
vector<pair<int, int> > dot;
vector<arec_t> rec;

int main()
{
    cin >> n >> m >> k;
    pair<int, int> tmp;
    rep(i, 1, k)
    {
        cin >> tmp.first >> tmp.second;
        if((tmp.first!=0)&&(tmp.second!=0)&&((tmp.first!=n)&&(tmp.second!=m)))
        dot.push_back(tmp);
    }
    dot.push_back(pair<int, int>(0, 0));
    dot.push_back(pair<int, int>(n, 0));
    dot.push_back(pair<int, int>(0, m));
    dot.push_back(pair<int, int>(n, m));

    sort(dot.begin(), dot.end(), mcmp);

    // for(int i=0;i<dot.size();i++)
    // {
    //     cout<<"d "<<dot[i].first<<" "<<dot[i].second<<endl;
    // }

    int mlb, mub, l, r;
    long long max = 0;
    int end = dot.size();
    for (int i = 0; i < end; i++)
    {
        int ub = 0;
        int lb = m;
        int startn = dot[i].first;
        int lastn = dot[i].first;
        for (int j = i + 1; j < end; j++)
        {
            if (dot[j].first != lastn)
            {
                //get a big rec
                long long area = (dot[j].first - startn) * (lb - ub);
                // cout<<"a:"<<startn<<" "<<lastn<<" "<<lb<<" "<<ub<<endl;

                if (area > max)
                {
                    // mlb = lb;
                    // mub = ub;
                    // l = startn;
                    // r = lastn;
                    max = area;
                }
                lastn = dot[j].first;
            }
            if (dot[j].first != startn)
            {

                if (dot[j].second >= dot[i].second)
                {
                    if (dot[j].second <= lb)
                    {
                        lb = dot[j].second;
                        // cout << i << j << "lb" << lb << endl;
                    }
                }
                if (dot[j].second <= dot[i].second)
                {
                    if (dot[j].second >= ub)
                    {
                        ub = dot[j].second;
                        // cout << i << j << "ub" << ub << endl;
                    }
                }
            }
        }
        //the end
        long long area = (n - startn) * (lb - ub);
        if (area > max)
        {
            // mlb = lb;
            // mub = ub;
            // l = startn;
            // r = n;
            max = area;
        }
    }

    for (int i = end - 1; i >= 0; i--)
    {
        int ub = 0;
        int lb = m;
        int startn = dot[i].first;
        int lastn = dot[i].first;
        for (int j = i - 1; j >= 0; j--)
        {
            if (dot[j].first != lastn)
            {
                //get a big rec
                long long area = (startn-dot[j].first) * (lb - ub);
                if (area > max)
                {
                    // mlb = lb;
                    // mub = ub;
                    // l = startn;
                    // r = lastn;
                    max = area;
                }
                lastn = dot[j].first;
            }
            if (dot[j].first != startn)
            {

                if (dot[j].second >= dot[i].second)
                {
                    if (dot[j].second <= lb)
                    {
                        lb = dot[j].second;
                        // cout << i << j << "lb" << lb << endl;
                    }
                }
                if (dot[j].second <= dot[i].second)
                {
                    if (dot[j].second >= ub)
                    {
                        ub = dot[j].second;
                        // cout << i << j << "ub" << ub << endl;
                    }
                }
            }
        }
        //the end
        long long area = (startn-0) * (lb - ub);
        if (area > max)
        {
            // mlb = lb;
            // mub = ub;
            // l = startn;
            // r = n;
            max = area;
        }
    }

    sort(dot.begin(), dot.end(), mcmp2);
    int maxl = 1;
    for (int i = 0; i < (end - 1); i++)
    {
        if ((dot[i + 1].second - dot[i].second) > maxl)
            maxl = dot[i + 1].second - dot[i].second;
    }

    // cout<<maxl<<"maxl"<<endl;
    long long area = maxl * n;
    if (area > max)
    {
        // mlb = lb;
        // mub = ub;
        // l = startn;
        // r = n;
        max = area;
    }

    // cout << endl
    //      << mlb << " " << mub << " " << l << " " << r << endl;

    cout << max;
}
