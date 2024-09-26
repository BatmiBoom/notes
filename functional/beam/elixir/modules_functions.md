# Modules and Functions

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

## Function definition

Inside a module, we can define functions with `def/2` and private functions with `defp/2`.

```elixir
defmodule Math do
  def sum(a, b) do
    do_sum(a, b)
  end

  defp do_sum(a, b) do
    a + b
  end
end

IO.puts Math.sum(1, 2)    #=> 3
IO.puts Math.do_sum(1, 2) #=> ** (UndefinedFunctionError)
```

Function declarations also support guards and multiple clauses. If a function has several clauses, Elixir will try each clause until it finds one that matches. Here is an implementation of a function that checks if the given number is zero or not:

```elixir
defmodule Math do
    def zero?(0) do
        true
    end

    def zero?(x) when is_integer(x) do
        false
    end
end

IO.puts Math.zero?(0) #=> true
IO.puts Math.zero?(1) #=> false
IO.puts Math.zero?([1, 2, 3]) #=> ** (FunctionClauseError)
IO.puts Math.zero?(0.0) #=> ** (FunctionClauseError)
```

Giving an argument that does not match any of the clauses raises an error.

Similar to constructs like `if`, function definitions support both `do:` and `do-block` syntax, as we learned in the previous chapter.

```elixir
defmodule Math do
    def zero?(0), do: true
    def zero?(x) when is_integer(x), do: false
end
```

You may use `do:` for one-liners but always use `do-blocks` for functions spanning multiple lines.

## Default arguments

Function definitions in Elixir also support default arguments:

```elixir
defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world
```

Any expression is allowed to serve as a default value, but it won't be evaluated during the function definition. Every time the function is invoked and any of its default values have to be used, the expression for that default value will be evaluated:

```elixir
defmodule DefaultTest do
  def dowork(x \\ "hello") do
    x
  end
end

DefaultTest.dowork()
"hello"

DefaultTest.dowork(123)
123

DefaultTest.dowork()
"hello"
```

If a function with default values has multiple clauses, it is required to create a function head (a function definition without a body) for declaring defaults:

```elixir
defmodule Concat do
  # A function head declaring defaults
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world
IO.puts Concat.join("Hello")               #=> Hello
```

When a variable is not used by a function or a clause, we add a leading underscore `_` to its name to signal this intent.
