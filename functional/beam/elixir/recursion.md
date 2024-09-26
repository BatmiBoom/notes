# Recursion

We leverage recursion and high-level functions for working with collections.

## Loops through recursion

Due to immutability, loops in Elixir are written differently from imperative languages.

Functional languages rely on recursion: a function is called recursively until a condition is reached that stops the recursive action from continuing. No data is mutated in this process.

```elixir
defmodule Recursion do
  def print_multiple_times(msg, n) when n > 0 do
    IO.puts(msg)
    print_multiple_times(msg, n - 1)
  end

  def print_multiple_times(_msg, 0) do
    :ok
  end
end

Recursion.print_multiple_times("Hello!", 3)
# Hello!
# Hello!
# Hello!
# :ok
```

Similar to `case`, a function may have many clauses.

## Reduce and map algorithms

- The process of taking a list and mapping over it is known as a `map algorithm`.
- The process of taking a list and reducing it down to one value is known as a `reduce algorithm`

### Reduce

Sum a list of numbers:

```elixir
defmodule Math do
    def sum_list([head | tail], accumulator) do
        sum_list(tail, head + accumulator)
    end

    def sum_list([], accumulator) do
        accumulator
    end
```

We invoke `sum_list` with the list [1, 2, 3] and the initial value 0 as arguments. We will try each clause until we find one that matches according to the pattern matching rules. In this case, the list [1, 2, 3] matches against [head | tail] which binds head to 1 and tail to [2, 3]; accumulator is set to 0.

Then, we add the head of the list to the accumulator head + accumulator and call sum_list again, recursively, passing the tail of the list as its first argument. The tail will once again match [head | tail] until the list is empty, as seen below:

```
sum_list [1, 2, 3], 0
sum_list [2, 3], 1
sum_list [3], 3
sum_list [], 6
```

When the list is empty, it will match the final clause which returns the final result of 6.

### Map

What if we instead want to double all of the values in our list?

```elixir
defmodule Math do
    def double_each([head | tail]) do
        [head * 2 | double_each(tail)]
    end

    def double_each([]) do
        []
    end
end

```

```elixir
iex math.exs
Math.double_each([1, 2, 3]) #=> [2, 4, 6]
```

```
double_each([1, 2, 3])
[1 * 2, double_each([2, 3])]
[1*2, 2*2, double_each([3])]
[1*2, 2*2, 3*2, double_each([])]
[2, 4, 6]
```

Here we have used recursion to traverse a list, doubling each element and returning a new list.

Recursion and tail call optimization are an important part of Elixir and are commonly used to create loops. However, when programming in Elixir you will rarely use recursion as above to manipulate lists.
