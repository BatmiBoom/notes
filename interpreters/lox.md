## Lox Language

This is the language we are going to build an interpreter and a compiler

### Hello, Lox

```lox
// Your first Lox program!
print "Hello, world!";
```

As that `//` line comment and the trailing semicolon imply, Lox's syntax is a member of the C family.

### A high-level language

When I think of languages that are small but useful, what comes to mind are high-level “scripting” languages like JavaScript, Scheme, and Lua. Of those three, Lox looks most like JavaScript, mainly because most C-syntax languages do. Lox’s approach to scoping hews closely to Scheme. The C flavor of Lox we’ll build is heavily indebted to Lua’s clean, efficient implementation.

Lox shares two other aspects with those three languages:

### Dynamic typing

Lox is dynamically typed. Variables can store values of any type, and a single variable can even store values of different types at different times. If you try to perform an operation on values of the wrong type — say, dividing a number by a string — then the error is detected and reported at runtime.

There are plenty of reasons to like static types, but they don’t outweigh the pragmatic reasons to pick dynamic types for Lox. A static type system is a ton of work to learn and implement.

> After all, the two languages we’ll be using to implement Lox are both statically typed.

### Automatic memory management

There are two main techniques for managing memory: **reference counting** and **tracing garbage collection** (GC).

- Ref counters are much simpler to implement, but this approach has limitations.
- Tracing garbage collection it is a little harrowing working at the level of raw memory. Debugging a GC can sometimes leave you seeing hex dumps in your dreams.

> In practice, ref counting and tracing are more ends of a continuum than opposing sides. Most ref counting systems end up doing some tracing to handle cycles, and the write barriers of a generational collector look a bit like retain calls if you squint.

### Data types

Lox builtin data types:

- Booleans: are the only data type in Lox named after a person, George Boole, which is why “Boolean” is capitalized. He died in 1864, nearly a century before digital computers turned his algebra into electricity.
  There are two Boolean values, obviously, and a literal for each one.
  ```lox
   true;  // Not false.
   false; // Not *not* false.
  ```
- Numbers: Lox has only one kind of number: double-precision floating point.
  ```lox
  1234; // An integer.
  12.34; // A decimal number.
  ```
- Strings. Like most languages, they are enclosed in double quotes.
  ```lox
  "I am a string";
  ""; // The empty string.
  "123"; // This is a string, not a number.
  ```
  There is quite a lot of complexity hiding in that innocuous sequence of characters.
  Even that word “character” is a trickster. Is it ASCII? Unicode? A code point or a “grapheme cluster”? How are characters encoded? Is each character a fixed size, or can they vary?
- Nil. It represents “no value”. When we get to implementing it, that will help distinguish when we’re talking about Lox’s nil versus Java or C’s null.
  There are good arguments for not having a null value in a language since null pointer errors are the scourge of our industry. If we were doing a statically typed language, it would be worth trying to ban it. In a dynamically typed one, though, eliminating it is often more annoying than having it.

### Expressions

If built-in data types and their literals are atoms, then expressions must be the molecules.

#### Arithmetic

Lox features the basic arithmetic operators you know and love from C and other languages:

```lox
add + me;
subtract - me;
multiply * me;
divide / me;
```

The sub-expressions on either side of the `operator` are `operands`. Because there are two of them, these are called `binary operators`. Because the `operator` is fixed in the middle of the operands, these are also called `infix operators`.

There are some `operators` that have more than two `operands` and the `operators` are interleaved between them. The only one in wide usage is the “conditional” or “ternary” operator of C and friends:

```c
condition ? thenArm : elseArm;
```

Some call these `mixfix operators`.

One `arithmetic operator` is actually both an `infix` and a `prefix` one. The `-` operator can also be used to negate a number.

```c
-negateMe;
```

All of these operators work on numbers, and it’s an error to pass any other types to them. The exception is the + operator — you can also pass it two strings to concatenate them.

#### Comparison and equality

We have a few more operators that always return a Boolean result. We can compare numbers using the old Comparison Operators.

```lox
less < than;
lessThan <= orEqual;
greater > than;
greaterThan >= orEqual;
```

We can test two values of any kind for equality or inequality.

```lox
1 == 2; // false.
"cat" != "dog"; // true.
```

Even different types.

```lox
314 == "pi"; // false.
```

Values of different types are never equivalent.

```lox
123 == "123"; // false.
```

I’m generally against implicit conversions.

### Logical Operators

The not operator, a prefix `!`, returns `false` if its operand is true, and vice versa.

```lox
!true;
!false;
```

The other two logical operators really are control flow constructs in the guise of expressions. An `and` expressions determines if two values are both true. It returns the left operand if it's false, or the right operand otherwise.

```lox
true and false;
true and true;
```

And an `or` expression determines if either of two values (or both) are true. It returns the left operand if it is true and the right operand otherwise

```lox
false or false;
true or false;
```

The reason `and` and `or` are like control flow structures is that they **short-circuit**. Not only does `and` return the left operand if it is `false`, it doesn't even evaluate the right one in that case. If the left operand of an `or` is true, the right is skipped.

### Precedence and grouping

All of these operators have the same precedence and associativity that you’d expect coming from C. In cases where the precedence is not what you want, you can use `()` to group stuff.

```lox
var average = (min + max) / 2;
```

## Statements

Where an expression’s main job is to produce a `value`, a statement’s job is to produce an `effect`. Since, by definition, statements don’t evaluate to a value, to be useful they have to otherwise change the world in some way — usually modifying some state, reading input, or producing output.

```lox
print "Hello, world!";
```

As expression `"some expression";` followed by a `;` promotes the expression to statement-hood. This is called, an **expression statement**.

If you want to pack a series of statements where a single one is expected, you can wrap them up in a **block**

```lox
{
    print "One statement.";
    print "Two statements.";
}
```

## Variables

You declare variables using `var` statements. If you omit the initializer, the variable’s value defaults to `nil`.

```lox
var imAVariable = "here is my value";
var iAmNil;

var breakfast = "bagels";
print breakfast; // "bagels".
breakfast = "beignets";
print breakfast; // "beignets".
```

## Control Flow

- If statement executes one of two statements based on some condition.
  ```lox
  if (condition) {
    print "yes";
  } else {
    print "no";
  }
  ```
- While loop executes the body repeatedly as long as the condition expression evaluates to true.
  ```lox
  var a = 1;
  while (a < 10) {
    print a;
    a = a + 1;
  }
  ```
- For loops.
  ```lox
    for (var a = 1; a < 10; a = a + 1) {
      print a;
    }
  ```

## Functions

A function call expression looks the same as it does in C.

```lox
makeBreakfast(bacon, eggs, toast);
```

You can also call a function without passing anything to it.

```lox
makeBreakfast();
```

The parentheses are mandatory in this case. If you leave them off, the name does not call the function, it just refers to it.

Defining a function

```lox
fun printSum(a, b) {
  print a + b;
}
```

- An `argument` is an actual value you pass to a function when you call it. So a function call has an argument list. Sometimes you hear actual parameter used for these.
- A `parameter` is a variable that holds the value of the argument inside the body of the function. Thus, a function declaration has a parameter list. Others call these formal parameters or simply formals.

> Some statically typed languages make a distinction between `declaring` a function and `defining` it. A declaration binds the function’s type to its name so that calls can be type-checked but does not provide a body. A definition declares the function and also fills in the body so that the function can be compiled.

The body of a function is always a block. Inside it, you can `retur`n a value using a return statement.

```lox
fun returnSum(a, b) {
  return a + b;
}
```

If execution reaches the end of the block without hitting a `return`, it implicitly returns `nil`.

### Closures

Functions are first class in Lox, which just means they are real values that you can get a reference to, store in variables, pass around, etc. This works:

```lox
fun addPair(a, b) {
  return a + b;
}

fun identity(a) {
  return a;
}

print identity(addPair)(1, 2); // Prints "3".
```

Since function declarations are statements, you can declare local functions inside another function.

```lox
fun outerFunction() {
  fun localFunction() {
    print "I'm local!";
  }

  localFunction();
}
```

If you combine local functions, first-class functions, and block scope, you run into this interesting situation:

```lox
fun returnFunction() {
  var outside = "outside";

  fun inner() {
    print outside;
  }

  return inner;
}

var fn = returnFunction();
fn();
```

Here, `inner()` accesses a local variable declared outside of its body in the surrounding function. This comes from lisp

For that to work, `inner()` has to “hold on” to references to any surrounding variables that it uses so that they stay around even after the outer function has returned. We call functions that do this **closures**.

## Classes

For a dynamically typed language, objects are pretty handy. We need some way of defining compound data types to bundle blobs of stuff together.

If we can also hang methods off of those, then we avoid the need to prefix all of our functions with the name of the data type they operate on to avoid colliding with similar functions for different types. In, say, Racket, you end up having to name your functions like hash-copy (to copy a hash table) and vector-copy (to copy a vector) so that they don’t step on each other. Methods are scoped to the object, so that problem goes away.

### Classes or prototypes

When it comes to objects, there are actually two approaches to them, classes and prototypes. Classes came first, and are more common thanks to C++, Java, C#, and friends. Prototypes were a virtually forgotten offshoot until JavaScript accidentally took over the world.

- In class-based languages, there are two core concepts: instances and classes. Instances store the state for each object and have a reference to the instance’s class. Classes contain the methods and inheritance chain. To call a method on an instance, there is always a level of indirection. You look up the instance’s class and then you find the method there:

  ```
  |------------------------|                      |--------------|
  | benedict     instance  |                      | Brunch class |
  | - meat = "ham"         | ---- HAS CLASS --->  |              |
  | - bread = "Muffin"     |                      | - drink()    |
  |________________________|                      |______________|
                                                         |
                                                     INHERITS FROM
                                                         |
                                                  |-----------------|
                                                  | Breakfast class |
                                                  | - serve()       |
                                                  |_________________|
  ```

  > In a statically typed language like C++, method lookup typically happens at compile time based on the static type of the instance, giving you static dispatch. In contrast, dynamic dispatch looks up the class of the actual instance object at runtime. This is how virtual methods in statically typed languages and all methods in a dynamically typed language like Lox work.

- Prototype-based languages merge these two concepts. There are only objects — no classes — and each individual object may contain state and methods. Objects can directly inherit from each other (or “delegate to” in prototypal lingo):

  ```
  |------------------|
  | classyBrunc  obj |
  | - meat = "ham"   |
  |__________________|
          |
      DELEGATES TO
          |
  |------------------|
  | porkProduct  obj |
  | - meat = "ham"   |
  |__________________|
          |
      DELEGATES TO
          |
  |------------------|
  | breakfast    obj |
  | - server()       |
  |__________________|
  ```

  > In practice the line between class-based and prototype-based languages blurs. JavaScript’s “constructor function” notion pushes you pretty hard towards defining class-like objects. Meanwhile, class-based Ruby is perfectly happy to let you attach methods to individual instances.

This means that in some ways prototypal languages are more fundamental than classes. They are really neat to implement because they’re so simple. Also, they can express lots of unusual patterns that classes steer you away from.

But I have looked at a lot of code written in prototypal languages. Do you know what people generally do with all of the power and flexibility of prototypes?  . . . They use them to reinvent classes.

Prototypes are simpler in the language, but they seem to accomplish that only by pushing lasses

### Classes in Lox

Declaring a class:

```lox
class Breakdast {
    cook() {
        print "Eggs a-fryin;!";
    }

    serve(who) {
        print "Enojy your breakfast, " + who + ".";
    }
}
```

The body of a class contains its methods. They look like function declarations but without the `fun` keyword. When the class declaration is executed, Lox creates a class object and stores that in a variable named after the class. Just like functions,classes are first class in lox.

```lox
var someVariable = Breakfast;
someFunction(Breakfast);
```

Next, we need a way to create instances. We could add some sort of new keyword, but to keep things simple, in Lox the class itself is a factory function for instances. Call a class like a function, and it produces a new instance of itself.

```lox
var breakfast = Breakfast();
print Breakfast; // "Breakfast instance"
```

### Instantiation and initialization

The idea behind object-oriented programming is encapsulating behavior and state together. To do that, you need fields. Lox, like other dynamically typed languages, lets you freely add properties onto objects.

```lox
breakfast.meat = "sausage";
breakfast.bread = "sourdough";
```

Assigning to a field creates it if it doesn’t already exist.

If you want to access a field or method on the current object from within a method, you use good old this.

```lox
class Breakfast {
  serve(who) {
    print "Enjoy your " + this.meat + " and " +
        this.bread + ", " + who + ".";
  }

  // ...
}
```

Part of encapsulating data within an object is ensuring the object is in a valid state when it’s created. To do that, you can define an initializer. If your class has a method named `init()`, it is called automatically when the object is constructed. Any parameters passed to the class are forwarded to its initializer.

```lox
class Breakfast {
  init(meat, bread) {
    this.meat = meat;
    this.bread = bread;
  }

  // ...
}

var baconAndToast = Breakfast("bacon", "toast");
baconAndToast.serve("Dear Reader");
// "Enjoy your bacon and toast, Dear Reader."
3 . 9 . 6
```

### Inheritance

Lox supports single inheritance. When you declare a class, you can specify a class that it inherits from using a less-than (<) operator.

```lox
class Brunch < Breakfast {
    drink() {
        print "How about a Bloody Mary?";
    }
}
```

If you know any type theory, you’ll notice it’s not a totally arbitrary choice. Every instance of a subclass is an instance of its superclass too, but there may be instances of the superclass that are not instances of the subclass. That means, in the universe of objects, the set of subclass objects is smaller than the superclass’s set, though type nerds usually use <: for that relation.

Here, `Brunch` is the derived class or subclass, and `Breakfast` is the base class or superclass.

Every method defined in the superclass is also available to its subclasses.

```lox
var benedict = Brunch("ham", "English muffin");
benedict.serve("Noble Reader");
```

Even the `init()` method gets inherited. In practice, the subclass usually wants to define its own `init()` method too. But the original one also needs to be called so that the superclass can maintain its state. We need some way to call a method on our own instance without hitting our own methods.

```lox
class Brunch < Breakfast {
    init(meat, bread, drink) {
        super.init(meat, bread);
        this.drink = drink;
    }
}
```

That’s about it for object orientation. I tried to keep the feature set minimal. The structure of the book did force one compromise. Lox is not a pure object-oriented language. In a true OOP language every object is an instance of a class, even primitive values like numbers and Booleans.
