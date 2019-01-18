CC = mipsel-linux-gcc

all: clean main asm

main : extra.c
	${CC} -G 0 -O0 \
	-fno-pic -mno-abicalls -fno-builtin -nostdinc -mips3 -Ttext=0xffffffff00000000 -N -o main \
	extra.c \
	-nostdlib -Wl,-m -Wl,elf32ltsmip -T ld.script		

clean:
	rm -rf main *.o

asm:
	mipsel-linux-objdump -d main > kernel.txt
