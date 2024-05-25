# Hash Map

A hash map or hash table is a structure that maps keys to values. A hash table uses a hash function to compute an index into an array of buckets, from which the desired value can be found. During lookup, the key is hashed and the resulting hash indicates where the corresponding value is stored.

Ideally the hash function will assign each key to a unique bucket, but most hash table designs employ an imperfect hash function, which might cause hash collisions where the hash function generates the same index for more than one key. Such collisions are typically accommodated for somehow.

In a well-built hash map, the average computational cost for each lookup, insertion, and deletion is independent of the number of elements stored in the table. In other words, all these basic operations are O(1).

- Can be used for exact machting

## Hash Maps are just key -> value stores

"bob" -> "ross"
"pablo" -> "picasso"
"leonardo" -> "davinci"

Here's an example in Python using the built in hashmap implementation called a dictionary. It can store arbitrary key/value pairs. In this case, we are mapping string keys to string values.

```python
m = {}
m["bob"] = "ross"
m["pablo"] = "picasso"
m["leonardo"] = "davinci"
```

## Toy Hash Map

```python
class HashMap:
    def __init__(self, size):
        self.hashmap = [None for i in range(size)]

    def __repr__(self):
        buckets = []
        for v in self.hashmap:
            if v != None:
                buckets.append(v)
        return str(buckets)
```

### Key-To-Index

```python
class HashMap:
    def key_to_index(self, key):
        sum = 0
        for char in key:
            sum += ord(char)

        return int(sum % len(self.hashmap))
```

### Insert

```python
class HashMap:
    def insert(self, key, value):
        i = self.key_to_index(key)

        item = (key, value)
        self.hashmap[i] = item
```

### Get

```python
class HashMap:
    def get(self, key):
        i = self.key_to_index(key)

        if self.hashmap[i] == None:
            raise Exception("sorry, key not found")

        return self.hashmap[i][1]
```

### Current_load, Resize, Insert

#### `current_load()`

This method returns the number of filled buckets in the hashmap as a percentage of the total number of buckets.

If the length of the underlying list is zero, return 1. Otherwise, divide the number of filled buckets by the length of the underlying list and return it.

#### `resize()`

If the length of the underlying hashmap is 0, make the length 1 (by just adding a None entry).

Get the current load. If it's less than 5%, do nothing, we have plenty of space.

Otherwise, create a new empty hashmap that's 10x the size of the current one, then use the insert method to re-insert all the key-value pairs from the old hashmap into the new one.

#### `insert()`

Call resize() before inserting to make sure there's enough space. Then, insert the key-value pair into the hashmap as normal.

```python
    def insert(self, key, value):
        self.resize()
        index = self.key_to_index(key)
        self.hashmap[index] = (key, value)

    def resize(self):
        if len(self.hashmap) == 0:
            self.hashmap = [None]
            return
        load = self.current_load()
        if load < 0.05:
            return
        old_hashmap = self.hashmap.copy()
        self.hashmap = [None] * (len(old_hashmap) * 10)
        for kvp in old_hashmap:
            if kvp is not None:
                self.insert(kvp[0], kvp[1])

    def current_load(self):
        if len(self.hashmap) == 0:
            return 1
        filled_slots = 0
        for slot in self.hashmap:
            if slot is not None:
                filled_slots += 1
        return filled_slots / len(self.hashmap)
```
