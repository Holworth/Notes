// ----------------------------------------------------------------
//              Lagenaria Siceraria OS: Mini scanf
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

#include "stdarg.h"
#include "screen.h"
#include "syscall.h"
#include "string.h"

static void disable_interrupt()
{
    uint32_t cp0_status = get_cp0_status();
    cp0_status &= 0xfffffffe;
    set_cp0_status(cp0_status);
}

static void enable_interrupt()
{
    uint32_t cp0_status = get_cp0_status();
    cp0_status |= 0x01;
    set_cp0_status(cp0_status);
}

static char mread_uart_ch(void)
{
    char ch = 0;
    unsigned char *read_port = (unsigned char *)(0xbfe48000 + 0x00);
    unsigned char *stat_port = (unsigned char *)(0xbfe48000 + 0x05);

    while ((*stat_port & 0x01))
    {
        ch = *read_port;
    }
    return ch;
}

void scanf(const char *fmt, ...)
{
    //Use read_uart_ch() to complete scanf(), read input as a hex number.
    //Extending function parameters to (const char *fmt, ...) as printf is recommended but not required.
    //TODO
}

void gethex(int *mem)
{
    //Use read_uart_ch() to complete scanf(), read input as a hex number.
    //Extending function parameters to (const char *fmt, ...) as printf is recommended but not required.

    // read command from UART port
    char buffer[100];
    int inline_position=0;

    while (1)
    {
        disable_interrupt();
        char ch = mread_uart_ch();
        enable_interrupt();
        if (!ch)
            continue;

        if (ch == 127) //in qemu sim
        {
            if (inline_position > 0)
            {
                inline_position--;
                screen_write_ch('\b');
            }
        }
        else if (ch == 8) //on board
        {
            if (inline_position > 0)
            {
                inline_position--;
                screen_write_ch('\b');
            }
        }
        else if (ch != 13) //
        {
            buffer[inline_position++]=ch;
            screen_write_ch(ch);
        }
        else //ch==13
        {
            buffer[inline_position++]='\0';
            break;
        }
    }

    *mem=htoi(buffer);
    return;
}