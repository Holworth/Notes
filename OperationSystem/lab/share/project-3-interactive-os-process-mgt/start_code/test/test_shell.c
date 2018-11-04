/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *                  The shell acts as a task running in user mode. 
 *       The main function is to make system calls through the user's output.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this 
 * software and associated documentation files (the "Software"), to deal in the Software 
 * without restriction, including without limitation the rights to use, copy, modify, 
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit 
 * persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * */

#include "test.h"
#include "stdio.h"
#include "screen.h"
#include "syscall.h"
#include "time.h"
#include "sched.h"

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

// struct task_info task1 = {"task1", (uint32_t)&ready_to_exit_task, USER_PROCESS};
// struct task_info task2 = {"task2", (uint32_t)&wait_lock_task, USER_PROCESS};
// struct task_info task3 = {"task3", (uint32_t)&wait_exit_task, USER_PROCESS};

// struct task_info task4 = {"task4", (uint32_t)&semaphore_add_task1, USER_PROCESS};
// struct task_info task5 = {"task5", (uint32_t)&semaphore_add_task2, USER_PROCESS};
// struct task_info task6 = {"task6", (uint32_t)&semaphore_add_task3, USER_PROCESS};

// struct task_info task7 = {"task7", (uint32_t)&producer_task, USER_PROCESS};
// struct task_info task8 = {"task8", (uint32_t)&consumer_task1, USER_PROCESS};
// struct task_info task9 = {"task9", (uint32_t)&consumer_task2, USER_PROCESS};

// struct task_info task10 = {"task10", (uint32_t)&barrier_task1, USER_PROCESS};
// struct task_info task11 = {"task11", (uint32_t)&barrier_task2, USER_PROCESS};
// struct task_info task12 = {"task12", (uint32_t)&barrier_task3, USER_PROCESS};

// struct task_info task13 = {"SunQuan",(uint32_t)&SunQuan, USER_PROCESS};
// struct task_info task14 = {"LiuBei", (uint32_t)&LiuBei, USER_PROCESS};
// struct task_info task15 = {"CaoCao", (uint32_t)&CaoCao, USER_PROCESS};

// static struct task_info *test_tasks[16] = {&task1, &task2, &task3,
//                                            &task4, &task5, &task6,
//                                            &task7, &task8, &task9,
//                                            &task10, &task11, &task12,
//                                            &task13, &task14, &task15};
static int num_test_tasks = 15;

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
        pcb[i].priority_level_set = priority_set[i];
        pcb[i].timeslice_set = timeslice_set[i];
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

#define SHELL_LINE_POSITION 20
#define SHELL_BUFFER_SIZE 40
#define SHELL_LINE_SIZE 40
#define SHELL_HISTORY 40
#define SHELL_SCREEN_HEIGHT 5
char shell_buffer[SHELL_BUFFER_SIZE];
char shell_history[SHELL_HISTORY][SHELL_LINE_SIZE];
char argc;
char argv[10][20];

int shell_line_position;
int shell_history_cnt;
int shell_inline_position;

inline void shell_drawline()
{
    sys_move_cursor(1, SHELL_LINE_POSITION);
    printf("--------------SHELL------------ run_time_now:%d\n", time_elapsed);
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

inline void shell_add_to_buffer(char ch)
{
    shell_buffer[shell_inline_position++] = ch;
}

inline void shell_update_current_line()
{
    printf("> root@LSOS:%s", shell_buffer);
}

inline loop_sub(int shell_history_cnt)
{
    if(shell_history_cnt)
    return shell_history_cnt--;
    shell_history_cnt=SHELL_HISTORY-1;
}

inline void shell_print(char *string)
{
    if (shell_line_position < SHELL_SCREEN_HEIGHT)
    {
        printf("%s", string);
        shell_line_position++;
        shell_history_cnt++;
        if (shell_history_cnt >= SHELL_HISTORY)
        {
            shell_history_cnt = 0;
        }
        strcpy(shell_history[shell_history_cnt],string);
    }
    else
    {
        strcpy(shell_history[shell_history_cnt],string);
        int i=SHELL_SCREEN_HEIGHT;
        int reverse_point=shell_history_cnt;
        while(i>0)
        {
            sys_move_cursor(1,SHELL_LINE_POSITION+i);
            printf("%s",shell_history[reverse_point]);
            loop_sub(reverse_point);
        }
        shell_history_cnt++;
        if (shell_history_cnt >= SHELL_HISTORY)
        {
            shell_history_cnt = 0;
        }
    }
}

inline void shell_interpret_cmd()
{
    argc=0;
    int i=0;
    int j=0;
    int in_space=1;
    while(1)
    {
        if((shell_buffer[i]==' ')||(shell_buffer[i]=='\t')||(shell_buffer[i]=='\0'))
        {
            if(!in_space)
            {
                argv[argc++][j]='\0';
                j=0;
            }
            in_space=1;
            if((shell_buffer[i]=='\0'))break;
        }
        else
        {
            in_space=0;
            argv[argc][j++]=shell_buffer[i];
        }
        i++;
    }
    //strcmp();return 0 if eq

    // Use key tree here to make it faster
    if(!strcmp(argv[0],"echo"))
    {
        cmd_echo();
        return;
    }
    if(!strcmp(argv[0],"echo"))
    {
        cmd_echo();
        return;
    }
    if(!strcmp(argv[0],"ps"))
    {
        cmd_ps();
        return;
    }
    if(!strcmp(argv[0],"clear"))
    {
        cmd_clear();
        return;
    }
    if(!strcmp(argv[0],"cls"))
    {
        cmd_clear();
        return;
    }
    if(!strcmp(argv[0],"about"))
    {
        cmd_about();
        return;
    }
    if(!strcmp(argv[0],"exec"))
    {
        cmd_exec();
        return;
    }
    if(!strcmp(argv[0],"kill"))
    {
        cmd_kill();
        return;
    }
    //TODO
}

// Shell embedded commands:

inline void cmd_echo()
{
    int i=1;
    while(i<argc)
    {
        shell_print(argv[i++]);
    }
}

inline void cmd_clear()
{
    shell_line_position=0;
    int i=0
    for(i=0;i<=SHELL_SCREEN_HEIGHT;i++)
    {
        sys_move_cursor(1,SHELL_LINE_POSITION+i);
        printf("                                                   \n");
    }
    return;
}

char* str_running="RUNNING";
char* str_ready="READY";
char* str_blocked="BLOCKED";
char* str_sleep="SLEEPING";
char* str_exit="EXITED";
char* str_unknown="UNKNOWN";

inline char* status_to_str(task_status_t status)
{
    switch(status)
    {
        case TASK_RUNNING: return str_running;
        case TASK_READY: return str_ready;
        case TASK_BLOCKED: return str_blocked;
        case TASK_EXITED: return str_exited;
        return str_unknown;
    }
}

inline void cmd_ps()
{
    printf("[Process Table] --------------------\n");
    int i=0;
    int cnt=0;
    for(;i<NUM_MAX_TASK;i++)
    {
        if(pcb[i].valid)
        {
            printf("[%d] PID: %d  STATUS: %s",cnt++,pcb[i].pid,status_to_str(pcb[i].status));
        }
    }
}

inline void cmd_about()
{
	printf(" Lagenaria Siceraria OS\n");
	printf(" Copyright (C) 2018 Huaqiang Wang\n");
}

inline void cmd_history()
{
    //TODO
	printf(" Lagenaria Siceraria OS\n");
	printf(" Copyright (C) 2018 Huaqiang Wang\n");
}

inline void cmd_exec()
{
    //TODO
}

inline void cmd_kill()
{
    //TODO
}

// Shell itself
void test_shell()
{
    disable_interrupt();
    // init_other_tasks(num_task5_tasks,task5_tasks);
    enable_interrupt();

    shell_drawline();

    while (1)
    {
        // read command from UART port
        disable_interrupt();
        char ch = read_uart_ch();
        enable_interrupt();
        sys_move_cursor(SHELL_LINE_POSITION + 2);
        printf("%c", ch);

        // TODO solve command
        if (ch != '\n')
        {
            shell_drawline();
            shell_add_to_buffer(ch);
            sys_move_cursor(1, shell_line_position + SHELL_LINE_POSITION + 1);
            shell_update_current_line();
        }
        else
        {
            disable_interrupt();
            shell_add_to_buffer('\0');
            char temp[50] = "> root@LSOS:", shell_buffer;
            shell_print(temp);
            enable_interrupt();
        }
    }
}