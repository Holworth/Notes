// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;
int x, y;
int n;
#define L 0
#define R 1
#define U 2
#define D 3

int opt[1000001][4][4];

const char *Sp;

inline int cvt(char a)
{
    switch (a)
    {
    case 'L':
        return L;
    case 'R':
        return R;
    case 'U':
        return U;
    case 'D':
        return D;
    }
}

int move(int src, int dst)
{
    switch (src)
    {
    case L:
        switch (dst)
        {
        case L:
            return 0;
        case R:
            return 3;
        case U:
            return 2;
        case D:
            return 4;
        }
    case R:
        switch (dst)
        {
        case L:
            return 1;
        case R:
            return 0;
        case U:
            return 3;
        case D:
            return 2;
        }
    case U:
        switch (dst)
        {
        case L:
            return 3;
        case R:
            return 2;
        case U:
            return 0;
        case D:
            return 2;
        }
    case D:
        switch (dst)
        {
        case L:
            return 1;
        case R:
            return 3;
        case U:
            return 2;
        case D:
            return 0;
        }
    }
}

int main()
{

    // cout<<move(L,R)<<endl;
    // cout<<move(L,L)<<endl;
    // cout<<move(L,D)<<endl;
    cin >> n;
    while (n-- > 0)
    {
        for (int i = 0; i < 1000001; i++)
        {
            for (int a = 0; a < 4; a++)
            {
                for (int b = 0; b < 4; b++)
                {
                    opt[i][a][b] = 5000000;
                }
            }
        }
        for (int a = 0; a < 4; a++)
        {
            for (int b = 0; b < 4; b++)
            {
                opt[0][a][b] = move(L, a) + move(R, b);
            }
        }
        opt[0][L][R] = 0;
        int result = 0;
        string S;
        cin >> S;
        Sp = S.c_str();
        int length = S.length();
        {
            for (int i = 1; i <= length; i++)
            {
                int now = cvt(Sp[i - 1]);
                int min = 5000000;
                for (int a = 0; a < 4; a++)
                {
                    min = 5000000;
                    for (int l = 0; l < 4; l++)
                    {
                        for (int p = 0; p < 4; p++)
                        {
                            if ((opt[i - 1][l][p] + move(l, a) + move(p, now)) < min)
                            {
                                min = (opt[i - 1][l][p] + move(l, a) + move(p, now));
                            }
                        }
                    }
                    opt[i][a][now] = min;
                }
                for (int a = 0; a < 4; a++)
                {
                    min = 5000000;
                    for (int l = 0; l < 4; l++)
                    {
                        for (int p = 0; p < 4; p++)
                        {
                            if ((opt[i - 1][l][p] + move(l, now) + move(p, a)) < min)
                            {
                                min = (opt[i - 1][l][p] + move(l, now) + move(p, a));
                            }
                        }
                    }
                    opt[i][now][a] = min;
                }
            }
        }
        result = 50000000;
        for (int i = 0; i < 4; i++)
        {
            int q = opt[length][cvt(Sp[length - 1])][i];
            int v = opt[length][i][cvt(Sp[length - 1])];
            if (q < result)
                result = q;
            if (v < result)
                result = v;
        }
        cout << result + S.length() << endl;
    }
    return 0;
}