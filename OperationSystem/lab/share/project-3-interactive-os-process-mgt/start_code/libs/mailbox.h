#ifndef INCLUDE_MAIL_BOX_
#define INCLUDE_MAIL_BOX_

#include "queue.h"
#include "sync.h"

#define MAILBOX_SIZE 100
typedef struct mailbox
{
    char name[25];
    char content[MAILBOX_SIZE];
    condition_t  not_full;
    condition_t  not_empty;
    int valid;
    int quote;
    int size;
    int size_used;
    mutex_lock_t mutex_lock;
} mailbox_t;

//Use linked list? array?
//Use array-linklist;

void mbox_init();
mailbox_t *mbox_open(char *);
void mbox_close(mailbox_t *);
void mbox_send(mailbox_t *, void *, int);
void mbox_recv(mailbox_t *, void *, int);

#endif