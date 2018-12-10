// ----------------------------------------------------------------
//                   Lagenaria Siceraria OS
//                            mm.h
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

#ifndef INCLUDE_MM_H_
#define INCLUDE_MM_H_

#include "type.h"
#include "sync.h"


#define TLB_ENTRY_NUMBER 64
#define MAX_L2_PER_PROC  4

int tlb_clock;

// TLB related asm //---------------------------
void update_tlb(unsigned int ehi, unsigned int elo0, unsigned int elo1, unsigned int index);
void do_TLB_init();
void do_TLB_Refill();
void do_page_fault();

extern void TLB_set_global(int vaddr, int index, int raddr);
extern void TLB_set_proc(int tlb_index, int vaddr, int raddr, int pid);
extern void tlb_info();
extern void set_tlb_valid_0(int vaddr, int pid);

void mod_helper(void);
void tlb_helper(void);


// PTE define //-------------------------------

//pte_L2: 2^8 * 16Byte -> 4KB
typedef struct page_table_entry_L2
{
    char setuped;       //vaddr-raddr project has already been setuped
    char inmem;         //this l2's page(s) is in memory, "valid" in tlb
    char R;         //reserved
    char swap_cnt;      //4: count how many times this page has been swaped
    void* raddr;        //8: this page(s)' addr in physic memory
    int disk_addr;      //12: this page(s)' addr in disk. 0 if it has not been swaped out.
    int reserved;       //16: for align 16, now is used as R in clock algorithm.
    //for each tlb miss, reserved (i.e. R) ++
}pte_L2;

//pte_L1 always in memory
typedef struct page_table_entry_L1
{
    char setuped;       //L2 page table has already been setuped
    char inmem;         //pte_L2 is in memory, ie: pte_L2 valid
    char swap_cnt;      //L2 page table swap cnt
    char resv2;         //reserved for align
    pte_L2* addr;       //L2 page table's addr in disk.
    int disk_addr;      //L2 page table's addr in physic memory
}pte_L1;

// 16 L1 pte array is always in memory
// For each process, there are at most 4 L2 page table in memory
// It will not take for more than 1 MB space.
// PTE point is contained in TLB; 

pte_L1 PTE_L1[16][2048];
pte_L2 PTE_L2[16][4][256];

// TLB contains:
// pte_L1*
// pte_L2_count; //initial:=0

// Clock Algorithm //--------------------------------

#define CLOCK_SIZE 256*4
int next_clock(int);
int next_clock(int);
int clock_findnext();

// Page Alloc Operations //--------------------------------

#define MEM_BASE 0x00f00000
#define MEM_UPPER_BOUND 0x01000000
#define PAGE_SIZE 0x00001000

void* free_mem_page[0x2000];
int free_mem_page_stack_point;

void* init_page_stack();
void* alloc_page();
void* free_page(void*);

extern int do_tlbp();

// VM deamon proc //----------------------------------

void deamon_vm(void);

typedef struct swap_request_struct
{
    int disk_addr;
    void* mem_addr;
    int size;
    int valid;//optional
}swap_request_t;

char* swap_buffer[512];
char* L2_pt_swap_buffer[512];

// Disk Regulation //-------------------------------

#define SWAP_BASE 0x00100000
int disk_addr;
// int disk_addr=SWAP_BASE;
int disk_init();
int alloc_disk(int);

// For Debug //-------------------------------
void wrong_addr();
#endif
