# Tree

A tree is a widely used data structure that simulates a hierarchical tree structure, with a root value and subtrees of children with a parent node, represented as a set of linked nodes.

```text
            | Parent Node |
    | Node |             | Node |
| Node |  | Node |            | Node |
```

A tree is a collection of nodes starting at a root or head node, similar to how our linked list was a collection of nodes starting with a head (root). The big difference between LL and a tree is that a tree's nodes can have multiple children instead of just one

A generic tree structure has the following rules:

- Each node has a value and a list of "children"
- Children can only have a single "parent"
- Duplicate values are allowed, multiple nodes can have the same value

Linked List

```text
node -> node -> node
```

Tree

```text
            > node
      > node
            > node
> node
            > node
      > node
            > node

```

## Binary Tree

Trees aren't particularly useful data structures unless they're ordered in some way. One of the most common types of ordered tree is a **Binary Search Tree** or **BST**. In addition to the properties we've already talked about, a binary tree has some additional constraints:

- Instead of a list of children, each node has at most 2 children, a right and a left child
- The left child's value must be less than its parent's value
- The right child's value must be greater than its parents
- No two nodes in the BST can have the same value

By ordering the tree this way now, we can add, remove, and find nodes very quickly later.

We are gonna use only a single class, the BSTNode class. Any BSTNode is technically also a full Binary Search Tree, with itself as te root node. Each method that traverses the tree will do so recursively

The insert method of a BTS has `O(log(n))`

### BST - Insert

```python
class BSTNode:
    def __init__(self, val=None):
        self.left = None
        self.right = None
        self.val = val

    def insert(self, val):
        if not self.val:
            self.val = val
            return

        if self.val == val:
            return

        if val < self.val and self.left is None:
            if not self.left:
                self.left = BSTNode(val)
            return
            self.left.insert(val)

        if val > self.val and self.right is None:
            if not self.right:
                self.right = BSTNode(val)
                return
            self.right.insert(val)
```

### BST - Min/Max

Some of the simpler algorithms in regardto a `BST` are the `get_min` and `get_max` methods.
The `get_min` functino should loop through all the left child nodes and return the value of the last one.
The `get_max` function should do the same for the right children

```python
class BSTNode:
    def get_min(self):
        tree = self

        while tree.left != None:
            tree = tree.left

        return tree.val

    def get_max(self):
        tree = self
        while tree.right != None:
            tree = tree.right

        return tree.val
```

### BST - Delete

The delete method is O(log(n)) because we don't have to search the entire tree. We only have to search one linear path, and the length of that path is the depth of the tree.

As it turns out, the depth of the tree on average is equal to log base 2 of the number of nodes in the tree. For example:

```text
level 0 - search 1 node
level 1 - search 2 nodes
level 2 - search 4 nodes
level 3 - search 8 nodes
level 4 - search 16 nodes
level 5 - search 32 nodes
level 6 - search 64 nodes
level 7 - search 128 nodes
level 8 - search 256 nodes
level 9 - search 512 nodes
level 10 - search 1024 nodes
```

We only need to use ~10 steps to insert a node into a tree of ~1000 nodes.

```python
class BSTNode:
    def delete(self, val):
        if self.val is None:
            return None

        if val < self.val:
            if self.left:
                self.left = self.left.delete(val)
            return self
        if val > self.val:
            if self.right:
                self.right = self.right.delete(val)
            return self

        if self.right is None:
            return self.left
        if self.left is None:
            return self.right

        min_larger_node = self.right
        while min_larger_node.left:
            min_larger_node = min_larger_node.left

        self.val = min_larger_node.val
        self.right = self.right.delete(min_larger_node.val)
        return self
```

### BST - Traverse

Sometimes its useful, albeit a bit slow, to iterate over all the nodes in the tree, rather than searching for specific one

#### Recursive `preorder` method.

It returns a list of the values in the order they are wisited, and it takes as an argument the ordering of values we have visited so far.

```python
class BSTNode:
    def preorder(self, visited):
        if self.val is not None:
            visited.append(self.val)
        if self.left is not None:
            self.left.preorder(visited)
        if self.right is not None:
            self.right.preorder(visited)
        return visited`
```

#### Recursive `postorder` method

Implement the recursive postorder method. It returns a list of the values in the order they are visited, and it takes as an argument the ordering of values we have visited so far.

```python
class BSTNode:
    def postorder(self, visited):
        if self.left is not None:
            self.left.postorder(visited)
        if self.right is not None:
            self.right.postorder(visited)
        if self.val is not None:
            visited.append(self.val)
        return visited
```

#### Recursive `inorder` method

Implement the recursive inorder method. It returns a list of the values in the order they are visited, and it takes as an argument the ordering of values visited so far.

```python
class BSTNode:
    def inorder(self, visited):
        if self.left is not None:
            self.left.inorder(visited)
        if self.val is not None:
            visited.append(self.val)

        if self.right is not None:
            self.right.inorder(visited)

        return visited
```

#### Recursice `exists` method

```python
class BSTNode:
    def exists(self, val):
        if val == self.val:
            return True

        if val < self.val:
            if self.left is None:
                return False
            return self.left.exists(val)

        if self.right is None:
            return False
        return self.right.exists(val)
```

### Unbalanced Trees

BST's have a problem. While it's true that on average a BST has O(log(n)) lookups, deletions, and insertions, that fundamental benefit can break down quickly.

```text
    | 2 |
| 1 |   | 3 |
            | 4 |
                | 5 |
```

If mostly sorted data, or even worse, completely sorted data, is inserted into a binary tree, the tree will be much deeper than it is wide. As you know by now, the complexity of the tree's operations depend entirely on the depth of the tree.

### Balanced Tree

A balanced tree will always have the minimum height possible for the number of elements it contains.

## Red-Black Tree

Is a kind of self-balancing binary search tree. Each node stores an extra bit, which we weill call the color, red or black. The color ensures that the tree remains approximately balanced during insertions and deletions

When the tree is modified, the new tree is rearranged and repainted to restore the coloring proporties that constrain how unbalanced the tree can become in the worst case

```
                        | 13 B |
                | 8 R |          | 17 R |
           | 1 B |  | 11 B |  | 15 B | | 25 B |
      | Nil |  | 6 R |            | 22 R | | 27 R |
```

### Properties

In addition to all the properties of a BST, a red-black tree must have the following:

- Each node is either red or black
- The root is black. This rule is sometimes omitted. Since the root can always be changed from red to black, but not necessarily viceversa, this rule has little effect on analysis.
- All `Nil` leaf nodes are blac
- If a node is red, then both its children are black
- All paths from a single node go through the same number of black nodes to reach any of its descendant `Nil` nodes.

### Perfectly Balanced?

The re-balancing of a red-black tree does not result in a perfectly balanced tree. However, its insertion and deletion operations, along with the tree rearrangement and recoloring, are always performed in O(log(n)) time.

### RB - Insert

In a normal BST, the child nodes don't need to know about, or carry a reference to their parent, the same is not true for Red-Black trees.

```python
class RBNode:
    def __init__(self, val):
        self.red = False
        self.parent = None
        self.val = val
        self.left = None
        self.right = None


class RBTree:
    def __init__(self):
        self.nil = RBNode(None)
        self.nil.red = False
        self.nil.left = None
        self.nil.right = None
        self.root = self.nil

    def insert(self, val):
        node = RBNode(val)
        node.parent = None
        node.left = self.nil
        node.right = self.nil
        node.red = True

        parent = None
        current = self.root

        while current != self.nil:
            parent = current

            if node.val < current.val:
                current = current.left
            elif node.val > current.val:
                current = current.right
            else:
                return

        node.parent = parent

        if parent == None:
            self.root = node
        elif node.val < parent.val:
            parent.left = node
        else:
            parent.right = node
```

### RB - Rotation

Lets write the `rotate_left` and `rotate_right` methods. These methods will be fundamental the to "fix" method that we will implemet.

The rotations are tools we'll use to keep our tree balanced. Every time one branch of the tree starts to get too long, we will just rotate those branches to keep the tree shallow. A shallow tree is a health (fast) tree!

- A properly-ordered tree pre-rotation remains a properly-ordered tree post-rotation
- Rotations are O(1) operations
- When rotating left:
  - The "pivot" node's initial parent becomes its left child
  - The "pivot" node's old left child becomes its initial parent's new right child

```python
class RBTree:
    def rotate_left(self, x):
        if x == self.nil or x.right == self.nil:
            return

        y = x.right
        x.right = y.left
        if y.left != self.nil:
            y.left.parent = x

        y.parent = x.parent
        if x.parent is None:
            self.root = y
        elif x == x.parent.left:
            x.parent.left = y
        else:
            x.parent.right = y
        y.left = x
        x.parent = y

    def rotate_right(self, x):
        if x == self.nil or x.left == self.nil:
            return

        y = x.left
        x.left = y.right
        if y.right != self.nil:
            y.right.parent = x

        y.parent = x.parent
        if x.parent is None:
            self.root = y
        elif x == x.parent.right:
            x.parent.right = y
        else:
            x.parent.left = y
        y.right = x
        x.parent = y
```

### RB - Insert

```python
    def insert(self, val):
        new_node = RBNode(val)
        new_node.parent = None
        new_node.left = self.nil
        new_node.right = self.nil
        new_node.red = True

        parent = None
        current = self.root
        while current != self.nil:
            parent = current
            if new_node.val < current.val:
                current = current.left
            elif new_node.val > current.val:
                current = current.right
            else:
                # duplicate, just ignore
                return

        new_node.parent = parent
        if parent is None:
            self.root = new_node
        elif new_node.val < parent.val:
            parent.left = new_node
        else:
            parent.right = new_node

        self.fix_insert(new_node)

    def fix_insert(self, new_node):
        while new_node != self.root and new_node.parent.red:
            if new_node.parent == new_node.parent.parent.right:
                u = new_node.parent.parent.left
                if u.red:
                    u.red = False
                    new_node.parent.red = False
                    new_node.parent.parent.red = True
                    new_node = new_node.parent.parent
                else:
                    if new_node == new_node.parent.left:
                        new_node = new_node.parent
                        self.rotate_right(new_node)
                    new_node.parent.red = False
                    new_node.parent.parent.red = True
                    self.rotate_left(new_node.parent.parent)
            else:
                u = new_node.parent.parent.right

                if u.red:
                    u.red = False
                    new_node.parent.red = False
                    new_node.parent.parent.red = True
                    new_node = new_node.parent.parent
                else:
                    if new_node == new_node.parent.right:
                        new_node = new_node.parent
                        self.rotate_left(new_node)
                    new_node.parent.red = False
                    new_node.parent.parent.red = True
                    self.rotate_right(new_node.parent.parent)
        self.root.red = False
```

### RBNode - Search Range:

The method should take two arguments, lower_bound and upper_bound, and return a list of character objects whose gamer tags fall within the specified range, inclusive.

```python
class RBNode:
    def search_range(self, lower_bound, upper_bound):
        result = []
        if self.val is None:
            return result
        if lower_bound <= self.val.gamertag <= upper_bound:
            result.append(self.val)
        if self.left and self.val.gamertag > lower_bound:
            result.extend(self.left.search_range(lower_bound, upper_bound))
        if self.right and self.val.gamertag < upper_bound:
            result.extend(self.right.search_range(lower_bound, upper_bound))
        return result
```

### RBNode - Height:

```python
class RBNode:
    def height(self):
        if self.val is None:
            return 0
        left_height = 0
        right_height = 0
        if self.left is not None:
            left_height = self.left.height()
        if self.right is not None:
            right_height = self.right.height()
        return max(left_height, right_height) + 1
```
