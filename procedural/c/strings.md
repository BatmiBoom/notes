# Strings

We define strings like this

`char *msg = "ssh terminal.shop for the best coffee";`

`msg` is a pointer to the first character of the string `"ssh termina.shop for the best coffe"`, which is a `C string`.

## C strings

- How we represent text in C programs
- Any number of characters (`char`s) terminated by a null character (`'\0'`)
- A pointer to the first element of a character array.

It's important to understand that most string manipulation in C is done using pointers to move around the array and the null terminator is critical for determining the end of a string.

In the example above, the string "ssh terminal.shop for the best coffee" is stored in memory as an array of characters, and the null terminator '\0' is automatically added at the end.

C Strings are Simple

- Unlike other programming languages, C strings do not store their length.
- The length of a C string is determined by the position of the null terminator (`'\0'`).
- Functions like `strlen` calculate the length of a string by iterating through the characters until the null terminator is encountered.
- This lack of length storage requires careful management to avoid issues such as buffer overflows and off-by-one errors during string operations.

## Pointers vs Arrays

You can declare strings in C using either arrays or pointers:

```c
char str1[] = "Hi";
char *str2 = "Snek";
printf("%s %s\n", str1, str2);
```

The output is the same. Let's break down the memory of this example:

```c
// notice we aren't using all 50 characters
char first[50] = "Snek";
char *second = "lang!";
strcat(first, second);
printf("Hello, %s\n", first); // Output: Hello, Sneklang!
```

The `strcat` function appends its second argument to the first argument.

Here's what first might look like in memory:
|'S' |'n' |'e' |'k' |'\0' |???? |... |????|
|----|----|----|----|-----|-----|----|-----|
|0x3000 |0x3001 |0x3002 |0x3003 |0x3004 |0x3005 |... |0x3050|

NOTE! There is a bunch of garbage memory after the end of the string.

Here's what second might look like in memory:
|'l' | 'a' | 'n' | 'g' | '!' | '\0'|
|------|-------|-------|-------|-------|-------|
|0x4000| 0x4001| 0x4002| 0x4003| 0x4004| 0x4005|

## Concat Function

```c
void concat_strings(char *str1, const char *str2) {
  int i = 0;

  while (str1[i] != '\0') {
    i++;
  }

  int j = 0;
  while (str2[j] != '\0') {
    str1[i] = str2[j];
    i++;
    j++;
  }
}
```

## Smart append

- Checks for available space before appending.
- Appends as much as possible if there's not enough space.
- Always ensures the buffer remains null-terminated.
- Returns a status indicating whether the full append was possible.

```c
#include <string.h>
#include "exercise.h"

int smart_append(TextBuffer* dest, const char* src) {
  if (dest->buffer == NULL || src == NULL) {
    return 1;
  }

  size_t src_len = strlen(src);
  size_t remainig_space_dest = sizeof(dest->buffer) - dest->length - 1;

  if (src_len > remainig_space_dest) {
    strncat(dest->buffer, src, remainig_space_dest);
    dest->length = 63;
    return 1;
  }

  strcat(dest->buffer, src);
  dest->length += src_len;
  return 0;
}
```
