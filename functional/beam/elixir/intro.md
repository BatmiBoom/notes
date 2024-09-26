# Elixir

Elixir is a dynamic, functional language for building scalable and maintainable applications. Runs on the Erlang VM, known for creating low-latency, distributed, and fault-tolerant systems.

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
