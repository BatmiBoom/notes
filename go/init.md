- [GO](#go)
  - [Comparing Go's Speed](#comparing-go's-speed)
  - [The compilation process](#the-compilation-process)
  - [Structure of a go program](#structure-of-a-go-program)
  - [Go is strongly typed](#go-is-strongly-typed)
  - [Go programs are easy on memory](#go-programs-are-easy-on-memory)
    - [COMPARISON](#comparison)
  - [Basic Types](#basic-types)
    - [Bool](#bool)
    - [String](#string)
      - [Concatenate Strings](#concatenate-strings)
    - [Integer](#integer)
  - [Comments](#comments)
  - [Declaring a Variable](#declaring-a-variable)
    - [Short Variable Declaration](#short-variable-declaration)
  - [Type Inference](#type-inference)
  - [Same Line Declarations](#same-line-declarations)
  - [Type Sizes](#type-sizes)
  - [Prefer "default" types](#prefer-"default"-types)
  - [WHEN SHOULD I USE A MORE SPECIFIC TYPE?](#when-should-i-use-a-more-specific-type?)
  - [Constants](#constants)
    - [Computed Constants](#computed-constants)
  - [Formatting Strings in Go](#formatting-strings-in-go)
    - [Default Representation](#default-representation)
    - [String](#string)
    - [Integer](#integer)
    - [Float](#float)
  - [Conditionals](#conditionals)
    - [The initial statement of an if block](#the-initial-statement-of-an-if-block)
  - [Functions](#functions)
    - [Multiple Parameters](#multiple-parameters)
    - [Functions as values](#functions-as-values)
    - [Anonymous functions](#anonymous-functions)
    - [Passing variables by value](#passing-variables-by-value)
    - [Ignoring return values](#ignoring-return-values)
    - [Named return values](#named-return-values)
      - [The benefits of named returns](#the-benefits-of-named-returns)
    - [Explicit Returns](#explicit-returns)
    - [Early Returns](#early-returns)
  - [Structs](#structs)
    - [Nested Structs](#nested-structs)
    - [Anonymous structs](#anonymous-structs)
    - [Embedded structs](#embedded-structs)
    - [Struct methods](#struct-methods)
  - [Interfaces](#interfaces)
    - [Interface Implementation](#interface-implementation)
    - [Multiple Interfaces](#multiple-interfaces)
    - [Name your interface arguments](#name-your-interface-arguments)
  - [Type assertions](#type-assertions)
  - [Type Switches](#type-switches)
  - [Clean Interfaces](#clean-interfaces)
    - [The Empty Interface](#the-empty-interface)
      - [Zero Value of an interface](#zero-value-of-an-interface)
      - [Interfaces on pointers](#interfaces-on-pointers)
  - [The Error Interface](#the-error-interface)
    - [The errors package](#the-errors-package)
  - [Loops](#loops)
    - [Omitting conditions from a FOR LOOP](#omitting-conditions-from-a-for-loop)
  - [Continue & Break](#continue-&-break)
  - [Arrays](#arrays)
  - [Slices](#slices)
    - [Make](#make)
    - [VARIADIC](#variadic)
    - [SPREAD OPERATOR](#spread-operator)
    - [APPEND](#append)
    - [SLICE OF SLICES](#slice-of-slices)
    - [Tricky Slices](#tricky-slices)
    - [RANGE](#range)
  - [MAPS](#maps)
    - [MUTATIONS](#mutations)
    - [KEY TYPES](#key-types)
    - [MAP LITERALS](#map-literals)
    - [MISSING KEYS](#missing-keys)
    - [DELETING MAP ENTRIES](#deleting-map-entries)
    - [NESTED](#nested)
  - [FIRST CLASS AND HIGHER ORDER FUNCTIONS](#first-class-and-higher-order-functions)
    - [CURRYING](#currying)
    - [DEFER](#defer)
    - [CLOSURES](#closures)
    - [ANONYMOUS FUNCTIONS](#anonymous-functions)
    - [POINTERS](#pointers)
    - [NIL POINTERS](#nil-pointers)
    - [POINTER RECEIVERS](#pointer-receivers)
  - [PACKAGES](#packages)
  - [CONCURRENCY](#concurrency)
  - [MUTEXES](#mutexes)
  - [GENERICS](#generics)
  - [PROVERBS](#proverbs)

# GO

Is **fast**, **simple** and **productive**.

Generally speaking, compiled languages run much faster than interpreted languages, and Go is no exception.

## Comparing Go's Speed

Go is generally faster and more lightweight than interpreted or VM-powered languages like:

- Python
- JS
- PHP
- Ruby
- Java

However, in terms of execution speed, Go does lag behind some other compiled languages like:

- C
- C++
- Rust

Go is a bit slower mostly due to its automated memory management, also known as the "Go runtime". Slightly slower speed is the price we pay for memory safety and simple syntax!

## The compilation process

Computers need machine code, they don't understand English or even Go. We need to convert our high-level (Go) code into machine language, which is really just a set of instructions that some specific hardware can understand. In your case, your CPU.

The Go compiler's job is to take Go code and produce machine code. On Windows, that would be a .exe file. On Mac or Linux, it would be any executable file. The code you write in your browser here on Boot.dev is being compiled for you on Boot.dev's servers, then the machine code is executed in your browser as Web Assembly.

## Structure of a go program

- `package main` -> lets the Go compiler know that we want this code to compile and run as a standalone program, as opposed to being a library that's imported by other programs.
- `import fmt` -> imports the fmt (formatting) package. The formatting package exists in Go's standard library and lets us do things like print text to the console.
- `func main()` defines the main function. main is the name of the function that acts as the entry point for a Go program.

```go
package main

import "fmt"

func main() {
	fmt.Println("the compiled textio server is starting")
}
```

## Go is strongly typed

Go enforces strong and static typing, meaning variables can only have a single type. A `string` variable like "hello world" can not be changed to an `int`, such as the number 3.

One of the biggest benefits of strong typing is that errors can be caught at "compile time". In other words, bugs are more easily caught ahead of time because they are detected when the code is compiled before it even runs.

Contrast this with most interpreted languages, where the variable types are dynamic. Dynamic typing can lead to subtle bugs that are hard to detect. With interpreted languages, the code must be run to catch syntax and type errors.

## Go programs are easy on memory

Go programs are fairly lightweight. Each program includes a small amount of "extra" code that's included in the executable binary. This extra code is called the Go Runtime. One of the purposes of the Go runtime is to clean up unused memory at runtime.

In other words, the Go compiler includes a small amount of extra logic in every Go program to make it easier for developers to write code that's memory efficient.

### COMPARISON

As a general rule, Java programs use more memory than comparable Go programs. There are several reasons for this, but one of them is that Java uses an entire virtual machine to interpret bytecode at runtime. Go programs are compiled into machine code, and the overhead of the Go runtime is typically less than the overhead of the Java virtual machine.

On the other hand, Rust and C programs use slightly less memory than Go programs because more control is given to the developer to optimize the memory usage of the program. The Go runtime just handles it for us automatically.

## Basic Types

### Bool

### String

#### Concatenate Strings

We use the `+` operator to concatenate strings

```go
func helloWorld(s1 string, s2 string) string {
    return s1 + " " + s2
}
```

### Integer

- int int8 int16 int32 int64
- uint uint8 uint18 uint32 uint64 uintptr
- byte // alias for uint8
- rune // alias for int32 - represents a Unicode code point
- float32 float64
- complex64 complex128

## Comments

```go
// This is a single line comment

/*
    This is a multi-line comment
    niether of these comments will execute
    as code
*/
```

## Declaring a Variable

Variables are declared using the `var` keyword.

```go
var number int
```

To declare a variable called `pi` to be of type `float64` with a value of `3.14159`

```go
var pi float64 = 3.14159
```

The value of a declared variable with no assignment will be its zero value

### Short Variable Declaration

Inside a function (like the main function) the := short assignment statement can be used in place of a var declaration. The := operator infers the type of the new variable based on the value. It's colloquially called the walrus operator because it looks like a walrus... sort of.

These two lines of code are equivalent:

`var empty string` === `empty:= ""`

```go
numCars:= 10 // inferred as an integer
temperature := 0.0 // inferred as a float because it has a decimal
var isFunny = true // inferred as a boolean
```

Outside of a functino (in the global/package.scope), every statements begins with a keyword (`var`, `func`, and so on) and so the `:=` construct is not available

## Type Inference

To declare a variable without specifying an explicit type (either by using the `:=` syntax or `var = expression` syntax), the variable's type is inferred from the value on the right hand side.

When the right hand side of the declaration is typed, the new variable is of that same type:

```go
var i int
j := i // j is also an int
```

However, when the right hand side is a literal value (an untyped numeric constant like `42` or `3.14`), the new variable will be an `int`, `float64`, or `complex128` depending on its precision

```go
i := 42
f := 3.14
g := 0.867 + 0.5i
```

## Same Line Declarations

You can declare multiple variables on the same line:

```go
mileage, company := 80276, "Tesla"
```

## Type Sizes

ints, uints, floats and complex numbers all have type sizes.

```
int  int8  int16  int32  int64 // whole numbers

uint uint8 uint16 uint32 uint64 uintptr // positive whole numbers

float32 float64 // decimal numbers

complex64 complex128 // imaginary numbers (rare)
```

The size (8, 16, 32, 64, 128, etc) represents how many bits in memory will be used to store the variable. The "default" int and uint types refer to their respective 32 or 64-bit sizes depending on the environment of the user.

The standard sizes that should be used unless the developer has a specific need are:

- int
- uint
- float64
- complex128

Some types can be converted like this:

```go
temperatureFloat := 88.26
temperatureInt := int64(temperatureFloat)
```

Casting a float to an integer in this way truncates the floating point portion.

## Prefer "default" types

A problem arises when we have a uint16, and the function we are trying to pass it into takes an int. We're forced to write code riddled with type casts like int(myUint16).

This style of development can be slow and annoying to read. When Go developers stray from the default type for any given type family, the code can get messy quickly.

Unless you have a good reason to, stick to the following types:

- bool
- string
- int
- uint
- byte
- rune
- float64
- complex128

## WHEN SHOULD I USE A MORE SPECIFIC TYPE?

When you're super concerned about performance and memory usage.

That s about it. The only reason to deviate from the defaults is to squeeze out every last bit of performance when you are writing an application that is resource-constrained. (Or, in the special case of uint64, you need an absurd range of unsigned integers).

## Constants

Are declared with the `const` keyword. They can't use the `:=` short declaration syntax

```go
const pi = 3.141
```

Can be character, string, boolean, or numeric values. They can not be more complex types like slices, maps and structs.

The value of a constant can't be changed after if has been declared.

### Computed Constants

Must be known at compile time. They are usually declared with a static value:

```go
cost myInt = 15
```

However, constants can be computed as long as the computation can happen at compile time.

```go
const firstName = "Lane"
const lastName = "Wagner"
const fullName = firstName + " " + lastName
```

That said, you cannot declare a constant that can only be computed at run-time.
This breaks:

```go
const currentTime = time.now()
```

## Formatting Strings in Go

Go follows the `printf` tradition from the C language. In my opinion, string formatting/interpolation in Go is less than Python's f-strings.

- `fmt.Printf` -> prints a formatted string to standard out.
- `fmt.Sprintf` -> returns the formatted string

These following "formatting verbs" work with the formatting functions above:

### Default Representation

The `%v` variant prints the Go syntax representation of a value, it's a nice default.

```go
s := fmt.Sprintf("I am %v years old", 10)
s := fmt.Sprintf("I am %v years old", "way too many")
```

If you want to print in a more specific way. you can use the following formatting verbs:

### String

```go
s := fmt.Sprintf("I am %s years old", "way to many")
```

### Integer

```go
s := fmt.Sprintf("I am %d years old", 10)
```

### Float

```go
s := fmt.Sprintf("I am %f years old", 10.523)
// I am 10.523000 years old

// The ".2" rounds the number to 2 decimal places
s := fmt.Sprintf("I am %.2f years old", 10.523)
// I am 10.52 years old
```

## Runes and String Encoding

Generally a "character" is a single byte.
Using `ASCII` encoding, the standard for the C programming language, we can represent 128 characters with 7 bits. This is enough for the English alphabet, numbers, and some special characters.

In Go, strings are just sequences of bytes: they can hold arbitrary data. However, Go also has a special type, `rune`, which is an alias for `int32`. This means that a `rune` is a 32-bit integer, which is large enough to hold any `Unicode` code point.

When you're working with strings, you need to be aware of the encoding (bytes -> representation). Go uses UTF-8 encoding, which is a variable-length encoding.

There are 2 main takeaways:

- When you need to work with individual characters in a string, you should use the `rune` type. It breaks strings up into their individual characters, which can be more than one byte long.
- We can use `zany` characters like emojis and Chinese characters in our strings, and Go will handle them just fine

## Conditionals

`if` statements in Go do not use parentheses around the condition:

```go
if height > 4 {
    fmt.Println("You are tall enough!")
}
```

`else if` and `else` are supported as you might expect:

```go
if height > 6 {
    fmt.Println("You are super tall!")
} else if height > 4 {
    fmt.Println("You are tall enough!")
} else {
    fmt.Println("You are not tall enough!")
}
```

### The initial statement of an if block

An `if` conditional can have an "initial" statement. The variable(s) created in the initial statement are only defined within the scope of the `if` body.

`if INITIAL_STATEMENT; CODITION {}`

```go
length := getLength(email)
if length < 1 {
    fmt.Println("Email is invalid")
}

// We can do
if length := getLength(email); length < 1 {
    fmt.Println("Email is invalid")
}
```

### Switch

Switch statements are a way to compare a value against multiple options. They are similar to if-else statements but are more concise and readable when the number of options is more than 2.

```go
func getCreator(os string) string {
    var creator string
    switch os {
    case "linux":
        creator = "Linus Torvalds"
    case "windows":
        creator = "Bill Gates"
    case "mac":
        creator = "A Steve"
    default:
        creator = "Unknown"
    }
    return creator
}
```

Notice that in Go, the `break` statement is not required at the end of a `case` to stop it from falling through to the next case. The `break` statement is implicit in Go.

If you do want a `case` to fall through to the next case, you can use the `fallthrough` keyword.

```go
func getCreator(os string) string {
    var creator string
    switch os {
    case "linux":
        creator = "Linus Torvalds"
    case "windows":
        creator = "Bill Gates"

    // all three of these cases will set creator to "A Steve"
    case "Mac OS":
        fallthrough
    case "Mac OS X":
        fallthrough
    case "mac":
        creator = "A Steve"

    default:
        creator = "Unknown"
    }
    return creator
}
```

The `default` case does what you'd expect: it's the case that runs if none of the other cases match.

## Functions

The variable types comes after the variable name

```go
func sub(x int, y int) int {
    return x - y
}
```

`func sub(x int, y int) int` is known as the "function signature"

### Multiple Parameters

When multiple arguments are of the same type, and are next to each other in the function signature, the type only needs to be declared after the last argument.

```go
func addToDatabase(hp, damage int) {}
func addToDatabase(hp, damage int, name string) {}
func addToDatabase(hp, damage int, name string, level int) {}
```

### Functions as values

Go supports first-class and higher-order functions, which are just fancy ways of saying "functions as values". Functions are just another type.

```go
func add(x, y int) int {
	return x + y
}

func mul(x, y int) int {
	return x * y
}

func aggregate(a, b, c int, arithmetic func(int, int) int) int {
  firstSum := arithmetic(a, b)
  secondSum := arithmetic(firstSum, c)
  return secondSum
}

func main() {
	sum := aggregate(2, 3, 4, add)
	product = aggregate(2, 3, 4, mul)
}
```

### Anonymous functions

Anonymous functions are true to form in that they have no name.

```go
func conversions(converter func(int) int, x, y, z int) (int, int, int) {
	convertedX := converter(x)
	convertedY := converter(y)
	convertedZ := converter(z)
	return convertedX, convertedY, convertedZ
}

func main() {
	newX, newY, newZ := conversions(func(a int) int {
	    return a + a
	}, nums)

	newX, newY, newZ = conversions(func(a int) int {
	    return a * a
	}, nums)
}
```

### Passing variables by value

Variables in Go are passed by value (except for a few data types we haven't covered yet).

"Pass by value" means that when a variable is passed into a function, that function receives a copy of the variable. The function is unable to mutate the caller's original data.

```go
func main() {
    x := 5
    increment(x)

    fmt.Println(x)
    // still prints 5,
    // because the increment function
    // received a copy of x
}

func increment(x int) {
    x++
}
```

### Ignoring return values

A function can return a value that the caller doesn't care about. We can explicitly ignore variables by using an underscore: "\_"

```go
func getPoint() (x int, y int) {
  return 3, 4
}

// ignore y value
x, _ := getPoint()
```

### Named return values

Return values may be given names, and if they are, then they are treated the same as if they were new variables defined at the top of the function.

Named return values are best thought of as a way to document the purpose of the returned values.

> A return statement without arguments returns the named return values. This is known as a "naked" return. Naked return statements should be used only in short functions. They can harm readability in longer functions.

```go
func getCoords() (x, y int){
  // x and y are initialized with zero values

  return // automatically returns x and y
}
```

Is the same as:

```go
func getCoords() (int, int){
  var x int
  var y int
  return x, y
}
```

#### The benefits of named returns

**Good for documentation**

Named return parameters are great for documenting a function. We know what the function is returning directly from its signature

Named return parameters are particularly important in longer functions with many return values.

```go
func calculator(a, b int) (mul, div int, err error) {
    if b == 0 {
      return 0, 0, errors.New("Can't divide by zero")
    }
    mul = a * b
    div = a / b
    return mul, div, nil
}
```

NOTE : nil is the zero value of an error. More on this later.

### Explicit Returns

Even though a function has named return values, we can still explicitly return values if we want

```go
func getCoords() (x, y int){
  return x, y // this is explicit
}

func getCoords() (x, y int){
  return 5, 6 // this is explicit, x and y are NOT returned
}

func getCoords() (x, y int){
  return // implicitly returns x and y
}
```

### Early Returns

Go supports the ability to return early from a function. This is a powerful feature that can clean up code, especially when used as guard clauses.

Guard Clauses leverage the ability to `return` early from a function ( or `continue` through a loop ) to make nested conditionals one-dimensional. Instead of using if/else chains, we just return early from the function at the end of each conditional bloc

```go
func divide(dividend, divisor int) (int, error) {
	if divisor == 0 {
		return 0, errors.New("Can't divide by zero")
	}
	return dividend/divisor, nil
}
```

Error handling in Go naturally encourages developers to make use of guard clauses. When I started writing more JavaScript, I was disappointed to see how many nested conditionals existed in the code I was working on.

Let s take a look at an exaggerated example of nested conditional logic:

```go
func getInsuranceAmount(status insuranceStatus) int {
  amount := 0
  if !status.hasInsurance(){
    amount = 1
  } else {
    if status.isTotaled(){
      amount = 10000
    } else {
      if status.isDented(){
        amount = 160
        if status.isBigDent(){
          amount = 270
        }
      } else {
        amount = 0
      }
    }
  }
  return amount
}
```

This could be written with guard clauses instead:

```go
func getInsuranceAmount(status insuranceStatus) int {
  if !status.hasInsurance(){
    return 1
  }
  if status.isTotaled(){
    return 10000
  }
  if !status.isDented(){
    return 0
  }
  if status.isBigDent(){
    return 270
  }
  return 160
}
```

## Structs

We use structs in Go to represent structured data. For example, if we want to represent a car we could do the following:

```go
type car struct {
  maker string
  model string
  doors int
  mileage int
}
```

This creates a new struct type called car. All cars have a maker, model, doors and mileage.

Structs in Go are often used to represent data that you might use a dictionary or object for in other languages.

### Nested Structs

```go
type car struct {
  maker string
  model string
  doors int
  mileage int
  frontWheel wheel
  backWheel wheel
}

type wheel struct {
  radius int
  material string
}
```

The fields of a struct can be accessed using the dot . operator.

```go
myCar := car{}
myCar.frontWheel.radius = 5
```

### Anonymous structs

Is just like a normal struct, but it is defined without a name and therefore cannot be referenced elsewhere in the code

To create an anonymous struct, just instantiate the instance immediately using a second pair of brackets

```go
myCar := struct {
    maker string
    model string
} {
    maker: "tesla",
    model: "model 3",
}
```

You can even nest anonymous structs as fields within other structs

```go
type car struct {
  maker string
  model string
  doors int
  mileage int
  // wheel is a field containing an anonymous struct
  wheel struct {
    radius int
    material string
  }
}
```

**When should you use an anonymous struct?**

In general, prefer named structs. Named structs make it easier to read and understand your code, and they have the nice side-effect of being reusable. I sometimes use anonymous structs when I know I won't ever need to use a struct again. For example, sometimes I'll use one to create the shape of some JSON data in HTTP handlers.

If a struct is only meant to be used once, then it makes sense to declare it in such a way that developers down the road won t be tempted to accidentally use it again.

### Embedded structs

Go is not an object-oriented language. However, embedded structs provide a kind of data-only inheritance that can be useful at times. Go doesn't support classes or inheritance in the complete sense, but embedded structs are a way to elevate and **share fields between struc definitions**

```go
package main

type membershipType string

const (
	TypeStandard membershipType = "standard"
	TypePremium  membershipType = "premium"
)

// don't touch above this line

type Membership struct {
	Type membershipType
	MessageCharLimit int
}

type User struct {
	Name string
	Membership
}

func newUser(name string, membershipType membershipType) User {
	charLimit := 100
	if membershipType == TypePremium {
		charLimit = 1000
	}

	return User{
		Name: name,
		Membership: Membership{
			Type: membershipType,
			MessageCharLimit: charLimit,
		},
	}
}
```

**EMBEDDED VS NESTED**

Unlike nested structs, an embedded struct's fields are accessed at the top level like normal fields.
Like nested structs, you assign the promoted fields with the embedded struct in a composite literal.

### Struct methods

Methods are just functions that have a receiver. A receiver is a special parameter that syntactically goes before the name of the function.

```go
type rect struct {
  width int
  height int
}

// area has a receiver of (r rect)
func (r rect) area() int {
  return r.width * r.height
}

var r = rect{
  width: 5,
  height: 10,
}

fmt.Println(r.area())
// prints 50
```

A receiver is just a special kind of function parameter. Receivers are important because they will, as you'll learn in the exercises to come, allow us to define interfaces that our structs (and other types) can implement.

### Memory Layout

Structs sit in memory in a contiguous block, with fields placed one after another as defined in the `struct`. For example this `struct`:

```go
type stats struct{
    Reach uint16
    NumPosts uint8
    NumLikes uint8
}
```

Looks like this in memory:

```
stats struct (4 bytes total
|----------------------------|-----------|-----------|
|                            |           |           |
|       Reach                | NumPosts  | NumLikes  |
|       uint16               | uint8     | uint8     |
|       (2 bytes)            | (1 byte)  | (1 bytes) |
|                            |           |           |
|____________________________|___________|___________|
```

#### ORDER OF FIELDS MATTERS

The order of `fields` in a `struct` can have a big impact on memory usage. This is the same `struct` as above, but poorly designed:

```go
type stats struct {
	NumPosts uint8
	Reach    uint16
	NumLikes uint8
}
```

Looks like this in memory:

```
stats struct (6 bytes total
|----------|---------|---------------------|-----------|-----------|
|          |         |                     |           |           |
| NumPosts | Wasted  |     Reach           | NumLikes  | Wasted    |
| uint8    | Space   |     uint16          | uint8     | Space     |
| (1 byte) | (1 byte)|     (2 bytes)       | (1 byte)  | (1 bytes) |
|          |         |                     |           |           |
|__________|_________|_____________________|___________|___________|
```

Notice that Go has "aligned" the fields, meaning that it has added some padding (wasted space) to make up for the size difference between the `uint16` and `uint8` types. It's done for execution speed, but it can lead to increased memory usage.

If you have a specific reason to be concerned about memory usage, aligning the fields by size (largest to smallest) can help. You can also use the reflect package to debug the memory layout of a `struct`:

```go
typ := reflect.TypeOf(stats{})
fmt.Printf("Struct is %d bytes\n", typ.Size())
```

### Empty Struct

Are used in Go as a unary value.

```go
// anonymous empty struct type
empty := struct{}{}

// named empty struct type
type emptyStruct struct{}
empty := emptyStruct{}
```

The cool thing about empty structs is that they're the smallest possible type in Go: they take up zero **bytes of memory**.

Memory Usage:

- `struct{}{}` - 0 bytes
- `bool` - 1 bytes
- `uint16` - 2 bytes
- `int64` - 8 bytes

## Enums

Go's lack of enums, sum types, tagged unions, etc. Compared to other statically typed languages like:

- Rust
- TypeScript
- OCaml

Go's type system just isn't as powerful. It's more similar to C's type system than it is to Rust's. It's more concerned with simplicity than it is with expressiveness.

### Error Handling

In Rust, like Go, errors are just values. In Go, we write something like this:

```go
user, err := getUser()
if err != nil {
    return fmt.Errorf("failed to get user: %w", err)
}
// do something with user
```

In Rust, we can do something like this:

```rust
let user_result = get_user();
let user = match user_result {
    Ok(user) => user,
    Err(error) => return Err(format!("failed to get user: {}", error)),
};
```

In Rust, the `get_user` function in Rust returns a `Result` type: a type that is either an `Ok` or an `Err`. The compiler forces the developer to handle the error case before they can continue with the happy path (using the user data).

In Go, the developer can choose to happily ignore the `error` value if they choose and use the user data, even if it's invalid (probably nil or an empty struct).

The support for enums in Rust makes it easier to write bug-free code.

```user.go
package main

import "fmt"

type email struct {
	status    string
	recipient *user
}

type user struct {
	email  string
	status string
}

type analytics struct {
	totalBounces int
}

func (u *user) updateStatus(status string) error {
	if status != "email_bounced" {
		return fmt.Errorf("invalid status: %s", status)
	}
	u.status = status
	return nil
}

func (a *analytics) track(event string) error {
	if event != "email_bounced" {
		return fmt.Errorf("invalid event: %s", event)
	}
	a.totalBounces++
	return nil
}
```

```main.go
package main

import (
	"fmt"
)

func (a *analytics) handleEmailBounce(em email) error {
	err := em.recipient.updateStatus(em.status)
	if err != nil {
		return fmt.Errorf("error updating user status: %w", err)
	}
	err = a.track(em.status)
	if err != nil {
		return fmt.Errorf("error updating user status: %w", err)
	}

	return nil
}
```

## Type Aliases

For all its faults, TypeScript does have a pretty incredible type system. Here's one of the things it can do that i often miss in Go:

```typescript
type sendingChannel = "email" | "sms" | "phone";

function sendNotification(ch: sendingChannel, message: string) {}
```

This `sendingChannel` type that we've created is a `union type`. It can only be one of the three strings that we've defined. That means when a developer calls `sendNotification()` they can't accidentally pass an invalid `sendingChannel` like `"slack"` or even a misspelled `"emil"`. The TypeScript compiler will catch that mistake at compile time.

In Go, we don't have these nice things. We embrace the Grug mentality. The closest thing we have to a union type is a type alias:

```go
type sendingChannel string

const (
    Email sendingChannel = "email"
    SMS sendingChannel = "sms"
    Phone sendingChannel = "phone"
)

func sendNotification(ch sendingChannel, message string) {}
```

It's a bit safer than using a plain old `string` in Go, but it's not completely safe. Go will stop us from doing this:

```go
sendingCh := "slack"
sendNotification(sendingCh, "hello") // string is not sendingChannel
```

But it will _not_ stop us from doing this:

```go
// "slack" is automatically implied as a sendingChannel
sendNotification("slack", "hello")
```

And will also not stop us from doing this:

```go
sendingCh := "slack"
convertedSendingCh := sendingChannel(sendingCh)
sendNotification(convertedSendingCh, "hello")
```

The `sendingChannel` type is just an alias for `string`, and because we made some constants of that type, most developers will just use those constants: we've made it easy to do the right thing. That said, Go still doesn't force us to do the right thing like TypeScript does.

### IOTA

Go has a language feature, that when used with a type alias, kinda looks like an enum.Its called `iota`

```go
type sendingChannl int

const (
    Email sendingChannel = iota
    SMS
    Phone
)
```

The `iota` keyword is a special keyword in Go that creates a sequence of numbers. It starts at `0` and increments by `1` for each constant in the `const` block. So in the example above, `Email` is 0, `SMS` is 1, and `Phone` is 2.

Go developers sometimes use iota to create a sequence of constants to represent a set of related values, much like you would with an `enum` in other languages. But remember, it's not an `enum`. It's just a sequence of numbers.

## Interfaces

Are just collections of method signatures. A type "implements" an interface if it has methods that match the interface's method signatures

```go
type shape interface {
  area() float64
  perimeter() float64
}

type rect struct {
    width, height float64
}
func (r rect) area() float64 {
    return r.width * r.height
}
func (r rect) perimeter() float64 {
    return 2*r.width + 2*r.height
}

type circle struct {
    radius float64
}
func (c circle) area() float64 {
    return math.Pi * c.radius * c.radius
}
func (c circle) perimeter() float64 {
    return 2 * math.Pi * c.radius
}
```

When a type implements an `interface`, it can then be used as that `interface type`. As an example, because the `empty interface` doesn't require a type to have any methods at all, every type automatically implements the empty interface, written as:

```go
interface{}
```

### Interface Implementation

Interfaces are implemented _implicitly_.

A type never declares that it implements a given interface. If an interface exists and a type has the proper methods defined. then the type automatically fulfills that interface.

### Multiple Interfaces

A type can implement any number of interfaces in Go. For example, the **empty interface**, `interface()`, is always implemented by every type because it has no requirements.

### Name your interface arguments

```go
type Copier interface {
    Copy(string, string) int
}
```

Based on the code alone, can you deduce what kinds of strings you should pass into the `Copy` function?

Let's add some named arguments an return data to make it more clear

```go
type Copier interface {
    Copy(sourceFile string, destinationFile string) (bytesCopied int)
}
```

## Type assertions

When working with interfaces in Go, every once-in-awhile you'll need access to the underlying type of an interface value. You can cast an interface to its underlying type using a `type assertion`

In the example below:

- We want to check if `s` is a `circle` in order to cast in into its underlying concrete type
- We know `s` is an instance of the `shape` interface, but we do not know if it's also a `circle`
- `c` is a new `circle` struct cast from `s`
- `ok` is `true` if `s` is indeed a `circle`, or `false` if `s` is NOT a `circle`.

```go
type shape interface {
	area() float64
}

type circle struct {
	radius float64

s := circle {
    r : 5
}

c, ok := s.(circle)
if !ok {
	// log an error if s isn't a circle
	log.Fatal("s is not a circle")
}

radius := c.radius
```

Example

```go
func getExpenseReport(e expense) (string, float64) {
	exp, ok := e.(email)
	if ok {
		return exp.toAddress, exp.cost()
	}

	sms, ok := e.(sms)
	if ok {
		return sms.toPhoneNumber, sms.cost()
	}

	return "", 0.0
}

type expense interface {
	cost() float64
}

type email struct {
	isSubscribed bool
	body         string
	toAddress    string
}

type sms struct {
	isSubscribed  bool
	body          string
	toPhoneNumber string
}

type invalid struct{}

func (e email) cost() float64 {
	if !e.isSubscribed {
		return float64(len(e.body)) * .05
	}
	return float64(len(e.body)) * .01
}

func (s sms) cost() float64 {
	if !s.isSubscribed {
		return float64(len(s.body)) * .1
	}
	return float64(len(s.body)) * .03
}

func (i invalid) cost() float64 {
	return 0.0
}
```

## Type Switches

A `type switch` makes it easy to do several type assertions in a series.

A type switch is similar to a regular switch statement, but the cases specify types instead of values.

```go
func printNumericValue(num interface{}) {
	switch v := num.(type) {
	case int:
		fmt.Printf("%T\n", v)
	case string:
		fmt.Printf("%T\n", v)
	default:
		fmt.Printf("%T\n", v)
	}
}

func main() {
	printNumericValue(1)
	// prints "int"

	printNumericValue("1")
	// prints "string"

	printNumericValue(struct{}{})
	// prints "struct {}"
}
```

Example:

```go
func getExpenseReport(e expense) (string, float64) {
	switch v := e.(type) {
	case email :
		return v.toAddress, v.cost()
	case sms :
		return v.toPhoneNumber, v.cost()
	default:
		return "", 0.0
	}
}

type expense interface {
	cost() float64
}

type email struct {
	isSubscribed bool
	body         string
	toAddress    string
}

type sms struct {
	isSubscribed  bool
	body          string
	toPhoneNumber string
}

type invalid struct{}

func (e email) cost() float64 {
	if !e.isSubscribed {
		return float64(len(e.body)) * .05
	}
	return float64(len(e.body)) * .01
}

func (s sms) cost() float64 {
	if !s.isSubscribed {
		return float64(len(s.body)) * .1
	}
	return float64(len(s.body)) * .03
}

func (i invalid) cost() float64 {
	return 0.0
}
```

## Clean Interfaces

Writing clean interfaces is _hard_. Frankly, anytime you're dealing with abstractions in code, the simple can become complex very quickly if you're not careful. Let's go over some rules of thumb for keeping interfaces clean

1. Keep Interfaces Small:
   Interfaces are meant to define the minimal behavior necessary to accurately represent an idea or concept.

   Here is an example from the standard HTTP package of a larger interface that's a good example of defining minimal behavior:

```go
   type File interface {
    io.Closer
    io.Reader
    io.Seeker
    Readdir(count int) ([]os.FileInfo, error)
    Stat() (os.FileInfo, error)
}
```

Any type that satisfies the interface's behaviors can be considered by the HTTP package as a File. This is convenient because the HTTP package doesn't need to know if it's dealing with a file on disk, a network buffer, or a simple `[]byte`

2. Interfaces should have no knowledge of satisfying types
   An interface should define what is necessary for other types to classify as a member of that interface. They shouldn t be aware of any types that happen to satisfy the interface at design time.

For example, let s assume we are building an interface to describe the components necessary to define a car.

```go
type car interface {
	Color() string
	Speed() int
	IsFiretruck() bool
}
```

`Color()` and `Speed()` make perfect sense, they are methods confined to the scope of a car. `IsFiretruck()` is an anti-pattern. We are forcing all cars to declare whether or not they are firetrucks. In order for this pattern to make any amount of sense, we would need a whole list of possible subtypes. `IsPickup()`, `IsSedan()`, `IsTank()` where does it end??

Instead, the developer should have relied on the native functionality of type assertion to derive the underlying type when given an instance of the car interface. Or, if a sub-interface is needed, it can be defined as:

```go
type firetruck interface {
	car
	HoseLength() int
}
```

Which inherits the required methods from car and adds one additional required method to make the car a firetruck.

3. Interfaces are not classes

- Interfaces are not classes, they are slimmer.
- Interfaces dont have constructors or deconstructors that require that data is created or destroyed.
- Interfaces arent hierarchical by nature, though there is syntactic sugar to create interfaces that happen to be supersets of other interfaces.
- Interfaces define function signatures, but not underlying behavior. Making an interface often wont DRY up your code in regards to struct methods. For example, if five types satisfy the fmt.Stringer interface, they all need their own version of the String() function.

Example of good interface:

```go
type Formatter interface {
	Format() string
}

type PlainText struct {
	message string
}

func (p PlainText) Format() string {
	return p.message
}

type Bold struct {
	message string
}

func (b Bold) Format() string {
	return "**" + b.message + "**"
}
type Code struct{
	message string
}

func (c Code) Format() string {
	return "`" + c.message + "`"
}

func SendMessage(formatter Formatter) string {
	return formatter.Format()
}
```

Example of Interface and Switch:

```go
type notification interface {
	importance() int
}

type directMessage struct {
	senderUsername string
	messageContent string
	priorityLevel  int
	isUrgent       bool
}

type groupMessage struct {
	groupName      string
	messageContent string
	priorityLevel  int
}

type systemAlert struct {
	alertCode      string
	messageContent string
}
func (d directMessage) importance() int {
	if d.isUrgent {
		return 50
	}

	return d.priorityLevel
}
func (g groupMessage) importance() int {
	return g.priorityLevel
}
func (s systemAlert) importance() int {
	return 100
}

func processNotification(n notification) (string, int) {
	switch m := n.(type) {
	case directMessage:
		return m.senderUsername, m.importance()
	case groupMessage:
		return m.groupName, m.importance()
	case systemAlert:
		return m.alertCode, m.importance()
	default:
		return "", 0
	}
}
```

### The Empty Interface

The empty interface doesn't specify any methods, and as such every type in Go implements the empty interface. `interface{}`

It’s for this reason that developers sometimes use a `map[string]interface{}` to work with arbitrary `JSON` data, although I recommend using `anonymous structs` instead where possible.

#### Zero Value of an interface

Interfaces can be `nil`, in fact, it's their zero value. That's why when we check for errors in GO, we're always checking `if err != nil`, because `err` is an interface

#### Interfaces on pointers

It's a common "gotcha" in Go to implement a method on a pointer type and expect the underlying type to implement the interface, _it doesn't work like that_.

```go
type rectangle interface {
    height() int
    width() int
}

type square struct {
    length int
}

func (sq *square) width() int {
    return sq.length
}

func (sq *square) height() int {
    return sq.length
}
```

Though you may expect it to, in this example the `square` type does not implement the `rectangle interface`. The `*square` type does. If I wanted the `square` type to implement the `rectangle` interface I would just need to remove the pointer receivers.

```go
type rectangle interface {
    height() int
    width() int
}

type square struct {
    length int
}

func (sq square) width() int {
    return sq.length
}

func (sq square) height() int {
    return sq.length
}
```

## The Error Interface

Go programs express errors with `error` values. An Error is any type that implements the simple built-in `error interface`:

```go
type error interface {
    Error() string
}
```

When something can go wrong in a function, that function should return an `error` as its last return value. Any code that calls a function that can return an `error` should handle errors by testing whether the error is `nil`.

```go
// Atoi converts a stringified number to an integer
i, err := strconv.Atoi("42b")
if err != nil {
    fmt.Println("couldn't convert:", err)
    // because "42b" isn't a valid integer, we print:
    // couldn't convert: strconv.Atoi: parsing "42b": invalid syntax
    // Note:
    // 'parsing "42b": invalid syntax' is returned by the .Error() method
    return
}
```

A `nil` error denotes success; a non-nil error denotes failure.

Because errors are just interfaces, you can build your own custom types that implement the `error` interface. Here's an example of a `userError` `struct` that implements the `error` interface:

```go
type useError struct {
    name string
}

func (e userError) Error() string {
    return fmt.Sprintf("%v has a problem with their account", e.name)
}
```

It can then be used as an error:

```go
func sendSMS(msg, userName string) error {
    if !canSendToUser(userName) {
        return userError{name: userName}
    }
}
```

### The errors package

The Go standard library provides an "errors" package that makes it easy to deal with errors

Read the godoc for the [errors.New()](https://pkg.go.dev/errors#New), but here's a simple example:

```go
import (
	"errors"
)

func divide(x, y float64) (float64, error) {
	if y == 0 {
		return 0, errors.New("no dividing by 0")
	}
	return x / y, nil
}
```

## Loops

The basic loop in Go is written in standard C-like syntax:

```go
for INITIAL; CONDITION; AFTER {}
```

- `INITIAL` is run once at the beginning of the loop and can create
  variables within the scope of the loop.
- `CONDITION` is checked before each iteration. If the condition doesn't pass
  then the loop breaks.
- `AFTER` is run after each iteration.

```go
for i := 0; i < 10; i++ {
  fmt.Println(i)
}
// Prints 0 through 9
```

### Omitting conditions from a FOR LOOP

Loops can omit sections of a for loop. For example, the `CONDITION` can be omitted which causes the loop to run forever

```go
for INITIAL; ; AFTER {}
```

**THERE IS NO WHILE LOOP IN GO**

A `while` loop is just a `for` loop that only has a CONDITION

```go
for CONDITION {}
```

For example

```go
plantHeight := 1
for plantHeight < 5 {
  fmt.Println("still growing! current height:", plantHeight)
  plantHeight++
}
fmt.Println("plant has grown to ", plantHeight, "inches")
```

## Continue & Break

The `continue` keyword stops the current iteration of a loop and continues to the next iteration. `continue` is a powerful way to use the guard clause pattern within loops.

```go
for i := 0; i < 10; i++ {
  if i % 2 == 0 {
    continue
  }
  fmt.Println(i)
}
```

The `break` keyword stops the current iteration of a loop and exits the loop.

```go
for i := 0; i < 10; i++ {
  if i == 5 {
    break
  }
  fmt.Println(i)
}
```

## Arrays

Arrays are fixed-size groups of variables of the same type.

The type `[n]T` is an array of n values of type `T`.

To declare an array of 10 integers:

```go
var myInsta [10]int
```

Or to declare an initialized literal:

```go
primes := [6]int{2, 3, 5, 7, 11, 13}
```

## Slices

99 times out of 100 you will use a slice instead of an array when working with ordered lists.

Arrays are fixed in size. Once you make an array like `[10]int` you can't add an 11 element.

A slice is a dynamically-sized, flexible view of the elements of an array.

The `zero` value of slice is `nil`

Slices **always** have an underlying array, thought it isn't always specified explicitly. To explicitly create a slice on top of an array we can do:

```go
primes := [6]int{2, 3, 5, 7, 11, 13}
my_slice := primes[1:4] // {3, 5, 7}
```

The syntax is:

```text
arrayname[lowIndex:highIndex]
arrayname[lowIndex:]
arrayname[:highIndex]
arrayname[:]
```

`lowIndex`, `highIndex`, or both can be omitted to use the entire array on that side of the colon.

Slices wrap arrays to give a more general, powerful, and convenient interface to sequences of data. Except for items with explicit dimensions such as transformation matrices, most array programming in Go is done with slices rather than simple arrays.

Slices hold references to an underlying array, and if you assign one slice to another, both refer to the same array. If a function takes a slice argument, changes it makes to the elements of the slice will be visible to the caller, analogous to passing a pointer to the underlying array. A Read function can therefore accept a slice argument rather than a pointer and a count; the length within the slice sets an upper limit of how much data to read. Here is the signature of the Read() method of the File type in package os:

Referenced from Effective Go

```go
func (f *File) Read(buf []byte) (n int, err error)
```

### Make

We can create a new slice using the `make` function:

```go
// func make([]T, len, cap)
my_slice := make([]int, 5, 10)


// the capacity argument is usually omitted and defaults to the length
my_slice := make([]int, 5)
```

Slices created with make will be filled with the zero value of the type.

If we want to create a slice with a specific set of values, we can use a slice literal:

```go
my_slice := []string{"I", "love", "go"}
```

**LENGTH**
The length of a slice is simply the number of elements it contains. It is accessed using the built-in `len()` function.

**CAPACITY**
The capacity of a slice is the number of elements in the underlying array, counting from the first element in the slice. It is accessed using the built-in `cap()` function.

The length of a slice may be changed as long as it still fits within the limits of the underlying array; just assign it to a slice of itself. The capacity of a slice, accessible by the built-in function cap, reports the maximum length the slice may assume. Here is a function to append data to a slice. If the data exceeds the capacity, the slice is reallocated. The resulting slice is returned. The function uses the fact that `len` and `cap` are legal when applied to the nil slice, and return 0.

```go
func Append(slice, data []byte) []byte {
    l := len(slice)
    if l + len(data) > cap(slice) {  // reallocate
        // Allocate double what's needed, for future growth.
        newSlice := make([]byte, (l+len(data))*2)
        // The copy function is predeclared and works for any slice type.
        copy(newSlice, slice)
        slice = newSlice
    }
    slice = slice[0:l+len(data)]
    copy(slice[l:], data)
    return slice
}
```

### VARIADIC

Many functions, especially those in the standard library, can take an arbitrary number of final arguments. This is accomplished by using the "..." syntax in the function signature.

A variadic function receives the variadic arguments as a slice.

```go
func concat(strs ...string) string {
    final := ""
    // strs is just a slice of strings
    for i := 0; i < len(strs); i++ {
        final += strs[i]
    }
    return final
}

func main() {
    final := concat("Hello ", "there ", "friend!")
    fmt.Println(final)
    // Output: Hello there friend!
}
```

The familiar `fmt.Println()` and `fmt.Sprintf()` are variadic! `fmt.Println(1)` prints each element with space delimiters and a newline at the end.

```go
func Println(a ...interface{}) (n int, err error)
```

### SPREAD OPERATOR

The spread operator allows us to pass a slice into a variadic function. The spread operator consists of three dots following the slice in the function call.

```go
func printStrings(strings ...string) {
	for i := 0; i < len(strings); i++ {
		fmt.Println(strings[i])
	}
}

func main() {
    names := []string{"bob", "sue", "alice"}
    printStrings(names...)
}
```

### APPEND

The built-in append function is used to dynamically add elements to a slice:

```go
func append(slice []Type, elems ...Type) []Type
```

If the underlying array is not large enough, `append()` will create a new underlying array and point the slice to it.

Notice that `append()` is variadic, the following are all valid:

```go
slice = append(slice, oneThing)
slice = append(slice, firstThing, secondThing)
slice = append(slice, anotherSlice...)
```

### SLICE OF SLICES

Slices can hold other slices, effectively creating a matrix, or a 2D slice.

```go
rows := [][]int{}
```

```go
func createMatrix(rows, cols int) [][]int {
	matrix := make([][]int, rows)
	for i := 0; i < rows ; i++ {
		matrix[i] = make([]int, cols)
		for j := 0 ; j < cols ; j++ {
			matrix[i][j] = i * j
		}
	}

	return matrix
}
```

### Tricky Slices

The `append()` function changes the underlying array of its parameter AND returns a new slice. This means that using `append()` on anything other than itself is usually a BAD idea.

```go
// dont do this!
someSlice = append(otherSlice, element)
```

**EXAMPLE 1: WORKS AS EXPECTED**

```go
a := make([]int, 3)
fmt.Println("len of a:", len(a))
// len of a: 3
fmt.Println("cap of a:", cap(a))
// cap of a: 3
fmt.Println("appending 4 to b from a")
// appending 4 to b from a
b := append(a, 4)
fmt.Println("b:", b)
// b: [0 0 0 4]
fmt.Println("addr of b:", &b[0])
// addr of b: 0x44a0c0
fmt.Println("appending 5 to c from a")
// appending 5 to c from a
c := append(a, 5)
fmt.Println("addr of c:", &c[0])
// addr of c: 0x44a180
fmt.Println("a:", a)
// a: [0 0 0]
fmt.Println("b:", b)
// b: [0 0 0 4]
fmt.Println("c:", c)
// c: [0 0 0 5]
```

With slices a, b, and c, 4 and 5 seem to be appended as we would expect. We can even check the memory addresses and confirm that b and c point to different underlying arrays.

**EXAMPLE 2: SOMETHING FISHY**

```go
i := make([]int, 3, 8)
fmt.Println("len of i:", len(i))
// len of i: 3
fmt.Println("cap of i:", cap(i))
// cap of i: 8
fmt.Println("appending 4 to j from i")
// appending 4 to j from i
j := append(i, 4)
fmt.Println("j:", j)
// j: [0 0 0 4]
fmt.Println("addr of j:", &j[0])
// addr of j: 0x454000
fmt.Println("appending 5 to g from i")
// appending 5 to g from i
g := append(i, 5)
fmt.Println("addr of g:", &g[0])
// addr of g: 0x454000
fmt.Println("i:", i)
// i: [0 0 0]
fmt.Println("j:", j)
// j: [0 0 0 5]
fmt.Println("g:", g)
// g: [0 0 0 5]
```

In this example, however, when 5 is appended to g it overwrites j's fourth index because j and g point to the same underlying array. The append() function only creates a new array when there isn't any capacity left. We created i with a length of 3 and a capacity of 8, which means we can append 5 items before a new array is automatically allocated.

### RANGE

Go provides syntactic sugar to iterate easily over elements of a slice:

```go
for INDEX, ELEMENT := range SLICE {}

fruits := []string{"apple", "banana", "grape"}
for i, fruit := range fruits {
    fmt.Println(i, fruit)
}
// 0 apple
// 1 banana
// 2 grape
```

## MAPS

Maps are similar to JS objects and Python dicts.

Maps are a data structure that provides key->value mapping.

The zero value of a map is `nil`

We can create a map by using a literal or by using the`make()` function:

```go
ages:= make(map[string]int)
ages["John"] = 37
ages["Jorge"] = 21
ages["Mary"] = 24

ages = map[string]int{
    "John" : 37,
    "Mary" : 21
}
```

The `len()` function works on a map, it returns the total number of key/value pairs.

### MUTATIONS

**INSERT A ELEMENT**

`m[key] = elem`

**GET AN ELEMENT**

`elem = m[key]`

**DELETE AN ELEMENT**

`delete(m. key)`

**CHECK IF A KEY EXISTS**

`elem, ok := m[key]`

- If `key` is in `m`, then `ok` is `true`. If not, `ok` is `false`
- If `key` is not in the map, then `elem` is the zero value for the map's element type.

### KEY TYPES

Any type can be used as the value in a map, but _keys_ are more restrictive.

As mentioned earlier, map keys may be of any type that is comparable. The language spec defines this precisely, but in short, comparable types are boolean, numeric, string, pointer, channel, and interface types, and structs or arrays that contain only those types. Notably absent from the list are slices, maps, and functions; these types cannot be compared using ==, and may not be used as map keys.

It's obvious that `strings`, `ints`, and other basic types should be available as map keys, but perhaps unexpected are `struct` keys. `Struct` can be used to key data by multiple dimensions. For example, this map of maps could be used to tally web page hits by country:

`hits := make(map[string]map[string]int)`

This is a map of string to (map of string to int). Each key of the outer map is the path to a web page with its own inner map. Each inner map key is a two-letter country code. This expression retrieves the number of times an Australian has loaded the documentation page:

`n := hits["/doc/"]["au"]`

Unfortunately, this approach becomes unwieldy when adding data, as for any given outer key you must check if the inner map exists, and create it if needed:

```go
func add(m map[string]map[string]int, path, country string) {
    mm, ok := m[path]
    if !ok {
        mm = make(map[string]int)
        m[path] = mm
    }
    mm[country]++
}
add(hits, "/doc/", "au")
```

On the other hand, a design that uses a single map with a struct key does away with all that complexity:

```go
type Key struct {
    Path, Country string
}
hits := make(map[Key]int)
```

When a Vietnamese person visits the home page, incrementing (and possibly creating) the appropriate counter is a one-liner:

```go
hist[Key{"/ref/spec"}]
```

**LIKE SLICES, MAPS HOLD REFERENCES**

Like slices, maps hold references to an underlying data structure. If you pass a map to a function that changes the contents of the map, the changes will be visible in the caller

### MAP LITERALS

Maps can be constructed using the usual composite literal syntax with colon-separated key-value pairs, so it's easy to build them during initialization.

```go
var timeZone = map[string]int{
    "UTC":  0*60*60,
    "EST": -5*60*60,
    "CST": -6*60*60,
    "MST": -7*60*60,
    "PST": -8*60*60,
}
```

### MISSING KEYS

An attempt to fetch a map value with a key that is not present in the map will return the zero value for the type of the entries in the map. For instance, if the map contains `integers`, looking up a non-existent key will return `0`. A set can be implemented as a map with value type `bool`. Set the map entry to true to put the value in the set, and then test it by simple indexing.

```go
attended := map[string]bool{
    "Ann": true,
    "Joe": true,
    ...
}

if attended[person] { // will be false if person is not in the map
    fmt.Println(person, "was at the meeting")
}
```

Sometimes you need to distinguish a missing entry from a zero value. Is there an entry for "UTC" or is that 0 because it's not in the map at all? You can discriminate with a form of multiple assignment.

```go
var seconds int
var ok bool
seconds, ok = timeZone[tz]
```

For obvious reasons, this is called the “comma ok” idiom. In this example, if tz is present, seconds will be set appropriately and ok will be true; if not, seconds will be set to zero and ok will be false. Here's a function that puts it together with a nice error report:

```go
func offset(tz string) int {
    if seconds, ok := timeZone[tz]; ok {
        return seconds
    }
    log.Println("unknown time zone:", tz)
    return 0
}
```

### DELETING MAP ENTRIES

To delete a map entry, use the delete built-in function, whose arguments are the map and the key to be deleted. It's safe to do this even if the key is already absent from the map.

```go
delete(timeZone, "PDT")  // Now on Standard Time
```

### NESTED

Maps can contain maps, creating a nested structure. For example:

```go
map[string]map[string]int
map[rune]map[string]int
map[int]map[string]map[string]int
```

## FIRST CLASS AND HIGHER ORDER FUNCTIONS

A programming language is said to have "first-class functions" when functions in that language are treated like any other variable. Functions can be passed as an argument to other functions, can be returned by another function and can be assigned as a value to a variable

A function that returns a function or accepts a function as input is called a Higher-Order function.

```go
func add(x, y int) int {
  return x + y
}

func mul(x, y int) int {
  return x * y
}

// aggregate applies the given math function to the first 3 inputs
func aggregate(a, b, c int, arithmetic func(int, int) int) int {
  return arithmetic(arithmetic(a, b), c)
}

func main() {
  fmt.Println(aggregate(2,3,4, add))
  // prints 9
  fmt.Println(aggregate(2,3,4, mul))
  // prints 24
}
```

A function's type is dependent on the types of its parameters and return values.

**WHY FIRST-CLASS AND HIGHER-ORDER FUNCTIONS?**

At first, it may seem like dynamically creating functions and passing them around as variables adds unnecessary complexity. Most of the time you would be right. There are cases however when functions as values make a lot of sense. Some of these include:

- (HTTP API handlers)[https://en.wikipedia.org/wiki/Web_API]
- (Pub/Sub handlers)[https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern]
- `Onclick` callbacks

Any time you need to run custom code at a time in the future, functions as values might make sense.

### CURRYING

Function currying is a concept from functional programming and involves partial application of functions. It allows a function with multiple arguments to be transformed into a sequence of functions, each taking a single argument.

Although Go does not support full currying, it is possible to simulate this behavior. Bu designing functions that take other functions as inputs and return new functions, we can achieve a similar effect.

```go
func main() {
  squareFunc := selfMath(multiply)
  doubleFunc := selfMath(add)

  fmt.Println(squareFunc(5))
  // prints 25

  fmt.Println(doubleFunc(5))
  // prints 10
}

func multiply(x, y int) int {
  return x * y
}

func add(x, y int) int {
  return x + y
}

func selfMath(mathFunc func(int, int) int) func (int) int {
  return func(x int) int {
    return mathFunc(x, x)
  }
}
```

### DEFER

The `defer` keyword is a fairly unique feature of Go. It allows a function to be executed automatically _just before_ its enclosing function returns

Deferred functions are typically used to close database connections, file handlers and the like.

```go
func CopyFile(dstName, srcName string) (written int64, err error) {

  src, err := os.Open(srcName)
  if err != nil {
    return
  }
  defer src.Close()

  dst, err := os.Create(dstName)
  if err != nil {
    return
  }
  defer dst.Close()

  return io.Copy(dst, src)
}
```

Defer is a great way to make sure that something happens at the end of a function, even if there are multiple return statements.

### BLOCK SCOPE

Unlike Python, Go is not function-scoped, it's block-scoped. Variables declared inside a block are only accessible within that block (and its nested blocks). There's also the package scope. We'll talk about packages later, but for now, you can think of it as the outermost, nearly global scope.

```go
package main

// scoped to the entire "main" package (basically global)
var age = 19

func sendEmail() {
    // scoped to the "sendEmail" function
    name := "Jon Snow"

    for i := 0; i < 5; i++ {
        // scoped to the "for" body
        email := "snow@winterfell.net"
    }
}
```

Blocks are defined by curly braces `{}`. New blocks are created for:

- Functions
- Loops
- If statements
- Switch statements
- Select statements
- Explicit blocks

It's a bit unusual, but occasionally you'll see a plain old explicit block. It exists for no other reason than to create a new scope.

```go
package main

func main() {
    {
        age := 19
        // this is okay
        fmt.Println(age)
    }

    // this is not okay
    // the age variable is out of scope
    fmt.Println(age)
}
```

### CLOSURES

A closure is a function that references variables from outside its own function body. The function may access and assign to the referenced variables.

When a variable is enclosed in a closure, the enclosing function has access to a mutable reference to the original value

In this example, the `concatter()` function returns a function that has reference to an enclosed doc value. Each successive call to `harryPotterAggregator` mutates that same doc variable.

```go
func concatter() func(string) string {
	doc := ""
	return func(word string) string {
		doc += word + " "
		return doc
	}
}

func main() {
	harryPotterAggregator := concatter()
	harryPotterAggregator("Mr.")
	harryPotterAggregator("and")
	harryPotterAggregator("Mrs.")
	harryPotterAggregator("Dursley")
	harryPotterAggregator("of")
	harryPotterAggregator("number")
	harryPotterAggregator("four,")
	harryPotterAggregator("Privet")

	fmt.Println(harryPotterAggregator("Drive"))
	// Mr. and Mrs. Dursley of number four, Privet Drive
}
```

### ANONYMOUS FUNCTIONS

Anonymous functions are true to form in that they have no name. We've been using them throughout this chapter, but we haven't really talked about them yet.

Anonymous functions are useful when defining a function that will only be used once or to create a quick closure.

```go
func doMath(f func(int) int, nums []int) []int {
	var results []int
	for _, n := range nums {
		results = append(results, f(n))
	}
	return results
}

func main() {
	nums := []int{1, 2, 3, 4, 5}

	allNumsDoubled := doMath(func(x int) int {
	    return x + x
	}, nums)

	fmt.Println(allNumsDoubled)
}
```

### POINTERS

As we have learned, a variable is a named location in memory that stores a value. We can manipulate the value of a variable by assigning a new value to it or by performing operations on it. When we assign a value to a variable, we are storing that value in a specific location in memory.

```go
x := 42
// "x" is the name of a location in memory.
// That location is storing the integer value of 42
```

**A POINTER IS A VARIABLE**
A pointer is a variable that stores the memory address of another variable. This means that a pointer "points to" the location of where the data is stored NOT the actual data itself.

The `*` syntax defines a pointer:

```go
var p *int
```

The `&` operator generates a pointer to its operand.
The `*` dereferences a pointer to gain access to the value

```go
myString := "hello"
myStringPtr := &myString

fmt.Println(*myStringPtr) // read myString through the pointer
*myStringPtr = "world"    // set myString through the pointer
```

Unlike C, Go has no pointer arithmetic

**WHY ARE POINTERS USEFUL?**

Pointers allow us to manipulate data in memory directly, without making copies or duplicating data. This can make programs more efficient and allow us to do things that would be difficult or impossible without them.

**A POINTER'S ZERO VALUE IS NIL**

### NIL POINTERS

Pointers can be very dangerous.

If a pointer points to nothing (the zero value of the pointer type) then dereferencing it will cause a runtime error (a panic) that crashes the program. Generally speaking, whenever you're dealing with pointers you should check if it's nil before trying to dereference it.

### POINTER RECEIVERS

A receiver type on a method can be a pointer.

Methods with pointer receivers can modify the value to which the receiver points. Since methods often need to modify their receiver, pointer receivers are more common than value receivers. However, methods with pointer receivers don't require that a pointer is used to call the method. The pointer will automatically be derived from the value.

```go
type car struct {
	color string
}

func (c *car) setColor(color string) {
	c.color = color
}

func main() {
	c := car{
		color: "white",
	}
	c.setColor("blue")
	fmt.Println(c.color)
	// prints "blue"
}
```

**NON-POINTER RECEIVER**

```go
type car struct {
	color string
}

func (c car) setColor(color string) {
	c.color = color
}

func main() {
	c := car{
		color: "white",
	}
	c.setColor("blue")
	fmt.Println(c.color)
	// prints "white"
}
```

### REFERENCES

It's possible to define an empty pointer. For example, an empty pointer to an integer:
`var p *int`

Its zero value is `nil`, which means it doesn't point to any memory address.

It's common to immediately create a new pointer by instead using the `&` operator to get a pointer to its operand:

```go
myString := "hello" // myString is just a string
myStringPtr := &myString // myStringPtr is a pointer to myString's address
```

**DEREFERENCE**

The `*` operator deferences a pointer to get the original value

```go
fmt.Println(*myStringPtr) // read myString through the pointer
*myStringPtr = "world" // set myString through the pointer
```

Unlike C, Go has no pointer arithmetic.

### Pass by Reference

Functions in Go generally pass variables by `value`, meaning that functions receive a `copy` of most **non-composite** types:

```go
func increment(x int) {
    x++
    fmt.Println(x)
    // 6
}


func main() {
    x := 5
    increment(x)
    fmt.Println(x)
    // 5
}
```

The main function still prints 5 because the increment function received a **copy** of `x`.

One of the most common use cases for `pointers` in Go is to pass `variables` by `reference`, meaning that the function receives the `address` of the original `variable`, not a `copy` of the value. This allows the function to `update` the original `variable value`.

```go
func increment(x *int) {
    *x++
    fmt.Println(*x)
    // 6
}

func main() {
    x := 5
    increment(&x)
    fmt.Println(x)
    // 6
}
```

```go
package main

import (
	"strings"
)

func removeProfanity(message *string) {
	*message = strings.ReplaceAll(*message, "fubb", "****")
	*message = strings.ReplaceAll(*message, "shiz", "****")
	*message = strings.ReplaceAll(*message, "witch", "*****")
}
```

### Pointer Performance

> Pointers are always faster because copying is slow.

But that doesn't mean we have to use it everywhere

Here are my rules of thumb:

- First, worry about writing clear, correct, maintainable code.
- If you have a performance problem, fix it.

Before even thinking about using pointers to optimize your code, use pointers when you need a shared reference to a value; otherwise, just use values.

If you do have a performance problem, consider:

- Stack vs. Heap
- Copying

Interestingly, local non-pointer variables are generally faster to pass around than pointers because they're stored on the stack, which is faster to access than the heap. Even though copying is involved, the stack is so fast that it's no big deal.

Once the value becomes large enough that copying is the greater problem, it can be worth using a pointer to avoid copying. That value will probably go to the heap, so the gain from avoiding copying needs to be greater than the loss from moving to the heap.

One of the reasons Go programs tend to use less memory than Java and C# programs is that Go tends to allocate more on the stack.

## PACKAGES

[packages](./packages.md)

## CONCURRENCY

[concurrency](./concurrency.md)

## MUTEXES

[mutexes](./mutexes.md)

## GENERICS

[generics](./generics.md)

## PROVERBS

[proverbs](./proverbs.md)
