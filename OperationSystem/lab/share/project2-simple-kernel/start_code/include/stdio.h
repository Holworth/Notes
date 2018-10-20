#ifndef INCLUDE_STDIO_H_
#define INCLUDE_STDIO_H_

// #define DEBUG
/* kernel printf */
int printk(const char *fmt, ...);

/* user printk */
int printf(const char *fmt, ...);

#ifdef DEBUG
#define info(x) printk(">\n> [INFO] "#x"                \n")
#define ppinit(x) printk("> [INIT] "#x"                \n ")
#define check(x) printk("> [CHECK] "#x":0x%x            \n",x)
#else
#define info(x) 1
#define ppinit(x) 1 
#define check(x) 1 
#endif
// #define check(x) printk("1",x)

#endif
