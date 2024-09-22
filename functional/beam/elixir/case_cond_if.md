# case

Allow us to compare a value against many patterns until we find a matching one:

```elixir
case {1,2,3} do
    {4, 5, 6} ->
        "This clause won't match"
    {1, x, 3} ->
        "This clause will match and bind x to 2 in this clause"
    _ ->
        "This clause would match any value"
end
```

If you want to pattern match against an existing variable, you need to use the `^` operator:

```elixir
x = 1
case 10 do
    ^x -> "Won't Match"
    _ -> "Will Match"
end
```

Clauses also allow extra conditions to be specified via guards:

```elixir
case {1,2,3} do
    {1, x, 3} when x > 0 ->
        "This clause will match and bind x to 2 in this clause"
    _ ->
        "This clause would match any value"
end
```

If none of the clauses match, an error is raised.

# if/unless

In many situations, you need to write conditions that go beyond what can be expressed with `case`.
For those, `if/2` and `unless/2` are useful alternatives.

```elixir
if true do
    "This works!"
else
    "This won't!"
end

unless true do
    "This will never be seen"
end
```

If the condition given to `if/2` returns `false` or `nil`, the body given between `do`-`end` is not executed and instead it returns `nil`. The opposite happens with `unless/2`.

If any variable is declared or changed inside `if`, `case`, and similar constructs, the declaration and change will only be visible inside the construct

```elixir
x = 1
if true do
  x = x + 1 # 2
end
x # 1
```

In said cases, if you want to change a value, you must return the value from the `if`:

```elixir
x = 1
x = if true do
    x + 1
end
x # 2
```

An interesting note regarding `if/2` and `unless/2` is that they are implemented as macros in the language: they aren't special language constructs as they would be in many languages.

# cond

If you need to check across several conditions and find the first one that does not evaluate to `nil` or `false`, `cond/1` is what you want:

```elixir
cond do
    2 + 2 == 5 ->
        "This will not be true"
    2 * 2 == 3 ->
        "Nor this"
    1 + 1 == 2 ->
        "But this will"
end
```

This is equivalent to else if clauses in many imperative languages - although used less frequently in Elixir.

If all of the conditions return nil or false, an error (`CondClauseError`) is raised. For this reason, it may be necessary to add a final condition, equal to true, which will always match:

```elixir
cond do
  2 + 2 == 5 ->
    "This is never true"
  2 * 2 == 3 ->
    "Nor this"
  true ->
    "This is always true (equivalent to else)"
end
```
