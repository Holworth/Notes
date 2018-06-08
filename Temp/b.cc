#include <iostream>
using namespace std;
int main(void)
{
    char va[1000];
    char vb[1000];
    int i1 = 0;
    int i2 = 0;
    char item = 'a';
    int secondStr = -1;
    while (cin >> item)
    {
        if (item == ';')
        {
            secondStr = 1;
            continue;
        }
        if (secondStr < 0)
        {
            if (item == ',')
            {
                va[i1] = '-';
            }
            else
            {
                va[i1] = item;
            }
            i1++;
        }
        else
        {
            if (item == ',')
            {
                vb[i2] = '-';
            }
            else
            {
                vb[i2] = item;
            }
            i2++;
        }
    }


    // 如果前部分和后部分相等，这输出0；如果前 > 后，则输出1；如果前 < 后，则输出2 
    int result;
    bool type = 0;
    int i = 0;
    while (1)
    {
        if(type==0)
        {
            if(va[i]>vb[i])
            {
                result = 2;
                break;
            }else if(va[i]<vb[i])
            {
                result =1;
                break;
            }
            type = 1;
        }
        else //type=1
        {
            if(va[i]!='-')
            {
                if(vb[i]!='-')
                {
                    result = 0;
                    break;
                }
                result = 2;
                break;
            }else
            {
                if(vb[i]!='-')
                {
                    result =1;
                    break;
                }
            }
            type = 0;
        }

        ++i;
    }

    cout << result;
    return 0;
}