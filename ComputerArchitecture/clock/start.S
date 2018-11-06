#include <asm.h>
#include <regdef.h>
#include <ucas_cde.h>

#define ALARM 0
#define DEBUG 1

.macro RESET_COMPARE
# set compare
#if DEBUG
li  a0, 200
#else
li  a0, 25000000
#endif
mtc0 a0, CP0_COMPARE
nop
# enable interrupt
li  a0, 0x1000ff01
mtc0 a0, CP0_STATUS
nop
.endm

.macro WAITS waittime
    li    k0, waittime
    li    k1, 0
loop_wait:
    addiu k1, 1
    bne   k0, k1, loop_wait
    nop
.endm



##s0, number
##s1, number adress 
##s2, exception use
##s3, score
##s4, exception pc
	.set	noreorder
	.globl	_start
	.globl	start
	.globl	__main
_start:
start:

reset:

# clock
li  s0, 0x0 #s0 
li  s1, 0x0 #s1
li  s2, 0x0 #m0
li  s3, 0x0 #m1
li  s4, 0x0 #h0
li  s5, 0x0 #h1

li  s7, 0x0 #set_clock:1
li  s8, 0x0 #set_alarm:1
#   s7==s8==0 --> timer mode

# alarm
li  t0, 0x0 #s0
li  t1, 0x0 #s1
li  t2, 0x0 #m0
li  t3, 0x0 #m1
li  t4, 0x0 #h0
li  t5, 0x0 #h1

li  t6, 0x0 #alarm_enable:1|alarm_disable:0
li  t7, 0x0 #alarm_show time left
li  t8, 0x0 #alarm_show

RESET_COMPARE

timer_mode:
loop:
    b    loop
    nop


.org 0x380
    mfc0 a0, CP0_STATUS
    mfc0 a1, CP0_CAUSE
    li   a2, 0x00008000
    li   a3, 0x00000400
    or   a2,a2,a1
    or   a3,a3,a1
    bnez a2,time_int
    nop
    bnez a3,key_int
    nop
int_eret:
    eret
    nop

time_int:
    RESET_COMPARE
    nop
#time++
    addiu s0,s0,0x1
    jal   update_time
    nop
    jal   time_print
    nop

#if ALARM
    bne   s0,t0,noalarm
    nop
    bne   s1,t1,noalarm
    nop
    bne   s2,t2,noalarm
    nop
    bne   s3,t3,noalarm
    nop
    bne   s4,t4,noalarm
    nop
    bne   s5,t5,noalarm
    nop
    jal show_alarm
    nop
noalarm:
nop
#endif
    

#end interrupt
#make sure int in int works normally
    la    k0,timer_mode
    mtc0  k0,CP0_EPC
    nop
    eret


update_time:
#s0
    li    k0,10
    bne   s0,k0,3f
    nop
    addiu s1,s1,0x1
    and   s0,zero,zero
3:
#s1
    li    k0,6
    bne   s1,k0,3f
    nop
    addiu s2,s2,0x1
    and   s1,zero,zero
3:
#s2
    li    k0,10
    bne   s2,k0,3f
    nop
    addiu s3,s3,0x1
    and   s2,zero,zero
3:
#s3
    li    k0,6
    bne   s3,k0,3f
    nop
    addiu s4,s4,0x1
    and   s3,zero,zero
3:
#s4
    li    k1, 2
    beq   s5,k1,h2x
    nop
#h:0x, 1x
    li    k0,10
    bne   s4,k0,3f
    nop
    addiu s5,s5,0x1
    and   s4,zero,zero
    b     1f
#h:2x
h2x:
    li    k0,4
    bne   s4,k0,3f
    nop
    addiu s5,s5,0x1
    and   s4,zero,zero
1:
#s5
    li    k0,3
    bne   s5,k0,3f
    nop
    and   s5,zero,zero
3:
    nop
    jr ra
    nop

alarm_print:
    li    k0,0
    sll   k1,t0,0
    addu k0,k1
    sll   k1,t1,4
    addu k0,k1
    sll   k1,t2,8
    addu k0,k1
    sll   k1,t3,12
    addu k0,k1
    sll   k1,t4,16
    addu k0,k1
    sll   k1,t5,20
    addu k0,k1
    li    k1,NUM_ADDR
    sw    k0,0(k1)
    nop
    jr    ra
    nop

update_alarm:
#s0
    li    k0,10
    bne   t0,k0,3f
    nop
    addiu t1,t1,0x1
    and   t0,zero,zero
3:
#s1
    li    k0,6
    bne   t1,k0,3f
    nop
    addiu t2,t2,0x1
    and   t1,zero,zero
3:
#s2
    li    k0,10
    bne   t2,k0,3f
    nop
    addiu t3,t3,0x1
    and   t2,zero,zero
3:
#s3
    li    k0,6
    bne   t3,k0,3f
    nop
    addiu t4,t4,0x1
    and   t3,zero,zero
3:
#s4
    li    k1, 2
    beq   t5,k1,h2x
    nop
#h:0x, 1x
    li    k0,10
    bne   t4,k0,3f
    nop
    addiu t5,t5,0x1
    and   t4,zero,zero
    b     1f
#h:2x
h2x:
    li    k0,4
    bne   t4,k0,3f
    nop
    addiu t5,t5,0x1
    and   t4,zero,zero
1:
#s5
    li    k0,3
    bne   t5,k0,3f
    nop
    and   t5,zero,zero
3:
    nop
    jr ra
    nop


time_print:
    li    k0,0
    sll   k1,s0,0
    addu k0,k1
    sll   k1,s1,4
    addu k0,k1
    sll   k1,s2,8
    addu k0,k1
    sll   k1,s3,12
    addu k0,k1
    sll   k1,s4,16
    addu k0,k1
    sll   k1,s5,20
    addu k0,k1
    li    k1,NUM_ADDR
    sw    k0,0(k1)
    nop
    jr    ra
    nop

show_alarm:
    li    k0,0xffffffff
    li    k1,NUM_ADDR
    sw    k0,0(k1)
    nop
    jr    ra
    nop

key_int:
    li    k0,BTN_KEY_ADDR
    nop
    lw    k1,0(k0)
#set_clock: 01000000
    andi  a0,k1,0x40
    beq   a0,zero,1f
    nop

#set_clock called
    beq   s7,zero,s7z#s7==0
    nop
    li    s7,0x0
    li    a1,0x1000ff03
    mtc0  a1,CP0_STATUS
    nop
    b     2f
    nop
s7z:#s7==0
    li    s7,0x1
    li    a1,0x10000f03
    mtc0  a1,CP0_STATUS
    nop
2:
    eret
1:

#set_alarm: 10000000
    andi  a0,k1,0x80
    beq   a0,zero,1f
    nop

#set_alarm called
    beq   s8,zero,s8z#s8==0
    nop
    li    s8,0x0
    li    a1,0x1000ff03
    mtc0  a1,CP0_STATUS
    nop
    b     2f
    nop
s8z:#s8==0-->s8==1
    li    s8,0x1
    li    a1,0x10000f03
    mtc0  a1,CP0_STATUS
    nop
    jal alarm_print
    nop
2:
    b     endkey
1:

#normal_key start

    bne   s7,zero,key_set_alarm
    nop

key_set_clock:

#s0
    andi  a0,k1,0x1
    beq   a0,zero,1f
    addiu s0,s0,0x1
    jal   update_time
    jal   time_print
    b     endkey
1:
#s1
    andi  a0,k1,0x2
    beq   a0,zero,1f
    addiu s1,s1,0x1
    jal   update_time
    jal   time_print
    b     endkey
1:
#m0
    andi  a0,k1,0x4
    beq   a0,zero,1f
    addiu s2,s2,0x1
    jal   update_time
    jal   time_print
    b     endkey
1:
#m1
    andi  a0,k1,0x8
    beq   a0,zero,1f
    addiu s3,s3,0x1
    jal   update_time
    jal   time_print
    b     endkey
1:
#h0
    andi  a0,k1,0x10
    beq   a0,zero,1f
    addiu s4,s4,0x1
    jal   update_time
    jal   time_print
    b     endkey
1:
#h1
    andi  a0,k1,0x20
    beq   a0,zero,1f
    addiu s5,s5,0x1
    jal   update_time
    jal   time_print
    b     endkey
1:

key_set_alarm:
    nop
    bne   s8,zero,endkey
    nop

#s0
    andi  a0,k1,0x1
    beq   a0,zero,1f
    addiu t0,t0,0x1
    jal   update_alarm
    jal   alarm_print
    b     endkey
1:
#s1
    andi  a0,k1,0x2
    beq   a0,zero,1f
    addiu t1,t1,0x1
    jal   update_alarm
    jal   alarm_print
    b     endkey
1:
#m0
    andi  a0,k1,0x4
    beq   a0,zero,1f
    addiu t2,t2,0x1
    jal   update_alarm
    jal   alarm_print
    b     endkey
1:
#m1
    andi  a0,k1,0x8
    beq   a0,zero,1f
    addiu t3,t3,0x1
    jal   update_alarm
    jal   alarm_print
    b     endkey
1:
#h0
    andi  a0,k1,0x10
    beq   a0,zero,1f
    addiu t4,t4,0x1
    jal   update_alarm
    jal   alarm_print
    b     endkey
1:
#h1
    andi  a0,k1,0x20
    beq   a0,zero,1f
    addiu t5,t5,0x1
    jal   update_alarm
    jal   alarm_print
    b     endkey
1:

endkey:
    nop
    #ifdef DEBUG
        WAITS(10)
    #else
        WAITS(2000000)
    #endif
    eret
    nop