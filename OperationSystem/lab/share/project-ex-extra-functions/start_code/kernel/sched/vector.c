#include "queue.h"
#include "sched.h"
#include "vector.h"
#include "stack.h"

void vector_init(vector_t *vector)
{
    vector->head = vector->tail = NULL;
}

void vector_node_init(vector_node_t* node, void* val)
{
    node->prev=node->next=0;
    node->data=val;
}

int vector_is_empty(vector_t *vector)
{
    if (vector->head == NULL)
    {
        return 1;
    }
    return 0;
}

void vector_push(vector_t *vector, vector_node_t *item)
{
    /* vector is empty */
    if (vector->head == NULL)
    {
        vector->head = item;
        vector->tail = item;
        item->next = NULL;
        item->prev = NULL;
    }
    else
    {
        ((vector->tail))->next = item;
        item->next = NULL;
        item->prev = vector->tail;
        vector->tail = item;
    }
}

void *vector_devector(vector_t *vector)
{
    vector_node_t *temp = vector->head;

    /* this vector only has one item */
    if (temp->next == NULL)
    {
        vector->head = vector->tail = NULL;
    }
    else
    {
        vector->head = ((vector->head))->next;
        (vector->head)->prev = NULL;
    }

    temp->prev = NULL;
    temp->next = NULL;

    return (void *)temp;
}

/* test if an item exists in vector */
int vector_exist(vector_t *vector, void *item)
{
    vector_node_t *now = vector->head;
    while(now)
    {
        if(item==now)return 1;
        now=now->next;
    }
    return 0;
}

/* remove this item and return next item */
void *vector_remove(vector_t *vector, vector_node_t *item)
{
    vector_node_t *next = item->next;

    if (item == vector->head && item == vector->tail)
    {
        vector->head = NULL;
        vector->tail = NULL;
    }
    else if (item == vector->head)
    {
        vector->head = item->next;
        ((vector->head))->prev = NULL;
    }
    else if (item == vector->tail)
    {
        vector->tail = item->prev;
        ((vector->tail))->next = NULL;
    }
    else
    {
        ((item->prev))->next = item->next;
        ((item->next))->prev = item->prev;
    }

    item->prev = NULL;
    item->next = NULL;

    return next;
}
