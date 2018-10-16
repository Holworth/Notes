#include <stdio.h>
// #include <ctype.h>
#define showsz(t) printf("Size of type "#t" : %d\n",sizeof(t))
int main(){
    showsz(int);
    showsz(short);
    showsz(char);
    showsz(float);
    showsz(double);
    showsz(int*);
    showsz(long);
    showsz(long long);
}