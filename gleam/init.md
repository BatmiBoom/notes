# GLEAM

## Hello World

```gleam
import gleam/io

pub fn main() {
    io.println("Hello World!")
}
```

To run a gleam program you can use the command `gleam run`

## Modules

Gleam code is organized into unis called _modules_. A module is a bunch of definitions( types, functions, etc) that seem to belong together. For example, the `gleam/io` module contains a variety of functions for printing, like `println`

All gleam code is in _some_ module or other, whose name comes from the name of the it's in. For example, `gleam/io` is in a file called `io.gleam` in a directory called `gleam`.

For code in one module to access code in another module, we import it using the `import` keyword, and the name used to refer to it is the last part of the module name. For example, the `gleam/io` module is referred to as `io` once imported,

The `as` keyword can be used to refer to a module by a different name

```gleam
import gleam/io
import gleam/strings as text

pub fn main() {
    io.print("Hello, Mike!")

    io.println(text.trim("  Hello, Mike!  "))
}
```

### Unqualified imports

Normally functions from other modules are used in a _qualified_ fashion, meaning the name used to refer the module goes before function name with a dot between them. For example, `io.println("Hello!")`

It is also possible to specify a list of functions to import from a module is an _unqualified_ fashion, meaning the function name can be used without the module _qualifier_ (the name and the dot) before it.

```gleam
import gleam/io.{println}

pub fn main() {
    print("Hello, Mike!")
}
```
