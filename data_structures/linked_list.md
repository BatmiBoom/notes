# Linked Lists

A linked list is a linear data structure where elements are not stored next to each other in memory. The elemetns in a linked list are linked using pointers.

Linked lists can be contrasted with te native `List` (aka Array) in Python. Items in a normal list are stored next to each other in memory, and to get an item from a `List` we need to use the numbered index: `item = mylist[1]`.

In a Linked List, there are no indexes. We need to walk each node of the list because the only way to get the location of the second item in a linked list is to look at the pointer of the first item.

The time compexity of adding an item to the beginning of a Python list is O(n) and a linked list is O(1)

Linked Lists make Queues faster in python, but have little effect on Stacks

## Building a Linked List

### Node Class

NODE 1           NODE 2           NODE 3
| DATA   |   |-> | DATA    |   |-> |  DATA   |
| Pointer| --|   | Pointer | --|   | Pointer |

Lets create the building block of a linked list - a Node. A Node can be represented by a simple class that has two data points:

- `val` - The raw value that the node holds
- `next` - A pointer to the next node in the list

```python
class Node:
    def __init__(self, val):
        self.val = val
        self.next = None

    def set_next(self, node):
        self.next = node
```

### Iterating

Now we'll add a `LinkedList` class that connect the `Node`.

#### The yield keyword

Allow us to return a value from a function with the ability for the caller to resume the called functino where it left off, that is, directly after the `yield`. A function that uses the `yield` is called a **GENERATOR**. The values generated from a generator can be iterated over using the `in` keyword:

```python
def number_generator():
    yield 1
    yield 2
    yield 3

for value in number_generator():
    print(value)

# 1
# 2
# 3
```

#### LinkedList Class

```python
class Node:
    def __init__(self, val):
        self.val = val
        self.next = None

    def set_next(self, node):
        self.next = node

class LinkedList:
    def __init__(self):
        self.head = None

    def __iter__(self):
        node = self.head
        while node is not None:
            yield node
            node = node.next

    def add_to_head(self, node):
        if self.head == None:
            self.head = node
            return

        node.next, self.head = self.head, node

    def add_to_tail(self, node):
        if self.head is None:
            self.head = node
            return

        last_node = None
        for current_node in self:
            last_node = current_node
        last_node.set_next(node)

```

We can reformat the linked list to offer O(1) in add_to_tail method, we need to add a variable that helds the tail

```python
class LinkedList:
    def __init__(self):
        self.head = None
        self.tail = None

    def add_to_head(self, node):
        if self.head is None:
            self.head = node
            self.tail = node
            return
        node.set_next(self.head)
        self.head = node

    def add_to_tail(self, node):
        if self.head is None:
            self.head = node
            self.tail = node
            return

        self.tail.next, self.tail = node, node

    def remove_from_head(self):
        if self.head is None:
            return None
        temp = self.head
        self.head = self.head.next
        if self.head is None:
            self.tail = None
        return temp

    def __iter__(self):
        node = self.head
        while node is not None:
            yield node
            node = node.next

    def __repr__(self):
        nodes = []
        for node in self:
            nodes.append(node.val)
        return " -> ".join(nodes)
```

### Ejercice Matchmaking queue

In Fantasy Quest, players can join a matchmaking queue to find opponents for PvP (player vs player) battles. We'll use the Queue class we've built to manage the matchmaking process.

Notice the search_and_remove method on the Queue class, it breaks the rules of a traditional queue data structure but will be useful in solving this real-world problem. It's okay to violate academic constraints as software engineers as long as we understand the tradeoffs involved.

```python
class Queue:
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.insert(0, item)

    def pop(self):
        if len(self.items) == 0:
            return None
        temp = self.items[-1]
        del self.items[-1]
        return temp

    def peek(self):
        if len(self.items) == 0:
            return None
        return self.items[-1]

    def size(self):
        return len(self.items)

    def search_and_remove(self, item):
        if item not in self.items:
            return None
        self.items.remove(item)
        return item

    def __repr__(self):
        return f"[{', '.join(self.items)}]"

def matchmake(queue, player):
    if player[1] == "leave":
        queue.search_and_remove(player[0])

    if player[1] == "join":
        queue.push(player[0])

    if queue.size() >= 4:
        player1 = queue.pop()
        player2 = queue.pop()

        return f"{player1} matched {player2}!"

    return "No match found"
```
