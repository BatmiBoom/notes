#include "custom_object.h"

void refcount_inc(object_t *obj);
void refcount_dec(object_t *obj); 
void refcount_free(object_t *obj);
