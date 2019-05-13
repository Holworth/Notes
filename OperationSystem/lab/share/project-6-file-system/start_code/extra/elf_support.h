// ----------------------------------------------------------------
//                   Lagenaria Siceraria OS
//                  ELF support for Big Bonus
// ----------------------------------------------------------------
//              Copyright (C) 2019 Wang Huaqiang
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

#ifndef INCLUDE_ELF_SUPPORT_H_
#define INCLUDE_ELF_SUPPORT_H_

// #include <elf.h>
#include "melf.h"
#include "raw.h"

// uint32_t parse_net_pkg(uint32_t net_buff, char* name);//parse the net pkg, get the program file. 
// uint32_t parse_elf(char* name);//return the program's entry position. 

// uint32_t exec(char* name);//note: this is a syscall
// {
    //open file
    //parse_elf find entry
    //setup PCB
    //switch to new proc's vm
    //copy program file to vm
    //start new proc
// }

#endif