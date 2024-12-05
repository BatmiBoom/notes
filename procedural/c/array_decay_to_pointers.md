# Arrays Decay to Pointers

So we know that arrays are like pointers, but they're not exactly the same. Arrays allocate memory for all their elements, whereas pointers just hold the address of a memory location. In many contexts, arrays decay to pointers, meaning the array name becomes "just" a pointer to the first element of the array.

## When arrays decay

Arrays decay when used in expressions containing pointers:

```c
int arr[5];
int *ptr = arr;          // 'arr' decays to 'int*'
int value = *(arr + 2);  // 'arr' decays to 'int*'
```

**And also when they're passed to functions**

That's why you can't pass an array to a function by value like you do with a struct; instead, the array name decays to a pointer.

## When arrays don't decay

- `sizeof` Operator: Returns the size of the entire array, not just the size of a pointer.
- `&` Operator Taking the address of an array with `&arr` gives you a pointer to the whole array, not just the first element. The type of `&arr` is a pointer to the array type, e.g., `int *[5]` for an int array with 5 elements.
- Initialization: When an array is declared and initialized, it is fully allocated in memory and does not decay to a pointer.

```c
#include <stdio.h>

void core_utils_func(int core_utilization[]) {
  printf("sizeof core_utilization in core_utils_func: %zu\n", sizeof(core_utilization)); // 4 - decayed array - pointer size
}

int main() {
  int core_utilization[] = {43, 67, 89, 92, 71, 43, 56, 12};
  int len = sizeof(core_utilization) / sizeof(core_utilization[0]);
  printf("sizeof core_utilization in main: %zu\n", sizeof(core_utilization)); // 32
  printf("len of core_utilization: %d\n", len); // 8
  core_utils_func(core_utilization);
  return 0;
}
```

Take a look at the `main` function. It declares an array of numbers `core_utilization`. The array has 8 elements. Before passing the array to `core_utils_func` it prints the size of the array and the length of the array.

Notice that due to the array decaying to a pointer, the reported size in `core_utils_func` is the size of a pointer, not the size of the actual array.
