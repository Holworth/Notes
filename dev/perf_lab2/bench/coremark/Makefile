CC = mipsel-linux-gcc

ifndef $(ITERATIONS)
ITERATIONS=1
endif

NULLSTRING:= 
SPACE:=$(NULLSTRING) #end

COMPILER_FLAGS= -O3 -mno-abicalls -funroll-all-loops -falign-jumps=16 -falign-functions=16 -fgcse-sm -fgcse-las -finline-functions -finline-limit=1000 -msoft-float -EL -march=mips1 -mips1
CFLAGS= $(COMPILER_FLAGS) -I ../../include -include stdio.h
CFLAGS += -DCOMPILER_FLAGS=\"$(subst $(SPACE),\ , $(COMPILER_FLAGS))\"
CFLAGS += -G8 -DITERATIONS=$(ITERATIONS)
CFLAGS += -DCPU_COUNT_PER_US=$(CPU_Freq_MHz)

SRCS=core_list_join.c core_main.c core_matrix.c core_state.c core_util.c core_portme.c shell.c

.PHONY:compile link
all:link
	$(AR) -cr coremark.a $(patsubst %.c, %.o, $(wildcard *.c))
	echo "job done"

compile:
		$(CC) $(CFLAGS) -c $(SRCS)
link:compile
	@echo "link performed along with compile"
.PHONY:clean
clean:
	rm -rf *.o
	rm -rf *.a
