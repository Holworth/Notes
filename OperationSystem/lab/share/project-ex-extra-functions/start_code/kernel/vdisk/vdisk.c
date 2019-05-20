#include "vdisk.h"
#include "type.h"

int vdiskinit()
{
    uint32_t i;
    for (i = VDISK_BASE; i < VDISK_UPPER_BOUND; i += 4)
    {
        *(int *)i = 0;
    }
    return;
}

int vdiskread(unsigned char *buf, unsigned int base, int n)
{
    int offset = 0;
    unsigned char *memdisk_addr = (unsigned char *)(base + (unsigned int)VDISK_BASE);
    if ((uint32_t)(memdisk_addr + n) >= VDISK_UPPER_BOUND)
        panic("Vdisk read outranged.");
    for (offset = 0; offset < n; offset++)
    {
        (*(buf + offset)) = (*(memdisk_addr + offset));
    }
    return 0;
}

int vdiskwrite(unsigned char *buf, unsigned int base, int n)
{
    int offset = 0;
    unsigned char *memdisk_addr = (unsigned char *)(base + (unsigned int)VDISK_BASE);
    if ((uint32_t)(memdisk_addr + n) >= VDISK_UPPER_BOUND)
        panic("Vdisk write outranged.");
    for (offset = 0; offset < n; offset++)
    {
        (*(memdisk_addr + offset)) = (*(buf + offset));
    }
    return 0;
}