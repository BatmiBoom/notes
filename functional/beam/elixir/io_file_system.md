# IO and the file system

The IO system provides a great opportunity to shed some light on some philosophies and curiosities of Elixir and the Erlang VM.

## The IO module

The `IO` module is the main mechanism in Elixir for reading and writing to standard input/output (`:stdio`), standard error (`:stderr`), files, and other IO devices.

```elixir
IO.puts("hello world")
hello world # :ok
IO.gets("yes or no? ")
```

By default, functions in the `IO` module read from the standard input and write to the standard output. We can change that by passing, for example, `:stderr` as an argument:

```elixir
IO.puts(:stderr, "hello world")
# hello world
# :ok
```

## The File module

The `File` module contains functions that allow us to open files as IO devices. By default, files are opened in binary mode, which requires developers to use the specific `IO.binread/2` and `IO.binwrite/2` functions from the IO module:

```elixir
{:ok, file} = File.open("path/to/file/hello", [:write])
IO.binwrite(file, "world") # :ok
File.close(file) # :ok
File.read("path/to/file/hello") # {:ok, "world"}
```

The file could be opened with the `:append` option, instead of `:write`, to preserve its contents. You may also pass the `:utf8` option, which tells the `File` module to interpret the bytes read from the file as UTF-8-encoded bytes.

The File module has many functions to work with the file system. Those functions are named after their UNIX equivalents:

- `File.rm/1` can be used to remove files,
- `File.mkdir/1` to create directories,
- `File.mkdir_p/1` to create directories and parents
- `File.cp_r/2` copy files and directories recursively
- `File.rm_rf/1` remove files and directories recursively

You will also notice that functions in the File module have two variants: one "regular" variant and another variant with a trailing bang (!).

```elixir
File.read("path/to/file/hello") # {:ok, "world"}
File.read!("path/to/file/hello") # "world"
File.read("path/to/file/unknown") # {:error, :enoent}
File.read!("path/to/file/unknown") # (File.Error)
```

Notice that the version with `!` returns the contents of the file instead of a tuple, and if anything goes wrong the function raises an error.

The version without `!` is preferred when you want to handle different outcomes using pattern matching:

```elixir
case File.read("path/to/file/hello") do
    {:ok, body} -> # do something with the `body`
    {:error, reason} -> # handle the error caused by `reason`
end
```

## The Path module

The `Path` module provides facilities for working with such paths:

```elixir
Path.join("foo", "bar") # "foo/bar"
Path.expand("~/hello") # "/Users/jose/hello"
```

Using functions from the `Path` module as opposed to directly manipulating strings is preferred since the `Path` module takes care of different operating systems transparently.

We will peek a bit under the covers and learn how the IO system is implemented in the VM.

## Processes

You may have noticed that `File.open/2` returns a tuple like `{:ok, pid}`:

```elixir
{:ok, file} = File.open("hello") #{:ok, #PID<0.47.0>}
```

This happens because the `IO` module actually works with processes. Given a file is a process, when you write to a file that has been closed, you are actually sending a message to a process which has been terminated:

```elixir
File.close(file) # :ok
IO.write(file, "is anybody out there") #(ErlangError) Erlang
```

By modeling IO devices with processes, the Erlang VM allows us to even read and write to files across nodes. Neat!

## IODATA and CHARDATA

> iodata and chardata are lists of binaries and integers. Those binaries and integers can be arbitrarily nested inside lists.

Most of the IO functions also accept either `iodata` or `chardata`.

One of the main reasons for using `iodata` and `chardata` is for performance.

Given strings are immutable, if we do this, we will be copying the string "Mary" into the new "Hello Mary!" string

```elixir
name = "Mary"
IO.puts("Hello " <> name <> "!")
```

Copying can be quite expensive for large strings! For this reason, the IO functions allow you to pass instead a list of strings:

```elixir
name = "Mary"
IO.puts(["Hello ", name, "!"])
```

We call such lists either `iodata` or `chardata`.

`iodata` and `chardata` do not only contain strings, but they may contain arbitrary nested lists of strings too:

`IO.puts(["apple", [",", "banana", [",", "lemon"]]])`

`iodata` and `chardata` may also contain integers. For example, we could print our comma separated list of values by using `?`, as separator, which is the integer representing a comma (44):

`IO.puts(["apple", ?,, "banana", ?,, "lemon"])`

The difference between `iodata` and `chardata` is precisely what said integer represents.

- `iodata`, the integers represent bytes.
- `chardata`, the integers represent Unicode codepoints.

> If the file is opened without encoding, the file expects iodata, and we use the functions starting with `bin`
> If we use the default IO device (:stdio) and files opened with `:utf8` encoding expect chardata and work with the remaining functions in the IO module

Finally, there is one last construct called `charlist`, which we discussed in earlier chapters. Charlists are a special case of chardata where all values are integers representing Unicode codepoints. They can be created with the `~c` sigil:

```elixir
~c"hello"
~c"hello"
```

Charlists mostly show up when interfacing with Erlang, as some Erlang APIs use charlist as their representation for strings. For this reason, any list containing printable ASCII codepoints will be printed as a charlist:

```elixir
[?a, ?b, ?c] == ~c"abc"
```
