#include <bits/stdc++.h>
#include <algorithm>
using namespace std;

int main(int argc, char const *argv[])
{
    int a[5000000];
    long long len;
    long long find;
    scanf("%lld", &len);
    scanf("%lld", &find);
    long long i = 0;
    while (i < len)
    {
        scanf("%d", &a[i]);
        i++;
    }

    sort(a,a+len);
    printf("%d",a[len-find]);
    return 0;
}
