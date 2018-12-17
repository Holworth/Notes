#ifndef INCLUDE_TEST_NET_H_
#define INCLUDE_TEST_NET_H_
#include "queue.h"

// #define TEST_REGS1
#define TEST_REGS2
//#define TEST_REGS3

extern queue_t recv_block_queue;
#define EPT_ARP 0x0608 /* type: ARP */

static void init_data(uint32_t *addr);
//void phy_regs_task(void);
#if 1
void phy_regs_task1(void);
void phy_regs_task2(void);
void phy_regs_task3(void);
#endif
static void init_mac(void);
//extern uint32_t recv_flag[PNUM];
//extern uint32_t ch_flag ;

// queue_t recv_block_queue;
// desc_t *send_desc;
// desc_t *receive_desc;
// uint32_t cnt = 1; //record the time of iqr_mac
// //uint32_t buffer[PSIZE] = {0x00040045, 0x00000100, 0x5d911120, 0x0101a8c0, 0xfb0000e0, 0xe914e914, 0x00000801,0x45000400, 0x00010000, 0x2011915d, 0xc0a80101, 0xe00000fb, 0x14e914e9, 0x01080000};
// uint32_t buffer[PSIZE] = {0xffffffff, 0x5500ffff, 0xf77db57d, 0x00450008, 0x0000d400, 0x11ff0040, 0xa8c073d8, 0x00e00101, 0xe914fb00, 0x0004e914, 0x0000, 0x005e0001, 0x2300fb00, 0x84b7f28b, 0x00450008, 0x0000d400, 0x11ff0040, 0xa8c073d8, 0x00e00101, 0xe914fb00, 0x0801e914, 0x0000};


#endif