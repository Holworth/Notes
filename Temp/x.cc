#include <iostream>
#include <string>
using namespace std;
int main()
{
    string s;
    cin >> s;
    int maxl = 0;
    int p = -1;
    int l = s.length();
    bool redomark = 0;
    for (int i = 0; i < l; i++)
    {
        do
        {
            redomark = 0;
            for (int a = i + maxl + 1; a < l; a++)
            {
                int t = 0;
                while (((a + t) < l) && (t < (maxl + 1)) && (s[i + t] == s[a + t]))
                {
                    t++;
                }
                if ((t) > maxl)
                {
                    maxl = t;
                    p = i;
                    redomark = 1;
                    break;
                }
            }
        } while (redomark);
    }
    if (p == -1)
    {
        cout << "-1" << endl;
    }
    else
    {
        for (int m = 0; m < maxl; m++)
        {
            cout << s[p + m];
        }
        cout << " " << p << endl;
    }
}