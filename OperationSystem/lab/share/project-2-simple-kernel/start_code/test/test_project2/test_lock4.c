#include "test2.h"
#include "lock.h"
#include "stdio.h"
#include "syscall.h"

int is_init = FALSE;
int is_init2 = FALSE;
static char blank[] = {"                                             "};

/* if you want to use spin lock, you need define SPIN_LOCK */
//  #define SPIN_LOCK
spin_lock_t spin_lock;

/* if you want to use mutex lock, you need define MUTEX_LOCK */
#define MUTEX_LOCK
mutex_lock_t mutex_lock;
mutex_lock_t mutex_lock2;
mutex_lock_t mutex_lock3;

void lock_task1(void)
{
    int print_location = 3;
    int cnt = 0;
    while (1)
    {
        int i;
        if (!is_init)
        {

#ifdef SPIN_LOCK
            spin_lock_init(&spin_lock);
#endif

#ifdef MUTEX_LOCK
            mutex_lock_init(&mutex_lock);
#endif
            is_init = TRUE;
        }

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK1] Applying for lock1. (%d)\n", cnt++);

#ifdef SPIN_LOCK
        spin_lock_acquire(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_acquire(&mutex_lock);
#endif

        for (i = 0; i < 20; i++)
        {
            sys_move_cursor(1, print_location);
            printf("> [LOCK1] Has acquired lock1 and running.(%d)\n", i);
        }

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK1] Has acquired lock1 and exited.\n");

#ifdef SPIN_LOCK
        spin_lock_release(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_release(&mutex_lock);
#endif
    }
}

void lock_task2(void)
{
    int print_location = 4;
    int cnt = 0;
    while (1)
    {
        int i;
        if (!is_init)
        {

#ifdef SPIN_LOCK
            spin_lock_init(&spin_lock);
#endif

#ifdef MUTEX_LOCK
            mutex_lock_init(&mutex_lock);
#endif
            is_init = TRUE;
        }

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK2] Applying for lock1. (%d)\n", cnt++);

#ifdef SPIN_LOCK
        spin_lock_acquire(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_acquire(&mutex_lock);
#endif

        for (i = 0; i < 30; i++)
        {
            sys_move_cursor(1, print_location);
            printf("> [LOCK2] Has acquired lock1 and running.(%d)\n", i);
        }

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK2] Has acquired lock1 and exited.\n");

#ifdef SPIN_LOCK
        spin_lock_release(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_release(&mutex_lock);
#endif
    }
}

void lock_task3(void)
{
    int print_location = 8;
    int cnt = 0;
    while (1)
    {
        int i;
        if (!is_init)
        {

#ifdef SPIN_LOCK
            spin_lock_init(&spin_lock);
#endif

#ifdef MUTEX_LOCK
            mutex_lock_init(&mutex_lock);
#endif
            is_init = TRUE;
        }

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK3] Applying for lock1. (%d)\n", cnt++);

#ifdef SPIN_LOCK
        spin_lock_acquire(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_acquire(&mutex_lock);
#endif

        for (i = 0; i < 30; i++)
        {
            sys_move_cursor(1, print_location);
            printf("> [LOCK3] Has acquired lock1 and running.(%d)\n", i);
        }

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK3] Has acquired lock and exited.\n");

#ifdef SPIN_LOCK
        spin_lock_release(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_release(&mutex_lock);
#endif
    }
}

void lock_task4(void)
{
    int print_location = 9;
    int cnt = 0;
    while (1)
    {
        int i;
        if (!is_init2)
        {

#ifdef SPIN_LOCK
            spin_lock_init(&spin_lock);
#endif

#ifdef MUTEX_LOCK
            mutex_lock_init(&mutex_lock2);
#endif
            is_init2 = TRUE;
        }

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK4] Applying for lock2. (%d)\n", cnt++);

#ifdef SPIN_LOCK
        spin_lock_acquire(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_acquire(&mutex_lock2);
#endif

        for (i = 0; i < 30; i++)
        {
            sys_move_cursor(1, print_location);
            printf("> [LOCK4] Has acquired lock2 and running.(%d)\n", i);
        }

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK4] Has acquired lock2 and exited.\n");

#ifdef SPIN_LOCK
        spin_lock_release(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_release(&mutex_lock2);
#endif
    }
}

void lock_task5(void)
{
    int print_location = 10;
    sys_move_cursor(1, 11);
    printf("> [LOCK5] lock_task5(void) inited\n");
    sys_move_cursor(1, print_location);
    printf("> [LOCK5] lock_task5(void) inited\n");
    int cnt = 0;
    while (1)
    {
        int i;
        if (!is_init)
        {

#ifdef SPIN_LOCK
            spin_lock_init(&spin_lock);
#endif

#ifdef MUTEX_LOCK
            mutex_lock_init(&mutex_lock);
#endif
            is_init = TRUE;
        }
        if (!is_init2)
        {

#ifdef SPIN_LOCK
            spin_lock_init(&spin_lock);
#endif

#ifdef MUTEX_LOCK
            mutex_lock_init(&mutex_lock2);
#endif
            is_init = TRUE;
        }

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK5] Applying for lock1. (%d)\n", cnt++);

#ifdef SPIN_LOCK
        spin_lock_acquire(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_acquire(&mutex_lock);
#endif

        for (i = 0; i < 30; i++)
        {
            sys_move_cursor(1, print_location);
            printf("> [LOCK5] Has acquired lock1 and running.(%d)\n", i);
        }

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK5] Applying for lock2. (%d)\n", cnt++);

#ifdef SPIN_LOCK
        spin_lock_acquire(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_acquire(&mutex_lock2);
#endif

        for (i = 0; i < 40; i++)
        {
            sys_move_cursor(1, print_location);
            printf("> [LOCK5] Has acquired lock1, lock2 and running.(%d)\n", i);
        }
        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [LOCK5] Has acquired lock1, lock2 and exited.\n");

#ifdef SPIN_LOCK
        spin_lock_release(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_release(&mutex_lock2);
#endif

        sys_move_cursor(1, print_location);
        printf("%s", blank);

        sys_move_cursor(1, print_location);
        printf("> [TASK] Has acquired lock1, lock2 and exited.\n");

#ifdef SPIN_LOCK
        spin_lock_release(&spin_lock);
#endif

#ifdef MUTEX_LOCK
        mutex_lock_release(&mutex_lock);
#endif
    }
}