# Basic Types

- integer
  - 1
  - 0x1F
- float
  - 1.0
- boolean
  - true
- atom / symbol
  - :atom
- string
  - "elixir"
- list
  - [1,2,3]
- tuple
  - {1,2,3}

## Basic Arithmetic

```elixir
1 + 2
1 - 2
5 * 5
10 / 2
```

The `/` returns a float instead of an integer. If we want to do integer division - remainder, we can use `div` and `rem` functions:

We can also use `round` to get the closest integer to a given float and `trunc` to get the integer part of a float

```elixir
div(10, 2) # 5
rem(10, 3) # 1
round(3.58) # 4
trunc(3.58) # 3
```

Elixir allows to drop the parentheses when invoking functions that expect one or more arguments. However, is good practice to use it

### Float

Are 64-bit precision. Require a dot followed by at least one digit and also support `e` for scientific notation:

```elixir
1.0
1.0e-10
```

### Notation for binary, octal, and hexadecimal:

```elixir
0b1010
0o777
0x1f
```

### Predicate Functions

We can use them to check for the type of a value.

```elixir
is_integer(1) # true
is_integer(2.0) # false
is_float(2.0) # true
is_number(2.0) # true
is_number(2) # true
```

## Booleans and `nil`

- `true`
- `false`

Elixir also provides three boolean operators: `or/2`, `and/2` and `not/1`. These operators are strict in the sense that they expect something that evaluates to a boolean (`true` or `false`) as their first argument.

```elixir
true and true # true
false or is_boolean(true) # true
```

Providing a non-boolean will raise an exception:

```elixir
1 and true

# ** (BadBooleanError) expected a boolean on left-side of "and", got: 1
```

`or` and `and` are short-circuit operators. They only execute the right side if the left side is not enough to determine the result:

```elixir
false and raise("This error will never be raised") # false
true and raise("This error will never be raised") # true
```

Elixir also provides the concept of `nil`, to indicate the absence of a value, and a set of logical operators that also manipulate `nil`: `||/2`, `&&/2`, and `!/1`. For these operators, `false` and `nil` are considered "falsy", all other values are considered "truthy":

```elixir
# or
1 || true # 1
false || 11 # 11

# and
nil && 13 # nil
true && 17 # 17

# not
!true # false
!1 # false
!nil # true
```

Similarly, values like `0` and `""`, which some other programming languages consider to be "falsy" are also "truthy" in Elixir.

## Atoms

An atom is a constant whose value is its own name. Some other languages call these symbols. They are often useful to enumerate over distinct values, such as:

Atoms are equal if their names are equal.

```elixir
:apple # :apple
:orange # :orange
:watermelon # :watermelon

:apple == :apple # true
:orange == :apple # false
```

Often they are used to express the state of an operation, by using values such as `:ok` and `:error`

The booleans `true` and `false` are also atoms:

```elixir
true == :true # true
is_atom(true) # true
is_boolean(:false) # true
```

Elixir allows you to skip the leading : for the atoms `false`, `true` and `nil`.

## Strings

Strings in Elixir are delimited by double quotes, and they are encoded in UTF-8:

```elixir
"hellö" # "hellö"
```

### Concatenate

```elixir
"hello " <> "world"! # "hello world"
```

### String interpolation:

```elixir
string = "world"
"hello #{string}!" # "hello world"
```

String concatenation requires both sides to be strings but interpolation supports any data type that may be converted to a string

### Printing

We can print to stdout using the `IO.puts/1` function from the `IO` module:

```elixir
IO.puts("Hello\nWorld")
# Hello
# World
# :ok
```

Notice that the `IO.puts/1` function returns the atom `:ok` after printing.

### String Representation

Strings in Elixir are represented internally by contiguous sequences of bytes known as binaries:

```elixir
is_binary("hello") # true
```

We can also get the number of bytes in a string:

```elixir
byte_size("hellö") # 6
```

Notice that the number of bytes in that string is 6, even though it has 5 `graphemes`. That's because the `grapheme` "ö" takes 2 bytes to be represented in UTF-8. We can get the actual length of the string, based on the number of graphemes, by using the `String.length/1` function

### Length of String

```elixir
String.length("hellö") # 5
```

The `String` module contains a bunch of functions that operate on strings as defined in the Unicode standard:

```elixir
String.upcase("hellö") # "HELLÖ"
```

## Structural Comparison

Elixir also provides `==`, `!=`, `<=`, `>=`, `<` and `>` as comparison operators. We can compare numbers, atoms, strings, booleans, etc.

- Integers and floats compare the same if they have the same value
  - You can use the strict comparison operator `===` and `!==` if you want to distinguish between integers and floats (that's the only difference between these operators)

The comparison operators in Elixir can compare across any data type. We say these operators perform structural comparison.
