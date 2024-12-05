# Unions

Unions in C can hold one of several times. They're like a less-strict `sum type` from the world of functional programming.

```c
typedef union AgeOrName {
    int age;
    char *name;
} age_or_name_t;
```

The `age_or_name_t` type can hold _either_ an `int` or a `char *`, but not both at the same time.

We provide the list of possible types so that the compiler knows the maximum potential memory requirement.

This is how the union is used:

```c
age_or_name_t lane = { .age = 29 };
prinf("age: %d\n", lane.age);
```

What happens if we try to access the `name` field after setting the field `age`

```c
printf("name: %s\n", lane.name);
// name:
```

We get undefined behavior. A union only reserves enough space to hold the largest type in the union and then all of the fields use the same memory. So when we set `.age` to `29`, we are writing the integer representation of 29 to the memory:

`0000 0000 0000 0000 0000 0000 0001 1101`

Then if we try to access `.name`, we read from the same block of memory but try to interpret the bytes as a `char *`, which is why we get garbage. Put simply, setting the value of `.age` overwrites the value of `.name` and vice versa, and you should only access the field that you set.

## Helper Fields

One interesting trick is to use unions to create "helpers" for accessing different parts of a piece of memory.

```c
typedef union Color {
    struct {
        uint8_t r;
        uint8_t g;
        uint8_t b;
        uint8_t a;
    } components;
    uint32_t rgba;
} color_t;
```

It results in a memory layout like this:

```
|-------------------------------|
|   R   |   G   |   B   |   A   |
|uint8_t|uint8_t|uint8_t|uint8_t|
|-------------------------------|
|              RGBA             |
|             uint32_t          |
|-------------------------------|
| 1byte | 1byte | 1byte | 1byte |
```

Only 4 bytes are used. And, unlike in 99% of scenarios, it makes sense to both set and get values from this union through both the `components` and `rgba` fields! Both fields in the union are exactly 32 bits in size, which means that we can "safely" (?) access the entire set of colors through the `.rgba` field, or get a single color component through the `.components` field.
