export LD_PRELOAD =

##set your cpu frequency
##if your cpu is 33MHz, set 33
CPU_Freq_MHz= 55

CFLAGS := -D_KERNEL -DCONFIG_PAGE_SIZE_16KB -fno-builtin -mips1 -DCACHELOCK_MEM -DMEMSTART=0x80000000 -DMEMSIZE=0x04000 -DTIMER_COUNT_PER_US=100 -I include -include common.h -DAPB_CLK=33333333
CFLAGS += -DLS1FSOC -msoft-float 
CFLAGS += -DCPU_COUNT_PER_US=$(CPU_Freq_MHz)

OBJDIR = obj

export AR CFLAGS CPU_Freq_MHz
export CROSS_COMPILE ?= mipsel-linux-

all: coremark dhrystone

coremark:
	$(eval export BENCH = $@)
	make target_bench

dhrystone:
	$(eval export BENCH = $@)
	make target_bench

libtinyc.a :
	make -C lib $@

target_bench:
	$(eval export BENCH_DIR = $(BENCH))
	$(eval export BENCH_LIB = $(BENCH).a)
	make -C bench/$(BENCH_DIR)
	mkdir -p $(OBJDIR)/$(BENCH_DIR)
	make generate

generate: main.bin main.data convert
	./convert main.bin main.data $(OBJDIR)/$(BENCH_DIR)/

main.bin: main.elf
	${CROSS_COMPILE}objcopy -O binary -j .text $(OBJDIR)/$(BENCH_DIR)/$< $(OBJDIR)/$(BENCH_DIR)/$@ 
main.data: main.elf
	${CROSS_COMPILE}objcopy -O binary -j .data $(OBJDIR)/$(BENCH_DIR)/$< $(OBJDIR)/$(BENCH_DIR)/$@ 

main.elf: start.o libtinyc.a bin.lds
	${CROSS_COMPILE}ld -g -T bin.lds start.o bench/$(BENCH_DIR)/$(BENCH_LIB) lib/libtinyc.a -o $(OBJDIR)/$(BENCH_DIR)/$@
	${CROSS_COMPILE}objdump -alD $(OBJDIR)/$(BENCH_DIR)/$@ > $(OBJDIR)/$(BENCH_DIR)/test.s

bin.lds: bin.lds.S
	${CROSS_COMPILE}gcc -E -P -Umips -D_LOADER -U_MAIN $(CFLAGS) $< -o $@

start.o: start.S
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I ../include -c $< -nostdinc -nostdlib

convert: convert.c
	gcc -o convert convert.c
clean:
	rm -f *.o *.a 
	rm -rf obj
	make -C lib clean
	make -C bench clean
reset:
	make clean
	rm -f bin.lds convert

help:
	@echo "################################################################"
	@echo "### help for compiling performance func"
	@echo "################################################################"
	@echo "### options:"
	@echo "###     make      : get compiled result, which is saved in ./obj"
	@echo "###     make clean: remove *.o, *.a, and ./obj"
	@echo "###     make reset: "make clean" and remove convert, bin.lds"
	@echo "###     make help : show help information"
	@echo "###############################################################"

#-include rules.make
