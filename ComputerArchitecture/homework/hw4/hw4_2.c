#include<stdio.h>
#include<stdlib.h>

#define psize(x) printf("Sizeof "#x" is %d\n",sizeof(x))

struct dic{
    double d;
    int i;
    char c;
};

struct dci{
    double d;
    char c;
    int i;
};
struct dc4i{
    double d;
    char c[4];
    int i;
};
struct dc5i{
    double d;
    char c[5];
    int i;
};
struct dc8i{
    double d;
    char c[5];
    int i;
};
struct dc9i{
    double d;
    char c[5];
    int i;
};

struct idc{
    int i;
    double d;
    char c;
};

struct cdi{
    char c;
    double d;
    int i;
};

struct cid{
    char c;
    int i;
    double d;
};

struct ccid{
    char c1;
    char c2;
    int i;
    double d;
};

struct ic{
    int i;
    char c;
};
struct ic4{
    int i;
    char c[4];
};
struct ic5{
    int i;
    char c[5];
};
struct ci{
    char c;
    int i;
};
struct c4i{
    char c[4];
    int i;
};
struct c5i{
    char c[5];
    int i;
};
struct c8i{
    char c[8];
    int i;
};

struct icd{
    int a1;
    char a2;
    double a0;
};

int main()
{
    psize(struct dic);
    psize(struct dci);
    psize(struct idc);
    psize(struct cdi);
    psize(struct icd);
    psize(struct cid);
    psize(struct ic);
    psize(struct ic4);
    psize(struct ic5);
    psize(struct ci);
    psize(struct c4i);
    psize(struct c5i);
    psize(struct c8i);
}