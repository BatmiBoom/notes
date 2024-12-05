# Low Level Stack

We're going to implement a stack again, but this time we're going to do it while manually managing the memory of generic pointers!

## Exercise

Take a look at `stack.h`, specifically the Stack struct.

1. count is the number of elements in the stack.
2. capacity is the number of elements the stack can hold before it needs to be resized in memory.
3. data is a pointer to all the generic data.

Implement the stack_new function:

1. Allocate memory for a new Stack struct on the heap.
2. If allocation fails, return NULL.
3. Initialize the count to 0.
4. Initialize the capacity to the given value.
5. Initialize the data by allocating enough memory for capacity number of `void *` pointers.
6. If allocation fails, free the Stack struct and return NULL.
7. Return the new Stack struct.

```c
// stack.h
#include <stddef.h>

typedef struct Stack {
  size_t count;
  size_t capacity;
  void **data;
} stack_t;

stack_t *stack_new(size_t capacity);
```

```c
//stack.c
#include "snekstack.h"
#include <stdlib.h>

stack_t *stack_new(size_t capacity) {
    stack_t* stack = malloc(sizeof(stack_t));
    if ( stack == NULL ) {
        return NULL;
    }

    void* data = malloc(capacity);
    if (data == NULL) {
        free(stack);
        return NULL;
    }

    stack->count = 0;
    stack->capacity = capacity;
    stack->data = data;

    return stack;
}
```

## Push

Our stack has a `count` and a `capacity`... but what happens when the `count` is equal to the `capacity`? We need to make room for more data

We'll take a simple approach: whenever we run out of capacity, we'll double it. That way we don't have to reallocate memory on every push

### Exercise

Complete the stack_push function. It safe(ish)ly adds a new object to the top of the stack. Remember: the size of the data array is the capacity of the stack, and the number of elements that are actually in the stack is the count (which is less than or equal to the capacity).

1. If the stack's count is equal to the stack's capacity:
   - Double the stack's capacity
   - Reallocate enough memory for the stack's data using the new capacity
   - If `realloc` fails, free the old data and return immediately
   - If it succeeds, update the stack's data field to point to the new memory
2. Add the new object to the top of the stack (the count-th element in the array)
3. Increment the stack's count

```c
void stack_push(stack_t *stack, void *obj) {
  if (stack->count == stack->capacity) {
    void **new_memory = realloc(stack->data, stack->capacity * 2);
    if (new_memory_ == NULL) {
        free(stack->data);
        return;
    }

    stack->capacity = stack->capacity * 2;
    stack->data = new_memory;
  }

  stack->data[stack->count] = obj;
  stack->count++;
  return;
}
```

## Pop

As you should know by now, items go on and off the stack from the same end (last in, first out).

Complete the stack_pop function.

1. If the stack is empty, return NULL.
2. Decrement the stack's count.
3. Return the top element of the stack (the count-th element in the array).

```c
void *stack_pop(stack_t *stack) {
    if (stack->data == NULL) {
        return;
    }

    stack->count--;
    return stack->data[stack->count];
}
```

## Free

In C, we don't have a lot of abstractions at our disposal. There's no classes, destructors, functors, monads, etc.

We've got data. And we've got functions.

So, to make it easier to work with our Stack, we're going to build our own little free function that will clean up all the memory that we've allocated for our stack.

### Assignment

Complete the stack_free function.

1. If the stack is NULL, return immediately.
2. If the stack data is NULL, return immediately.
3. Free the stack data.
4. Free the stack itself.

You can assume all of the elements inside of the stack are already freed. That's not our problem.

```c
void stack_free(stack_t *stack) {
    if (stack == NULL || stack->data == NULL) {
        return;
    }

    free(stack->data);
    free(stack);
}
```
