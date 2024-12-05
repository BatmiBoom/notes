# Protocols

Mechanism to achieve polymorphism in Elixir where you want the behavior to vary depending on the data type. We are already familiar with one way of solving this type of problem: via pattern matching and guard clauses. Consider a simple utility module that would tell us the type of input variable.

```elixir
defmodule Utility do
    def type(value) when is_binary(value), do: "string"
    def type(value) when is_integer(value), do: "integer"
    # ... other implementations ...
end
```

If the use of this module were confined to your own project, you would be able to keep defining new `type/1` functions for each new data type.

However, this code could be problematic if it was shared as a dependency by multiple apps because there would be no easy way yo extend its functionality

This is where protocols can help us: protocols allow us to extend the original behavior for as many data types as we need. That's because dispatching on a protocol is available to any data type that has implemented the protocol and a protocol can be implemented by anyone, at any time

Here's how we could write the same `Utility.type/1` functionality as a protocol:

```elixir
defprotocol Utility do
    @spec type(t) :: String.t()
    def type(value)
end

defimpl Utility, for: BitString do
    def type(_value), do: "string"
end

defimpl Utility, for: Integer do
    def type(_value), do: "integer"
end
```

We define the protocol using `defprotocol/2` - its functions and specs may look similar to interfaces or abstract base classes in other languages. We can add as many implementations as we like using `defimlp/2`. The output is exactly the same as if we had a single module with multiple functions:

```elixir
Utility.type("foo") # string
Utility.type(123) # integer
```

With protocols, however, we are no longer stuck having to continuously modify the same module to support more and more data types. For example, we could spread the `defimpl` calls above over multiple files and Elixir will dispatch the execution to the appropriate implementation based on the data type. Functions defined in a protocol may have more than one input, but the dispatching will always be based on the data type of the first input

One of the most common protocols you may encounter is the `String.Chars` protocol: implementing its `to_stirng/1` function for your custom structs will tell the Elixir kernel how to represent them as strings.

## Example

In Elixir we have two idioms for checking how many items there are in a data structure: `length` and `size`. `length` means the information must be computed. For example, `length(list)` needs to traverse the whole list to calculate. On the other hand, `tuple_size(tuple)` and `byte_size(binary)` do not depend on the tuple and binary size as the size information is pre-computed in the data structure.

Even if we have type-specific functions for getting the size built into Elixir, we could implement a generic `Size` protocol that all data structures for which size is pre-computed would implement.

The protocol definition would look like this:

```elixir
defprotocol Size do
    @doc "Calculate the size of a data structure"
    def size(data)
end
```

The `Size` protocol expects a function called `size` that receives one argument(the data structure we want to know the size of) to be implemented

```elixir
defimpl Size, for: BitString do
    def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
    def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
    def size(tuple), do: tuple_size(tuple)
end
```

We didn't implement the `Size` protocol for lists as there is no "size" information pre-computed for lists, and he length of a list has to be computed (with `length/1`)

Now with the protocol defined and implementations in hand, we can start using it:

```elixir
Size.size("foo")
Size.size(%{label: "some label"})
Size.size({:ok, "hello"})
```

It's possible to implement protocols for all Elixir data types:

- Atom
- BitString
- Float
- Function
- Integer
- List
- Map
- PID
- Port
- Reference
- Tuple

## Protocols and structs

The power of Elixir's extensibility comes when `protocols` and `structs` are used together.

In the previous chapter, we have learned that although structs are maps, they do not share protocol implementations with maps. For example, `MapSets` are implemented as structs.

Instead of sharing protocol implementation with maps, structs require their own protocol implementation. Since a `MapSet` has its size precomputed and accessible through `MapSet.size/1`, we can define a Size implementation for it:

```elixir
defimpl Size, for: MapSet do
    def size(set), do: MapSet.size(set)
end
```

If desired, you could come up with your own semantics for the size of your struct. Not only that, you could use structs to build more robust data types, like queues, and implement all relevant protocols, such as Enumerable and possibly Size, for this data type.

```elixir
defmodule User do
    defstruct [:name, :age]
end

defimpl Size, for: User do
    def size(user), do: 2
end
```

## Implementing Any

Manually implementing protocols for all types can quickly become repetitive and tedious. In such cases, we can explicitly derive the protocol implementation for our types or automatically implement the protocol for all types. In both cases, we need to implement the protocol for Any.

### Deriving

Elixir allows us to derive a protocol implementation based on the Any implementation. Let's first implement Any as follows:

```elixir
defimpl Size, for: Any do
  def size(_), do: 0
end
```

The implementation above is arguably not a reasonable one. For example, it makes no sense to say that the size of a PID or an Integer is 0.

However, should we be fine with the implementation for Any, in order to use such implementation we would need to tell our struct to explicitly derive the Size protocol:

```elixir
defmodule OtherUser do
    @derive [Size]
    defstruct [:name, :age]
end

```

When deriving, Elixir will implement the Size protocol for `OtherUser` based on the implementation provided for Any.

### Fallback to Any

Another alternative to `@derive` is to explicitly tell the protocol to fallback to `Any` when an implementation cannot be found. This can be achieved by setting `@fallback_to_any` to true in the protocol definition:

```elixir
defprotocol Size do
  @fallback_to_any true
  def size(data)
end
```

As we said in the previous section, the implementation of Size for Any is not one that can apply to any data type. That's one of the reasons why @fallback_to_any is an opt-in behavior. For the majority of protocols, raising an error when a protocol is not implemented is the proper behavior. That said, assuming we have implemented Any as in the previous section:

```elixir
defimpl Size, for: Any do
  def size(_), do: 0
end
```

Now all data types (including structs) that have not implemented the Size protocol will be considered to have a size of 0.

Which technique is best between deriving and falling back to Any depends on the use case but, given Elixir developers prefer explicit over implicit, you may see many libraries pushing towards the @derive approach.

### Built-in protocols

Elixir ships with some built-in protocols. In previous chapters, we have discussed the `Enum` module which provides many functions that work with any data structure that implements the Enumerable protocol:

```elixir
Enum.map([1, 2, 3], fn x -> x * 2 end) # [2, 4, 6]
Enum.reduce(1..3, 0, fn x, acc -> x + acc end) # 6
```

Another useful example is the String.Chars protocol, which specifies how to convert a data structure to its human representation as a string. It's exposed via the to_string function:

```elixir
to_string(:hello) # "hello"
```

Notice that string interpolation in Elixir calls the to_string function:

```elixir
"age: #{25}"
"age: 25"
```

The snippet above only works because numbers implement the String.Chars protocol. Passing a tuple, for example, will lead to an error:

```elixir
tuple = {1, 2, 3} # {1, 2, 3}

"tuple: #{tuple}" # ** (Protocol.UndefinedError) protocol String.Chars not implemented for {1, 2, 3} of type Tuple
```

When there is a need to "print" a more complex data structure, one can use the inspect function, based on the Inspect protocol:

```elixir
"tuple: #{inspect(tuple)}"
"tuple: {1, 2, 3}"
```

The Inspect protocol is the protocol used to transform any data structure into a readable textual representation. This is what tools like IEx use to print results:

```elixir
{1, 2, 3} # {1, 2, 3}
%User{} # %User{name: "john", age: 27}
```

Keep in mind that, by convention, whenever the inspected value starts with #, it is representing a data structure in non-valid Elixir syntax. This means the inspect protocol is not reversible as information may be lost along the way:

```elixir
inspect &(&1+2) # "#Function<6.71889879/1 in :erl_eval.expr/5>"
```

There are other protocols in Elixir but this covers the most common ones. You can learn more about protocols and implementations in the Protocol module.
