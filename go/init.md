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
