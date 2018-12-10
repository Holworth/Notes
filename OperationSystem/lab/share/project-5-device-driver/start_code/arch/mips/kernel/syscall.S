#include "asm.h"

#extern int invoke_syscall(int, int, int, int);
LEAF(invoke_syscall)
    // syscall entry
    #or v0, a0, a0
    #or a0, a1, a1
    #or a1, a2, a2
    #or a2, a3, a3
    syscall
    jr ra
END(invoke_syscall)