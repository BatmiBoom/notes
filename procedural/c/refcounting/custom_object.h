#pragma once

#include <stdbool.h>
#include <stddef.h>

typedef struct Object object_t;

typedef struct {
    size_t size;
    object_t **elements;
} array_t;

typedef struct {
    object_t *x;
    object_t *y;
    object_t *z;
} vector_t;

typedef enum ObjectKind {
    INTEGER,
    FLOAT,
    STRING,
    VECTOR3,
    ARRAY,
} object_kind_t;

typedef union ObjectData {
    int v_int;
    float v_float;
    char *v_string;
    vector_t v_vector3;
    array_t v_array;
} object_data_t;

typedef struct Object {
    object_kind_t kind;
    object_data_t data;
    size_t refcount;
} object_t;

object_t *new_integer(int value);
object_t *new_float(float value);
object_t *new_string(char *value);
object_t *new_vector3(
    object_t *x, object_t *y, object_t *z
);
object_t *new_array(size_t size);
