/* NUS - CS3211 AY2017/2018 Sem 2
 *
 * (c) 2019 Huaqiang Wang
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unum.h>
#include <string.h>

#define PROG "unumcalc"


int main(int argc, char **argv) {
  unum_set_env( 3,4 );

#define UBND_ROP(result,op1,oper,op2)   \
  ubnd_set_str(u1, op1); \
  ubnd_set_str(u2, op2); \
  ubnd_##oper(result,u1, u2);

  #define VAR(name, val) UBND_VAR(#name); ubnd_set_str(#name,#val)

  UBND_VAR(x);
  ubnd_set_str(x,"[1.8,2.0]");
  UBND_VAR(one);
  ubnd_set_str(one,"1.0");
  UBND_VAR(n_one);
  ubnd_set_str(n_one,"-1.0");
  UBND_VAR(result);
  UBND_VAR(temp);

  //VAR(bigint, "10000000.0");
  UBND_VAR(bigint);
  ubnd_set_str(bigint,"10000000.0");
  //VAR(opt, "1.3");
  UBND_VAR(opt);
  ubnd_set_str(opt,"1.3");
  //VAR(three, "3.0");
  UBND_VAR(three);
  ubnd_set_str(three,"3.0");

//float f(float x) {
//  return -1.0/fabs(3*((1.0-(10000000.0*(x-1.3))))) + x*x + 1.0;
//}

ubnd_set_str(result, "1.0");
ubnd_mul(temp, x,x);
ubnd_add(result, temp, result);

ubnd_sub(temp, x, opt);
ubnd_mul(temp, bigint, temp);
ubnd_sub(temp, one, temp);
ubnd_mul(temp, three, temp);
unum_abs(temp, temp);
unum_div(temp, n_one, temp);
ubnd_add(result, temp, result);




 // if (strcmp("add",argv[2]) == 0) { UBND_ROP(fresult,argv[1],add,argv[3]); }
 // if (strcmp("sub",argv[2]) == 0) { UBND_ROP(fresult,argv[1],sub,argv[3]); }
 // if (strcmp("mul",argv[2]) == 0) { UBND_ROP(fresult,argv[1],mul,argv[3]); }
 // if (strcmp("div",argv[2]) == 0) { UBND_ROP(fresult,argv[1],div,argv[3]); }
 
 printf("   Result of "); ubnd_print(x); printf(" is "); ubnd_print(result); printf("\n");

  return 0;
}
