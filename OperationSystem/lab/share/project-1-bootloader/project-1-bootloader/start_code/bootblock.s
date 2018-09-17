.text
.global main

main:
	# 1) task1 call BIOS print string "It's bootblock!"

	la  $a0, msg
	lw  $a1, printstr
	jal $a1

	# 2) task2 call BIOS read kernel in SD card and jump to kernel start
	
	lw  $t0, read_sd_card
	lw  $a0, kernel
	lw  $a1, kernel_sd_position
	lw  $a2, kernel_size_t
	jal $t0

#bonus question:
#	lw  $ra, kernel
#	j   $t0

#normally:
	lw  $a0, kernel
	j   $a0


# while(1) --> stop here
stop:
	j stop

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
kernel_sd_position : .word 512

# 7. kernel size (temp)
kernel_size_t: .word 512
