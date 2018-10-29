// #include<bits/stdc++>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;

int list[1003][1003];
string A;
string B;
const char* Ap;
const char* Bp;
int val(char a, char b)
{
    if (a == '-')
    {
        if (b == '-')
            return 10000;
        return 3;
    }
    if (a == b)
        return 0;
    if (b == '-')
        return 3;
    if (a == 'G')
    {
        if (b == 'C')
            return 4;
    }
    if (a == 'C')
    {
        if (b == 'G')
            return 4;
    }
    return 5;
}

int opt(int la, int lb)
{

    int r1 = list[la - 1][lb - 1] + val(Ap[la-1], Bp[lb-1]);
    int r2 = list[la][lb - 1] + val('-', Bp[lb-1]);
    int r3 = list[la - 1][lb] + val(Ap[la-1], '-');

    if (r1 > r2)
        r1 = r2;
    if (r1 > r3)
        r1 = r3;
    return r1;
}

int main()
{

    // cout<<val('-','-');
    // cout<<val('-','A');
    // cout<<val('A','C');
    // cout<<val('C','C');
    // cout<<val('G','C');
    // cout<<val('C','G');
    cin >> A >> B;
    // cout << A << endl
    //      << B;
    int result = 0;
    int Alen = A.length();
    int Blen = B.length();
    Ap=A.c_str();
    Bp=B.c_str();
    for (int i = 0; i < (Alen + 1); i++)
    {
        list[i][0] = 3*i;
    }
    for (int i = 0; i < (Blen + 1); i++)
    {
        list[0][i] = 3*i;
    }
    list[0][0] = 0;
    for (int a = 1; a < (Alen + 1); a++)
    {
        for (int b = 1; b < (Blen + 1); b++)
        {
            list[a][b] = opt(a, b);
        }
    }
int min=1000000;
    // for (int a = 0; a < (Alen + 1); a++)
    // {
    //     for (int b = 0; b < (Blen + 1); b++)
    //     {
    //         if(list[a][b]<min)min=list[a][b];
    //         cout<<list[a][b]<<"\t";
    //     }
    //     cout<<endl;
    // }
    cout<<list[Alen][Blen];
    return 0;
}