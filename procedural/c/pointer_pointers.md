# Pointer-Pointers

A pointer-to-pointer in C is just a pointer variable that holds the address of another pointer.

This allows you to create complex data structures like arrays of pointers, and to modify pointers indirectly. The syntax is exactly what you would expect:

```c
int value;
int *pointer;
int **pointer_pointer;
```

Pointers to pointers are like a treasure map or a scavenger hunt. You start at one pointer and keep following the chain of addresses until you get to the final value. It's just a chain of dereferences.

## Exercise

Complete the `allocate_int` function. It accepts a pointer to a pointer to an integer called pointer_pointer, and a raw value.

1. Allocate memory for a single integer on the heap, and save it's address into a new pointer.
2. Update the memory address that pointer_pointer is pointing to, to be the address of the new pointer.
3. Set the raw value of the integer that pointer_pointer now points to the value passed in.

```c
#include "stdlib.h"

void allocate_int(int **pointer_pointer, int value) {
  int* int_alloc = (int*)malloc(sizeof(int));

  *pointer_pointer = int_alloc;
  if (*pointer_pointer == NULL) {
    return;
  }

  **pointer_pointer = value;
}
```
