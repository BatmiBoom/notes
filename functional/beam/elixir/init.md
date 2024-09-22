# Elixir

Elixir is a dynamic, functional language for building scalable and maintainable applications. Runs on the Erlang VM, known for creating low-latency, distributed, and fault-tolerant systems.

- [ Basic Types ](/basic_types/init.md)
  - [Binaries Strings Charlist](/basic_types/bsc.md)
- [ List and Tuples ](/list_tuples.md)
- [ Patter Matching ](/patter_matching.md)
- [ Conditionals ](/case_cond_if.md)
- [ Anonymous Functions ](/anonymus_functions.md)

## Interactive Mode

Elixir comes with three new CLI executables: `iex`, `elixir` and `elixirc`

We can run `iex` - Interactive Elixir. In interactive mode, we can type any Elixir expression and get its result.

## Running scripts

We create a file with `.elixir` and run it with `elixir <file>.exs`

```elixir
IO.puts("Hello World from Elixir!")
```

To see info about a type you are working on, you can use `i/1`

```elixir
i ~c"hello"
Term
  i ~c"hello"
Data type
  List
Description
  ...
Raw representation
  [104, 101, 108, 108, 111]
Reference modules
  List
Implemented protocols
  ...
```

## Identifying functions

Function are identified by both their name and their arity. From this point on we will use both the function name and its arity to describe functions. `trunc/1` identifies the function which is named `trunc` and takes `1` argument, whereas `trunc/2` identifies a different (nonexistent) function with the same name but with an arity of `2`

We can also use this syntax to access documentation. The Elixir shell defines the h function, which you can use to access documentation for any function. For example, typing h `trunc/1` is going to print the documentation for the `trunc/1` function:

`h trunc/1` works because it is defined in the `Kernel` module. All functions in the `Kernel` module are automatically imported into our namespace. Most often you will also include the module name when looking up the documentation for a given function:

```elixir
h Kernel.trunc/1
```

## Predicate Functions

We can use them to check for the type of a value.

```elixir
is_integer(1) # true
is_integer(2.0) # false
is_float(2.0) # true
is_number(2.0) # true
is_number(2) # true
```

## Structural Comparison

Elixir also provides `==`, `!=`, `<=`, `>=`, `<` and `>` as comparison operators. We can compare numbers, atoms, strings, booleans, etc.

- Integers and floats compare the same if they have the same value
  - You can use the strict comparison operator `===` and `!==` if you want to distinguish between integers and floats (that's the only difference between these operators)

The comparison operators in Elixir can compare across any data type. We say these operators perform structural comparison.
