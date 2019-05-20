// ----------------------------------------------------------------
//                   Lagenaria Siceraria OS
//                          memory.c
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

#include "sched.h"
#include "mm.h"
#include "stdio.h"
#include "sync.h"
#include "string.h"
#include "syscall.h"

static semaphore_t swap_sleep_sem;
static mutex_lock_t swap_lock;

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

// TLB related functions //-----------------------------------------

void tlb_info()
/// @brief Check tlb info when tlb exception happens.
/// @return void
{
    int ehi = get_CP0_ENTRYHI();
    int baddr = get_CP0_BADVADDR();
    printk("VPN2: %x, ASID: %x BADADDR:%x\n", (ehi & 0xffffe000) >> 13, ehi & 0xff, baddr);
    return;
}

static int get_L2_to_swap_out()
{
    int L2_to_swap_out = -1;
    int min_swap_find = 1000;
    int l;
    for (l = 0; l < 2048; l++)
    {
        if (current_running->pte_L1p[l].inmem)
        {
            int swap_cnt = current_running->pte_L1p[l].swap_cnt;
            if (swap_cnt < min_swap_find)
            {
                min_swap_find = swap_cnt;
                L2_to_swap_out = l;
            }
        }
    }
    return L2_to_swap_out;
}

uint32_t do_L2_swap(pte_L1 *pte_L1p)
//return empty/swap_in addr for new L2 page table
{
    // vt100_move_cursor(1, 7);
    // printk("do_L2_swap\n");
    // int L2_pick = current_running->pte_L2_clock % 4;

    //find a L1 term, its L2 is in mem;
    //use Least Switched Fst

    int L2_to_swap_out = get_L2_to_swap_out();
    //check
    if (L2_to_swap_out == -1)
        panic("L2_to_swap_out==-1");
    if (!current_running->pte_L1p[L2_to_swap_out].inmem)
        panic("get_L2_to_swap_out not in mem");

    //alloc disk
    uint32_t disk_addr;
    if (current_running->pte_L1p[L2_to_swap_out].disk_addr == 0)
    {
        disk_addr = alloc_disk(8);
        current_running->pte_L1p[L2_to_swap_out].disk_addr = disk_addr;
    }
    else
    {
        disk_addr = current_running->pte_L1p[L2_to_swap_out].disk_addr;
    }
    //write

    // vt100_move_cursor(1, 1);
    // other_check(disk_addr);

    //8*512=4K
    int i;
    for (i = 0; i < 8; i++)
    {
        // sdread(L2_pt_swap_buffer, disk_addr + 512 * i, 1);
        // printk("sdwrite:%x, %x, %x\n", ((uint32_t)current_running->pte_L1p[L2_to_swap_out].addr + 512 * i), disk_addr + 512 * i, 512);
        vdiskwrite(((unsigned char *)current_running->pte_L1p[L2_to_swap_out].addr + 512 * i), disk_addr + 512 * i, 512);
        // memcpy((void *)(&(current_running->pte_L2p[L2_pick])), (void *)L2_pt_swap_buffer, 512);
    }

    current_running->pte_L1p[L2_to_swap_out].inmem = 0;
    current_running->pte_L1p[L2_to_swap_out].swap_cnt++;

    //l2 inmem check
    //     for(k=0;k<2048;k++)
    // {
    //     if(current_running->pte_L1p[k].inmem)
    //     {
    //         d++;
    //     }
    // }
    // if(c==d)panic("c==d");

    //For dbg
    // {
    //     int k = 0;
    //     for (k = 0; k < 32; k++)
    //     {
    //         update_tlb(0, 0, 0, k); //
    //     }
    // }

    //swap new L2 in
    if (pte_L1p == 0)
    {
        return (uint32_t)(current_running->pte_L1p[L2_to_swap_out].addr);
    }
    else
    {
        // if(!pte_L1p->disk_addr)panic("!pte_L1p->disk_addr");

        int k;
        for (k = 0; k < 8; k++)
        {
            
            //L2 bug: I am so BIUBEE!!!!!
            // vdiskread((unsigned char *)((current_running->pte_L1p[L2_to_swap_out].addr)) + 512 * i, pte_L1p->disk_addr + 512 * i, 512);
            vdiskread((unsigned char *)((current_running->pte_L1p[L2_to_swap_out].addr)) + 512 * k, pte_L1p->disk_addr + 512 * k, 512);
            // sdwrite((int)current_running->pte_L1p[min_swap_find] + 512 * i, disk_addr + 512 * i, 1);
            // memcpy((void *)(&(current_running->pte_L2p[L2_pick])), (void *)L2_pt_swap_buffer, 512);
        }
        pte_L1p->inmem = 1;
        pte_L1p->addr = (current_running->pte_L1p[L2_to_swap_out].addr);

        return (uint32_t)current_running->pte_L1p[L2_to_swap_out].addr;
    }
}

void *do_swap(pte_L2 *swapin)
{
    // TODO
    // Choose a page to write to disk.
    // other_check(current_running->pid);
    // other_check(get_CP0_BADVADDR());

    int swap_target = clock_findnext();
    pte_L2 *pte_L2p = (pte_L2 *)(current_running->pte_L2p);
    if (!(pte_L2p)[swap_target].inmem)
    {
        //no page of this L2 is in mem
        panic("Need alloc other proc's mem.");
    }

    // Then swap it
    // Set inmem to 0.
    pte_L2p[swap_target].inmem = 0;

    // Set inmem in tlb to 0. (if have)
    // set_tlb_valid_0(vaddr, current_running->pid);
    //ERROR
    // uint32_t vaddr = get_CP0_BADVADDR();
    uint32_t outtgt_vaddr = pte_L2p[swap_target].l1_index << 21 | swap_target << 13;

    {
        uint32_t ehi = outtgt_vaddr >> 13;
        ehi = ehi << 13;
        ehi |= (current_running->pid & 0xff);
        do_tlbp();
        uint32_t index = get_CP0_INDEX();
        if (index >= 64) //index[31]=1;
        {
            //do nothing
        }
        else
        {
            uint32_t elo0, elo1;
            elo0 = ((int)pte_L2p[swap_target].raddr) >> 6;             //in fact this is useless
            elo1 = ((int)pte_L2p[swap_target].raddr + PAGE_SIZE) >> 6; //in fact this is useless
            elo0 |= (2 << 3) | (1 << 2) | (0 << 1) | (0);
            elo1 |= (2 << 3) | (1 << 2) | (0 << 1) | (0);
            update_tlb(ehi, elo0, elo1, index); //
        }
    }

    //TODO: sth is wrong, use this for test
    //Just reflush the ******* TLB
    {
        int k = 0;
        for (k = 0; k < 32; k++)
        {
            update_tlb(0, 0, 0, k); //
        }
    }

    // Add this page to write list, and get disk_addr.
    current_running->swap_request.valid = 1;
    current_running->swap_request.size = 16;
    current_running->swap_request.mem_addr = (void *)((uint32_t)0xa0000000 + (uint32_t)pte_L2p[swap_target].raddr);

    //

    if (!swapin) //just alloc new page
    {
        // panic("invalid swap in");
        current_running->swap_request.disk_addr = alloc_disk(16);
        pte_L2p[swap_target].disk_addr = current_running->swap_request.disk_addr;
        do_semaphore_down(&swap_sleep_sem);
        // printk("pte_L2p: %x swap_target:%x\n",pte_L2p,swap_target);
        // printk("pte_L2p[swap_target].raddr: %x\n",pte_L2p[swap_target].raddr);
        return pte_L2p[swap_target].raddr;
    }
    else //swap in and swap out
    {
        if (swapin->disk_addr != 0)
        {
            current_running->swap_request.disk_addr = swapin->disk_addr;
        }
        else
        {
            current_running->swap_request.disk_addr = alloc_disk(16);
        }
        swapin->raddr = pte_L2p[swap_target].raddr;
        swapin->inmem = 1;
        pte_L2p[swap_target].disk_addr = current_running->swap_request.disk_addr;
        // block and wait for another proc. (use wait signal)
        do_semaphore_down(&swap_sleep_sem);
        return swapin->raddr;
    }
}

void do_TLB_Refill()
{
    //TODO choose index
    // printk("TLB refill\n");
    int vaddr = get_CP0_BADVADDR();
    int ehi = get_CP0_BADVADDR();
    ehi = ehi >> 13;
    ehi = ehi << 13;
    ehi |= (current_running->pid & 0xff);
    do_tlbp();
    unsigned int tlb_index = get_CP0_INDEX();
    int l1_index = (vaddr & 0xffe00000) >> 21;
    int l2_index = (vaddr & 0x001fe000) >> 13;
    // vt100_move_cursor(1,9);
    // printk("l1_index:%d l2_index:%d tlb_index:%x\n", l1_index, l2_index, tlb_index);
    if (tlb_index >= 64) //INDEX 31 = 1
    {
        //Now use FIFO
        tlb_index = (tlb_clock++) % 32; //It seems that the last 32 terms in tlb works differently on borad and on qemu.
        //TODO choose tlb index
    }

    if (!current_running->pte_L1p[l1_index].setuped)
    //l2 page table has not been setuped.
    {
        pte_L2 *L2_addr = 0;
        if (!(current_running->pte_L2_count < MAX_L2_PER_PROC))
        // L2 page table switch
        {
            L2_addr = (pte_L2 *)do_L2_swap(0);
            // panic("L2 page table need switch (not setuped)");
            //TODO
            // printk("111:%x",L2_addr);
        }

        {
            //build new L2 page table
            int L2_inmem_num = current_running->pte_L2_clock % 4;
            current_running->pte_L2_clock++;
            current_running->pte_L2_count++;
            if (L2_addr == 0)
            {
                L2_addr = (pte_L2 *)&((current_running->pte_L2p)[L2_inmem_num]);
            }

            int i = 0;

            // for (i = 0; i++; i < 256)
            // {
            //     L2_addr[i].setuped = 0;
            //     L2_addr[i].inmem = 0;
            //     L2_addr[i].R=0;
            //     L2_addr[i].swap_cnt = 0;
            //     L2_addr[i].disk_addr = 0;
            //     L2_addr[i].raddr = 0;
            // }

            for (i = 0; i < 256; i++)
            {
                L2_addr[i].setuped = 0;
                L2_addr[i].inmem = 0;
                L2_addr[i].R = 0;
                L2_addr[i].swap_cnt = 0;
                L2_addr[i].disk_addr = 0;
                L2_addr[i].raddr = 0;
                L2_addr[i].l1_index = l1_index;
            }

            // link new L2 page table to L1
            current_running->pte_L1p[l1_index].setuped = 1;
            current_running->pte_L1p[l1_index].inmem = 1;
            current_running->pte_L1p[l1_index].addr = L2_addr;
            current_running->pte_L1p[l1_index].disk_addr = 0;
            // printk("build new L2 page table %x\n",L2_addr );
        }
    }

    if (!current_running->pte_L1p[l1_index].inmem)
    //l2 page table not in memory.
    {
        current_running->pte_L1p[l1_index].addr = (pte_L2 *)do_L2_swap(&current_running->pte_L1p[l1_index]);
        // panic("L2 page table need switch (not in mem)");
    }

    pte_L2 *l2 = current_running->pte_L1p[l1_index].addr;
    if (l2[l2_index].setuped)
    {
        if (l2[l2_index].inmem) //valid
        {
            //just continue
        }
        else //not in mem
        {
            //TODO PAGE SWITCH
            // panic("Page not in mem.");
            l2[l2_index].raddr = do_swap(&l2[l2_index]); //TODO: swap in
            l2[l2_index].inmem = 1;
            l2[l2_index].R = 1;
        }
    }
    else //this l2 vaddr first used.
    {
        void *raddr;
        //alloc_page() return 0 if failed
        if (!(raddr = alloc_page())) //alloc_page failed
        {
            raddr = do_swap(0); //TODO: swap out
            // panic("do_swap (L2 fst use)");
            // printk("raddr = do_swap(0): %x\n",raddr);
        }
        (l2[l2_index]).setuped = 1;
        (l2[l2_index]).inmem = 1;
        (l2[l2_index]).R = 1;
        (l2[l2_index]).raddr = (void *)raddr;
        (l2[l2_index]).disk_addr = 0;
        (l2[l2_index]).l1_index = l1_index;
    }
    uint32_t elo0, elo1;
    elo0 = ((int)l2[l2_index].raddr) >> 6;
    elo1 = ((int)l2[l2_index].raddr + PAGE_SIZE) >> 6;
    elo0 |= (2 << 3) | (1 << 2) | (1 << 1) | (0);
    elo1 |= (2 << 3) | (1 << 2) | (1 << 1) | (0);
    vt100_move_cursor(1, 10);
    printk("write_tlb: ehi:%x, elo0:%x, elo1:%x, index:%x, raddr:%x\n", ehi, elo0, elo1, tlb_index, l2[l2_index].raddr);
    update_tlb(ehi, elo0, elo1, tlb_index); //TODO
    printk("update tlb finished\n");
    return;
}

void mod_helper(void)
{
    panic("VADDR ILLEGAL MOD");
}

void tlb_helper(void)
{
    // printk("\nIn tlb_helper.\n");
    // tlb_info();

    do_TLB_Refill();
}

// Page Alloc Operations //--------------------------------
void *init_page_stack()
{
    int addr_now = MEM_UPPER_BOUND;
    while (addr_now > MEM_BASE)
    {
        addr_now -= PAGE_SIZE << 1;
        free_page((void *)addr_now);
    }
}

void *alloc_page()
{
    if (free_mem_page_stack_point)
    {
        return free_mem_page[--free_mem_page_stack_point];
    }
    else //no free mem_page remains
    {
        return 0;
    }
}

void *free_page(void *paddr)
{
    free_mem_page[free_mem_page_stack_point++] = paddr;
}

// VM deamon proc //----------------------------------

void deamon_vm(void)
{
    //Init
    sys_semaphore_init(&swap_sleep_sem, 0);
    //sth went wrong!!! TODO
    while (1)
    {
        int h;
        sys_move_cursor(1, 14);
        printf("Deamon vm running. (%d)", h++);
        if (swap_sleep_sem.queue.head) //not empty
        {
            //do swap
            swap_request_t *request = &((pcb_t *)swap_sleep_sem.queue.head)->swap_request; //todo
            // void	sdread(unsigned	char	*buf,	unsigned	int	base,	int	n)
            // void sdwrite(unsigned	int	base,	int	n,	unsigned	char	*buf)
            if (!request->valid)
                panic("Invalid swap operation.");
            int i;
            for (i = 0; i < request->size; i++)
            {
                //sdread
                // disable_interrupt();
                // Have problem
                // printk("sdread:%x, %x, %x\n",swap_buffer, 0, 512);
                // sdread(swap_buffer, 0, 512);
                // ((void (*) (void*,int,int))(0x8007b1cc))(&swap_buffer, request->disk_addr + 512 * i, 512);
                // enable_interrupt();

                // sdread(swap_buffer, request->disk_addr + 512 * i, 512);
                // sdwrite((uint32_t)request->mem_addr + 512 * i, request->disk_addr + 512 * i, 512);

                // printk("sdread:%x, %x, %x\n", swap_buffer, request->disk_addr + 512 * i, 512);
                vdiskread((unsigned char *)swap_buffer, request->disk_addr + 512 * i, 512);
                // printk("sdwrite:%x, %x, %x\n", (uint32_t)request->mem_addr + 512 * i,
                //    request->disk_addr + 512 * i, 512);
                vdiskwrite((unsigned char *)request->mem_addr + 512 * i, request->disk_addr + 512 * i, 512);
                // printk("memcpy:%x, %x, %x\n", (void *)((uint32_t)request->mem_addr + 512 * i), (void *)swap_buffer, 512),
                memcpy((void *)((uint32_t)request->mem_addr + 512 * i), (void *)swap_buffer, 512);
            }
            request->valid = 0;
            // printk("\nswap deamon finished job.\n");
            sys_semaphore_up(&swap_sleep_sem);
        }
    }
}

// Disk Regulation //-------------------------------

int disk_init()
{
    disk_addr = SWAP_BASE;
}

#define VM_MEM_UPPERBOUND 2*SWAP_BASE

int alloc_disk(int sectors)
{
    int tmp = disk_addr;
    disk_addr += sectors * 512;
    os_assert(tmp<VM_MEM_UPPERBOUND);
    return tmp;
}

void do_TLB_init()
{
    int i;
    for (i = 0; i < 32; i++)
    {
        // update_tlb(0x00000001+2*i*0x1000,0x40000+2*i*0x1000+0x16,0x40000+2*i*0x1000+0x1000+0x16,i);
    }
}

// Clock Algorithm //--------------------------------

// #define CLOCK_SIZE 256*4
// int clock_point[16];
// #define next_clock(clock) ((clock==CLOCK_SIZE)?0:clock++)

int next_clock(int clock)
{
    clock++;
    if (clock == CLOCK_SIZE)
        return 0;
    return clock;
}

int clock_findnext()
{
    // @notused param L2start The base addr of L2 page table for current proc
    pte_L2 *L2start = (pte_L2 *)current_running->pte_L2p;
    current_running->clock_point;
    int dbg_cnt = 0;
    while (dbg_cnt++ < (3 * CLOCK_SIZE))
    {
        pte_L2 *p = &L2start[current_running->clock_point];
        if (p->setuped)
        {
            if (p->inmem)
            {
                if (p->R)
                {
                    p->R = 0;
                }
                else //!p->R
                {
                    //find result
                    p->R = 1;
                    return current_running->clock_point;
                }
            }
            else //not in mem
            {
                //just skip
            }
        }
        else //not setuped
        {
        }
        current_running->clock_point = next_clock(current_running->clock_point);
    }
    panic("Clock Algorithm Failure");
}

// For Debug //-------------------------------
void wrong_addr()
{
    int baddr = get_CP0_BADVADDR();
    int epc = get_CP0_EPC();
    vt100_move_cursor(1, 3);
    printk("[WRONG ADDR]: BADADDR:%x\n", (baddr));
    printk("[WRONG ADDR]: EPC:%x\n", (epc));
    // current_running->user_context.cp0_epc+=4;
    panic("WRONG ADDR");
    return;
}

void L2_dump()
{
    printf("Dump L2:\n");
    int i = 0;
    for (i = 0; i < 2048; i++)
    {
        if (current_running->pte_L1p[i].setuped)
        {
            printf("| %d  %d  0x%x  0x%x  \n", i, current_running->pte_L1p[i].inmem, current_running->pte_L1p[i].addr, current_running->pte_L1p[i].disk_addr);
        }
    }
    return;
}
