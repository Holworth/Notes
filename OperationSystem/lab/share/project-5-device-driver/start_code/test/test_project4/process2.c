#include "sched.h"
#include "stdio.h"
#include "syscall.h"
#include "time.h"
#include "screen.h"
#include "test4.h"

#define RW_TIMES 2

int rand()
{
	int current_time = time_elapsed;
	return current_time % 100000;
}

static void enable_interrupt()
{
	uint32_t cp0_status = get_cp0_status();
	cp0_status |= 0x01;
	set_cp0_status(cp0_status);
}

/*static void disable_interrupt()
{
    uint32_t cp0_status = get_cp0_status();
    cp0_status &= 0xfffffffe;
    set_cp0_status(cp0_status);
}


static char read_uart_ch(void)
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
*/

void rw_task1(void)
{
	int mem1, mem2 = 0;
	int curs = 0;
	int memory[RW_TIMES];
	int i = 0;
	int m;
	for (i = 0; i < RW_TIMES; i++)
	{
		sys_move_cursor(1, curs + i);
		gethex(&mem1);
		// mem1=0;
		sys_move_cursor(1, curs + i);
		memory[i] = mem2 = rand();
		*(int *)mem1 = mem2;
		printk("Write: 0x%x, %d", mem1, mem2);
	}
	curs = RW_TIMES;
	for (i = 0; i < RW_TIMES; i++)
	{
		sys_move_cursor(1, curs + i);
		gethex(&mem1);
		// mem1=0;
		sys_move_cursor(1, curs + i);
		memory[i + RW_TIMES] = *(int *)mem1;
		if (memory[i + RW_TIMES] == memory[i])
			printf("Read succeed: %d", memory[i + RW_TIMES]);
		else
			printf("Read error: %d", memory[i + RW_TIMES]);
	}
	// sys_exit();
	m = get_cp0_status();
	printf("0x%x\n", m);
	// sys_exit();
	// enable_interrupt();
	while (1)
	{
		sys_move_cursor(1, 13);
		printf("Process2: Test fin.\n");
	}
	//Only input address.
	//Achieving input r/w command is recommended but not required.
}

void pressure_test(void)
{
	uint32_t i = 0x0;
	uint32_t j = 0x0;
	int clk = 0;
	for (i = 0; i < 0x70000000; i += 4)
	{
		(*(int *)i) = i+1;
		sys_move_cursor(1, 1);
		printf("Pressure_test1: now write 0x%x\n", i+1);
		if (clk == 0)
		{
			clk = 1;
		}
		else
		{
			clk = 0;
			sys_move_cursor(1, 2);
			printf("Pressure_test2: now read 0x%x, should be 0x%x\n", (*(int *)(j)),(j)+1);
			if(((*(int *)(j)))!=((j)+1)){while(1);}
			j += 4;
		}
	}
	while(1);
}

void pressure_test2(void)
{
	uint32_t i = 0x0;
	uint32_t j = 0x0;
	int clk = 0;
	for (i = 0; i < 0x70000000; i += 4)
	{
		(*(int *)i) = i+2;
		sys_move_cursor(1, 3);
		printf("Pressure_test2: now write 0x%x\n", i+2);
		if (clk == 0)
		{
			clk = 1;
		}
		else
		{
			clk = 0;
			sys_move_cursor(1, 4);
			printf("Pressure_test2: now read 0x%x, should be 0x%x\n", (*(int *)(j)),(j)+2);
			if(((*(int *)(j)))!=((j)+2)){while(1);}
			j += 4;
		}
	}
	while(1);
}

void mem_swap_test(void)
{
	uint32_t i = 0x0;
	uint32_t j = 0x0;
	int clk = 0;
	for (i = 0; i < 0x70000000; i += 0x1000)
	{
		(*(int *)i) = i+3;
		sys_move_cursor(1, 5);
		printf("Mem_swap_test: now write 0x%x\n", i+3);
		if (clk == 0)
		{
			clk = 1;
		}
		else
		{
			clk = 0;
			sys_move_cursor(1, 6);
			printf("Mem_swap_test: now read 0x%x, should be 0x%x\n", (*(int *)(j)),(j)+3);
			if(((*(int *)(j)))!=((j)+3)){while(1);}
			j += 0x1000;
		}
	}
	while(1);
}
