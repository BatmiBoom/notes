# Structs

- Is part of the collection types
- In C, structs are passed by value.
- In C, we're only allowed to return a **single value** from a function.

`Structs` solve this. Here's an example of the syntax:

```c
struct Human {
    int age;
    char *name;
    int is_alive;
};
```

## Initializers

How do we actually make an instance of a struct? We define the struct type in `.h` files.

Unfortunately, there are a few different ways to initialize a `struct`, I'll give you an example of each using this struct:

```c
struct City {
    char \*name;
    int lat;
    int lon;
};
```

### Zero Initializer

This sets all the fields to 0 values.

```c
struct City c = {0};
```

### Positional Initializer

```c
struct City c = {"San Francisco", 37, -122};
```

### Designated Initializer

This is my preferred way to initialize a struct. Why?

- It's easier to read
- If the fields change, you don't have to worry about breaking the ordering

```c
int main() {
    struct City c = {
        .name = "San Francisco",
        .lat = 37,
        .lon = -122
    };
}

```

### Accessing Fields

Accessing a field in a struct is done using the `.` operator. For example:

```c
struct City c;
c.lat = 41; // Set the latitude
printf("Latitude: %d", c.lat); // Print the latitude
```

### Returning a Struct

There is two main ways

```c
// Normal Way
struct Point createPoint(int x, int y) {
    struct Point p;  // Declare a struct variable
    p.x = x;         // Assign values to its fields
    p.y = y;
    return p;        // Return the struct
}

// Available in C >= 99
struct Coordinate new_coord(int x, int y, int z) {
  return (struct Coordinate){
    .x = x,
    .y = y,
    .z = z
  };
}
```

### Return multiple values

We can accomplish effectively the same thing by returning a struct:

```c
struct Human become_older(int age, char *name) {
  struct Human h = {.age = age, .name = name};
  h.age++;
  return h;
}
```

## `typedef`

How can I make my struct types easier to write, like `int`?

C can do this with the `typedef` keyword.

```c
struct Pastry {
    char *name;
    float weight;
};
```

This can also be written as:

```c
typedef struct Pastry {
    char *name;
    float weight;
} pastry_t;
```

Now, you can use `pastry_t` wherever before you would have used `struct Pastry`. Note: The `_t` at the end is a common convention to indicate a type.

In fact, you can optionally skip giving the struct a name:

```c
typedef struct {
    char *name;
    float weight;
} pastry_t;
```

In this case you'd only be able to refer to the type as `pastry_t`.

```c
// coord.h
#pragma once

typedef struct Coordinate {
  int x;
  int y;
  int z;
} coordinate_t;

coordinate_t new_coord(int x, int y, int z);
coordinate_t scale_coordinate(coordinate_t coord, int factor);


// coord.c
#include "coord.h"

coordinate_t new_coord(int x, int y, int z) {
  coordinate_t coord = {.x = x, .y = y, .z = z};
  return coord;
}

coordinate_t scale_coordinate(coordinate_t coord, int factor) {
  coordinate_t scaled = coord;
  scaled.x *= factor;
  scaled.y *= factor;
  scaled.z *= factor;

  return scaled;
}
```

## Sizeof

We can also use `sizeof` to find out the size of `struct`

```c
printf("Size of coordinate_t: %zu bytes\n", sizeof(coordinate_t))
```

## Memory Layout

Structs are stored contiguously in memory one field after another

```c
typedef struct Coordinate {
    int x;
    int y;
    int z;
} coordiante_t;
```

Assuming `int` is 4 bytes, the memory layout for `coordinate_t` would look like:

```
|---------|---------|---------|
|         |         |         |
| field x | field y | field z |
|         |         |         |
|_________|_________|_________|
  4 bytes   4 bytes   4 bytes
```

### Mixed type structs

```c
typedef struct Human{
    char first_inital;
    int age;
    double height;
} human_t;
```

Assuming `char` is 1 byte, `int` is 4 bytes, and `double` is 8 bytes, the memory layout for human_t might look like this:

```
|---------|---------|---------|---------|
| first   |         |         |         |
| Initial | padding |   age   | height  |
|         |         |         |         |
|_________|_________|_________|_________|
  1 bytes   3 bytes   4 bytes   8 bytes
```

Wait! What is that `padding` doing here?

It turns out that CPUs can't access data that isn't aligned, so C inserts padding to maintain alignment (e.g. every 4 bytes in this example).

## Struct Padding

Almost all compilers use this basic rules:

- The fields of a struct are laid out in memory contiguously.
- Structs can vary in size depending on how they are laid out.

C is a language that aims to give tight control over memory, so the fact that you can control the layout of your structs is a feature, not a bug.

Compilers + modern hardware + optimizations + skill issues means that sometimes what you think the computer is going to do isn't exactly what it actually does. That said, C is designed to get you close to the machine and allows you to dig in and figure out what's going on if you want to for a specific compiler or architecture.

> As a rule of thumb, ordering your fields from largest to smallest will help the compiler minimize padding:

```c
typedef struct {
  char a;
  double b;
  char c;
  char d;
  long e;
  char f;
} poorly_aligned_t;

typedef struct {
  double b;
  long e;
  char a;
  char c;
  char d;
  char f;
} better_t;
```
