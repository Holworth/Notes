.text
.global main

main:
	# 1) task1 call BIOS print string "It's bootblock!"

	la  $a0, msg
	jal 0x8007b980
	nop

	# 2) task2 call BIOS read kernel in SD card and jump to kernel start

#	target position
	li  $a0, 0xa0800200
#	data source
	li  $a1, 0x00000200
# 	data size
#	calculate data size (byte)
#	imagecreater saved kernel size in sector number here:
#	lw	$a2,  0xa08001fc
#	sll	$a2, 9

#   or
#   for small kernel or self-set-global kernel:
	li  $a2, 0x0000f000

#normal way

	jal 0x8007b1cc
	nop
	jal   0xa0800200

#bonus question:
#	li  $ra, 0xa0800000
#	j   0x8007b1cc

# while(1) --> stop here
stop:
	j stop
	nop

.data

msg: .ascii "> [BOOT] Bootloader started.\n"

# 1. PMON read SD card function address
# read_sd_card();
read_sd_card: .word 0x8007b1cc

# 2. PMON print string function address
# printstr(char *string)
printstr: .word 0x8007b980

# 3. PMON print char function address
# printch(char ch)
printch: .word 0x8007ba00

# 4. kernel address (move kernel to here ~)
kernel : .word 0xa0800200

# 5. kernel main address (jmp here to start kernel main!)
kernel_main : .word 0xa0800200

# 6. kernel sd position
kernel_sd_position : .word 0x00000200

# 7. kernel size (temp)
kernel_size_t: .word 0x00000200
