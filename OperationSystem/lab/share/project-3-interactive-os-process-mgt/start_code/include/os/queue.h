/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *                            Queue Algorithm
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE. 
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * */

#ifndef INCLUDE_LIST_H_
#define INCLUDE_LIST_H_

#include "type.h"

typedef struct queue
{
    void *head;
    void *tail;
} queue_t;

void queue_init(queue_t *queue);

int queue_is_empty(queue_t *queue);

void queue_push(queue_t *queue, void *item);

void *queue_dequeue(queue_t *queue);

/* remove this item and return next item */
void *queue_remove(queue_t *queue, void *item);

// typedef pcb_t item_t;

// typedef struct list
// {
//     int head;
//     int tail;
//     int empty;
//     pcb_t *list_array[NUM_MAX_TASK];
// } list_t;


// void list_init(list_t *list);

// int list_is_empty(list_t *list);

// void list_push(list_t *list, void *item);

// void *list_pop(list_t *list);

// /* remove this item and return next item */
// void *list_remove(list_t *queue, void *item);


#define STACKSIZE 32
struct int_stack
{
    int point;
    uint32_t data[STACKSIZE];
};

struct int_stack freed_stack;

struct int_stack lock_stack;

struct int_stack queue_stack;

int stack_empty()
{
    return int_stack->point==0;
}

int stack_full(struct *int_stack)
{
    return int_stack->point==STACK_SIZE;
}

int stack_push(struct int_stack* stack,uint32_t data)
{
    stack->data[stack->point++]=data;
}

uint32_t stack_pop(struct int_stack* stack)
{
    return stack->data[stack->point--];
}



#endif