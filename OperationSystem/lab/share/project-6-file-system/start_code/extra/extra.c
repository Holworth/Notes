// ----------------------------------------------------------------
//                   Lagenaria Siceraria OS
//                      Extra Bonus Test
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


#define bios_printstr 0x8007b980

void __attribute__((section(".entry_function"))) _start(void)
{
    // Call PMON BIOS printstr to print message"
    char mstr[]="Big Bonus Succeed!\n";
    void (*call_printstr)(char* ) =(void (*)(char* )) bios_printstr;
    call_printstr(mstr);
    while(1);
}