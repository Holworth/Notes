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
            mutex_lock_release(&mailbox_lock);
            // printk("Find mbox %s\n",name);
            return &mboxs[i];
        }
        if(!mboxs[i].valid)
        {
            find_empty=i;
        }
    }
    if(find_empty==-1)panic("MBOXS_FULL");

    //Create new mailbox.
    mboxs[find_empty].quote++;
    mboxs[find_empty].valid=1;
    mboxs[find_empty].size=MAILBOX_SIZE;
    mboxs[find_empty].size_used=0;
    strcpy((char*)&mboxs[find_empty].name, (char*)name);
    do_condition_init(&mboxs[find_empty].not_full);
    do_condition_init(&mboxs[find_empty].not_empty);
    // printk("Created mbox %s\n",name);
    mutex_lock_release(&mailbox_lock);

    return &mboxs[find_empty];
}

void mbox_close(mailbox_t *mailbox)
{
    mutex_lock_acquire(&mailbox_lock);
    if(!mailbox->valid)panic("INVALID_MAILBOX");
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
    while((mailbox->size_used+msg_length)>mailbox->size)
    {
        sys_condition_wait(&mailbox->mutex_lock, &mailbox->not_full);
    }
    // printk("%x\n",((uint8_t*)&mailbox->content+mailbox->size_used));
    // printk("%x\n",(uint8_t*)msg);
    // printk("%x\n",(uint32_t)msg_length);
    mmemcpy(((uint8_t*)&(mailbox->content)+mailbox->size_used),(uint8_t*)msg,(uint32_t)msg_length);
    mailbox->size_used+=msg_length;
    sys_condition_broadcast(&mailbox->not_empty);
    mutex_lock_release(&mailbox->mutex_lock);
}

void mbox_recv(mailbox_t *mailbox, void *msg, int msg_length)
{
    mutex_lock_acquire(&mailbox->mutex_lock);
    // printk("mailbox->size_used: %d\n",mailbox->size_used);
    while(mailbox->size_used<msg_length)
    {
        sys_condition_wait(&mailbox->mutex_lock, &mailbox->not_empty);
    }
    mailbox->size_used-=msg_length;
    mmemcpy((uint8_t*)msg,(uint8_t*)&(mailbox->content)+mailbox->size_used,(uint32_t)msg_length);
    sys_condition_broadcast(&mailbox->not_full);
    mutex_lock_release(&mailbox->mutex_lock);
}