# Enumerables and Streams

While Elixir allows us to write recursive code, most operations we perform on collections is done with the help of the `Enum` and `Stream` modules.

## Enumerables

Elixir provides the concept of `enumerables` and the `Enum` module to work with them. We have already learned two enumerables: `lists` and `maps`.

```elixir
Enum.map([1, 2, 3], fn x -> x * 2 end) # [2, 4, 6]
Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end) # [2, 12]
```

The `Enum` module provides a huge range of functions to transform, sort, group, filter and retrieve items from enumerables.

Elixir also provides ranges, which are also enumerable:

```elixir
Enum.map(1..3, fn x -> x \* 2 end) # [2, 4, 6]
Enum.reduce(1..3, 0, &+/2) # 6

```

The functions in the `Enum` module are limited to, as the name says, enumerating values in data structures.

We say the functions in the `Enum` module are polymorphic because they can work with diverse data types. In particular, the functions in the `Enum` module can work with any data type that implements the `Enumerable` protocol.

## Eager vs Lazy

All the functions in the `Enum` module are eager. Many functions expect an enumerable and return a list back:

```elixir
odd? = fn x -> rem(x, 2) != 0 end
Enum.filter(1..3, odd?) # [1, 3]
```

This means that when performing multiple operations with `Enum`, each operation is going to generate an intermediate list until we reach the result:

```elixir
1..100_000
    |> Enum.map(&(&1 \* 3))
    |> Enum.filter(odd?)
    |> Enum.sum()
```

## Streams

As an alternative to `Enum`, Elixir provides the `Stream` module which supports lazy operations:

```elixir
1..100_000
    |> Stream.map(&(&1 * 3))
    |> Stream.filter(odd?)
    |> Enum.sum()
```

Streams are lazy, composable enumerables.

In the example above, `1..100_000 |> Stream.map(&(&1 * 3))` returns a data type, an actual stream, that represents the map computation over the range `1..100_000`

Furthermore, they are composable because we can pipe many stream operations:

```elixir
1..100_000
    |> Stream.map(&(&1 * 3))
    |> Stream.filter(odd?)
```

Instead of generating intermediate lists, streams build a series of computations that are invoked only when we pass the underlying stream to the `Enum` module. Streams are useful when working with large, possibly infinite, collections.

Many functions in the Stream module accept any enumerable as an argument and return a stream as a result. It also provides functions for creating streams. For example, `Stream.cycle/1` can be used to create a stream that cycles a given enumerable infinitely. Be careful to not call a function like `Enum.map/2` on such streams, as they would cycle forever:

```elixir
stream = Stream.cycle([1, 2, 3])
Enum.take(stream, 10) # [1, 2, 3, 1, 2, 3, 1, 2, 3, 1]
```

On the other hand, `Stream.unfold/2` can be used to generate values from a given initial value:

```elixir
stream = Stream.unfold("hełło", &String.next_codepoint/1)
Enum.take(stream, 3) # ["h", "e", "ł"]
```

Another interesting function is `Stream.resource/3` which can be used to wrap around resources, guaranteeing they are opened right before enumeration and closed afterwards, even in the case of failures. For example, `File.stream!/1` builds on top of `Stream.resource/3` to stream files:

```elixir
stream = File.stream!("path/to/file")
%File.Stream{
    line_or_bytes: :line,
    modes: [:raw, :read_ahead, :binary],
    path: "path/to/file",
    raw: true
}

Enum.take(stream, 10)
```

The example above will fetch the first 10 lines of the file you have selected. This means streams can be very useful for handling large files or even slow resources like network resources.
