#ifndef INCLUDE_MAIL_BOX_
#define INCLUDE_MAIL_BOX_

typedef struct mailbox
{
    
} mailbox_t;

//Use linked list? array?
//Use array-linklist;

void mbox_init();
mailbox_t *mbox_open(char *);
void mbox_close(mailbox_t *);
void mbox_send(mailbox_t *, void *, int);
void mbox_recv(mailbox_t *, void *, int);

#endif