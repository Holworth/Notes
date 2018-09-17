#define PORT 0xbfe48000
#define bios_printstr 0x8007b980

char hello_os[]="Hello OS!\n";
int (*call_printstr)(char* string) = bios_printstr;

void __attribute__((section(".entry_function"))) _start(void)
{
	// Call PMON BIOS printstr to print message "Hello OS!"
	call_printstr(hello_os);
	return;
}
