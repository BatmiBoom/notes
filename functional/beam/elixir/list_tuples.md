# List and Tuples

### (Linked) Lists

Elixir uses square brackets to specify a list of values. Values can be of any type:

```elixir
[1, 2, true, 3] # [1,2,true,3]
length([1, 2, 3]) # 3
```

Two lists can be concatenated or subtracted using the `++/2` and `--/2` operators respectively

```elixir
[1, 2, 3] ++ [4, 5, 6] # [1, 2, 3, 4, 5, 6]
[1, true, 2, false, 3, true] -- [true, false] # [1, 2, 3, true]
```

List operators never modify the existing list. Concatenating to or removing elements from a list returns a new list. Elixir data structures are immutable.

The head is the first element of a list and the tail is the remainder of the list. They can be retrieved with the functions `hd/1` and `tl/1`.

```elixir
list = [1, 2, 3]

hd(list) # 1

tl(list) # [2, 3]
```

Getting the head or the tail of an empty list throws an error:

```elixir
hd([])
# ** (ArgumentError) argument error
```

Sometimes you will create a list and it will return a quoted value preceded by ~c. For example:

```elixir
[11, 12, 13]
~c"\v\f\r"

[104, 101, 108, 108, 111]
~c"hello"
```

When Elixir sees a list of printable ASCII numbers, Elixir will print that as a charlist (literally a list of characters).

The [head | tail] format is not only used on pattern matching but also for prepending items to a list:

```elixir
list = [1, 2, 3] # [1, 2, 3]
[0 | list] # [0, 1, 2, 3]
```

## Tuples

Elixir uses curly brackets to define tuples. Like lists, tuples can hold any values:

```elixir
{:ok, "hello"}
tuple_size({:ok, "hello"})
```

Tuples store elements contiguously in memory. This means accessing a tuple element by index or getting the tuple size is a fast operation. Indexes start from zero.

```elixir
tuple = {:ok, "hello"}
elem(tuple, 1) # "hello"
tuple_size(tuple) # "hello"
```

It is also possible to put an element at a particular index in a tuple with `put_elem/3`:

```elixir
tuple = {:ok, "hello"} # {:ok, "hello"}
put_elem(tuple, 1, "world") # {:ok, "world"}
tuple # {:ok, "hello"}
```

Notice that `put_elem/3` returned a new tuple. The original tuple stored in the tuple variable was not modified. Like lists, tuples are also immutable. Every operation on a tuple returns a new tuple.

## Lists or tuples?

What is the difference between lists and tuples?

Lists are stored in memory as **linked lists**, meaning that each element in a list holds its value and points to the following element until the end of the list is reached. This means accessing the length of a list is a linear operation: we need to traverse the whole list in order to figure out its size.

Similarly, the performance of list concatenation depends on the length of the left-hand list:

```elixir
list = [1, 2, 3] # [1, 2, 3]

# This is fast as we only need to traverse `[0]` to prepend to `list`
[0] ++ list # [0, 1, 2, 3]

# This is slow as we need to traverse `list` to append 4
list ++ [4] # [1, 2, 3, 4]
```

Tuples, on the other hand, are stored contiguously in memory. This means getting the tuple size or accessing an element by index is fast. On the other hand, updating or adding elements to tuples is expensive because it requires creating a new tuple in memory:

```elixir
tuple = {:a, :b, :c, :d}
{:a, :b, :c, :d}
put_elem(tuple, 2, :e)
{:a, :b, :e, :d}
```

Note, however, the elements themselves are not copied. When you update a tuple, all entries are shared between the old and the new tuple, except for the entry that has been replaced. This rule applies to most data structures in Elixir. This reduces the amount of memory allocation the language needs to perform and is only possible thanks to the immutable semantics of the language.

Those performance characteristics dictate the usage of those data structures. In a nutshell, lists are used when the number of elements returned may vary. Tuples have a fixed size. Let's see two examples from the String module:

```elixir
String.split("hello world") # ["hello", "world"]
String.split("hello beautiful world") # ["hello", "beautiful", "world"]
```

The `String.split/1` function breaks a string into a list of strings on every whitespace character. Since the amount of elements returned depends on the input, we use a list.

On the other hand, `String.split_at/2` splits a string in two parts at a given position. Since it always returns two entries, regardless of the input size, it returns tuples:

```elixir
String.split_at("hello world", 3) # {"hel", "lo world"}
String.split_at("hello world", -4) # {"hello w", "orld"}
```

It is also very common to use tuples and atoms to create "tagged tuples", which is a handy return value when an operation may succeed or fail. For example, `File.read/1` reads the contents of a file at a given path, which may or may not exist. It returns tagged tuples:

```elixir
File.read("path/to/existing/file")
{:ok, "... contents ..."}
File.read("path/to/unknown/file")
{:error, :enoent}
```

If the path given to `File.read/1` exists, it returns a tuple with the atom `:ok` as the first element and the file contents as the second. Otherwise, it returns a tuple with `:error` and the error description.

Elixir often guides you to do the right thing. For example, there is an `elem/2` function to access a tuple item:

```elixir
tuple = {:ok, "hello"} # {:ok, "hello"}
elem(tuple, 1) # "hello"
```

### Size or Length?

When counting the elements in a data structure, Elixir also abides by a simple rule:

- `size` if the operation is in constant time (the value is pre-calculated)
- `length` if the operation is linear (calculating the length gets slower as the input grows). As a mnemonic, both "length" and "linear" start with "l".
