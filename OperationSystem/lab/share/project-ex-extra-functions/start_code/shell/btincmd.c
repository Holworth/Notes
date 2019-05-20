// ----------------------------------------------------------------
//                   Lagenaria Siceraria OS
//                   Shell Build-in Commands
// ----------------------------------------------------------------
//              Copyright (C) 2018 Wang Huaqiang 
//             email : wanghuaqiang16@mails.ucas.ac.cn
// ----------------------------------------------------------------
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
// -----------------------------------------------------------------

// Shell embedded commands:

#include "shell.h"

inline void cmd_echo()
{
    int i = 1;
    while (i < argc)
    {
        // shell_print(argv[i++]);
        printf("%s\n", argv[i++]);
    }
}

inline void cmd_clear()
{
    // shell_line_position=0;
    // int i=0
    // for(i=0;i<=SHELL_SCREEN_HEIGHT;i++)
    // {
    //     sys_move_cursor(1,SHELL_LINE_POSITION+i);
    //     printf("                                                   \n");
    // }
    disable_interrupt();
    screen_clear_area(SHELL_LINE_POSITION, SHELL_LINE_POSITION + SHELL_SCREEN_HEIGHT);
    enable_interrupt();
    sys_move_cursor(1, SHELL_LINE_POSITION + 1);
    return;
}

inline void cmd_ps()
{
    sys_ps();
}

inline void cmd_about()
{
    printf(" Lagenaria Siceraria OS\n");
    printf(" Copyright (C) 2018 Huaqiang Wang\n");
    printf(" Compiled at: %s,%s\n",__DATE__,__TIME__);
}

inline void cmd_history()
{
    //TODO
    printf(" Lagenaria Siceraria OS\n");
    printf(" Copyright (C) 2018 Huaqiang Wang\n");
}

inline void cmd_exec()
{
    if (argc == 1)
    {
        printf("No enough args for exec.\n");
        return;
    }
    int i;
    for (i = 1; i <= (argc - 1); i++)
    {
        int num = atoi(argv[i]);
        if(num<16)
        {
            printf("Exec task: %d\n", num);
            sys_spawn(test_tasks[num]);
        }
        else
        {
            printf("Exec: Task: %d does not exist!\n", num);
        }
    }
}

inline void cmd_kill()
{
    int kill_id = atoi(argv[1]);
    if (kill_id == current_running->pid)
    {
        printf("#Shell: You wanna kill yourself? That's not socialism.\n");
        return;
    }
    if (proc_exist(kill_id))
    {
        sys_kill(kill_id);
    }
    else
    {
        printf("#Shell: Process does not exist.\n");
    }
    return;
}

inline void cmd_reboot()
{
    disable_interrupt();
    int i;
    for (i = 0; i < NUM_MAX_TASK; i++)
    {
        pcb[i].valid = 0;
    }
    asm("jal _start\n nop\n");
}

inline void cmd_dump()
{
    if(argc!=2)
    {
        printf("Dump: Invalid arguments. Usage: dump [vaddr (in hex, no 0x)] / [l2]\n");
        return;
    }
    if(strcmp("l2",argv[1]))
    {
        uint32_t* dumpaddr=(uint32_t *)htoi(argv[1]);
        uint32_t dumpval=*dumpaddr;
        printf("Dump addr 0x%x, result: 0x%x, %d\n",dumpaddr,dumpval, dumpval);
    }else
    {
        L2_dump();
    }
    return;
}

inline void cmd_findmem()
{
    if(argc!=2)
    {
        printf("Findmem: Invalid arguments. Usage: find [val]\n");
        return;
    }
        uint32_t findval=(uint32_t)htoi(argv[1]);
        uint32_t findaddr=0xa0000000;
        for(;findaddr<0xa1f00000;findaddr+=4)
        {
            if((*(uint32_t*)findaddr)==findval)
                printf("Find in addr 0x%x\n",findaddr);
        }
    return;
}

inline void cmd_set()
{
    if(argc!=3)
    {
        printf("Set: Invalid arguments.\n");
        printf("Usage: set [vaddr (in hex, no 0x)] [val (in hex, no 0x)]\n");
        return;
    }
    uint32_t* setaddr=(uint32_t *)htoi(argv[1]);
    uint32_t setval=htoi(argv[2]);
    printf("Set addr 0x%x to: 0x%x, %d\n",setaddr ,setval, setval);
    *(setaddr)=setval;
    return;
}

inline void cmd_test()
{
    unsigned int i=0;
    for(i=0xa0000000;i<0xa1f00000;i+=4)
    {
        if(*(int*)i==0x4321)
        {
            printf("%x\n",i);
        }
    }
    return ;
}

inline void cmd_ppkg()
{
    int i;
    for(i=0;i< 64;i++)
    {
        int *content = (int*)(BIG_RECEIVE_BUFFER + 1024*i);
        printf("\t%x\t",*content);
    }
    return ;
}

inline void cmd_start()
{
    if(argc!=2)
    {
        printf("Usage: start [proc name]\n");
        return;
    }
    int i;
    for(i=0;i<NUM_MAX_TASK;i++)
    {
        if((test_tasks[i])&&(!strcmp(test_tasks[i]->name,argv[1])))
        {
            sys_spawn(test_tasks[i]);
            return;
        }
    }
    printf("Failed to start %s.\n");
}

inline void cmd_read()
{
    if(argc!=2)
    {
        printf("Usage: read [disk addr]\n");
        return;
    }
    // sdwrite(char	*buff, uint32_t offset,	uint32_t size);
    uint32_t buff;
    sdread(&buff, htoi(argv[1]), sizeof(uint32_t));
    printf("Read addr 0x%x, result: 0x%x\n", htoi(argv[1]),buff);
    return;
}

inline void cmd_write()
{
    if(argc!=3)
    {
        printf("Usage: write [disk addr] [data(uint32_t)]\n");
        return;
    }
    // sdwrite(char	*buff, uint32_t offset,	uint32_t size);
    uint32_t buff=htoi(argv[2]);
    sdwrite(&buff, htoi(argv[1]), sizeof(uint32_t));
    printf("Write addr 0x%x, data: 0x%x\n", htoi(argv[1]),htoi(argv[2]));
    return;
}

inline void show_path()
{
    int i;
    if(current_dir_level)
        printf("/");
    else
    {
        while(i!=current_dir_level)
        {
            printf("/%s",current_dir);
        }
    }
    return;
}

inline void cmd_pwd()
{
    show_path();
    printf("\n");
    return;
}
