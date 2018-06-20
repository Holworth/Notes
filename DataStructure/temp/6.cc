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

    p = 0;
    
    while(1)
    {
        if(!a[p])
        {
            if(!b[p])
            {
                cout << 0;
                return 0;
            }else
            {
                cout << -1;
                return 0;
            }
        }
        if(a[p]==b[p])
        {
            p++;
            continue;
        }
        if(a[p]>b[p])
        {
            cout << 1;
            return 0;
        }
        if(a[p]<b[p])
        {
            cout << -1;
            return 0;
        }
    }
}