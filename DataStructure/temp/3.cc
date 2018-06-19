#include <iostream>

using namespace std;

class mstack
{

  public:
    char data[200];
    int point;
    mstack()
    {
        point = 0;
    }
    int push(char i)
    {
        data[point++] = i;
    }
    int pop()
    {
        point--;
    }
    char top()
    {
        return data[point - 1];
    }
    int empty()
    {
        return point == 0;
    }
};

bool isop(char i)
{
    return (i == '+') | (i == '-') | (i == '*') | (i == '/');
}

int level(char i)
{
    switch (i)
    {
    case '+':
        return 1;
    case '-':
        return 1;
    case '*':
        return 2;
    case '/':
        return 2;
    default:
        throw(-1);
    }
}

int lower(char a, char b)
{
    int la = level(a);
    int lb = level(b);
    return la <= lb;
}

int rpn()
{
    char i;
    mstack OP;
    // mstack OP;
    while (cin >> i)
    {
        if (i == '(')
        {
            rpn();
            continue;
        }
        if (i == ')')
        {
            goto end;
        }
        if (isop(i))
        {
            if (OP.empty())
            {
                OP.push(i);
                continue;
            }
            if (lower(i, OP.top()))
            {
                while ((!OP.empty())&&lower(i, OP.top()))
                {
                    cout << OP.top();
                    OP.pop();
                }
                OP.push(i);
            }
            else
            {
                OP.push(i);
            }
        }
        else
        {
            cout << i;
        }
    }
end:
    while (!OP.empty())
    {
        cout << OP.top();
        OP.pop();
    }
}

int main()
{
    rpn();

    // }
}