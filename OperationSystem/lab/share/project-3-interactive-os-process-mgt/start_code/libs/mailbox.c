#include "string.h"
#include "stdio.h"
#include "mailbox.h"
#include "lock.h"
#include "sync.h"

#define MAX_NUM_BOX 32

static mailbox_t mboxs[MAX_NUM_BOX];

mutex_lock_t mailbox_lock;

void mbox_init()
{
    do_mutex_lock_init(&mailbox_lock);
    int i=0;
    for(i=0;i<MAX_NUM_BOX;i++)
    {
        do_mutex_lock_init(&mboxs[i].mutex_lock);
    }
}

mailbox_t *mbox_open(char *name)
{
    mutex_lock_acquire(&mailbox_lock);
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
    mboxs[find_empty].size=MAILBOX_SIZE;
    mboxs[find_empty].size_used=0;
    // do_semaphore_init(mboxs[find_empty].full,0);
    // do_semaphore_init(mboxs[find_empty].empty,1);
    mutex_lock_release(&mailbox_lock);
    return &mboxs[find_empty];
}

void mbox_close(mailbox_t *mailbox)
{
    mutex_lock_acquire(&mailbox_lock);
    if(!mailbox->valid)error("INVALID_MAILBOX");
    mailbox->quote--;
    if(mailbox->quote<=0)
    {
        mailbox->valid=0;
    }
    mutex_lock_release(&mailbox_lock);
}

void mbox_send(mailbox_t *mailbox, void *msg, int msg_length)
{
    mutex_lock_acquire(&mailbox->mutex_lock);
    while(mailbox->size_used+msg_length<mailbox->size)
    {
        sys_condition_wait(&mailbox->mutex_lock, mailbox->not_full);
    }
    memcpy((uint8_t*)&mailbox->content+mailbox->size_used,(uint8_t*)msg,(uint32_t)msg_length);
    mailbox->size_used+=msg_length;
    sys_condition_broadcast(&mailbox->not_empty);
    mutex_lock_release(&mailbox->mutex_lock);
}

void mbox_recv(mailbox_t *mailbox, void *msg, int msg_length)
{
    mutex_lock_acquire(&mailbox_lock);
    while(mailbox->size_used+msg_length<mailbox->size)
    {
        sys_condition_wait(&mailbox->mutex_lock, mailbox->not_empty);
    }
    mailbox->size_used-=msg_length;
    memcpy((uint8_t*)msg,(uint8_t*)&mailbox->content+mailbox->size_used,(uint32_t)msg_length);
    sys_condition_broadcast(&mailbox->not_full);
    mutex_lock_release(&mailbox_lock);
}