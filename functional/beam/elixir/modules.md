# Modules

In Elixir we group several functions into modules. We've already used many different modules in the previous chapters, such as `String` module.

We use the `defmodule` macro to create new modules. The first letter of the module must be in uppercase. We use the `def` macro to define functions in that module

```elixir
defmodule Math do
    def sum(a, b) do
        a + b
    end
end

Math.sum(1,2)
```

## Compilation

It is convenient to write modules into files so they can be compiled and reused

We can create a file named `math.ex` and define the module name `Math`

This file can be compiled using `elixirc`:

`elixirc math.ex`

This will generate a file named `Elixir.Math.beam` containing the bytecode for the defined module. If we start `iex` again, our module definition will be available (provided that `iex` is started in the same directory the bytecode file is in)

Elixir projects are usually organized into three directories:

- `_build` - contains compilation artifacts
- `lib` - contains Elixir code (usually .ex files)
- `test` - contains tests (usually .exs files)

When working on actual projects, the build tool called `mix` will be responsible for compiling and setting up the proper paths for you.

## Scripting mode

Elixir also supports `.exs` files for scripting. Elixir treats both files exactly the same way, the only difference is in intention. `.ex` files are meant to be compiled while `.exs` files are used for scripting.

For instance, we can create a file called math.exs

```elixir
defmodule Math do
    def sum(a, b) do
        a + b
    end
end

IO.puts Math.sum(1, 2)
```

And we run it with `elixir math.exs`

Because we used `elixir` instead of `elixirc`, the module was compiled and loaded into memory, but no `.beam` file was written to disk.

- [Functions](/modules_functions.md)
- [Attributes](/module_attributes.md)
