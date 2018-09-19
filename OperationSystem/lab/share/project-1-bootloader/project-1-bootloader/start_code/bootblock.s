.text
.global main

main:
	# 1) task1 call BIOS print string "It's bootblock!"

	la  $a0, msg
	jal 0x8007b980
#	jal printstr
	nop

	# 2) task2 call BIOS read kernel in SD card and jump to kernel start

#	lw  $a0, kernel
#	lw  $a1, kernel_sd_position
#	lw  $a2, kernel_size_t
#	lb  $a2, 0x800001FF
	li  $a0, 0xa0800200
	li  $a1, 0x00000200
	li  $a2, 0x00000200

	jal 0x8007b1cc
#	jal read_sd_card
	nop

#bonus question:
#	lw  $ra, kernel
#	j   read_sd_card

#normally:
	jal   kernel
	nop

# while(1) --> stop here
stop:
	j stop
	nop

.data

msg: .ascii "It's a bootloader...\n"

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
