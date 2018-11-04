#include "string.h"
#include "mailbox.h"

#define MAX_NUM_BOX 32

static mailbox_t mboxs[MAX_NUM_BOX];

void mbox_init()
{
}

mailbox_t *mbox_open(char *name)
{
}

void mbox_close(mailbox_t *mailbox)
{
}

void mbox_send(mailbox_t *mailbox, void *msg, int msg_length)
{

}

void mbox_recv(mailbox_t *mailbox, void *msg, int msg_length)
{
}