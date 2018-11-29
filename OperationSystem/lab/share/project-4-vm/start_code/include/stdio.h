#ifndef INCLUDE_STDIO_H_
#define INCLUDE_STDIO_H_

// #define DEBUG

/* kernel printk */
int printk(const char *fmt, ...);

/* kernel printsys (print to srceen) */
int printsys(const char *fmt, ...);

/* user printf */
int printf(const char *fmt, ...);

#ifdef DEBUG
#define info(x) printk(">\n> [INFO] "#x"                    \n")
#define ppinit(x) printk("> [INIT] "#x"                     \n ")
#define check(x) printk("> [INFO:%d] "#x":0x%x               \n",info_cnt++,x)
#else
#define info(x) 1
#define ppinit(x) 1 
#define check(x) 1 
#endif

// #define check(x) printk("1",x)
#define other_check(x) printk("> [INFO:%d] "#x":0x%x               \n",info_cnt++,x)

int panic(char* error_name);
void error_ps();

int breakpoint;//usage: while(breakpoint)
int info_cnt;

#define FLOAT_PRINT_START(x,y) \
{\
    int cursor_x_now=screen_cursor_x;\
    int cursor_y_now=screen_cursor_y;\
    sys_move_cursor(x, y);\

#define FLOAT_PRINT_END(x,y) \
    screen_cursor_y=cursor_y_now;\
    screen_cursor_x=cursor_x_now;\
}\

#endif
