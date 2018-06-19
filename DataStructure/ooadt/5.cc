#include <iostream>
int pos[256];
char a[200];
char b[200];
using namespace std;
int main()
{
    char i;
    int p = 0;
    while (i = cin.get())
    {
        if (i == ' ')
        {
            // cout << "FFFFF";
            break;
        }
        a[p++] = i;
    }
    p = 0;
    while (cin >> i)
    {
        b[p] = i;
        p++;
    }

    //pos = real pos + 1;

    p = 0;
    bool exist = 0;
    while (b[p] != 0)
    {
        pos[b[p++]] = -1;
    }
    p = 0;
    while (a[p] != 0)
    {
        if (pos[a[p]] == 0)
        {
            exist = 1;
            pos[a[p]] = p + 1;
            cout << a[p];
        }
        p++;
    }

    if (exist)
        cout << " ";
    p = 0;
    while (a[p] != 0)
    {
        if (pos[a[p]] > 0)
        {
            cout << pos[a[p]] - 1;
            pos[a[p]] = 0;
        }
        p++;
    }
    if (!exist)
        cout << -1 << endl;
}