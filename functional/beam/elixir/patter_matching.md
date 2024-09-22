# Pattern Matching

- `=` is called the match operator. We can use it to patten match inside data structures.
- `^` is called the pin operator. We can use it to access previously bound values.

## The Match Operator

We have used the `=` operator a couple times to assign variables in Elixir. We can see why its called the match operator.

```elixir
x = 1 # 1
1 = x # 1
2 = x # ** (MatchError) no match of right hand side value: 1
```

Notice that `1=x` is a valid expression, and it matched because both the left and right side are equal to 1. When the sides do not match, a `MatchError` is raised.

A variable can only be assigned on the left side of `=`

### Pattern Matching

`=` is not only to match against simple values, but it is also useful for destructuring more complex data types.

```elixir
{a, b, c} = {:hello, "world", 42} # {:hello, "world", 42}
a # :hello
b # "world"
```

- `MatchError` will occur if the sides can't be matched
- `MatchError` when comparing different types, for example if matching a tuple on the left side with a list of the right side.
- `MatchError` for specific values

  ```elixir
  {:ok, result} = {:ok, 13}
  result # 13

  {:ok, result} = {:error, :oops} # ** (MatchError)
  ```

- A list also supports matching on its own head and tail:

```elixir
[head | tail] = [1,2,3]
[head | tail] = [] # ** (MatchError)
```

## The Pin Operator

Variables in Elixir can be rebound:

Use the pin operator `^` when you want to pattern match against a variable's **existing** value rather than rebinding the variable

```elixir
x = 1
^x = 2 # ** (MatchError)
```

We can use the pin operator inside other pattern matches, such as tuples or lists:

```elixir
x = 1 # 1
[^x, 2, 3] = [1, 2, 3] # [1, 2, 3]
{y, ^x} = {2, 1} # {2, 1}
y # 2
{y, ^x} = {2, 2} # ** (MatchError)
```

If a variable is mentioned more than once in a pattern, all references must bind to the same value:

```elixir
{x, x} = {1, 1} # {1, 1}
{x, x} = {1, 2} # ** (MatchError)
```

In some cases, you don't care about a particular value in a pattern. It is a common practice to bind those values to the underscore, `_`.

```elixir
[head | _] = [1, 2, 3] # [1, 2, 3]
head # 1
```
