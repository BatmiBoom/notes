# Attributes

Serves three purposes:

1. As module and function annotations
2. As temporary module storage to be used during compilation
3. As compile-time constants

## As annotations

We can define the module documentation by using the module attribute syntax.

```elixir
defmodule MyServer do
    @moduledoc "My server code."
```

Elixir has a handful of reserved attributes. The most common ones:

- `@moduledoc` -> docs for the current module
- `@doc` -> docs for the function or macro below the attribute
- `@spec` -> `typespec` for the function below the attribute
- `@behaviour` -> specify an OTP or user-defined behaviour

```elixir
defmodule Math do
  @moduledoc """
  Provides math-related functions.

  ## Examples
      iex> Math.sum(1, 2)
      3
  """

  @doc """
  Calculates the sum of two numbers.
  """
  def sum(a, b), do: a + b
end
```

Elixir promotes the use of Markdown with heredocs to write readable documentation. Heredocs are multi-line strings, they start and end with triple double-quotes, keeping the formatting of the inner text. We can access the documentation of any compiled module directly from IEx:

```bash
elixirc math.ex
iex
h Math # Access the docs for the module Math
h Math.sum # Access the docs for the sum function
```

We also provide a tool called `ExDoc` which is used to generate HTML pages from the documentation.

You can take a look at the docs for Module for a complete list of supported attributes. Elixir also uses attributes to annotate our code with `typespecs`.

## As temporary storage

How we read attributes?

```elixir
defmodule MyApp.Status do
    @service URI.parse("https://example.com")
    def status(email) do
        SomeHttpClient.get(@service)
    end
end
```

> Do not add a newline between the attribute and its value, otherwise Elixir will assume you are reading the value, rather than setting it.

The module attribute is defined at compilation time and its return value, is what will be substituted in for the attribute. So the above will effectively compile to this:

```elixir
defmodule MyApp.Status do
    def status(email) do
        SomeHttpClient.get(%URI{
            authority: "example.com",
            host: "example.com",
            port: 443,
            scheme: "https"
        })
    end
end

```

Every time we read an attribute inside a function, compiler takes a snapshot of its current value. Therefore if you read the same attribute multiple times, you end-up increasing compilation times.

For example, instead of this:

```elixir
def some_function, do: do_something_with(@example)
def another_function, do: do_something_else_with(@example)
```

Prefer this:

```elixir
def some_function, do: do_something_with(example())
def another_function, do: do_something_else_with(example())
defp example, do: @example
```

## As compile-time constants

Module attributes may also be useful as compile-time constants. Generally speaking, functions themselves are sufficient for the role of constants in a codebase. For example, instead of defining:

`@hours_in_a_day 24`

You should prefer:

`defp hours_in_a_day(), do: 24`

It is common in many projects to have a module called `MyApp.Constants` that defines all constants used throughout the codebase.

For example, you may specify a system configuration constant as follows:

```elixir
defp system_config(), do: %{timezone: "Etc/UTC", locale: "pt-BR"}
```

A common scenario is module attributes inside patterns and guards, as an alternative to `defguard/1`, since they only support a limited set of expressions:

```elixir
# Inside pattern
@default_timezone "Etc/UTC"
def shift(@default_timezone), do: ...

# Inside guards
@time_periods [:am, :pm]
def shift(time, period) when period in @time_periods, do: ...
```

Module attributes as constants and as temporary storage are most often used together: the module attribute is used to compute and store an expensive value, and then exposed as constant from that module.
