#include <stdlib.h>
#include <string.h>

#include "custom_object.h"
#include "refcount.c"

object_t *new_object() {
  object_t *new_obj = calloc(1, sizeof(object_t));
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

  object_t **elements = calloc(size, sizeof(object_t *));
  if (elements == NULL) {
    free(obj);
    return NULL;
  }

  obj->kind = ARRAY;
  obj->data.v_array = (array_t){.size = size, .elements = elements};

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

object_t *new_vector3(object_t *x, _object_t *y, _object_t *z) {
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
