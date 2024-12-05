# Forward Declaration

Sometimes you have a struct that may need to reference itself, or be used recursively.

For example, consider a `Node struct` that can contain other Nodes. This might be useful for building a linked list or a tree:

```c
typedef struct Node {
  int value;
  node_t *next;
} node_t;
```

The problem here is that node_t is not defined yet, so the compiler will complain. To fix this, we can add a forward declaration:

```c
typedef struct Node node_t;

typedef struct Node {
  int value;
  node_t *next;
} node_t;

```

Note that the forward declaration must match the eventual definition, so you can't do something like this:

```c
typedef struct Node node_t;

typedef struct BadName {
    int value;
    node_t *next;
} node_t;
```

## Mutual Structs

Forward declaration can also be used when two structs reference each other (a circular reference). For example, a `Person` has a `Computer` and a `Computer` has a `Person`

```c
typedef struct Computer computer_t;
typedef struct Person person_t;

struct Person {
  char *name;
  computer_t *computer;
};

struct Computer {
  char *brand;
  person_t *owner;
};
```
