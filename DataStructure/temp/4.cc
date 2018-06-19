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

class mqueue
{

  public:
    char data[200];
    int point;
    int point2;
    mqueue()
    {
        point = 0;
        point2 = 0;
    }
    int push_back(char i)
    {
        data[point++] = i;
    }
    int pop_back()
    {
        point--;
    }
    int pop_head()
    {
        point2++;
    }
    char head()
    {
        return data[point2];
    }
    char back()
    {
        return data[point - 1];
    }
    int empty()
    {
        return point == point2;
    }
};

int main()
{
    char i;
    mqueue Q;
    while (1)
    {
        cin >> i;
        if (i == '@')
            break;
        Q.push_back(i);
    }
    while(!Q.empty())
    {
        // cout << Q.head() << "--" << Q.back() << endl;
        if (Q.head() != Q.back())
        {
            cout<<0<<endl;
            return 0;
        }
        Q.pop_back();
        if(Q.empty())
        {
            cout<<1<<endl;
            return 0;
        }
        Q.pop_head();
    }
    cout << 1 << endl;
}