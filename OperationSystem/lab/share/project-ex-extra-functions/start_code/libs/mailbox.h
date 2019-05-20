#ifndef INCLUDE_MAIL_BOX_
#define INCLUDE_MAIL_BOX_

#include "queue.h"
#include "sync.h"

#define MAILBOX_SIZE 100
typedef struct mailbox
{
    char name[25];//mailbox名称
    char content[MAILBOX_SIZE];//mailbox内容缓冲
    condition_t  not_full;//条件变量:非满
    condition_t  not_empty;//条件变量:非空
    int valid;//mailbox有效(被激活)
    int quote;//当前被引用数
    int size;//mailbox最大容量
    int size_used;//当前已使用的容量
    mutex_lock_t mutex_lock;//互斥锁, 用于维护mailbaox访问的原子性
} mailbox_t;

//Use linked list? array?
//Use array-linklist;

void mbox_init();
mailbox_t *mbox_open(char *);
void mbox_close(mailbox_t *);
void mbox_send(mailbox_t *, void *, int);
void mbox_recv(mailbox_t *, void *, int);

#endif