#define PORT 0xbfe48000
#define bios_printstr 0x8007b980


void __attribute__((section(".entry_function"))) _start(void)
{
	// Call PMON BIOS printstr to print message "Hello OS!"
	char hello_os[]="Hello OS!\n";
	void (*call_printstr)(char* ) = bios_printstr;
	call_printstr(hello_os);
	while(1);
	return;
}
//
