#include<stdio.h>
#include<stdlib.h>

int main(int argc, char* argv[], char* env[])
{
    printf("0x%x\n",0);
    int i=0;
    while(argv[i])
    {
    puts(argv[i++]);
    }
    return 0;
}