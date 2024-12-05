# Hello World in C

```c
#include <stdio.h>

int main() {
    printf("Hello World...\n");
    return 0;
}
```

## Simplest C Program

```c
int main() {
    return 0;
}
```

- A function named `main` is always the entry point to a C program
- `int` is the return type of the function. Because this is the main function, the return value is the exit code of the program. 0 means success, anything else means failure.
- `return 0` returns the 0 value from the function.
- The pesky `;` is required in C to terminate statements

## Print

Print in C is done with a function called `printf` from the `stdio.h` (standard input/output) library. To use it, you need an `#include` at the top of your file

`include <stdio.h>`

Then you can use `printf` from inside a function:

`printf("Hello, World!\n");`

### Printing Variables

Common _format specifiers_ are:

- `%d` - digit
- `%c` - char
- `%f` - float
- `%s` - char\*

```c
#include <stdio.h>

int main() {
    int age = 30;
    char* name = "Nico";
    printf("Hello, %s, You're %d years old. \n", name, age);
    return 0;
}
```

## Comments

Two ways to write comments:

```c
// This is a single-line comment

/*
multi
line
*/
```

# Basic Types

- `int` - An integer
- `float` - A floating point number
- `char` - A character
- `char*` - An array of characters

## Variables

Variables cannot change types, however their value can change.

`qualifier type identifier = value;`

```c
#include <stdio.h>

int main() {
    int x = 5;
    x = 10;
    x = 15;
    return 0;
}
```

## Constants

We can use the `const` type qualifier

```c
int main() {
    const int x = 5;
    x = 10; // error
}
```

## Strings

C strings are just arrays of characters. To define a string we do

```c
char* msg_from_dax = "You still have 0 users";
```

## Functions

Functions specify the types for their arguments and return value.

```c
float add(int x, int y) {
    return (float)(x + y);
}
```

- The first type, `float` is the return type.
- `add` is the name of the function.
- `int x`, `int y` are the arguments to the function, and their types are specified.
- `x + y` adds the two arguments together.
- `(float)` casts the result to a `float`.

Here's how you would call this function:

```c
int main() {
    float result = add(10, 5);
    printf("result: %.f\n", result);
    return 0;
}
```

## Void

In C, there's a special type for function signatures `void`. There are two primary ways you'll use `void`:

- To explicitly state that a function takes no arguments:
  ```c
  int get_integer(void) {
      return 42;
  }
  ```
- When a function doesn't return anything:
  ```c
  void print_integer(int x) {
      printf("This is an int: %d", x);
  }
  ```

`void` is not like `None` in Python. It's not a value that can be assigned to a variable. _It's just a way to say that a function doesn't return anything or doesn't take any arguments_

## File Layout

- `.c` files contain the implementation (c code)
- `.h` files are header flies that contain the function prototypes

To import code from another file, you include the `.h` file

This example includes a function, and a way to use the munit testing framework.

- exercise.h
  ```c
  float get_average(int x, int y, int z);
  ```
- exercise.c
  ```c
  float get_average(int x, int y, int z) {
    return (float)(x + y + z) / 3;
  }
  ```
- main.c

  ```c
  #include "munit.h"
  #include "exercise.h"

  munit_case(RUN, test_get_average, {
    float result = get_average(3, 4, 5);
    munit_assert_double_equal(result, 4.0. "Average of 3,4,5 is 4")
  })

  int main() {
    MunitTest tests[] = {
        munit_test("/get_average", test_get_average),
        munit_test("/get_average_float", test_non_integer),
        munit_test("/get_average_same", test_average_of_same),
        munit_test("/get_average_big", test_average_of_big_numbers),
          munit_null_test,
    };

    MunitSuite suite = munit_suite("get_average", tests);

    return munit_suite_main(&suite, NULL, 0, NULL);
  }
  ```

## Math Operators

All the same operators you'd expect exist in C:

```c
x + y;
x - y;
x * y;
x / y;
```

If you're coming from Python, `+=`, `-=`, `*=`, `/=` are all the same.

In addition, there are also the `++` and `--` operators:

```c
x++; // += 1
x--; // -= 1
```

These increment (++) and decrement (--) operators can be used in two forms: `postfix` and `prefix`.

- Postfix (x++ or x--): The value of x is used in the expression first, and then x is incremented or decremented. For example:
  ```c
  int a = 5;
  int b = a++; // b is assigned 5, then a becomes 6
  ```
- Prefix (++x or --x): x is incremented or decremented first, and then the new value of x is used in the expression. For example:
  ```c
  int a = 5;
  int b = ++a; // a becomes 6, then b is assigned 6
  ```

> Avoid prefix operators. If we want to increment a variable but keep the original value, i do that in two steps. Postfix is more common

## If Statements

Most basic form of control flow in C

```c
if (x > 3) {
    printf("x is greater than 3\n");
}
```

`if/else/else if` are also available

```c
if (x > 3) {
    printf("x is greater than 3\n");
} else if (x == 3) {
    printf("x is 3\n");
} else {
    printf("x is less than 3\n");
}
```

## Ternary

Like JavaScript, C has a ternary operator:

```c
int a = 5;
int b = 10;
int max = a > b ? a : b;
printf("max: %d\n", max);
```

Let's break down the syntax:

`a > b ? a : b`

The entire line is a single expression that evaluates to one value. Here's how it works:

- a > b is the condition
- a is the final value if the condition is true
- b is the final value if the condition is false

Ternaries are a way to write a simple if/else statement in one line.

## Type Sizes

In C, the size in memory of a type is not guaranteed to be the same on all systems. That's because the size of a type is dependent on the system's architecture. For example, on a 32-bit system, the size of an int is usually 4 bytes, while on a 64-bit system, the size of an int is usually 8 bytes - of course, you never know until you run `sizeof` with the compiler you plan on using.

However, some types are always guaranteed to be the same.

Basic C Types and Sizes:

- char
  - Size: 1 byte
  - Represents: Single character.
  - Notes: Always 1 byte, but can be signed or unsigned.
- float
  - Size: 4 bytes
  - Represents: Single-precision floating-point number.
- double
  - Size: 8 bytes
  - Represents: Double-precision floating-point number.

The actual sizes of these types can be determined using the sizeof operator in C for a specific platform, which we'll learn about next.

## Sizeof

C gives us a way to check the size of a type or a variable: `sizeof`.

You can use `sizeof` like a function (technically it's a unary operator)

```c
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

int main() {
    printf("sizeof(char) = %zu\n", sizeof(char));
    printf("sizeof(bool) = %zu\n", sizeof(bool));
    printf("sizeof(int) = %zu\n", sizeof(int));
    printf("sizeof(float) = %zu\n", sizeof(float));
    printf("sizeof(double) = %zu\n", sizeof(double));
    printf("sizeof(size_t) = %zu\n", sizeof(size_t));
}
```

Modifier `%zu` for printing `sizeof`

## `size_t`

The `size_t` type is a special type that is guaranteed to be able to represent the size of the largest possible object in the target platform's address space (i.e can fit any single, non-struct value inside of it)

## For Loop

A `for` in C is a control flow statement for repeated execution of a block of code.

The syntax of a `for` loop consist of three main parts:

1. Initialization
2. Condition
3. Final-expression

There is no "for each" (iterables) in C, we have to iterate over the numbers of indices in a list, and then we can access the item using the index.

`for (initlization; condition; final-expression) {}`

1. Initialization
   Executed only once at the beginning of the loop.
   Is typically used to initialize the loop counter: `int i = 0;`
2. Condition
   Checked before each iteration.
   If true, execute the body. If false, terminate the loop
   Often checks to ensure i is less than some value: `i < 5;`
3. Final-expression
   Executed after each iteration of the loop body.
   Can be used to update the loop counter or run any other code: `i++`
4. Loop Body
   The block of code that is executed while the condition is true.

```c
#include <stdio.h>

int main() {
    for (int i = 0; i < 5; i++) {
        printf("%d\n", i);
    }

    return 0;
}
```

## While Loop

A `while` is a control flow statement that allows code to be executed repeatedly based on a given boolean (`true`/`false`) condition. The loop continues to execute as long as the condition remains true.

`while (condition) {}`

Parts of a while Loop

1. Condition
   Checked before each iteration.
   If `true`, execute the body. If `false`, terminate the loop
2. Loop Body
   The block of code that is executed while condition is `true`.

```c
#include <stdio.h>

int main() {
    int i = 0;
    while (i < 5) {
        printf("%d\n", i);
        i++;
    }
    return 0;
}
```

Key Points

- The condition is evaluated before the execution of the loop body.
- If the condition is false initially, the loop body will never even start.
- If the condition never becomes false, you will get an infinite loop.

## Do While Loop

A `do while` loop in C is a control flow statement that allows code to be executed repeatedly based on a given boolean condition.

Unlike the `while` loop, the `do while` loop checks the condition after executing the loop body, so the loop body is always executed at least once.

`do {} while (condition);`

Parts of a do while Loop

1. Loop Body
   The block of code that is executed before checking the condition, and then repeatedly as long as the condition is true.
2. Condition:
   Checked after each iteration.
   If true, execute the body again. If false, terminate the loop

```c
#include <stdio.h>

int main() {
    int i = 0;
    do {
        printf("i = %d\n", i);
        i++;
    } while (i < 5);
    return 0;
}
```

Key Points

- The `do while` loop guarantees that the loop body is executed at least once, even if the condition is false initially.
- The most common scenario you will see a do-while loop used is in C macros - they let you define a block of code and execute it exactly once in a way that is safe across different compilers, and ensures that the variables created/referenced within the macro do not leak to the surrounding environment.
- If you end up looking at any source code for macros, you will probably see a few do-while loops. For example, here's a simplified version from our `munit` testing library we're using:

```c
#define munit_assert_type_full(T, fmt, a, op, b, msg)
    do {
        T munit_tmp_a_ = (a);
        T munit_tmp_b_ = (b);
        if (!(munit_tmp_a_ op munit_tmp_b_)) {
            munit_errorf("assertion failed: %s %s %s (" prefix "%" fmt suffix " %s " "%" fmt "): %s", #a, #op, #b, munit_tmp_a_, #op, munit_tmp_b_, msg);
        }
    } while (0)
```

It creates a `do-while` loop, creates a few new variables and then checks that the assertion is valid. If it is not, then it errors and formats a (complicated) error message

> Note: there is no semi-colon after the while(0). This lets the macro be used in a block of code without causing syntax errors.

## Pragma Once and Header Guards

We saw how `.h` header files are used in a previous lesson, let's talk about a potential issue you might run into: multiple inclusions. If the same header file gets included more than once, you can end up with some nasty errors caused by redefining things like functions or structs.

### Pragma once

One simple solution is `#pragma once`. Adding this line to the top of a header file tells the compiler to include the file only once

```c
// my_header.h

#pragma once

struct Point {
    int x;
    int y;
};
```

### Header Guards

Another common way to avoid multiple inclusions is with include guards, which use preprocessor directives like this:

```c
#ifndef MY_HEADER_H
#define MY_HEADER_H

// some cool code

#endif
```

This method works by defining a unique macro for the header file. If it’s already been included, the guard prevents it from being processed again.
