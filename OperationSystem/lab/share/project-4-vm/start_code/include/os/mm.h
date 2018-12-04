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
    char setuped;
    char inmem;
    char valid;
    char swap_cnt;//4
    void* raddr;//8
    int disk_addr;//12
    int reserved;//for align 16
}pte_L2;

//pte_L1 always in memory
typedef struct page_table_entry_L1
{
    char setuped;
    char inmem;//ie: pte_L2 valid, pte_L2 is in memory
    char resv1;
    char resv2;
    pte_L2* addr;
    int disk_addr;
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


// Page Alloc Operations //--------------------------------

#define MEM_BASE 0x00f00000
#define MEM_UPPER_BOUND 0x01f00000
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

// Disk Regulation //-------------------------------

#define SWAP_BASE 0x000f0000
int disk_addr;
int alloc_disk(int);

// For Debug //-------------------------------
void wrong_addr();
#endif
