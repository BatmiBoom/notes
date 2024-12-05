# Array

Let's add a dynamically sized array.

## Exercise

1. Add a new value to `object_kind_t` called `ARRAY`.
2. Create a new struct called `array_t` that has two field:
   - `size` - the number of elements in the array, a `size_t`
   - `elements` - a pointer to an array of `objects_t **`
3. Add a new array_t field to object_data_t called v_array.
4. Declare the new_array function.
5. Accept a size as an input.
6. Allocate memory for a new pointer to a snek_object_t, and if the allocation fails return NULL.
7. Allocate memory for a new pointer to an array of objects.
   - How much memory should you allocate? Think about it: probably the `sizeof` a pointer for each element in the array. We're not storing the actual objects in the array, just pointers to them.
   - If the allocation fails, free the first snek object allocation and return NULL.
   - Use `calloc` instead of `malloc` so there is no "junk" in our array to start, we want beautiful, pristine NULLs. Note that `calloc` takes two arguments: number of objects and the size of each object.
8. Set the kind field to the appropriate enum.
9. Create a new array_t struct and set the size and elements fields.
10. Set the v_array field of the new object to the newly created array_t.
11. Return the pointer to the new object.

```c
typedef struct Object object_t;

typedef enum ObjectKind{
    INTEGER,
    FLOAT,
    STRING,
    VECTOR3,
    ARRAY
} object_kind_t;

typedef struct Vector3 {
    object_t *x;
    object_t *y;
    object_t *z;
} vector_t;

typedef struct Array {
    size_t size;
    object_t **elements;
} array_t;

typedef union ObjectData{
    int v_int;
    float v_float;
    char *v_string;
    vector_t v_vector3;
    array_t v_array;
} object_data_t;

struct Object{
    object_kind_t kind;
    object_data_t data;
} object_t;

object_t *new_array(size_t size) {
    object_t *array_object = malloc(sizeof(object_t));
    if (array_object == NULL) {
        return NULL;
    }

    object_t **array_mem = calloc(size, sizeof(object_t));
    if (array_mem == NULL) {
        free(array_object);
        return NULL;
    }


    array_object->kind = ARRAY;
    array_object->data.v_array = (array_t){.size=size, .elements=array_mem};

    return array_object;
}
```

# Get and Set

We can make empty arrays! Now we are gonna allow to store and retrieve values from the array

- `snek_array_set` - Sets a vale at a specific index in the array (This is effectively `array[3] = new_value` in Python)
- `snek_array_get` - Gets a value at a specific index in the array (This effectively `print(array[7])` in Python)

## Exercise

- Get
  1. If the object or the new value are NULL, return false.
  2. If the object's kind is not ARRAY, return false.
  3. If the index is out of bounds, return false. Remember, the v_array field has a size field.
  4. Set the value in the elements array at the specified index to the new value.
  5. Return true. The return value is a boolean that indicates success.
- Set
  1. If the object is NULL, return NULL.
  2. If the object's kind is not ARRAY, return NULL.
  3. If the index is out of bounds, return NULL.
  4. Return the value in the elements array at the specified index.

```c
bool array_set(object_t *array, size_t index, object_t *value) {
    if (array == NULL || value == NULL) {
        return false;
    }

    if (array->kind != ARRAY) {
        return false;
    }

    if (index < 0 || index > array->data.v_array.size) {
        return false;
    }

    array->data.v_array.elements[index] = value;
    return true;
}

object_t *array_get(object_t *array, size_t index) {
    if (array == NULL) {
        return NULL;
    }

    if (array->kind != ARRAY) {
        return NULL;
    }

    if (index < 0 || index > array->data.v_array.size) {
        return NULL;
    }

    return array->data.v_array.elements[index];
}
```

# Length

```c
int obj_length(object_t *obj) {
    if (obj == NULL) {
        return -1;
    }

    int a = 0;
    switch(obj->kind){
        case INTEGER:
            a = 1;
            break;
        case FLOAT:
            a = 1;
            break;
        case STRING:
            a = strlen(obj->data.v_string);
            break;
        case VECTOR3:
            a = 3;
            break;
        case ARRAY:
            a = obj->data.v_array.size;
            break;
        default:
            a = -1;
            break;
    }

    return a;
}
```
