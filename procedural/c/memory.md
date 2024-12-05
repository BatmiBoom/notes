# Memory

> Variables are human readable names that refer to some data in memory.

> Memory is a big array of bytes, and data is stored in the array.

A variable is a human readable name that refers to an address in memory, which is an index into the big array of bytes.

```
| variable | value      | address | size |
|----------|------------|---------|------| |-> |----| 0
|   name   | "teej"     |    0    |  4b  |-|   |    | .
|          |            |         |      | |   |    | .
|----------|------------|---------|------| |-> |----| 4
|          |            |         |      | |   |    | .
|  handle  | "teej_dev" |    4    |  8b  |-|   |    | .
|          |            |         |      | |   |    | .
|          |            |         |      | |   |    | .
|----------|------------|---------|------| |-> |____| 11

```

## Getting a Variable's Address

In C, you can print the address of a variable by using the address-of-operator: `&`. Here's an example:

```c
#include <stdio.h>

int main() {
  int age = 37;
  printf("The address of age is: %p\n", &age);
  return 0;
}

// The address of age is: 0xfff8
```

> Note: The %p format specifier will format a pointer to be printed.

## What is an Address?

Memory can be thought of as a big array of bytes, and each byte has an address.

The beauty is that each address is literally just a **number**.

You might be thinking, "Hey, if it's just a number, why does it look all disgusting like `0xfff8`?"

That's because `0xfff8` is just a number. But:

- It's written in hexadecimal (base 16) instead of decimal (base 10).
- It's a pretty big number, so it's not very human readable. `0xfff8` is the same as `65,528` in decimal.
  ```
  |-------|-------|-------|
  | 0x408 | 0x409 | 0x40A | hexadecimal
  | 1032  | 1033  | 1034  | decimal
  |_______|_______|_______|
  ```

## Virtual Memory

As it turns out, your code probably doesn't have direct access to the physical RAM in your computer.

Instead, your operating system provides a layer of abstraction called virtual memory. Virtual memory makes it seem like your program has direct access to all the memory on the machine, even if it doesn't.

- Physical Memory: The actual RAM sticks in your computer.
- Operating System: The software that manages access to the physical memory.
- Your Program: When it runs, it becomes a process and is given access to a chunk of virtual memory by the operating system.
- Virtual Memory: This abstracted chunk of memory that your program can use.

```
|---------| can i have memory? |----|      |----------|
| Program |------------------->|    |      | Physical |
|_________|                    |    |      | Memory   |
|---------|                    | OS |      |__________|
| Virtual |   knock yourself   |    |----->|          |
| Memory  |<-------------------|    |------|          |
|_________|        out         |____|      |__________|
```

By only giving processes access to a chunk of virtual memory, the operating system can do some cool things:

- Isolation: One process can't access the memory of another process.
- Security: The operating system can prevent processes from accessing certain parts of memory.
- Simplicity: Developers don't have to worry about managing physical memory and the memory of other processes.
- Performance: The operating system can optimize memory access depending on the hardware and needs of the program. For example, by moving data between physical memory and the hard drive.
