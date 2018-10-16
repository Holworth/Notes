CC = mipsel-linux-gcc

ifndef $(ITERATIONS)
ITERATIONS=10
endif

COMPILER_FLAGS= -O3 -mno-abicalls -funroll-all-loops -falign-jumps=16 -falign-functions=16 -fgcse-sm -fgcse-las -finline-functions -finline-limit=1000 -msoft-float -EL -march=mips1 -mips1
CFLAGS= $(COMPILER_FLAGS) -I ../../include -include stdio.h
CFLAGS += -G8 -DTIME -DITERATIONS=$(ITERATIONS)
CFLAGS += -DCPU_COUNT_PER_US=$(CPU_Freq_MHz)

all:link
	$(AR) -cr dhrystone.a $(patsubst %.c, %.o, $(wildcard *.c))
	echo "job done"
compile:
		$(CC) $(CFLAGS) -c dhry_1.c dhry_2.c shell.c
link:compile
	@echo "link performed along with compile"
.PHONY:clean
clean:
	rm -rf *.o
	rm -rf *.a
