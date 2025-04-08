# Garbage Collector

- [ Objects ](./objects.md)

`Sneklang`, the language we're building, has automatic memory management. Specifically, it makes use of a **garbage collector**.

- In C and C++, management of heap memory is done manually with malloc and free (and new and delete in C++).
- Rust has a compile-time system that ensures memory safety.
- Zig gives the programmer access to "allocators" to manage memory.

These are all examples of "manual memory management" - the programmer has to write code that keeps track of and frees memory.

## So what's a garbage collector?

A garbage collector is a program (or part of a program) that automatically frees memory that is no longer in use. Languages like `Python`, `Java`, `JavaScript`, `OCaml`, and even `Go` use garbage collectors as the code is running to manage memory.

Automatic memory management can be a huge productivity boost for developers but it typically comes with a performance cost because, the garbage collector is always running.

It's no coincidence that C, C++, Rust, and Zig are all great choices when you need to squeeze every last drop of performance out of your code.

## Refcounting

One of the simplest ways to implement a garbage collector is to use a reference counting algorithm. It goes something like this:

- All objects keep track of a `reference_count` integer.
- When that object is referenced, its reference count is incremented.
- When an object is garbage collected, the reference count of any object it references is decremented.
- When any object's reference count reaches zero, the object is garbage collected.

## Handling Cycles

We built a simple reference counting garbage collector. It can handle:

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

## Pros and Cons

To solve our cyclic reference issue we're going to implement a Mark and Sweep garbage collector.

Pros of MaS

- Can detect cycles, and thus prevent memory leaks in certain cases
- Less on-demand book keeping (Remember: all work done by the GC is "wasted" - it doesn't make your GPT-4 wrapper custom AI product run any faster)
- Reduces potential performance degradation in highly multi-threaded programs (refcounting requires atomic updates for thread safety)

Cons of MaS

- More complex to implement
- Can cause "stop-the-world" pauses when lots of objects exist and must be freed
- Higher memory overhead
- Less predictable performance
