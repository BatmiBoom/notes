# Binaries, strings, and charlists

## Unicode and Code Points

A standard is required so that the ones and zeros on one machine mean the same thing when they are transmitted to another.

The Unicode Standard acts as an official registry of virtually all the characters we know.

Unicode organizes all of the characters in its repertoire into code charts, and each character is given a unique numerical index. This numerical index is known as a Code Point.

You can use a `?` in front of a character literal to reveal its code point:

```elixir
?a # 97
?ł # 322
```

We refer to a code point by its hex representation
We can represent any Unicode character in an string by using the `\uXXXX` notation and the hex representation of its code point number:

```elixir
"\u0061" == "a" # true
0x0061 = 97 = ?a # 97
```

The hex representation will also help you look up information about a code point, e.g. https://codepoints.net/U+0061 has a data sheet all about the lower case a.

## UTF-8 and Encodings

Whereas the code point is what we store, an encoding deals with how we store it: encoding is an implementation. We need a mechanism to convert the code point numbers into bytes so they can be stored in memory, written to disk, etc.

Which means that code points are encoded as a series of 8-bit bytes. UTF-8 is a variable width character encoding that uses one to four bytes to store each code point. It is capable of encoding all valid Unicode code points. Let's see an example:

```elixir
string = "héllo" # "héllo"
String.length(string) # 5
byte_size(string) # 6
```

UTF-8 also provides a notion of graphemes.
Graphemes may consist of multiple characters that are often perceived as one. For example, the woman firefighter emoji is represented as the combination of three characters: `the woman emoji`, `a hidden zero-width joiner`, `fire engine emoji`

```elixir
String.codepoints("👩‍🚒") # ["👩", "‍", "🚒"]
String.graphemes("👩‍🚒") # ["👩‍🚒"]
```

Elixir is smart enough to know they are seen as a single character, and therefore the length is still one

If you want to see the exact bytes that a string would be stored in a file, a common trick is to concatenate the null byte `<<0>>` to it:

```elixir
"hełło" <> <<0>> # <<104, 101, 197, 130, 197, 130, 111, 0>>
```

Alternatively, you can view a string's binary representation by using `IO.inspect/2`:

```elixir
IO.inspect("hełło", binaries: :as_binaries)
```

## Bitstrings

A bitstring is a fundamental data type in Elixir, denoted with the <<>> syntax. Is used to store the encoded bytes of unicode chars. A bitstring is a contiguous sequence of bits in memory.

By default, 8 bits (1 byte) is used to store each number in a bitstring, but you can manually specify the number of bits via a `::n` modifier to denote the size in `n` bits, or you can use the more verbose declaration `::size(n)`:

```elixir
<<42>> == <<42::8>> # true
<<3:4>> # <<3:size(4)>>
```

For example, the decimal number`3` when represented with 4 bits in base 2 would be `0011`, which is equivalent to the values `0`, `0`, `1`, `1`, each stored using 1 bit:

```elixir
<<0::1, 0::1, 1::1, 1::1>> == <<3::4>> # true
```

Any value that exceeds what can be stored by the number of bits provisioned is truncated:

```elixir
<<1>> == <<257>> # true
```

## Binaries

A binary is a bitstring where the number of bits is divisible by 8. That means that every binary is a bitstring, but not every bitstring is a binary. We can use the `is_bitstring/1` and `is_binary/1` functions to demonstrate this.

```elixir
is_bitstring(<<3::4>>) # true
is_binary(<<3::4>>) # false
is_bitstring(<<0, 255, 42>>) # true
is_binary(<<0, 255, 42>>) # true
is_binary(<<42::16>>) # true
```

We can pattern match on binaries / bitstrings:

```elixir
<<0, 1, x>> = <<0, 1, 2>> # <<0, 1, 2>>
x # 2
```

Note that unless you explicitly use `::` modifiers, each entry in the binary pattern is expected to match a single byte (exactly 8 bits). If we want to match on a binary of unknown size, we can use the `binary` modifier at the end of the pattern:

```elixir
<<0, 1, x::binary>> = <<0, 1, 2, 3>> # <<0, 1, 2, 3>>
x # <<2, 3>>
```

There are a couple other modifiers that can be useful when doing pattern matches on binaries. The binary-size(n) modifier will match n bytes in a binary:

```elixir
<<head::binary-size(2), rest::binary>> = <<0, 1, 2, 3>>
head # <<0, 1>>
rest # <<2, 3>>
```

A string is a UTF-8 encoded binary, where the code point for each character is encoded using 1 to 4 bytes. Thus every string is a binary, but due to the UTF-8 standard encoding rules, not every binary is a valid string.

```elixir
is_binary("hello") # true
is_binary(<<239, 191, 19>>) # true
String.valid?(<<239, 191, 19>>) # false
```

The string concatenation operator `<>` is actually a binary concatenation operator:

```elixir
"a" <> "ha" # "aha"
<<0, 1>> <> <<2, 3>> # <<0, 1, 2, 3>>
```

Given that strings are binaries, we can also pattern match on strings:

```elixir
<<head, rest::binary>> = "banana"
head == ?b # true
rest # "anana"
```

## Charlists

A charlist is a list of integers where all the integers are valid code points.

```elixir
~c"hello"
[?h, ?e, ?l, ?l, ?o] # ~c"hello"
```

The `~c` sigil indicates the fact that we are dealing with a charlist and not a regular string.

A charlist contains integer code points. The list is only printed as a sigil if all code points are within the ASCII range:

```elixir
~c"hełło" # [104, 101, 322, 322, 111]
is_list(~c"hełło") # true
```

This is done to ease interoperability with Erlang, even though it may lead to some surprising behavior. For example, if you are storing a list of integers that happen to range between 0 and 127, by default IEx will interpret this as a charlist and it will display the corresponding ASCII characters.

```elixir
heartbeats_per_minute = [99, 97, 116]
~c"cat"
```

You can always force charlists to be printed in their list representation by calling the `inspect/2` function:

```elixir
inspect(heartbeats_per_minute, charlists: :as_list)#"[99, 97, 116]"
```

Furthermore, you can convert a charlist to a string and back by using the `to_string/1` and `to_charlist/1`:

```elixir
to_charlist("hełło") # [104, 101, 322, 322, 111]
to_string(~c"hełło") # "hełło"
to_string(:hello) # "hello"
to_string(1) # "1"
```

The functions above are polymorphic, in other words, they accept many shapes: not only do they convert charlists to strings (and vice-versa), they can also convert integers, atoms, and so on.

String concatenation uses the `<>` operator but charlists, being lists, use the list concatenation operator `++`:

```elixir
~c"this " <> ~c"fails" #\*\* (ArgumentError) expected binary argument in <> operator but got: ~c"this "
~c"this " ++ ~c"works" # ~c"this works"
"he" ++ "llo" # \*\* (ArgumentError) argument error
"he" <> "llo" # "hello"
```

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

```

```
