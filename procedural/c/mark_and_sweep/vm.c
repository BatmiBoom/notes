#include "vm.h"

vm_t *vm_new() {
  vm_t *vm = malloc(sizeof(vm_t));
  if (vm == NULL) {
    return NULL;
  }
  vm->frames = stack_new(8);
  vm->objects = stack_new(8);
  return vm;
}

void vm_free(vm_t *vm) {
  stack_free(vm->frames);
  stack_free(vm->objects);
  free(vm);
}

void vm_frame_push(vm_t *vm, frame_t *frame) { stack_push(vm->frames, frame); }

frame_t *vm_new_frame(vm_t *vm) {
  frame_t *frame = malloc(sizeof(frame_t));
  frame->references = stack_new(8);

  stack_push(vm->frames, frame);

  return frame;
}

void frame_free(frame_t *frame) {
  stack_free(frame->references);
  free(frame);
}
