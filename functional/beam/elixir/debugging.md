# Debugging

There are a number of ways to debug code in Elixir. In this chapter we will cover some of the more common ways of doing so.

## IO.inspect/2

What makes `IO.inspect(item, opts \\ [])` really useful in debugging is that it returns the item argument passed to it without affecting the behavior of the original code.

```elixir
(1..10)
|> IO.inspect()
|> Enum.map(fn x -> x * 2 end)
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()
```

Prints:

```elixir
1..10
[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
110
```

As you can see `IO.inspect/2` makes it possible to "spy" on values almost anywhere in your code without altering the result, making it very helpful inside of a pipeline like in the above case.

`IO.inspect/2` also provides the ability to decorate the output with a label option. The label will be printed before the inspected item:

```elixir
[1, 2, 3]
|> IO.inspect(label: "before")
|> Enum.map(&(&1 * 2))
|> IO.inspect(label: "after")
|> Enum.sum
```

Prints:

```elixir
before: [1, 2, 3]
after: [2, 4, 6]
```

It is also very common to use `IO.inspect/2` with `binding/0`, which returns all variable names and their values:

```elixir
def some_fun(a, b, c) do
  IO.inspect binding()
  ...
end
```

When `some_fun/3` is invoked with `:foo`, `"bar"`, `:baz` it prints:

```elixir
[a: :foo, b: "bar", c: :baz]
```

## dbg/2

It prints the value passed to it and returns it, it also prints the code and location.

```elixir
feature = %{name: :dbg, inspiration: "Rust"}
dbg(feature)
dbg(Map.put(feature, :in_version, "1.14.0"))
```

The code above prints this:

```elixir
[my_file.exs:2: (file)]
feature #=> %{inspiration: "Rust", name: :dbg}
[my_file.exs:3: (file)]
Map.put(feature, :in_version, "1.14.0") #=> %{in_version: "1.14.0", inspiration: "Rust", name: :dbg}
```

`dbg` understands Elixir code, so it will print values at every step of the pipeline.

```elixir
# In dbg_pipes.exs
__ENV__.file
|> String.split("/", trim: true)
|> List.last()
|> File.exists?()
|> dbg()
```

This code prints:

```elixir
[dbg_pipes.exs:5: (file)]
__ENV__.file #=> "/home/myuser/dbg_pipes.exs"
|> String.split("/", trim: true) #=> ["home", "myuser", "dbg_pipes.exs"]
|> List.last() #=> "dbg_pipes.exs"
|> File.exists?() #=> true
```

While `dbg` provides conveniences around Elixir constructs, you will need `IEx` if you want to execute code and set breakpoints while debugging.

## Pry

When using `IEx`, you may pass `--dbg pry` as an option to "stop" the code execution where the `dbg` call is:

`iex --dbg pry`

Or to debug inside a of a project:

`iex --dbg pry -S mix`

This is called "prying". While the pry session is running, the code execution stops, until continue (or c) or next (or n) are called. Remember you can always run iex in the context of a project with `iex -S mix TASK`.

## Breakpoints

`dbg` calls require us to change the code we intend to debug and has limited stepping functionality. Luckily `IEx` also provides a `IEx.break!/2` function which allows you to set and manage breakpoints on any Elixir code without modifying its source:

The mix test task direct integration with breakpoints via the -b/--breakpoints flag. When the flag is used, a breakpoint is set at the beginning of every test that will run:

Here are some commands you can use in practice:

```elixir
# Debug all failed tests
iex -S mix test --breakpoints --failed
# Debug the test at the given file:line
iex -S mix test -b path/to/file:line
```

## Observer

For debugging complex systems, jumping at the code is not enough. It is necessary to have an understanding of the whole virtual machine, processes, applications, as well as set up tracing mechanisms. Luckily this can be achieved in Erlang with :observer. In your application:

```elixir
:observer.start()
```

### Missing dependencies

When running iex inside a project with `iex -S mix`, observer won't be available as a dependency. To do so, you will need to call the following functions before:

```elixir
Mix.ensure_application!(:wx) # Not necessary on Erlang/OTP 27+
Mix.ensure_application!(:runtime_tools) # Not necessary on Erlang/OTP 27+
Mix.ensure_application!(:observer)
:observer.start()
```

The above will open another Graphical User Interface that provides many panes to fully understand and navigate the runtime and your project.

Finally, remember you can also get a mini-overview of the runtime info by calling `runtime_info/0` directly in IEx.
