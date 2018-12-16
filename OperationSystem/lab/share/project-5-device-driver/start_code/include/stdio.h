// ----------------------------------------------------------------
//              Lagenaria Siceraria OS: LSOSstdio
// ----------------------------------------------------------------
//              Copyright (C) 2018 Wang Huaqiang 
//             email : wanghuaqiang16@mails.ucas.ac.cn
// ----------------------------------------------------------------
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
// -----------------------------------------------------------------

#ifndef INCLUDE_STDIO_H_
#define INCLUDE_STDIO_H_

// #define DEBUG

/* kernel printk */
int printk(const char *fmt, ...);

/* kernel printsys (print to srceen) */
int printsys(const char *fmt, ...);

/* user printf */
int printf(const char *fmt, ...);

/* user scanf */
void scanf(const char *fmt, ...);

/* light weight scanf */
void gethex(int* mem);


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

#define os_assert(x) ((x)?1:panic("assert failed: "#x""))

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
