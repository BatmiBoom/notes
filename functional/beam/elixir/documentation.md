# Documentation

Documentation must be easy to write and easy to read.
Documentation is written using Markdown.

## Module Attributes

Documentation in Elixir is usually attached to module attributes. Let's see an example:

```elixir
defmodule MyApp.Hello do
  @moduledoc """
  This is the Hello module.
  """
  @moduledoc since: "1.0.0"

  @doc """
  Says hello to the given `name`.

  Returns `:ok`.

  ## Examples

      iex> MyApp.Hello.world(:john)
      :ok

  """
  @doc since: "1.3.0"
  def world(name) do
    IO.puts("hello #{name}")
  end
end

```

The `@moduledoc` attribute is used to add documentation to the module. `@doc` is used before a function to provide documentation for it. Elixir also allows metadata to be attached to documentation, by passing a keyword list to `@doc` and friends.

## Function Arguments

When documenting a function, argument names are inferred by the compiler. For example:

```elixir
def size(%{size: size}) do
  size
end
```

The compiler will infer this argument as map. You can specify the proper names for documentation by declaring only the function head at any moment before the implementation:

```elixir
def size(map_with_size)
def size(%{size: size}) do
  size
end
```

## Documentation metadata

Elixir allows developers to attach arbitrary metadata to the documentation. This is done by passing a keyword list to the relevant attribute. A commonly used metadata is `:since`, which annotates in which version that particular module, function, type, or callback was added, as shown in the example above.

Another common metadata is `:deprecated`, which emits a warning in the documentation, explaining that its usage is discouraged:

`@doc deprecated: "Use Foo.bar/2 instead"`

Note that the :deprecated key does not warn when a developer invokes the functions. If you want the code to also emit a warning, you can use the @deprecated attribute:

`@deprecated "Use Foo.bar/2 instead"`

Metadata can have any key. Documentation tools often use metadata to provide more data to readers and to enrich the user experience.

## `Code.fetch_docs/1`

Elixir stores documentation inside pre-defined chunks in the bytecode. Documentation is not loaded into memory when modules are loaded, instead, it can be read from the bytecode in disk using the `Code.fetch_docs/1` function. The downside is that modules defined in-memory, like the ones defined in `IEx`, cannot have their documentation accessed as they do not write their bytecode to disk.
