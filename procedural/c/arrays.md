# Arrays

- Fixed-size, ordered collection of elements.
- They are indexed by integers, starting at zero.
- They can only hold elements of the same type.
- They are stored in contiguous memory, like structs.
- They are passed by reference by default.

Integer Array

```c
int numbers[5] = {1, 2, 3, 4, 5};
```

## Iterating over an array

In C, there is no `for x in list:` syntax. We must iterate with a classic loop.

```c
#include <stdio.h>

int main() {
    int numbers[5] = {1, 2, 3, 4, 5};

    for (int i = 0; i < 5; i++) {
        printf("%d ", numbers[i]);
    }
    printf("\n");

    return 0;
}
```

## Updating values in an array

`arr[index] = value`

```c
#include <stdio.h>

int main() {
    int numbers[5] = {1, 2, 3, 4, 5};

    // Update some values
    numbers[1] = 20;
    numbers[3] = 40;

    // Print updated array
    for (int i = 0; i < 5; i++) {
        printf("%d ", numbers[i]);
    }
    printf("\n");

    return 0;
}
```

Passing an array to a function and modifying it on the function will change the values of the original array.

```c
#include "exercise.h"

void update_file(int filedata[200], int new_filetype, int new_num_lines){
  filedata[1] = new_num_lines;
  filedata[2] = new_filetype;
  filedata[199] = 0;
}
```

- [Array as pointers](./arrays_as_pointers.md)
- [Multibyte array](./multibyte_array.md.md)
- [Array Casting](./array_casting.md)
- [Arrays Decay to Pointers](./array_decay_to_pointers.md)
