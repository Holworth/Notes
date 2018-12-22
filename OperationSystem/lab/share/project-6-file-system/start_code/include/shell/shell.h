// ----------------------------------------------------------------
//                   Lagenaria Siceraria OS
//                       Shell IO Header
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


#ifndef INCLUDE_SHELL_H_
#define INCLUDE_SHELL_H_

#include "stdio.h"
#include "screen.h"
#include "syscall.h"
#include "time.h"
#include "sched.h"
#include "string.h"
#include "mac.h"
#include "test.h"
#include "fs.h"

#define SHELL_LINE_POSITION 15
#define SHELL_BUFFER_SIZE 40
#define SHELL_LINE_SIZE 40
#define SHELL_HISTORY 40
#define SHELL_SCREEN_HEIGHT 15
char shell_buffer[SHELL_BUFFER_SIZE];
char shell_history[SHELL_HISTORY][SHELL_LINE_SIZE];
char argc;
char argv[10][20];

int shell_history_cnt;
int shell_history_now;
int shell_inline_position;

extern void disable_interrupt();
extern void enable_interrupt();
extern char read_uart_ch(void);


#endif