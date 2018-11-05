#ifndef INCLUDE_MAIL_BOX_
#define INCLUDE_MAIL_BOX_

#include "queue.h"
#include "sem.h"

#define MAILBOX_SIZE 40
typedef struct mailbox
{
    char name[25];
    char content[MAILBOX_SIZE];
    semaphore_t  full;
    semaphore_t  empty;
    int  valid;
    //for debug
    int length;
} mailbox_t;

//Use linked list? array?
//Use array-linklist;

void mbox_init();
mailbox_t *mbox_open(char *);
void mbox_close(mailbox_t *);
void mbox_send(mailbox_t *, void *, int);
void mbox_recv(mailbox_t *, void *, int);

#endif