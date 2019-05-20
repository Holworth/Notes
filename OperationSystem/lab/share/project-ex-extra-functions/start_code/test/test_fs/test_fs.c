#include "fs.h"
#include "stdio.h"
#include "string.h"
#include "test_fs.h"
#include "syscall.h"

static char buff[64];

void test_fs(void)
{
    int i, j;
    int fd = sys_fopen("1.txt", O_RDWR);

    if(fd==-1)
    {
        printf("Sysopen failed: fd==-1\n");
        sys_exit();
    }

    for (i = 0; i < 10; i++)
    {
        //1
        // pprintf(i);
        // pprintf(fdesc[fd].pos);
        sys_fwrite(fd, "hello world!\n", 13);
    }

    // pprintf(fd);
    // printf("ok1");
    sys_fseek(fd, 0);
    // printf("ok2");

    for (i = 0; i < 10; i++)
    {
        // pprintf(i);
        sys_fread(fd, buff, 13);
        for (j = 0; j < 13; j++)
        {
            printf("%c", buff[j]);
        }
    }

    sys_fclose(fd);
    // sys_exit();
    return 0;
}

void test_bigfile(void)
{
    int i, j;
    int fd = sys_fopen("2.txt", O_RDWR);

    if(fd==-1)
    {
        printf("Sysopen failed: fd==-1\n");
        sys_exit();
    }

    for (i = 0; i < 10; i++)
    {
        sys_fwrite(fd, "hello world!\n", 13);
    }

    sys_fseek(fd, 0);

    for (i = 0; i < 10; i++)
    {
        sys_fread(fd, buff, 13);
        for (j = 0; j < 13; j++)
        {
            printf("%c", buff[j]);
        }
    }
    
    sys_fseek(fd, 80000);

    for (i = 0; i < 10; i++)
    {
        sys_fwrite(fd, "hello world!\n", 13);
    }

    sys_fseek(fd, 80000);

    for (i = 0; i < 10; i++)
    {
        sys_fread(fd, buff, 13);
        for (j = 0; j < 13; j++)
        {
            printf("%c", buff[j]);
        }
    }
    sys_fclose(fd);
    // sys_exit();
    return 0;

}