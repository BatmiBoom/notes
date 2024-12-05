# Objects

We are gonna build "objects" like in python, when we talk about objects we mean a higher-level data structure that holds some metadata about itself.

- What type of data it holds
- The size of the data it holds
- The data itself
- How many references to itself exist

```c
typedef enum ObjectKind{
    INTEGER
} object_kind_t;

typedef union ObjectData{
    int v_int;
} object_data_t;

typedef struct Object{
    object_kind_t kind;
    object_data_t data;
} object_t;
```

## Integer

Let's start simple with a single integer object. The difference between a "object integer" and a regular C integer is that the object integer:

1. Is allocated on the heap
2. Can store additional metadata about itself (for now, just its type)

```c
object_t *new_integer(int value) {
    object_t *int_object = malloc(sizeof(object_t));
    if (mem_int == NULL) {
        return NULL;
    }

    int_object->kind = INTEGER;
    int_object->data.v_int = value;

    return int_object;
}
```

## Float

We're going to use the `union` and `enum` features in C to be able to do save float and int in the same object. You will need to extend the existing `object_kind_t` and `object_data_t` types to be able to include both int and floats.

```c
typedef enum ObjectKind{
    INTEGER,
    FLOAT
} object_kind_t;

typedef union ObjectData{
    int v_int;
    float v_float;
} object_data_t;

typedef struct Object{
    object_kind_t kind;
    object_data_t data;
} object_t;

object_t *new_float(float value) {
    object_t *float_object = malloc(sizeof(object_t));
    if (float_object == NULL) {
        return NULL;
    }

    float_object->kind = FLOAT;
    float_object->data.v_float = value;

    return int_object;
}
```

## String Object

When we allocate memory for a "object", that reserves memory for the object itself. Small data types like integers and floats are stored directly in the object, so there's no need for additional memory allocation.

Strings, however, are a different story. Strings in C are just arrays of characters, and because they can be any length, we need to dynamically allocate memory for the string data separately from the object itself.

`char *my_string = "hello world";`

In the example above, `my_string` is a pointer to a character array.

The character array contains: `h e l l o  w o r l d \0` the extra spot at the end with the `\0` is the null terminator. It's how C knows where the strings ends.

## Exercise

1. Add a new value in object_kind_t called `STRING`.
2. Add a new `char *` field to object_data_t called `v_string`
3. Declare the new_string function.
4. Allocate memory for a new pointer to a object_t.
5. If the allocation fails, return NULL.
6. Calculate the length in bytes using strlen of the string passed in.
7. Allocate memory in a `char *` field equal to the length of the string plus one (for the null terminator).
8. If the allocation fails, return NULL and free the memory allocated for the object.
9. Copy the data from the input value into the new string field you just allocated using strcpy.
10. Set the kind field to the appropriate enum.
11. Store the newly allocated string in the object.
12. Return the pointer to the new snek object.

```c
typedef enum ObjectKind{
    INTEGER,
    FLOAT,
    STRING
} object_kind_t;

typedef union ObjectData{
    int v_int;
    float v_float;
    char *v_string;
} object_data_t;

typedef struct Object{
    object_kind_t kind;
    object_data_t data;
} object_t;

object_t *new_string(char *value) {
    object_t *string_object = malloc(sizeof(object_t));
    if (string_object == NULL) {
        return NULL;
    }


    char *temp_string = malloc(strlen(value) + 1);
    if (temp_string == NULL) {
        free(string_object);
        return NULL;
    }
    strcpy(temp_string, value);

    string_object->kind = STRING;
    string_object->data.v_string = temp_string;

    return string_object;
}
```

## Advanced Objects

- [Vector 3](./objects_vector3.md)
- [Array](./objects_array.md)
