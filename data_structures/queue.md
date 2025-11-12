# Queue

A queue is an abstract data type that serves as an ordered collection of elements. A simple queue typically has several operations:

- queue.push(item) -> adds an item to the tail of the queue

- queue.pop() -> removes and returns an item from the head of the queue

- queue.peek() -> returns an item from the head of the queue

- queue.size() -> returns the number of items in the queue

- Push = enqueue = add an item

- Pop = dequeue = remove an item

```text
TAIL -> |--| -> |--| -> |--| -> HEAD
```

The order in which elements come off a queue gives rise to its alternative name, FIFO (first in, first out)

Think of a line to get tickets. The first person to get in line will be the first person to receive a ticket and get out of line.

`-> [tail, item, item, item, head] ->`

Big(O) for `pop` `peek` is O(1)

Big(O) for finding an item in the middle of the queue O(n) because we might have to traverse the full len

````python
class Queue:
    def __init__(self):
        self.items = []

    def push(self, item):
        if not self.items:
            self.items.append(item)
        else:
            # self.items.append(0)
            # for i in range(len(self.items) - 1, 0, -1):
            #     self.items[i] = self.items[i - 1]
            #
            # self.items[0] = item
            # This can be replaced by
            self.items.insert(0, item)

    def pop(self):
        if self.items:
            return self.items.pop()
        return None

    def peek(self):
        if self.items:
            return self.items[-1]

        return None

    def size(self):
        return len(self.items)```
````

We can create queues with [LinkedLists](./linked_list.md) all we need to do is delete the `add_to_head` method, because queues have only one place to push and remove

## Queue Speed

In an optimized queue, they'd be:

`push` -> O(1) -> Add an item to the back of the queue
`pop` -> O(1) -> Remove and return the front item from the queue
`peek` -> O(1) -> Return the front item from the queue without modifying the queue
`size` -> O(1) -> Return the number of items in the queue
