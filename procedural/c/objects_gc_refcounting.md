# Refcounting

```c
// object.h
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
    object_t *x, _object_t *y, snek_object_t *z
);
object_t *new_array(size_t size);
```

```c
//object.c
#include <stdlib.h>
#include <string.h>

#include "object.h"

object_t *new_object() {
    object_t *new_obj = calloc(1, sizeof(snek_object_t));
    if (new_obj == NULL) {
        return NULL;
    }

    new_obj->refcount = 1;
    return new_obj;
}

object_t *new_array(size_t size) {
    object_t *obj = new_object();
    if (obj == NULL) {
        return NULL;
    }

    object_t **elements = calloc(size, sizeof(_object_t *));
    if (elements == NULL) {
        free(obj);
        return NULL;
    }

    obj->kind = ARRAY;
    obj->data.v_array = (_array_t){.size = size, .elements = elements};

    return obj;
}

bool array_set(object_t *obj, size_t index, object_t *value) {
    if (obj == NULL || value == NULL) {
        return false;
    }
    if (obj->kind != ARRAY) {
        return false;
    }
    if (index >= obj->data.v_array.size) {
        return false;
    }

    if (obj->data.v_array.elements[index] != NULL) {
        refcount_dec(obj->data.v_array.elements[index]);
    }

    refcount_inc(value);
    obj->data.v_array.elements[index] = value;
    return true;
}

object_t *array_get(object_t *obj, size_t index) {
    if (obj == NULL) {
        return NULL;
    }

    if (obj->kind != ARRAY) {
        return NULL;
    }

    if (index >= obj->data.v_array.size) {
        return NULL;
    }

    return obj->data.v_array.elements[index];
}

object_t *new_vector3(
    object_t *x, _object_t *y, _object_t *z
) {
    if (x == NULL || y == NULL || z == NULL) {
        return NULL;
    }

    object_t *obj = new_object();
    if (obj == NULL) {
        return NULL;
    }

    obj->kind = VECTOR3;
    obj->data.v_vector3 = (_vector_t){.x = x, .y = y, .z = z};
    refcount_inc(x);
    refcount_inc(y);
    refcount_inc(z);

    return obj;
}

object_t *new_integer(int value) {
    object_t *obj = new_object();
    if (obj == NULL) {
        return NULL;
    }

    obj->kind = INTEGER;
    obj->data.v_int = value;
    return obj;
}

object_t *new_float(float value) {
    object_t *obj = new_object();
    if (obj == NULL) {
        return NULL;
    }

    obj->kind = FLOAT;
    obj->data.v_float = value;
    return obj;
}

object_t *new_string(char *value) {
    object_t *obj = new_object();
    if (obj == NULL) {
        return NULL;
    }

    int len = strlen(value);
    char *dst = malloc(len + 1);
    if (dst == NULL) {
        free(obj);
        return NULL;
    }

    strcpy(dst, value);

    obj->kind = STRING;
    obj->data.v_string = dst;
    return obj;
}
```

# Increment

```c
void refount_inc(object_t *obj) {
    if (obj == NULL) {
        return;
    }
    obj->refcount += 1;
}
```

# Decrement and Free

```c
void refcount_dec(object_t *obj) {
    if (obj == NULL) {
        return;
    }
    obj->refcount--;
    if (obj->refcount == 0) {
        return refcount_free(obj);
    }
    return;
}

void refcount_free(object_t *obj) {
    switch (obj->kind) {
        case INTEGER:
        case FLOAT:
            break;
        case STRING:
            free(obj->data.v_string);
            break;
        case VECTOR3
            refcount_dec(obj->data.v_vector3.x);
            refcount_dec(obj->data.v_vector3.y);
            refcount_dec(obj->data.v_vector3.z);
        case ARRAY: {
            array_t arr = obj->data.v_array;
            for(int i = 0; i < arr.size; i++) {
                refcount_dec(arr.elements[i]);
            }

            free(arr.elements);
            break;
        }
        default:
            exit(1);
    }
    free(obj);
}
```

One of the great things about how we implemented our refcounting garbage collection is that the GC logic was all nicely encapsulated in the "new object" functions and the "increment/decrement refcount" functions that occur automatically within the container types. In other words, the add function that we wrote in the last chapter will automatically handle the refcounting for us!

## Handling Cycles

We built a simple reference counting garbage collector

```c
snek_object_t *first = new_snek_array(1);
snek_object_t *second = new_snek_array(1);
// refcounts: first = 1, second = 1
snek_array_set(first, 0, second);
// refcounts: first = 1, second = 2
refcount_dec(first);
// refcounts: first = 0, second = 1
refcount_dec(second);
// refcounts: first = 0, second = 0
// all free!
```

We create a first array, and shove the second array inside of it. Everything here works as expected. The trouble arises when we introduce a cycle: for example, first contains second but second also contains first...

The reason both `refcounts` are stuck at one after being decremented, is because when first has it's `refcount` decremented it already had 2. So it only drops to 1, which does not trigger a "free" of the second array:

```c
void refcount_dec(snek_object_t *obj) {
  if (obj == NULL) {
    return;
  }
  obj->refcount--;
  if (obj->refcount == 0) {
    // this doesn't happen when refcount is 1
    return refcount_free(obj);
  }
  return;
}
```

And because second still has 2 `refcounts`, it also only drops to 1, which fails to trigger a "free" of the first array.

In other words, we have a cycle, and our simple reference counting garbage collector can't handle it.
