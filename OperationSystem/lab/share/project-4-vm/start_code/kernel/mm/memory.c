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

void do_L2_swap(pte_L1 *pte_L1p)
{
    current_running->pte_L2_clock % 4;
}

void do_swap(int vaddr, pte_L2 *pte_L2p)
{
    // TODO
    // Choose a page to write to disk.
    int minfind = -1;
    {
        // pick the swap_cnt min one in l2 page table.
        // It is better to use a heap to imp it.
        // But I am lazy...
        int i;
        int min = 256;
        for (i = 0; i < 256; i++)
        {
            if (pte_L2p[i].inmem)
            {
                if (pte_L2p[i].swap_cnt < min)
                {
                    min = pte_L2p[i].swap_cnt;
                    minfind = i;
                }
            }
        }
        //then swap minfind
    }

    // Set inmem to 0.
    pte_L2p[minfind].inmem = 0;

    // Set inmem in tlb to 0. (if have)
    // set_tlb_valid_0(vaddr, current_running->pid);
    {
        uint32_t ehi = vaddr >> 13;
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
            elo0 = ((int)pte_L2p[minfind].raddr) >> 6;
            elo1 = ((int)pte_L2p[minfind].raddr + PAGE_SIZE) >> 6;
            elo0 |= (2 << 3) | (1 << 2) | (0 << 1) | (0);
            elo1 |= (2 << 3) | (1 << 2) | (0 << 1) | (0);
            update_tlb(ehi, elo0, elo1, index); //
        }
    }
    // Add this page to write list, and get disk_addr. (use lock to protect)
    current_running->swap_request.valid = 1;
    current_running->swap_request.size = 16;
    current_running->swap_request.mem_addr = pte_L2p[minfind].raddr;
    if (pte_L2p[minfind].disk_addr != 0)
    {
        current_running->swap_request.disk_addr = pte_L2p[minfind].disk_addr;
    }
    else
    {
        current_running->swap_request.disk_addr = alloc_disk(16);
    }
    // block and wait for another proc. (use wait signal)
    sys_semaphore_down(&swap_sleep_sem);
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
        if (!(current_running->pte_L2_count < MAX_L2_PER_PROC))
        // L2 page table switch
        {
            do_L2_swap(0);
            panic("L2 page table need switch (not setuped)");
            //TODO
        }

        {
            //build new L2 page table
            int L2_inmem_num = current_running->pte_L2_clock % 4;
            current_running->pte_L2_clock++;
            current_running->pte_L2_count++;
            int i = 0;
            for (i = 0; i++; i < 256)
            {
                (current_running->pte_L2p)[L2_inmem_num][i].setuped = 0;
                (current_running->pte_L2p)[L2_inmem_num][i].inmem = 0;
                (current_running->pte_L2p)[L2_inmem_num][i].disk_addr = 0;
            }

            // link new L2 page table to L1
            current_running->pte_L1p[l1_index].setuped = 1;
            current_running->pte_L1p[l1_index].inmem = 1;
            current_running->pte_L1p[l1_index].addr = (pte_L2 *)&(current_running->pte_L2p)[L2_inmem_num];
            current_running->pte_L1p[l1_index].disk_addr = 0;
        }
    }

    if (!current_running->pte_L1p[l1_index].inmem)
    //l2 page table not in memory.
    {
        do_L2_swap(&current_running->pte_L1p[l1_index]);
        panic("L2 page table need switch (not in mem)");
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
            panic("Page not in mem.");
            do_swap(vaddr, &l2[l2_index]);
            l2[l2_index].inmem = 1;
        }
    }
    else //this l2 vaddr first used.
    {
        void *raddr;
        //alloc_page() return 0 if failed
        while (!(raddr = alloc_page())) //alloc_page failed
        {
            panic("do_swap (L2 fst use)");
            do_swap(vaddr, &l2[l2_index]); //TODO
        }
        (l2[l2_index]).setuped = 1;
        (l2[l2_index]).inmem = 1;
        (l2[l2_index]).raddr = (void *)raddr;
        (l2[l2_index]).disk_addr = 0;
    }
    uint32_t elo0, elo1;
    elo0 = ((int)l2[l2_index].raddr) >> 6;
    elo1 = ((int)l2[l2_index].raddr + PAGE_SIZE) >> 6;
    elo0 |= (2 << 3) | (1 << 2) | (1 << 1) | (0);
    elo1 |= (2 << 3) | (1 << 2) | (1 << 1) | (0);
    vt100_move_cursor(1, 10);
    printk("write_tlb: ehi:%x, elo0:%x, elo1:%x, index:%x\n", ehi, elo0, elo1, tlb_index);
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
                sdread(swap_buffer, request->disk_addr + 512 * i, 1);
                sdwrite((int)request->mem_addr + 512 * i, request->disk_addr, 1);
                memcpy((void *)((int)request->mem_addr + 512 * i), (void *)swap_buffer, 512);
            }
            request->valid = 0;
            sys_semaphore_up(&swap_sleep_sem);
        }
    }
}

// Disk Regulation //-------------------------------

int alloc_disk(int sectors)
{
    int tmp = disk_addr;
    disk_addr += sectors * 512;
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

// For Debug //-------------------------------
void wrong_addr()
{
    int baddr = get_CP0_BADVADDR();
    int epc = get_CP0_EPC();
    vt100_move_cursor(1, 3);
    printk("[WRONG ADDR]: BADADDR:%x\n", (baddr));
    printk("[WRONG ADDR]: EPC:%x\n", (epc));
    // current_running->user_context.cp0_epc+=4;
    while (1)
        ;
    panic("WRONG ADDR");
    return;
}