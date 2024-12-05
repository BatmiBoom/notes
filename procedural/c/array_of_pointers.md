# Array of Pointers

Making an array of integers on the heap is pretty simple:

```c
int *int_array = malloc(sizeof(int) * 3);
int_array[0] = 1;
int_array[1] = 2;
int_array[2] = 3;
```

But we can also make an array of pointers! It's quite common to do this in C, especially considering that strings are just pointers to chars:

```c
char **string_array = malloc(sizeof(char *) * 3);
string_array[0] = "foo";
string_array[1] = "bar";
```

## Exercise

- Take a look at create_token_pointer_array. It correctly allocates an array of token pointers on the heap, but notice that the addresses it's adding to each index are the addresses of the stack-allocated inputs.

1. Update the create_token_pointer_array's loop to allocate new space for each token on the heap, and store the address of the new space in the array.
2. Copy the contents of the input struct into the newly allocated one.

```c
#include <stdlib.h>

token_t** create_token_pointer_array(token_t* tokens, size_t count) {
  token_t** token_pointers = (token_t**)malloc(count * sizeof(token_t*));
  if (token_pointers == NULL) {
    exit(1);
  }

  for (size_t i = 0; i < count; ++i) {
    // Before update : token_pointers[i] = &token;
    token_t* token = (token_t*)malloc(sizeof(token_t));
    *token = tokens[i];
    token_pointers[i] = token;
  }

  return token_pointers;
}
```
