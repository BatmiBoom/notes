# Structs

Are extensions built on top of maps that provide compile-time checks and default values.

## Defining Structs

To define a struct, the `defstruct/1` construct is used:

```elixir
defmodule User do
    defstruct name: "John", age: 27
end
```

The keyword list used with `defstruct` defines what fields the struct will have along with their default values. Structs take the name of the module they're define in. In the example above, we defined a struct named `User`.

We can now create `User` structs by using a syntax similar to the one used to create maps:

```elixir
%User{}
%User{age: 27, name: "John"}

%User{name: "Jane"}
%User{age: 27, name: "Jane"}
```

Structs provide compile-time guarantees that only the fields defined through `defstruct` will be allowed to exist in a struct:

## Accessing and updating structs.

Structs share the same syntax for accessing and updating fields as maps of fixed keys:

```elixir
john = %User{} # %User{age: 27, name: "John"}
john.name # "John"
jane = %{john | name: "Jane"} # %User{age: 27, name: "Jane"}
```

When using the update `syntax (|)`, Elixir is aware that no new keys will be added to the struct, allowing the maps underneath to share their structure in memory.

Structs can also be used in pattern matching, both for matching on the value of specific keys as well as for ensuring that the matching value is a struct of the same type as the matched value.

```elixir
%User{name: name} = john # %User{age: 27, name: "John"}
name # "John"
```

## Structs are bare maps underneath

Structs are simply maps with a "special" field named **struct** that holds the name of the struct:

```elixir
is_map(john) # true
john.**struct** # User
```

However, structs do not inherit any of the protocols that maps do. For example, you can neither enumerate nor access a struct

Structs alongside protocols provide one of the most important features for Elixir developers: data polymorphism.

## Default values and required keys

If you don't specify a default key value when defining a struct, nil will be assumed:

```elixir
defmodule Product do
    defstruct [:name]
end

%Product{} # %Product{name: nil}
```

You can define a structure combining both fields with explicit default values, and implicit nil values. In this case you must first specify the fields which implicitly default to nil:

```elixir
defmodule User do
    defstruct [:email, name: "John", age: 27]
end

%User{} # %User{age: 27, email: nil, name: "John"}
```

You can also enforce that certain keys have to be specified when creating the struct via the @enforce_keys module attribute:

```elixir
defmodule Car do

    @enforce_keys [:make]
    defstruct [:model, :make]

end
```

Enforcing keys provides a simple compile-time guarantee to aid developers when building structs.
