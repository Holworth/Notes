#ifndef INCLUDE_MM_H_
#define INCLUDE_MM_H_

#include "type.h"

#define TLB_ENTRY_NUMBER 64

void do_TLB_Refill();
void do_page_fault();

#endif
