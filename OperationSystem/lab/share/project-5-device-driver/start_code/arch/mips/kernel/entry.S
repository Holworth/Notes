#include "asm.h"

msg2: .ascii "> [INFO] ASM critical point.\n"

.equ    KERNEL, 0
.equ    USER,   156

.macro STI
.endm

.macro CLI
.endm

.macro MLOOP
    mloop:
    j  mloop
.endm

.macro INTERRUPT_ENABLE
    mfc0    k0, CP0_STATUS
    li      k1, 0x00000001
    or      k0, k0, k1
    mtc0    k1, CP0_STATUS
.endm

.macro INTERRUPT_ENABLE_AND_ERET
    mfc0    k0, CP0_STATUS
    li      k1, 0x10008003
    #li      k1, 0x1000fc03
    #or      k0, k0, k1
    mtc0    k1, CP0_STATUS
    eret
.endm

.macro INTERRUPT_DISABLE
#   WARNNING: TIME_IRQ NEED CP0_STATUS, DO NOT SET IT AS 0!!!
#   mtc0    zero, CP0_STATUS
    mfc0    k0, CP0_STATUS
    li      k1, 0xFFFFFFFE
    and     k0, k1
    mtc0    k0, CP0_STATUS
    nop

.endm

.macro GET_EPC
    # for debug
    mfc0    k0, CP0_EPC
    nop
.endm

.macro EPC_PLUS_4
    mfc0    k0, CP0_EPC
    addi    k0, 4
    mtc0    k0, CP0_EPC
    nop
.endm

.macro GET_STATUS
    mfc0    k0, CP0_STATUS
    nop
.endm

.macro RESET_CLOCK_INT
    li      k1, 150000
    mtc0    k1, CP0_COMPARE
    mtc0    $0, CP0_COUNT
.endm

LEAF(reset_clock_int)
    li      k1, 150000
    mtc0    k1, CP0_COMPARE
    mtc0    $0, CP0_COUNT
END(reset_clock_int)

LEAF(asm_cp)
	la  k0, msg2
	jal 0x8007b980
	nop
END(asm_cp)

LEAF(asm_start)
    mtc0    zero, CP0_STATUS
    mtc0    zero, CP0_WATCHLO
    mtc0    zero, CP0_WATCHHI

    mfc0    t0, CP0_CONFIG
    and     t0, ~0x7
    ori     t0, 0x2
    mtc0    t0, CP0_CONFIG
    
    jr  ra
END(asm_start)

LEAF(get_cp0_status)
    mfc0    v0, CP0_STATUS
    jr  ra
END(get_cp0_status)

LEAF(set_cp0_status)
    mtc0    a0, CP0_STATUS
    jr  ra
END(set_cp0_status)

LEAF(set_fake_scene)
    la  v0, fake_scene
    nop
    jr  ra
END(set_fake_scene)


LEAF(set_CP0_COMPARE)
    mtc0    a0, CP0_COMPARE
    jr  ra
END(set_CP0_COMPARE)

LEAF(set_CP0_COUNT)
    mtc0    a0, CP0_COUNT
    jr  ra
END(set_CP0_COUNT)

LEAF(set_SP)
    move sp, v0
    jr  ra
    nop
END(set_SP)

//get_CP0_ENTRYHI
LEAF(get_CP0_ENTRYHI)
    mfc0 v0, CP0_ENTRYHI
    nop
    jr ra
    nop
END(get_CP0_ENTRYHI)

//set_CP0_ENTRYHI
LEAF(set_CP0_ENTRYHI)
    mtc0 a0, CP0_ENTRYHI
    nop
    jr ra
    nop
END(set_CP0_ENTRYHI)

//get_CP0_EntryHI
LEAF(get_CP0_RANDOM)
    mfc0 v0, CP0_RANDOM
    nop
    jr ra
    nop
END(get_CP0_RANDOM)

// get_CP0_BADVADDR()
LEAF(get_CP0_BADVADDR)
    mfc0 v0, CP0_BADVADDR
    nop
    jr ra
    nop
END(get_CP0_BADVADDR)

// get_CP0_INDEX()
LEAF(get_CP0_INDEX)
    mfc0 v0, CP0_INDEX
    nop
    jr ra
    nop
END(get_CP0_INDEX)

// set_CP0_INDEX()
LEAF(set_CP0_INDEX)
    mtc0 a0, CP0_INDEX
    nop
    jr ra
    nop
END(set_CP0_INDEX)

//get_CP0_EPC()
LEAF(get_CP0_EPC)
    mfc0 v0, CP0_EPC
    nop
    jr ra
    nop
END(get_CP0_EPC)

//set_CP0_EPC()
LEAF(set_CP0_EPC)
    mtc0 a0, CP0_EPC
    nop
    jr ra
    nop
END(set_CP0_EPC)

//get_CP0_CAUSE()
LEAF(get_CP0_CAUSE)
    mfc0 v0, CP0_CAUSE
    nop
    jr ra
    nop
END(get_CP0_CAUSE)

//do_tlbp()
LEAF(do_tlbp)
    tlbp
    nop
    jr ra
    nop
END(do_tlbp)

//update_tlb()
LEAF(update_tlb)
    mtc0 a0, CP0_ENTRYHI
    nop
    mtc0 a1, CP0_ENTRYLO0
    nop
    mtc0 a2, CP0_ENTRYLO1
    nop
    mtc0 a3, CP0_INDEX
    nop
    li k1, 0
    mtc0 k1,CP0_PAGEMASK
    nop
    tlbwi
    jr ra
    nop
END(update_tlb)


LEAF(interrupt_enable_init)
#TODO: FIXIT
    mfc0    k0, CP0_STATUS
    ori     k0, 0x00008001
    mtc0    k0, CP0_STATUS
    nop
    jr  ra
END(interrupt_enable_init)

LEAF(interrupt_enable_all)
#TODO: FIXIT
    mfc0    k0, CP0_STATUS
    ori     k0, 0x0000fc01
    mtc0    k0, CP0_STATUS
    nop
    jr  ra
END(interrupt_enable_all)

LEAF(interrupt_enable)
    mfc0  k0, CP0_STATUS
    ori   k0, 0x1
    mtc0  k0, CP0_STATUS
    nop
    jr  ra
END(interrupt_enable)

LEAF(interrupt_disable)
    INTERRUPT_DISABLE
    nop
    jr  ra
END(interrupt_disable)

# reset CP0_COMPARE & CP0_COUNT register
LEAF(reset_count_compare)
    li      k0, 0x10000
    li      k1, 0x0
    mtc0    k0, CP0_COMPARE
    mtc0    k1, CP0_COUNT
    nop
    jr  ra
END(reset_count_compare)

LEAF(switch_to_kstack)
    lw k0, current_running
    lw $29, OFFSET_KBASE(k0)
    jr ra
    nop
END(switch_to_kstack)


.macro SAVE_CONTEXT offset
    // TODO save context
    lw k0, current_running
    addi k0, \offset
    sw $0, OFFSET_REG0(k0)
    sw $1, OFFSET_REG1(k0)
    sw $2, OFFSET_REG2(k0)
    sw $3, OFFSET_REG3(k0)
    sw $4, OFFSET_REG4(k0)
    sw $5, OFFSET_REG5(k0)
    sw $6, OFFSET_REG6(k0)
    sw $7, OFFSET_REG7(k0)
    sw $8, OFFSET_REG8(k0)
    sw $9, OFFSET_REG9(k0)
    sw $10, OFFSET_REG10(k0)
    sw $11, OFFSET_REG11(k0)
    sw $12, OFFSET_REG12(k0)
    sw $13, OFFSET_REG13(k0)
    sw $14, OFFSET_REG14(k0)
    sw $15, OFFSET_REG15(k0)
    sw $16, OFFSET_REG16(k0)
    sw $17, OFFSET_REG17(k0)
    sw $18, OFFSET_REG18(k0)
    sw $19, OFFSET_REG19(k0)
    sw $20, OFFSET_REG20(k0)
    sw $21, OFFSET_REG21(k0)
    sw $22, OFFSET_REG22(k0)
    sw $23, OFFSET_REG23(k0)
    sw $24, OFFSET_REG24(k0)
    sw $25, OFFSET_REG25(k0)


    sw $28, OFFSET_REG28(k0)
    sw $29, OFFSET_REG29(k0)
    sw $30, OFFSET_REG30(k0)
    sw $31, OFFSET_REG31(k0)

    mfc0 k1, CP0_STATUS
    nop
    sw k1, OFFSET_STATUS(k0)

    mfhi k1
    sw k1, OFFSET_HI(k0)

    mflo k1
    sw k1, OFFSET_LO(k0)

    mfc0 k1, CP0_BADVADDR
    nop
    sw k1, OFFSET_BADVADDR(k0)

    mfc0 k1, CP0_CAUSE
    nop
    sw k1, OFFSET_CAUSE(k0)
    
    mfc0 k1, CP0_EPC
    nop
    sw k1, OFFSET_EPC(k0)
    
    nop
.endm

.macro RESTORE_CONTEXT offset
    // TODO restore context
    lw k0, current_running
    addi k0, \offset
    lw $0, OFFSET_REG0(k0)
    lw $1, OFFSET_REG1(k0)
    lw $2, OFFSET_REG2(k0)
    lw $3, OFFSET_REG3(k0)
    lw $4, OFFSET_REG4(k0)
    lw $5, OFFSET_REG5(k0)
    lw $6, OFFSET_REG6(k0)
    lw $7, OFFSET_REG7(k0)
    lw $8, OFFSET_REG8(k0)
    lw $9, OFFSET_REG9(k0)
    lw $10, OFFSET_REG10(k0)
    lw $11, OFFSET_REG11(k0)
    lw $12, OFFSET_REG12(k0)
    lw $13, OFFSET_REG13(k0)
    lw $14, OFFSET_REG14(k0)
    lw $15, OFFSET_REG15(k0)
    lw $16, OFFSET_REG16(k0)
    lw $17, OFFSET_REG17(k0)
    lw $18, OFFSET_REG18(k0)
    lw $19, OFFSET_REG19(k0)
    lw $20, OFFSET_REG20(k0)
    lw $21, OFFSET_REG21(k0)
    lw $22, OFFSET_REG22(k0)
    lw $23, OFFSET_REG23(k0)
    lw $24, OFFSET_REG24(k0)
    lw $25, OFFSET_REG25(k0)


    lw $28, OFFSET_REG28(k0)
    lw $29, OFFSET_REG29(k0)
    lw $30, OFFSET_REG30(k0)
    lw $31, OFFSET_REG31(k0)


    lw k1, OFFSET_HI(k0)
    mthi k1

    lw k1, OFFSET_LO(k0)
    mtlo k1

    lw k1, OFFSET_BADVADDR(k0)
    mtc0 k1, CP0_BADVADDR
    nop

    lw k1, OFFSET_CAUSE(k0)
    mtc0 k1, CP0_CAUSE
    nop
    
    mtc0 zero, CP0_STATUS
    lw k1, OFFSET_EPC(k0)
    mtc0 k1, CP0_EPC
    nop
####################################2333333
    lw k1, OFFSET_STATUS(k0)
    mtc0 k1, CP0_STATUS
    nop
#########################################23
.endm

.macro SYSCALL_RESTORE_CONTEXT offset
    // TODO restore context
    lw k0, current_running
    addi k0, \offset
    lw $0, OFFSET_REG0(k0)
    lw $1, OFFSET_REG1(k0)
    #lw $2, OFFSET_REG2(k0) #v0
    lw $3, OFFSET_REG3(k0)
    lw $4, OFFSET_REG4(k0)
    lw $5, OFFSET_REG5(k0)
    lw $6, OFFSET_REG6(k0)
    lw $7, OFFSET_REG7(k0)
    lw $8, OFFSET_REG8(k0)
    lw $9, OFFSET_REG9(k0)
    lw $10, OFFSET_REG10(k0)
    lw $11, OFFSET_REG11(k0)
    lw $12, OFFSET_REG12(k0)
    lw $13, OFFSET_REG13(k0)
    lw $14, OFFSET_REG14(k0)
    lw $15, OFFSET_REG15(k0)
    lw $16, OFFSET_REG16(k0)
    lw $17, OFFSET_REG17(k0)
    lw $18, OFFSET_REG18(k0)
    lw $19, OFFSET_REG19(k0)
    lw $20, OFFSET_REG20(k0)
    lw $21, OFFSET_REG21(k0)
    lw $22, OFFSET_REG22(k0)
    lw $23, OFFSET_REG23(k0)
    lw $24, OFFSET_REG24(k0)
    lw $25, OFFSET_REG25(k0)


    lw $28, OFFSET_REG28(k0)
    lw $29, OFFSET_REG29(k0)
    lw $30, OFFSET_REG30(k0)
    lw $31, OFFSET_REG31(k0)


    lw k1, OFFSET_HI(k0)
    mthi k1

    lw k1, OFFSET_LO(k0)
    mtlo k1

    lw k1, OFFSET_BADVADDR(k0)
    mtc0 k1, CP0_BADVADDR
    nop

    lw k1, OFFSET_CAUSE(k0)
    mtc0 k1, CP0_CAUSE
    nop
    
    mtc0 zero, CP0_STATUS
    lw k1, OFFSET_EPC(k0)
    mtc0 k1, CP0_EPC
    nop
####################################2333333
    lw k1, OFFSET_STATUS(k0)
    mtc0 k1, CP0_STATUS
    nop
#########################################23
.endm

# NESTED(init_scheduler, 0, ra)
#     INTERRUPT_DISABLE
#     SAVE_CONTEXT(KERNEL)
#     jal     scheduler
#     RESTORE_CONTEXT(KERNEL)
#     INTERRUPT_ENABLE
#     jr      ra
# END(init_scheduler)

NESTED(do_scheduler, 0, ra)
# Used in kernel mode
    SAVE_CONTEXT(KERNEL)
    jal     scheduler
    RESTORE_CONTEXT(KERNEL)
    jr      ra
END(do_scheduler)

# NESTED(preemptive_scheduler, 0, ra)
#     INTERRUPT_DISABLE
#     jal     scheduler
#     RESTORE_CONTEXT(KERNEL)
#     INTERRUPT_ENABLE
#     GET_STATUS
#     #SET_EXL_0
#     GET_EPC
#     eret
# END(preemptive_scheduler)

.global exception_handler_begin
.global exception_handler_end

NESTED(exception_handler_entry, 0, sp)   
exception_handler_begin:
    // Leve2 exception Handler.
    //主要完成例外处理入口相关内容：关中断、保存现场、根据 CP0_CAUSE 寄存器的例外触发状态跳转到中断处理函数（handle_int）
    // DONE close interrupt
    INTERRUPT_DISABLE
    SAVE_CONTEXT(USER)
    jal switch_to_kstack
    // jmp exception_handler[i] which decided by CP0_CAUSE //TODO FIXIT
    mfc0 k0, CP0_CAUSE
    andi k0, 0x0000007C
    la   k1, exception_handler
    add  k0, k0, k1
    lw   k1, (k0)
    jalr  k1
    nop
exception_handler_end:
END(exception_handler_entry)

.global TLBexception_handler_begin
.global TLBexception_handler_end

NESTED(TLBexception_handler_entry, 0, sp)
TLBexception_handler_begin:
	//TLB exception entry
	//jmp exception_handler[i] which decided by CP0_CAUSE
    li k0, 0x80000180
    j k0
    nop
    //SAVE_CONTEXT(USER)
    //jal     tlb_info
    //nop
    //jal     do_TLB_Refill
    //nop
    //RESTORE_CONTEXT(USER)

    //eret
TLBexception_handler_end:
END(TLBexception_handler_entry)

NESTED(handle_int, 0, sp)
    // interrupt handler
    // Leve3 exception Handler.
    //跳转到中断向量处理函数（interrupt_helper 方法）、恢复现场、开中断
    //准备参数(uint32_t status, uint32_t cause)
    mfc0 a0, CP0_STATUS
    mfc0 a1, CP0_CAUSE
    nop
    addiu sp,sp,-8
    jal interrupt_helper
    addiu sp,sp,8
    nop
    #RESTORE_CONTEXT(KERNEL)#??
    RESTORE_CONTEXT(USER)#???
    GET_STATUS
    GET_EPC
    RESET_CLOCK_INT
    #INTERRUPT_ENABLE_AND_ERET
    eret
    nop
    #jr  ra
END(handle_int)

NESTED(handle_syscall, 0, sp)
    // system call handler
    #or a3, a2, a2
    #or a2, a1, a1
    #or a1, a0, a0
    #or a1, v0, v0
    jal system_call_helper
    nop
    SYSCALL_RESTORE_CONTEXT(USER)
    EPC_PLUS_4
    GET_STATUS
    GET_EPC
    #TODO
    INTERRUPT_ENABLE_AND_ERET
    eret
    nop
END(handle_syscall)

NESTED(handle_tlb, 0, sp)
    // system call handler
    #or a3, a2, a2
    #or a2, a1, a1
    #or a1, a0, a0
    #or a1, v0, v0
    jal tlb_helper
    nop
    RESTORE_CONTEXT(USER)
    INTERRUPT_ENABLE_AND_ERET
    #eret
    nop
END(handle_tlb)

NESTED(handle_mod, 0, sp)
    // system call handler
    #or a3, a2, a2
    #or a2, a1, a1
    #or a1, a0, a0
    #or a1, v0, v0
    jal mod_helper
    nop
    RESTORE_CONTEXT(USER)
    INTERRUPT_ENABLE_AND_ERET
    eret
END(handle_mod)

NESTED(handle_other, 0, sp)
    // other exception handler
    jal other_helper
    nop
    RESTORE_CONTEXT(USER)#???
    GET_STATUS
    GET_EPC
    #INTERRUPT_ENABLE_AND_ERET
    eret
END(handle_other)

NESTED(fake_scene, 0, sp)
    RESTORE_CONTEXT(USER)#???
    GET_STATUS
    GET_EPC
    RESET_CLOCK_INT
    #jal set_CP0_ENTRYHI_with_cpid
    nop
    INTERRUPT_ENABLE_AND_ERET
END(fake_scene)

NESTED(read_asm, 0, sp)
#	target position
#	li  $a0, 0xa0800200
#	data source
#	li  $a1, 0x00000200
# 	data size
#	li  $a2, 0x0000f000
	jal 0x8007b1cc
    nop
    jr ra
    nop
END(read_asm)
