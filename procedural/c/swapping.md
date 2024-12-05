# Swapping Integers

## Exercise

- Start with just swapping some integers. Complete the `swap_ints` function. It accepts two pointers to integers, and should swap the values of the integers they point to.

```c
void swap_ints(int* a, int* b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}
```

# Swapping Strings

## Exercise

Complete the `swap_strings` function. It swaps the values stored in the string pointers.

- `char**` is a `pointer` to a `char pointer`, which means we can simply switch the "address" that we're referencing in our `swap`

```c
void swap_strings(char **a, char **b) {
    char* tmp = *a;
    *a = *b;
    *b = tmp;
}
```

# Generic Swap

For the previous `swap` implementations we've known the type of the data we want to swap. Because we knew the type, the compiler knew the sizes of the data we want to swap.

However, to make a generic swap, we will need to provide the C compiler with the size of the data that we are swapping because `void *` loses that type info.

```c
void swap(void* vp1, void* vp2, size_t size);
```

The other problem we're going to have is that directly assigning pointer values does not work the same way with `void*`. Instead of using `*ptr1 = *ptr2`, we will use `memcpy`, which is included in the `string.h` library:

```c
void *memcpy(void *destination, void* source, size_t size);
```

So to move the data from ptr2 to ptr1, we will use the following:

```c
memcpy(ptr1, ptr2, size);
```

## Exercise

Implement the generic `swap()` function.

1. Allocate memory for a temporary buffer to store the data using `malloc`.
2. If the allocation fails (returns NULL) return immediately.
3. Use `memcpy` to shuffle the data around.
4. Don't forget to free the temporary buffer.

```c
#include <stdlib.h>
#include <string.h>

void swap(void *vp1, void *vp2, size_t size) {
    int *tmp= malloc(size);
    if ( tmp == NULL ) {
        return;
    }

    memcpy(tmp, vp1, size);
    memcpy(vp1, vp2, size);
    memcpy(vp2, tmp, size);

    free(tmp);
}
```
