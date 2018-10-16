#include <ucas_cde.h>
#include <time.h>

void shell(void)
{

    printf("dhrystone test begin.\n");
    int r = dhrystone(ITERATIONS);
	if(r == 0){
        printf("dhrystone PASS!\n");
		*((volatile int *)LED_RG1_ADDR) = 1;  
		*((volatile int *)LED_RG0_ADDR) = 1;  
		*((volatile int *)LED_ADDR)     = 0xffff;  
	}else{
        printf("dhrystone ERROR!!!\n");
		*((volatile int *)LED_RG1_ADDR) = 1;  
		*((volatile int *)LED_RG0_ADDR) = 2;  
		*((volatile int *)LED_ADDR)     = 0;

	}

    return;
}
