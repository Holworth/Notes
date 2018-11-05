#include "string.h"
#include "stdio.h"
#include "mailbox.h"
#include "lock.h"
#include "sync.h"

#define MAX_NUM_BOX 32

static mailbox_t mboxs[MAX_NUM_BOX];

mutexs_lock_t mailbox_lock;

void mbox_init()
{
    do_mutex_lock_init(&mailbox_lock);
}

mailbox_t *mbox_open(char *name)
{
    mutex_lock_acquire(mailbox_lock);
    int i=0;
    int find_empty=-1;
    for(i=0;i<MAX_NUM_BOX;i++)
    {
        if(!strcmp(mboxs[i].name,name))
        {
            mboxs[i].quote++;
            return &mboxs[i];
        }
        if(!mboxs[i].valid)
        {
            find_empty=i;
        }
    }
    if(find_empty==-1)error("MBOXS_FULL");
    mboxs[find_empty].quote++;
    mboxs[find_empty].valid=1;
    do_semaphore_init(mboxs[find_empty].full,0);
    do_semaphore_init(mboxs[find_empty].empty,1);
    mutex_lock_release(mailbox_lock);
    return &boxs[find_empty];
}

void mbox_close(mailbox_t *mailbox)
{
    mutex_lock_acquire(mailbox_lock);
    mailbox.quote--;
    if(mailbox.quote<=0)
    {
        mailbox.valid=0;
    }
    mutex_lock_release(mailbox_lock);
}

void mbox_send(mailbox_t *mailbox, void *msg, int msg_length)
{
    sys_semaphore_down(&mailbox->empty);
    mutex_lock_acquire(mailbox_lock);
    memcpy(&mailbox->content,msg,msg_length);
    mailbox->length=msg_length;
    mutex_lock_release(mailbox_lock);
    sys_semaphore_up(&mailbox->full);
}

void mbox_recv(mailbox_t *mailbox, void *msg, int msg_length)
{
    sys_semaphore_down(&mailbox->full);
    mutex_lock_acquire(mailbox_lock);
    memcpy(msg,&mailbox->content,msg_length);
    mutex_lock_release(mailbox_lock);
    sys_semaphore_up(&mailbox->empty);
}