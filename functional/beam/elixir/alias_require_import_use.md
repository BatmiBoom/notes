# Alias, Require, Import, and Use

> All modules defined in Elixir are defined inside the main Elixir namespace, such as Elixir.String. However, for convenience, you can omit "Elixir." when referencing them.

Elixir provides three directives `alias`, `require`, and `import` plus a macro called `use` summarized below:

```elixir
# Alias the module so it can be called as Bar instead of Foo.Bar
alias Foo.Bar, as: Bar

# Require the module in order to use its macros
require Foo

# Import functions from Foo so they can be called without the `Foo.` prefix
import Foo

# Invokes the custom code defined in Foo as an extension point
use Foo
```

The first three are called directives because they have lexical scope, while `use` is a common extension point that allows the used module to inject code.

## ALIAS - Lexical Scope

alias allows you to set up aliases for any given module name.

Imagine a module uses a specialized list implemented in Math.List. The alias directive allows referring to Math.List just as List within the module definition:

```elixir
defmodule Stats do
    alias Math.List, as: List
    # In the remaining module definition List expands to Math.List.
end
```

Aliases are frequently used to define shortcuts. In fact, calling alias without an :as option sets the alias automatically to the last part of the module name, for example:

`alias Math.List`

Is the same as:

`alias Math.List, as: List`

## REQUIRE - Lexical Scope

Elixir provides macros as a mechanism for meta-programming. Macros are expanded at compile time.

Public functions in modules are globally available, but in order to use macros, you need to opt-in by requiring the module they are defined in.

```elixir
Integer.is_odd(3) # \*\* (UndefinedFunctionError) function Integer.is_odd/1 is undefined or private. However, there is a macro with the same name and arity. Be sure to require Integer if you intend to invoke this macro (elixir) Integer.is_odd(3)

require Integer
Integer.is_odd(3) # true
```

`Integer.is_odd/1` is defined as a macro so that it can be used as a guard. This means that, in order to invoke `Integer.is_odd/1`, we need to first require the Integer module.

## IMPORT - Lexical Scope

We use import whenever we want to access functions or macros from other modules without using the fully-qualified name.

For example, if we want to use the `duplicate/2` function from the `List` module several times, we can import it:

```elixir
import List, only: [duplicate: 2]
duplicate(:ok, 3) # [:ok, :ok, :ok]
```

- :only is optional, its usage is recommended in order to avoid importing all the functions
- :except could also be given as an option in order to import everything in a module except a list of functions.

## USE

The use macro is frequently used as an extension point. This means that, when you use a module `FooBar`, you allow that module to inject any code in the current module, such as importing itself or other modules, defining new functions, setting a module state, etc.

For example, in order to write tests using the `ExUnit` framework, a developer should use the `ExUnit.Case` module:

```elixir
defmodule AssertionTest do
    use ExUnit.Case, async: true

    test "always pass" do
        assert true
    end
end

```

Behind the scenes, `use` requires the given module and then calls the **using**/1 callback on it allowing the module to inject some code into the current context. Some modules (for example, the above `ExUnit.Case`, but also `Supervisor` and `GenServer`) use this mechanism to populate your module with some basic behaviour, which your module is intended to override or complete.

Generally speaking, the following module:

```elixir
defmodule Example do
    use Feature, option: :value
end
```

is compiled into

```elixir
defmodule Example do
    require Feature
    Feature.**using**(option: :value)
end
```

Since `use` allows any code to run, we can't really know the side-effects of using a module without reading its documentation.

## Understanding Aliases

An alias in Elixir is a capitalized identifier which is converted to an atom during compilation.

By using the `alias/2` directive, we are changing the atom the alias expands to.

Aliases expand to atoms because in the Erlang Virtual Machine (and consequently Elixir) modules are always represented by atoms:

```elixir
List.flatten([1, [2], 3])
:"Elixir.List".flatten([1, [2], 3])
```

That's the mechanism we use to call Erlang modules:

```elixir
:lists.flatten([1, [2], 3])
```

## Module nesting

Now that we have talked about aliases, we can talk about nesting and how it works in Elixir. Consider the following example:

```elixir
defmodule Foo do
    defmodule Bar do
    end
end
```

The example above will define two modules: `Foo` and `Foo.Bar`.

Note: in Elixir, you don't have to define the Foo module before being able to define the Foo.Bar module, as they are effectively independent. The above could also be written as:

```elixir
defmodule Foo.Bar do
end

defmodule Foo do
    alias Foo.Bar
    # Can still access it as `Bar`
end
```

Aliasing a nested module does not bring parent modules into scope. Consider the following example:

```elixir
defmodule Foo do
    defmodule Bar do
        defmodule Baz do
        end
    end
end

alias Foo.Bar.Baz
# The module `Foo.Bar.Baz` is now available as `Baz`
# However, the module `Foo.Bar` is _not_ available as `Bar`
```

## Multi alias/import/require/use

Imagine you have an application where all modules are nested under `MyApp`, you can alias the modules `MyApp.Foo`, `MyApp.Bar` and `MyApp.Baz` at once as follows:

`alias MyApp.{Foo, Bar, Baz}`
