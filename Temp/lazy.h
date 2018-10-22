#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<math.h>
#include<stdarg.h>
#include<time.h>
#include<ctype.h>

//大写宏
#ifndef _AWSHEAD
    #define _AWSHEAD
#ifndef NDEBUG
    #define DEBUG

#define TRACK(x) (printf("track: " #x ":%d\n", x) * 0 + x)
//值追踪

#define CK(x) ({typeof(x) (_x)=(x);printf("track: " #x ":%d\n", _x);_x; })
//整数值追踪
//注意不要追踪会引发全局变化的函数和非整数值

#define CP (printf("Checkpoint. File:%s Line:%d\n",__FILE__, __LINE__))
//检查点

#define BP (printf("Breakpoint. File:%s Line:%d\n",__FILE__, __LINE__), getchar())
//断点
// #define LICENSE() (printf("Augustus Wang (c) 2017\n"),printf("Compiled on %s at %s\n", __DATE__,__TIME__))
//签名
#endif

#define LICENSE (printf("\n%s\n", __FILE__), printf("Copyright (c) 2018 Augustus Wang (Wang Huaqiang) \n"), printf("Compiled on %s at %s\n\n", __DATE__, __TIME__))
//签名


#define GET(x) scanf("%d", &x)
//读取整数


#define LEN(x) (sizeof(x) / sizeof(x[0]))
//数组长度

#define M_MAX(x, y) (((x) > (y)) ? (x) : (y))
#define M_MIN(x, y) (((x) < (y)) ? (x) : (y))
//比较大小

//以下宏定义的临时变量隐藏在代码块中,只要你不用_开头命名变量就没有问题
#define MIN(x,y) ({\
    typeof(x) _x = (x);\
    typeof(y) _y = (y);\
    (void) (&_x == &_y);\
    _x < _y ? _x : _y; })\

#define MAX(x,y) ({\
    typeof(x) _x = (x);\
    typeof(y) _y = (y);\
    (void) (&_x == &_y);\
    _x > _y ? _x : _y; })\
//比较大小,且对于每个变量仅调用一次

#define SWAP(a,b) do{\
    typeof(a) _t=a;\
    a=b;\
    b=_t;}while(0)
//交换a,b

#define BOOM(str) (fprintf(stderr, "Boomed in line%d, because of %s.\n", __LINE__, str), exit(1))
//错误处理:直接退出

#define SHOWALL(array, type) (puts("------------------------\nShow "#type" array: "#array" :"),SHOW(array,type,LEN(array)))
//显示数组值

#define RAW_CAT(X,Y) X##Y
//直接连接

int M_GETLINE(char s[],int lim){
    int c,i;
    i=0;
    while((c=getchar())!=EOF&&c!='\n'&&i<lim-1)
        s[i++]=c;
    if(c==EOF&&i==0)
        return -1;
    s[i]='\0';
    return i;
}

int SHOW(void* array,char* type,int length){//显示一维数组
    if(!strcmp(type,"int")){
        int *point = (int *)array;
        for (int i = 0; i < length; i++)
        {
                if(i%10==0)
                    puts("");
                printf("%d ", *(point + i));
        }
        puts("");
    }else if(!strcmp(type,"double")){
        double *point = (double *)array;
        for (int i = 0; i < length; i++)
        {
                if(i%10==0)
                    puts("");
                printf("%lf ", *(point + i));
        }
        puts("");
    }else if(!strcmp(type,"float")){
        float *point = (float *)array;
        for (int i = 0; i < length; i++)
        {
                if(i%10==0)
                    puts("");
                printf("%f ", *(point + i));
        }
        puts("");
    }else if(!strcmp(type,"char")){
        char *point = (char *)array;
        for (int i = 0; i < length; i++)
        {
                if(i%10==0)
                    puts("");
                printf("%d ", *(point + i));
        }
        puts("");
    }else{
        // puts("No matched type!");
        BOOM("No matched type!");
    }
}


#endif
