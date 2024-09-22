# Anonymous Functions

Allow us to store and pass executable code around as if it was an integer or a string.

## Defining anonymous functions

Are delimited by the keywords `fn` and `end`:

```elixir
add = fn a, b -> a + b end
add.(1, 2) # 3
is_function(add) # true
```

- Invoke anonymous functions by passing arguments to it.
- `.` between the variable and parentheses is required to invoke an anonymous function.

Anonymous functions in Elixir are also identified by the number of arguments they receive. We can check if a function is of any given arity by using `is_function/2`:

```elixir
is_function(add, 2) # true
is_function(add, 1) # false
```

## Closures

Anonymous functions can also access variables that are in scope when the function is defined. This is typically referred to as closures, as they close over their scope.

```elixir
add = fn a, b -> a + b end
double = fn a -> add.(a, a) end
double.(2) # 4
```

## Clauses and guards

Similar to `case/2`, we can pattern match on the arguments of anonymous functions as well as define multiple clauses and guards:

```elixir
f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end

f.(1, 3) # 4
f.(-1, 3) # -3
```

The number of arguments in each anonymous function clause needs to be the same, otherwise an error is raised.

## The capture operator

We have been using the notation `name/arity` to refer to functions
This notation can actually be used to capture an existing function into a data-type we can pass around, similar to how anonymous functions behave.

```elixir
fun = &is_atom/1 # &:erlang.is_atom/1
is_function(fun) # true
fun.(:hello) # true
fun.(123) # false
```

As you can see, once a function is captured, we can pass it as argument or invoke it using the anonymous function notation. The returned value above also hints we can capture functions defined in modules:

```elixir
fun = &String.length/1 # &String.length/1
fun.("hello") # 5
```

You can also capture operators:

```elixir
add = &+/2 # &:erlang.+/2
add.(1, 2) # 3
```

The capture syntax can also be used as a shortcut for creating functions. This is handy when you want to create functions that are mostly wrapping existing functions or operators:

```elixir
fun = &(&1 + 1) #Function<6.71889879/1 in :erl_eval.expr/5>
fun.(1) # 2

fun2 = &"Good #{&1}" #Function<6.127694169/1 in :erl_eval.expr/5>
fun2.("morning") # "Good morning"
```

The `&1` represents the first argument passed into the function. `&(&1 + 1)` above is exactly the same as `fn x -> x + 1 end`.
