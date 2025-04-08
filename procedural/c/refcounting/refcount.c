#include "refcount.h"
#include "custom_object.h"
#include <stdlib.h>

void refcount_inc(object_t *obj) {
  if (obj == NULL) {
    return;
  }
  obj->refcount += 1;
}

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
  case VECTOR3:
    refcount_dec(obj->data.v_vector3.x);
    refcount_dec(obj->data.v_vector3.y);
    refcount_dec(obj->data.v_vector3.z);
  case ARRAY:
    array_t arr = obj->data.v_array;
    for (int i = 0; i < arr.size; i++) {
      refcount_dec(arr.elements[i]);

      free(arr.elements);
    }
    break;
  default:
    exit(1);
  }
  free(obj);
}
