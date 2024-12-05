# Vector 3

`Vector3` is going to be the first `Object` that can hold a reference to another `Object`. It's a collection type: a type that holds other types.

LIST, DICTIONARIES, and SETS are all examples of collections types.

`Vector3` is similar to a Python tuple that contains exactly 3 "Objects" elements.

## Exercise

1. Forward declare the object_t struct at the top of the file. It will need to be used between object_t -> object_data_t -> vector_t.
2. Create a new struct called vector_t that has three fields. Name the fields x, y, and z. Each field should be a object_t pointer.
3. Add a new value in object_kind_t called `VECTOR3`.
4. Add a new vector_t field to object_data_t called v_vector3.
5. Declare the new_vector3 function.
6. If any of the inputs are NULL, return NULL.
7. Allocate memory for a new pointer to a snek_object_t, and if the allocation fails return NULL.
8. Set the kind field to the appropriate enum.
9. Create a new snek_vector_t struct and set the x, y, and z fields to the input pointers.
10. Set the v_vector3 field of the new snek object to the newly created snek_vector_t.
11. Return the pointer to the new snek object.

```c
typedef struct Object object_t;

typedef enum ObjectKind{
    INTEGER,
    FLOAT,
    STRING,
    VECTOR3
} object_kind_t;

typedef Vector3 {
    object_t *x;
    object_t *y;
    object_t *z;
} vector_t;

typedef union ObjectData{
    int v_int;
    float v_float;
    char *v_string;
    vector_t v_vector3;
} object_data_t;

struct Object{
    object_kind_t kind;
    object_data_t data;
} object_t;

object_t *new_vector3(object_t *x, object_t *y, object_t *z) {
    if (x == NULL || y == NULL || z == NULL) {
        return NULL;
    }

    object_t *vector3_object = malloc(sizeof(object_t));
    if (vector3_object == NULL) {
        return NULL;
    }

    vector_t new_vec = {
        .x = x,
        .y = y,
        .z = z,
    }

    vector3_object->kind = VECTOR3;
    vector3_object->data.v_vector3 = new_vec;

    return vector3_object;
}
```
