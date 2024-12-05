# Malloc

The `malloc` function (`m`emory `alloc`ation) is a standard library function in C that allocates a specified number of bytes of memory on the heap and returns a pointer to the allocated memory.

This new memory is **uninitialized**, which means:

- It contains whatever data was previously at that location.
- It is our responsibility to ensure that the allocated memory is properly initialized and eventually freed using `free` to avoid memory leaks.

If you want to make sure that the memory is properly initialized, you can use the `calloc` function, which allocated the specified number of bytes of memory on the heap and returns a pointer to the allocated memory. This memory is initialized to zero (meaning it contains all zeroes).

## Function Signature

```c
void* malloc(size_t size);
```

- `size`: The number of bytes to allocate
- Returns: A pointer to the allocated memory or `NULL` if the allocation fails.

## Example

```c
// Allocates memory for an array of 4 integers
int *ptr = malloc(4 * sizeof(int));
if (ptr == NULL) {
  // Handle memory allocation failure
  printf("Memory allocation failed\n");
  exit(1);
}
// use the memory here
// ...
free(ptr);
```

## Manual Memory Management

This idea of manually calling `malloc` and `free` is what puts the "manual" in "manually managing memory":

- The programmer must remember to eventually free the allocated memory using `free(ptr)` to avoid memory leaks.
- Otherwise, that allocated memory is never returned to the operating system for use by other programs. (Until the program exits, at which point the operating system will clean up after it, but that's not ideal.)

Example:

```c
#include <stdio.h>
#include <stdlib.h>

#include "exercise.h"

// Allocates an array of integers
int* allocate_scalar_list(int size, int multiplier) {
  int* scalar_list = (int*)malloc(size);
  if (scalar_list == NULL) {
    return NULL;
  }

  for (int i = 0; i < size; i++) {
    scalar_list[i] = i * multiplier;
  }

  return scalar_list;
}
```

# Realloc

The `realloc` function is used to resize memory that was previously allocated with `malloc` or `calloc`. It takes a pointer to the old memory and the new size, and returns a pointer to the new memory:

```c
void *realloc(void *ptr, size_t size);

int *smol_boi = malloc(10 * sizeof(int));
int *large_boi = realloc(smol_boi, 20 * sizeof(int));
```

# Free

The `free` function deallocates memory that was previously allocated by `malloc`, `calloc` or `realloc`.

> `free` does not change the **value** stored in the memory, and it doesn't even change the address stored in the pointer, It simply informs the Operating System that the memory can be used again.

## Forgetting to free

Forgetting to call `free` leads to a memory leak.

This means that the allocated memory remains occupied and cannot be reused, even though the program no longer needs it.

Memory leaks are one of the most common bugs in C programs, and they can be difficult to track down because the memory is still allocated and accessible, even though it is no longer needed.

# Big Endian and Little endian

Endianness is the order in which bytes are stored in memory. The two most common formats are big endian and little endian.

## Big Endian

In a big-endian system, the most significant byte is stored first, at the lowest memory address. The "most significant byte" is just a fancy way of saying "the biggest part of the number".

Let's say we ahve the hexadecimal number `0x12345678`. Here's how it would be storerd in big-endian format:

```
lower addresses        higher addresses
| 0x12 | 0x34 | 0x56 | 0x78 |
most significant       least significant
```

The most significant byte (0x12) is stored at the lowest memory address.

## Little endian

In a little-endian system, the least significant byte (the "smallest" part of the number) is stored first, at the lowest memory address. This is the format used by most modern computers.

Using the same number `0x12345678`, here’s how it would be stored in little-endian format:

```
lower addresses        higher addresses
| 0x78 | 0x56 | 0x34 | 0x12 |
most significant       least significant
```

Here, the least significant byte (0x78) is stored first.
