#ifndef INCLUDE_VECTOR_H_
#define INCLUDE_VECTOR_H_
#include "type.h"

typedef struct vector_node
{
    struct vector_node *prev;
    struct vector_node *next;
    void *data;
} vector_node_t;

typedef struct vector
{
    vector_node_t *head;
    vector_node_t *tail;
} vector_t;


void vector_init(vector_t *vector);
void vector_node_init(vector_node_t* node, void* val);
int vector_is_empty(vector_t *vector);
void vector_push(vector_t *vector, vector_node_t *item);
void *vector_devector(vector_t *vector);
int vector_exist(vector_t *vector, void *item);
void *vector_remove(vector_t *vector, vector_node_t *item);



#endif
