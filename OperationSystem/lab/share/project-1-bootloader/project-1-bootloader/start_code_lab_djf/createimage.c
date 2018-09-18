#include <assert.h>
#include <elf.h>
#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void write_bootblock(FILE *image, FILE *bbfile, Elf32_Phdr *Phdr);
Elf32_Phdr *read_exec_file(FILE *opfile);
uint8_t count_kernel_sectors(Elf32_Phdr *Phdr);
void extent_opt(Elf32_Phdr *Phdr_bb, Elf32_Phdr *Phdr_k, int kernelsz);

Elf32_Phdr *read_exec_file(FILE *opfile)
{
    Elf32_Ehdr *elf;
    Elf32_Phdr *Phdr = (Elf32_Phdr *)calloc(1, sizeof(Elf32_Phdr));
    uint8_t buf[4096];

    fread(buf, 1, 4096, opfile);
    elf = (Elf32_Ehdr *)buf;
    memcpy(Phdr, (void *)elf + elf->e_phoff, 32);
    return Phdr;
}

uint8_t count_kernel_sectors(Elf32_Phdr *Phdr)
{
    uint8_t sector_num = (Phdr->p_filesz + 511) / 512;
    return sector_num;
}

void write_bootblock(FILE *image, FILE *file, Elf32_Phdr *phdr)
{
    uint8_t buf[4096];
    fseek(file, phdr->p_offset, SEEK_SET);
    fread(buf, 1, phdr->p_filesz, file);
    fwrite(buf, 1, phdr->p_filesz, image);
}

void write_kernel(FILE *image, FILE *knfile, Elf32_Phdr *Phdr, int kernelsz)
{
    uint8_t buf[4096];
    fseek(knfile, Phdr->p_offset, SEEK_SET);
    while(kernelsz--)
    {
        fread(buf, 1, 4096, knfile);
        fwrite(buf, 1, 4096, image);
        fseek(knfile, 4096, SEEK_SET);
        fseek(image, 4096, SEEK_SET);
    }
}

void record_kernel_sectors(FILE *image, uint8_t kernelsz)
{
    uint8_t *buf = &kernelsz;
    fseek(image, 511, SEEK_SET);
    fwrite(buf, 1, 1, image);
}

void extent_opt(Elf32_Phdr *Phdr_bb, Elf32_Phdr *Phdr_k, int kernelsz)
{
        printf("bootblock size is %d byte!\n", Phdr_bb->p_filesz);
        printf("Bootblock message :\n");
        printf("Bootblock image memory size is 0x%x\n", Phdr_bb->p_memsz);
        printf("Bootblock image memory offset is 0x%x\n", Phdr_bb->p_offset);
        printf("kernel message :\n");
        printf("kernel image memeory size is 0x%x\n", Phdr_k->p_memsz);
        printf("kernel image memory offset is 0x%x\n", Phdr_k->p_offset);
        printf("kernel sector size is 0x%x\n", kernelsz);
}

int main()
{
    FILE *file = fopen("bootblock", "rb");
    assert(file);
    FILE *knfile = fopen("kernel", "rb");
    assert(knfile);
    FILE *image = fopen("image", "wb");

    Elf32_Phdr *Phdr_bb = read_exec_file(file);
    Elf32_Phdr *Phdr_k = read_exec_file(knfile);
    
    int kernelsz = (int)count_kernel_sectors(Phdr_k);

    write_bootblock(image, file, Phdr_bb);
    
    FILE *fp = image;
    fseek(fp, 4096, SEEK_SET);
    write_kernel(fp, knfile, Phdr_k, kernelsz);

    fp = image;
    record_kernel_sectors(fp, kernelsz);

    extent_opt(Phdr_bb, Phdr_k, kernelsz);
    fclose(file);
    fclose(knfile);
    fclose(image);

    return 0;
}
