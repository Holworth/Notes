#include "queue.h"
#include "sched.h"
#include "vector.h"
#include "stack.h"


int stack_empty(struct int_stack* stack)
{
    return stack->point==0;
}

int stack_full(struct int_stack* stack)
{
    return stack->point==STACKSIZE;
}

int stack_push(struct int_stack* stack,uint32_t data)
{
    stack->data[stack->point++]=data;
}

uint32_t stack_pop(struct int_stack* stack)
{
    return stack->data[stack->point--];
}

