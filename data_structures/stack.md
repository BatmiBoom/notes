# Stack

A stack is an abstract data type that serves as a collection of elements. Our stack will have several operations:

- stack.push(item) -> places a new item on top of the stack
- stack.pop() -> removes the top item from the stack and returns it
- stack.peek() -> returns the top item from the stack without modifying the stac
- stack.size() -> returns the number of items in the stac

```text
        |----------------|
 -> IN  |    top item    | -> OUT
        |----------------|
        |----------------|
        |      item      |
        |----------------|
        |----------------|
        |      item      |
        |----------------|
        |----------------|
        |  bottom item   |
        |----------------|
```

The order in which elements come of a stack fives rise to its alternative name, `LIFO` (last in, first out)

The "stack" name for this type of structure comes from the analogy to a set of physical items stacked on top of each other. This structure makes it easy to take an item off the top of the stack, while getting to an item deeper in the stack may require taking off multiple other items first.

The Big O complexity of the methods of the stack is O(1)

This is a stack made with lists

```python
class Stack:
    def __init__(self):
        self.arrows = []

    def push(self, arrow):
        self.arrows.append(arrow)

    def pop(self):
        if not self.arrows:
            return None

        value = self.arrows[len(self.arrows) - 1]
        del self.arrows[len(self.arrows) - 1]

        return value

    def peek(self):
        if not self.arrows:
            return None

        return self.arrows[len(self.arrows) - 1]

    def size(self):
        return len(self.arrows)
```

## Stack Overflow

A stack data structure is used by your programming language to keep track of which function will run next, and which variables exist in the scope of each function. For example, take a look at this example program:

```python
def function_one():
	# function_one is pushed onto the callstack
	function_two()
	function_two()
	# function_one is popped off of the callstack

def function_two():
	# function_two is pushed onto the callstack
	function_three()
	function_three()
	# function_two is popped off of the callstack

def function_three():
	# function_three is pushed onto the callstack
	print("function three")
	# function_three is popped off of the callstack

function_one()
```

A call frame is just an area of memory that is set aside by the language to keep track of a function call in progress. Call frames are born when a function is called, and they die when a function returns.

In other words:

- Calling a function pushes a call frame onto the runtime stack
- Returning from a function pops the top frame off the stack.

A stack overflow occurs if the number of calls in the stack exceeds the limit. The limit depends on many factors, including the programming language, machine architecture, multi-threading, and the amount of available memory. When a program goes over the limit, that stack is said to overflow which typically results in the rogram crashing

## Problem of balanced parenthesis, resolved with stack

```python
def is_balanced(input_str):
    stack = Stack()
    for char in input_str:
        if char == "(":
            stack.push(char)
        elif char == ")":
            if stack.pop() is None:
                return False
    return stack.peek() is None

class Stack:
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        if len(self.items) == 0:
            return None
        return self.items.pop()

    def peek(self):
        if len(self.items) == 0:
            return None
        return self.items[len(self.items) - 1]
```
