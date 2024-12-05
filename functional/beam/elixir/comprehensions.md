# Comprehensions

It is common to loop over an Enumerable, often filtering out some results and mapping values into another list. Comprehensions are syntactic sugar for such constructs: they group those common tasks into the `for` special form.

```elixir
for n <- [1, 2, 3, 4], do: n*n
```

A comprehension is made of three parts: generators, filters, and collectables

## Generators

In the expression above, `n <- [1, 2, 3, 4]` is the **generator**. It is really generating values to be used in the comprehension.

Any enumerable can be passed on the right-hand side of the generator expression:

```elixir
for n <- 1..4, do: n*n
```

Generator expressions also support pattern matching on their left-hand side; all non-matching patterns are ignored. Imagine that, instead of a range, we have a keyword list where the key is the atom :good or :bad and we only want to compute the square of the :good values:

```elixir
values = [good: 1, good: 2, bad: 3, good: 4]
for {:good, n} <- values, do: n * n
```

## Filters

Can be used to select some particular elements. For example: we can select the multiples of 3 and discard all others:

```elixir
for n <- 0..5, rem(n, 3) == 0, do: n \* n
```

Comprehensions discard all elements for which the filter expression returns false or nil.

Comprehensions also allow multiple generators and filters to be given. Here is an example that receives a list of directories and gets the size of each file in those directories:

```elixir
dirs = ["/home/mikey", "/home/james"]
for dir <- dirs,
        file <- File.ls!(dir),
        path = Path.join(dir, file),
        File.regular?(path) do
    File.stat!(path).size
end

```

Multiple generators can also be used to calculate the Cartesian product of two lists:

```elixir
for i <- [:a, :b, :c], j <- [1, 2], do: {i, j}
```

Finally, keep in mind that variable assignments inside the comprehension, be it in generators, filters or inside the block, are not reflected outside of the comprehension.

## Bitstring generators

Are also supported and are very useful when you need to comprehend over bitstring streams. The example below receives a list of pixels from a binary with their respective red, green and blue values and converts them into tuples of three elements each:

```elixir
pixels = <<213, 45, 123, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
for <<r::8, g::8, b::8 <- pixels>>, do: {r, g, b}
```

A bitstring generator can be mixed with "regular" enumerable generators, and supports filters as well

## The `:into` option

The result of a comprehension can be inserted into different data structures by passing the `:into` option to the comprehension.

For example, a bitstring generator can be used with the `:into` option in order to easily remove all spaces in a string:

```elixir
for <<c <- " hello, world">>, c != ?\s, into: "", do: <<c>>
```

Sets, maps, and other dictionaries can also be given to the `:into` option. In general, `:into` accepts any structure that implements the `Collectable` protocol.

A common use case of `:into` can be transforming values in a map:

```elixir
for {key, val} <- %{"a" -> 1, "b" -> 2}, into: %{}: {key, val*val}
```

We can also use streams. Since the `IO` module provides streams (that are both `Enumerable` and `Collectable`), an echo terminal that echoes back the upcased version of whatever is typed can be implemented using comprehensions:

```elixir
stream = IO.stream(:stdio, :line)
for line <- stream, into: stream do
    String.upcase(line) <> "\n"
end
```

## Other options

Comprehensions support other options, such as `:reduce` and `:uniq`.
