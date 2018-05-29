#include<iostream>
#include<map>
#include<utility>
#include<string>
#include<algorithm>
int main()
{
    using namespace std;
    pair<int, string>P;
    map<int, string>M;
    P.first = 1;
    P.second = "233333\n";
    M.insert(P);
    P.first = 2;
    P.second = "1233333\n";
    M.insert(P);
    for(auto& i : M)
    {
        cout << i.first<<endl;
    }

}