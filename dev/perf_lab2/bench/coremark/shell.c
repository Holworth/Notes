#include <ucas_cde.h>
#include <time.h>

void shell(void)
{
    write_confreg_cr(1,0x1234);
    printf("coremark test begin.\n");
	int r = core_mark(0,0,0x66,ITERATIONS,7,1,2000);
	if(r == 0){
        printf("coremark PASS!\n");
		*((volatile int *)LED_RG1_ADDR) = 1;  
		*((volatile int *)LED_RG0_ADDR) = 1;  
		*((volatile int *)LED_ADDR)     = 0xffff;  
	}else{
        printf("coremark ERROR!!!\n");
		*((volatile int *)LED_RG1_ADDR) = 1;  
		*((volatile int *)LED_RG0_ADDR) = 2;  
		*((volatile int *)LED_ADDR)     = 0;

	}

    return;
}
