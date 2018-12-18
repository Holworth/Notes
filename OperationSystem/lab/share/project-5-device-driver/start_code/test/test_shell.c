// ----------------------------------------------------------------
//                   Lagenaria Siceraria OS
//                           Shell
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

#include "test.h"
#include "stdio.h"
#include "screen.h"
#include "syscall.h"
#include "time.h"
#include "sched.h"
#include "string.h"
#include "mac.h"

static void disable_interrupt()
{
    uint32_t cp0_status = get_cp0_status();
    cp0_status &= 0xfffffffe;
    set_cp0_status(cp0_status);
}

static void enable_interrupt()
{
    uint32_t cp0_status = get_cp0_status();
    cp0_status |= 0x01;
    set_cp0_status(cp0_status);
}

static char read_uart_ch(void)
{
    char ch = 0;
    unsigned char *read_port = (unsigned char *)(0xbfe48000 + 0x00);
    unsigned char *stat_port = (unsigned char *)(0xbfe48000 + 0x05);

    while ((*stat_port & 0x01))
    {
        ch = *read_port;
    }
    return ch;
}


// LAB3
// struct task_info task1 = {"ready_to_exit_task", (uint32_t)&ready_to_exit_task, USER_PROCESS, 1, 1};
// struct task_info task2 = {"wait_lock_task", (uint32_t)&wait_lock_task, USER_PROCESS, 1, 1};
// struct task_info task3 = {"wait_exit_task", (uint32_t)&wait_exit_task, USER_PROCESS, 1, 1};

// struct task_info task4 = {"semaphore_add_task1", (uint32_t)&semaphore_add_task1, USER_PROCESS, 1, 1};
// struct task_info task5 = {"semaphore_add_task2", (uint32_t)&semaphore_add_task2, USER_PROCESS, 1, 1};
// struct task_info task6 = {"semaphore_add_task3", (uint32_t)&semaphore_add_task3, USER_PROCESS, 1, 1};

// struct task_info task7 = {"producer_task", (uint32_t)&producer_task, USER_PROCESS, 1, 1};
// struct task_info task8 = {"consumer_task1", (uint32_t)&consumer_task1, USER_PROCESS, 1, 1};
// struct task_info task9 = {"consumer_task2", (uint32_t)&consumer_task2, USER_PROCESS, 1, 1};

// struct task_info task10 = {"barrier_task1", (uint32_t)&barrier_task1, USER_PROCESS, 1, 1};
// struct task_info task11 = {"barrier_task2", (uint32_t)&barrier_task2, USER_PROCESS, 1, 1};
// struct task_info task12 = {"barrier_task3", (uint32_t)&barrier_task3, USER_PROCESS, 1, 1};

// struct task_info task13 = {"SunQuan", (uint32_t)&SunQuan, USER_PROCESS, 1, 1};
// struct task_info task14 = {"LiuBei", (uint32_t)&LiuBei, USER_PROCESS, 1, 1};
// struct task_info task15 = {"CaoCao", (uint32_t)&CaoCao, USER_PROCESS, 1, 1};

// static struct task_info *test_tasks[16] = {&task1, &task2, &task3,
//                                            &task4, &task5, &task6,
//                                            &task7, &task8, &task9,
//                                            &task10, &task11, &task12,
//                                            &task13, &task14, &task15};
// static int num_test_tasks = 15;

// LAB 4

struct task_info task1 = {"lab4_drawing_task1", (uint32_t)&lab4_drawing_task1, USER_PROCESS,1,1};
struct task_info task2 = {"rw_task1", (uint32_t)&rw_task1, USER_PROCESS,1,1};
struct task_info vm_deamon = {"vm_deamon", (uint32_t)&deamon_vm, KERNEL_PROCESS,1,1};
struct task_info pressure_test_task = {"pressure_test1", (uint32_t)&pressure_test, USER_PROCESS,1,1};
struct task_info pressure_test_task2 = {"pressure_test2", (uint32_t)&pressure_test2, USER_PROCESS,1,1};
struct task_info mem_swap_test_task = {"mem_swap_test", (uint32_t)&mem_swap_test, USER_PROCESS,1,1};
struct task_info L2_swap_test_task = {"L2_swap_test", (uint32_t)&L2_swap_test, USER_PROCESS,1,1};
struct task_info phy_regs_test1_task = {"phy_regs_task1", (uint32_t)&phy_regs_task1, USER_PROCESS,1,1};
struct task_info phy_regs_test2_task = {"phy_regs_task2", (uint32_t)&phy_regs_task2, USER_PROCESS,1,1};
struct task_info phy_regs_test3_task = {"phy_regs_task3", (uint32_t)&phy_regs_task3, USER_PROCESS,1,1};
struct task_info phy_regs_bonus_task = {"phy_regs_task_bonus", (uint32_t)&phy_regs_task_bonus, USER_PROCESS,10,10};
// struct task_info phy_regs_test1_task = {"phy_regs_task1", (uint32_t)&phy_regs_task1, KERNEL_PROCESS,1,1};
// struct task_info phy_regs_test2_task = {"phy_regs_task2", (uint32_t)&phy_regs_task2, KERNEL_PROCESS,1,1};
// struct task_info phy_regs_test3_task = {"phy_regs_task3", (uint32_t)&phy_regs_task3, KERNEL_PROCESS,1,1};
// struct task_info phy_regs_bonus_task = {"phy_regs_task_bonus", (uint32_t)&phy_regs_task_bonus, KERNEL_PROCESS,10,10};

static struct task_info *test_tasks[16] = 
    {
        &task1, &task2, 
        &vm_deamon,//2 
        &pressure_test_task,//3
        &pressure_test_task2,//4 
        &mem_swap_test_task,//5
        &L2_swap_test_task,//6
        &phy_regs_test1_task,//7
        &phy_regs_test2_task,//8
        &phy_regs_test3_task,//9
        &phy_regs_bonus_task//10
    };
static int num_test_tasks = 10;

void init_other_tasks(int task_num, struct task_info **tasks_used)
{
    int i;
    for (i = 1; i <= task_num; i++)
    {
        printk("\n> [Shell] Writing pcb %d.\n", i);
        pcb[i].valid = 1;
        pcb[i].pid = new_pid();
        pcb[i].type = tasks_used[i - 1]->type;
        pcb[i].status = TASK_READY;
        pcb[i].entry = tasks_used[i - 1]->entry_point;
        pcb[i].first_run = 1;
        pcb[i].priority_level_set = tasks_used[i - 1]->priority;
        pcb[i].timeslice_set = tasks_used[i - 1]->timeslice;
        queue_push(&ready_queue, (void *)&(pcb[i]));
        //alloc stack in scheduler if 1st run
        // pcb[i].kernel_stack_top=alloc_stack();
        // pcb[i].user_stack_top=alloc_stack();
        check(i);
        check(&pcb[i]);
        check(pcb[i].pid);
        check(pcb[i].entry);
    }
}

#define SHELL_LINE_POSITION 15
#define SHELL_BUFFER_SIZE 40
#define SHELL_LINE_SIZE 40
#define SHELL_HISTORY 40
#define SHELL_SCREEN_HEIGHT 15
char shell_buffer[SHELL_BUFFER_SIZE];
char shell_history[SHELL_HISTORY][SHELL_LINE_SIZE];
char argc;
char argv[10][20];

int shell_history_cnt;
int shell_history_now;
int shell_inline_position;

inline void shell_drawline()
{
    int cursor_x_now = screen_cursor_x;
    int cursor_y_now = screen_cursor_y;
    sys_move_cursor(1, SHELL_LINE_POSITION);
    printf("---------------Lagenaria Siceraria OS:SHELL--------------- run_time_now:%d\n", time_elapsed);
    screen_cursor_y = cursor_y_now;
    screen_cursor_x = cursor_x_now;
    return;
}

// inline void shell_reflush()
// {
//     sys_move_cursor(1,SHELL_LINE_POSITION+1);
//     int i=0;
//     for(i=0;i<SHELL_SCREEN_HEIGHT;i++)
//     {
//         printf(shell_screen_buffer[i]);
//     }
//     return;
// }


//Shell History

inline int loop_sub(int val)
{
    if(val)
    {
        val--;
        return val;
    }
    val=SHELL_HISTORY-1;
    return val;
}

inline int loop_add(int val)
{
    val++;
    if(val==SHELL_HISTORY)
        val = 0;
    return val;
}

inline void shell_clear_input()
{
    while(shell_inline_position>0)
    {
        shell_inline_position--;
        screen_write_ch('\b');
    }
}

inline void shell_fake_input(char* input)
{
    shell_inline_position=0;
    strcpy(shell_buffer, input);
    printf("%s",input);
    shell_inline_position+=strlen(shell_buffer);
}

inline void add_to_history()
{
    strcpy(shell_history[shell_history_cnt],shell_buffer);
    shell_history_cnt=loop_add(shell_history_cnt);
}

inline void get_history()
{
    shell_clear_input();
    shell_fake_input((char*)&shell_history[shell_history_now]);
    shell_history_now=loop_sub(shell_history_now);
}

inline void reset_history()//not clear all history!!!
{
    shell_history_now=shell_history_cnt;
}

inline void print_history(int num)
{
    printf("Shell History:\n");
    reset_history();
    while(num-->0)
    {
        shell_history_now=loop_sub(shell_history_now);
        printf("%d: %s",shell_history_now, shell_history[shell_history_now]);
        printf("\n");
    }
    reset_history();
}


//Shell History End

inline void shell_add_to_buffer(char ch)
{
    shell_buffer[shell_inline_position++] = ch;
}

inline void shell_update_current_line()
{
    printf("> root@LSOS:%s", shell_buffer);
}

// #define SHELL_PRINT_START \
// shell_line_position++;\
// sys_move_cursor(1,SHELL_LINE_POSITION+1+shell_line_position);
// #define SHELL_PRINT_END \
// if(shell_line_position<SHELL_SCREEN_HEIGHT);\
// else\
// {\
//     shell_line_position=SHELL_SCREEN_HEIGHT-1;\
//     disable_interrupt();\
//     screen_scroll(SHELL_LINE_POSITION+1,SHELL_LINE_POSITION+SHELL_SCREEN_HEIGHT);\
//     enable_interrupt();\
// }\

// Shell embedded commands:

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

inline void cmd_find()
{
    if(argc!=2)
    {
        printf("Find: Invalid arguments. Usage: find [val]\n");
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


inline void shell_interpret_cmd()
{
    argc = 0;
    int i = 0;
    int j = 0;
    int in_space = 1;
    while (1)
    {
        if ((shell_buffer[i] == ' ') || (shell_buffer[i] == '\t') || (shell_buffer[i] == '\0'))
        {
            if (!in_space)
            {
                argv[argc++][j] = '\0';
                j = 0;
            }
            in_space = 1;
            if ((shell_buffer[i] == '\0'))
            {
                argv[argc][j] = '\0';
                break;
            }
        }
        else
        {
            in_space = 0;
            argv[argc][j++] = shell_buffer[i];
        }
        i++;
    }
    //strcmp();return 0 if eq

    // Use key tree here to make it faster

    FLOAT_PRINT_START(SCREEN_WIDTH - 15, 2);
    printf("|argc : %d|", argc);
    FLOAT_PRINT_END(SCREEN_WIDTH - 15, 2);

    // FLOAT_PRINT_START(SCREEN_WIDTH - 15, 3);
    // printf("|argv0: %s|", argv[0]);
    // FLOAT_PRINT_END(SCREEN_WIDTH - 15, 3);

    // FLOAT_PRINT_START(1, 4);
    // printf("|buffr: %s|", shell_buffer);
    // FLOAT_PRINT_END(1, 4);

    if (!strcmp(argv[0], "echo"))
    {
        cmd_echo();
        return;
    }
    if (!strcmp(argv[0], "ps"))
    {
        cmd_ps();
        return;
    }
    if (!strcmp(argv[0], "clear"))
    {
        cmd_clear();
        return;
    }
    if (!strcmp(argv[0], "cls"))
    {
        cmd_clear();
        return;
    }
    if (!strcmp(argv[0], "about"))
    {
        cmd_about();
        return;
    }
    if (!strcmp(argv[0], "exec"))
    {
        cmd_exec();
        return;
    }
    if (!strcmp(argv[0], "kill"))
    {
        cmd_kill();
        return;
    }
    if (!strcmp(argv[0], "reboot"))
    {
        cmd_reboot();
        return;
    }
    if (!strcmp(argv[0], "history"))
    {
        print_history(5);
        return;
    }
    if (!strcmp(argv[0], "dump"))
    {
        cmd_dump();
        return;
    }
    if (!strcmp(argv[0], "find"))
    {
        cmd_find();
        return;
    }
    if (!strcmp(argv[0], "set"))
    {
        cmd_set();
        return;
    }
    if (!strcmp(argv[0], "test"))
    {
        cmd_test();
        return;
    }
    if (!strcmp(argv[0], "start"))
    {
        cmd_start();
        return;
    }
    if (!strcmp(argv[0], "ppkg"))
    {
        cmd_ppkg();
        return;
    }
    //TODO
    if (argc != 0)
        printsys("Can not interpret command: %s, argc: %d\n", argv[0], argc);
    else
        1;
    // printsys("\n");
}

inline void shell_newline()
{
    printf("> root@LSOS# ");
}

inline void show_ascii(char ch)
{

    FLOAT_PRINT_START(SCREEN_WIDTH - 15, 1);
    printf("|ascii: %d|", ch);
    FLOAT_PRINT_END(SCREEN_WIDTH - 15, 1);
    return;
}

inline void show_ehi()
{

    FLOAT_PRINT_START(SCREEN_WIDTH - 15, 14);
    int t=get_CP0_ENTRYHI();
    printf("|ehi: %x|", t);
    FLOAT_PRINT_END(SCREEN_WIDTH - 15, 14);
    return;
}

void start_deamon(char* name)
{
    int i;
    for(i=0;i<NUM_MAX_TASK;i++)
    {
        if((test_tasks[i])&&(!strcmp(test_tasks[i]->name,name)))
        {
            sys_spawn(test_tasks[i]);
            return;
        }
    }
    printf("[DEAMON] %s failed to start.\n");
}

// Shell itself
void test_shell()
{
    disable_interrupt();
    // init_other_tasks(num_task5_tasks,task5_tasks);
    enable_interrupt();
    cmd_clear();
    shell_drawline();
    sys_move_cursor(1, SHELL_LINE_POSITION + 1);
    start_deamon("vm_deamon");
    start_deamon("phy_regs_task3");
    cmd_about();
    shell_newline();

    // printf("%x\n",(int)TLBexception_handler_end-(int)TLBexception_handler_begin);

    while (1)
    {
        // read command from UART port
        disable_interrupt();
        char ch = read_uart_ch();
        enable_interrupt();
        if (!ch)
            continue;
        show_ehi();

        // TODO solve command
        if(ch==65)//up arrow
        {
            get_history();
        }
        else if (ch == 127)//in qemu sim
        {
            if(shell_inline_position>0)
            {
                shell_inline_position--;
                screen_write_ch('\b');
                show_ascii(ch);
            }
        }
        else if (ch == 8)//on board
        {
            if(shell_inline_position>0)
            {
                shell_inline_position--;
                screen_write_ch('\b');
                show_ascii(ch);
            }
        }
        else if (ch != 13) //
        {
            shell_add_to_buffer(ch);
            screen_write_ch(ch);
            //get ascii
            show_ascii(ch);
        }
        else //ch==13
        {
            disable_interrupt();
            shell_add_to_buffer('\0');
            screen_write_ch('\n');
            shell_inline_position = 0;
            enable_interrupt();
            add_to_history();
            reset_history();
            shell_interpret_cmd();

            disable_interrupt();
            screen_reflush();
            enable_interrupt();

            shell_newline();
        }
        shell_drawline();
    }
}