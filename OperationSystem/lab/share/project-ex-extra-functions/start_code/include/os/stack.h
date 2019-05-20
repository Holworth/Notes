#ifndef INCLUDE_STACK_H_
#define INCLUDE_STACK_H_

#define STACKSIZE 32
typedef struct int_stack
{
    int point;
    uint32_t data[STACKSIZE];
}stack_t;

struct int_stack freed_stack;

struct int_stack lock_stack;

struct int_stack queue_stack;


int stack_empty(struct int_stack* stack);
int stack_full(struct int_stack* stack);
int stack_push(struct int_stack* stack,uint32_t data);
uint32_t stack_pop(struct int_stack* stack);

#endif