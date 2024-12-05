# The Stack

Memory is basically just a giant array of bytes with addresses at various offsets, but it also has some additional structure.

In particular, memory is divided into two main regions:

- **STACK**
- **HEAP**

The **stack** is where local variables are stored. When a function is called, a new **stack frame** is created in memory to store the function's parameters and local variables. When the function returns, its entire **stack frame** is deallocated.

The stack is aptly named: it is a **stack** (the "Last In, First Out" data structure) of memory frames. Each time a function is called, a new frame is pushed onto the stack. When the function returns, its frame is popped off the stack.

Example:

```c
void create_typist(int uses_nvim) {
    int wpm = 150;
    char name[4] = {'t', 'e', 'e', 'j'};
}
```

Say we call `create_typist(1)`. Before the call, out stack memory might look like this, with the next memory address to be used `0xFEFC`:

```
<-lower addresses              higher addresses ->
|  ... |  ... |  ... |  ... |  ... |  ... |  ... |
|0xFEFC|0xFF00|0XFF04|0XFF08|0XFF0C|0XFF10|0XFF14|
```

Once called, the **stack pointer** is moved to make room for:

- The return address (to pick up execution after the function returns)
- Arguments to the function
- Local variables in the function body

```
<-lower addresses              higher addresses ->
|  ... |  ... |  ... |  ... |  ... |  ... |  ... |
|0xFEFC|0xFF00|0XFF04|0XFF08|0XFF0C|0XFF10|0XFF14|
|  ^                                         ^   |
|  | Return Adrress            Stack Pointer |   |
```

And the local variables are stored in the stack frame:

```
<-lower addresses              higher addresses ->
|  ... |   1  |  150 |  t   |  e   |  e   |   j  |
|0xFEFC|0xFF00|0XFF04|0XFF08|0XFF0C|0XFF10|0XFF14|
|  ^                                          ^  |
|  | Return Adrress             Stack Pointer |  |
```

When the function returns, the stack frame is deallocated by resetting the stack pointer to where the frame began.

## Why a stack?

Allocating memory on the stack is preferred when possible because the stack is faster and simpler than the heap

- Efficient Pointer Management: Stack "allocation" is just a quick increment or decrement of the stack pointer, which is extremely fast. Heap allocations require more complex bookkeeping.
- Cache-Friendly Memory Access: Stack memory is stored in a contiguous block, enhancing cache performance due to spatial locality.
- Automatic Memory Management: Stack memory is managed automaticall as functions are called and as they return.
- Inherent Thread Safety: Each thread has its own stack. Heap allocations require synchronization mechanisms when used concurrently, potentially introducing overhead

## Stack Overflow

So the stack is great and all, but one of the downsides is that it has a limited size. If you keep pushing frames onto the stack without popping them off, you'll eventually run out of memory and get a stack overflow.

That's one of the reasons recursion without tail-call optimization can be dangerous. Each recursive call pushes a new frame onto the stack, and if you have too many recursive calls, you'll run out of stack space.
