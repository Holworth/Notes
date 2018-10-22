#include <stdio.h>

int ck(int *add)
{
    int g;
    for (g = 0; g < 20; g++)
    {
        printf("%d ", add[g]);
    }
    puts("");
    return 0;
}

void mprint(int *c)
{
    int g = 299;
    for (g = 299; g >= 0; g--)
    {
        if (c[g])
            break;
    }
    while (g >= 0)
    {
        putchar(c[g] + '0');
        g--;
    }
}

int iszero(int* c)
{
    int i;
    for(i=299;i>=0;i--)
    {
        if(c[i])return 0;
    }
    return 1;
}

int add(int* a, int *b, int* c)
{
    int i;
    for(i=0;i<299;i++)
    {
        c[i]=a[i]+b[i]+c[i];
        if(c[i]>9)
        {
            c[i]-=10;
            c[i+1]+=1;
        }
    }
    return 0;
}

int sub(int*a, int*b, int *c)
{
    int i;
    for(i=0;i<299;i++)
    {
        c[i]=c[i]+a[i]-b[i];
        if(c[i]<0)
        {
            c[i+1]--;
            c[i]+=10;
        }
    }
    return 0;
}

int abscomp(int *a, int *b)
{
    int i;
    for(i=299;i>=0;i--)
    {
        if(a[i]>b[i])
            return 1;
        if(a[i]<b[i])
            return -1;
    }
    return 0;
}

int main()
{
    char sa[300];
    char sb[300];

    int a[300];
    int b[300];
    int c[300];

    int w;
    for (w = 0; w < 300; w++)
    {
        a[w] = 0;
        b[w] = 0;
        c[w] = 0;
    }
    scanf("%s %s", &sa, &sb);
    int ai, bi;
    for (ai = 0; sa[ai]; ai++)
        ;
    for (bi = 0; sb[bi]; bi++)
        ;

    int signa = sa[0] == '-';
    int signb = sb[0] == '-';

    // char* ra=sa;
    // char* rb=sb;
    int l = 0;
    while (ai-- > signa)
    {
        a[l++] = sa[ai] - '0';
    }
    int m = 0;
    while (bi-- > signb)
    {
        b[m++] = sb[bi] - '0';
    }

    int acb=abscomp(a,b);

    if (signa)
    {
        if (signb)//--
        {
            add(a,b,c);
            putchar('-');
            mprint(c);
            return 0;
        }
        else//-+
        {
            int *big;
            int *small;
            if(acb>0)
            {
                big=a;
                small=b;
                putchar('-');
            }else if(acb<0)
            {
                big=b;
                small=a;
            }else{
                //0
                printf("0");
                return 0;
            }
            sub(big, small,c);
            mprint(c);
            return 0;
        }
    }
    else
    {
        if (signb)//+-
        {
            int *big;
            int *small;
            if(acb>0)
            {
                big=a;
                small=b;
            }else if(acb<0)
            {
                big=b;
                small=a;
                putchar('-');
            }else{
                //0
                printf("0");
                return 0;
            }
            sub(big, small,c);
            mprint(c);
            return 0;
        }
        else//++
        {
            add(a,b,c);
            mprint(c);
            return 0;
        }
    }


}