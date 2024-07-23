# Data Types

## Literal

Is a value directly written in the source code instead of being the result of some other expression ( such as referencing a variable or a constant )

## Strings

Strings are a data type used in programming to represent text rather than numbers.

It is comprised of a set of characters that can contain spaces and numbers.

A string value is denoted by values inside the double quotation symbols " ".

- "Hello World" is a string value.
- "I have 0 cats!" is a string value.
- "100" is a string value.
- "true" is a string value.
- "Null" is a string value.

One thing to keep in mind is that you cannot do numerical calculations with string values.

"1" + "1" (strings) in programming is not the same as 1 + 1 (integers).

"1" + "1" will become the string value "11" whereas 1 + 1 will become the integer value 2.

## Integers/Numbers

An integer is a data type that represents some range of whole mathematical numbers.

In Godot `GDScript`, this range is between the values -9223372036854775808 and 9223372036854775807.

Integers are whole numbers. Some examples of whole numbers include 0, -100, 911.

Integers can be both positive, negative, and the number zero.

The most important aspect of an integer value is that it cannot have a decimal point (.). If there is a decimal point in the number, then it is a float data type value.

## Floats

A float is a floating-point number, which means it is a number with a decimal point.

Float data types are used when precision in mathematical calculations are needed.

A float value is similar to an integer. It is a numerical value; the only difference is that a float value is a decimal number.

Some examples include 0.0, -100.0, and 911.0.

## Booleans

The boolean is a data type that has only one of two possible values.

Boolean values are denoted by the keywords true and false.

The keyword true numerically represent the values 1, while the keyword false numerically represents the value 0.

## Null

The null data type is used to represent the absence of data.

The null value is denoted by the keyword null.

In `GDScript`, null is an empty data type that contains no information and cannot be assigned any other value.

# Variables

In computer science, a variable stores information to be referenced to and manipulated in a computer program.

In `GDScript`, you define a variable using the var keyword.

You need to have 4 crucial things in a single line of code to write a variable.

- Use the `var` keyword to signify the creation of a variable
- Immediately following the var keyword, come up with a name for the newly created variable
- Use the `=` symbol to assign a value to your variable. The = character is also called the assignment operator
- Lastly, after the = character, assign a literal value to your variable.

```GDScript
var a: int = 100
var b: String = "Hello world"
var c: float = 98.9
var d: bool = true`
```

or

```GDScript
var a := 100
var b := "Hello world"
var c := 98.9
var d := true`
```

A variable without a value is called an uninitialized variable.

This means that a variable is declared, but no value has been assigned to it.

```GDscript
var a
var b
var c
```

# Constants

A constant - also referred to as a constant variable - is a value that cannot be changed or altered by the application during runtime.

```GDScript
const never_changes: int = 100
```

## Converting Data Type

```GDScript
var text: String  = 100 as String
var num: int = "100" as int
var numFloat: float = 100 as float
```

# Operators & Operands

An operand is a variable, constant, or expression that acts upon the operator.

```GDScript
var a = 1 + 2
```

The integers `1` and `1` are _operands_. The `+` symbol is the _operator_. On top of that, the `=` symbol is the assignment operator.

## Arithmetic Operators

- `+` Addition Operator
- `-` Subtraction Operator
- `*` Multiplication Operator
- `/` Division Operator

## Relational Operators

- `==` Equality Operator
- `!=` Not Equal Operator
- `>` Greater Than Operator
- `>=` Greater Than or Equal Operator
- `<` Less Than Operator
- `<=` Less Than or Equal Operator

## Logical Operators

- `&&` AND Operator
- `||` OR Operator
- `!` NOT Operator

# Comments

```GDScript
# This is a single line commet

"""
This is a multiline comment
This is a multiline comment
"""
```

There are 4 different types of comments you may find yourself using:

- Methodology Description
- Meta-Data
- Debugging
- Code Description

## Methodology Description

Methodology comments can be used to explain the code you are using rather than the clarification of its intent.

For example, in your code for a sorting algorithm, you may use a methodology comment to explain why you used the insertion sort algorithm instead of the quick sort.

```GDScript
"""
Quicksort turned out to be slower than insertion sort for our list. For this reason, I went with insertion sort.
"""
```

## Meta-Data

These comments are at the top of a script file.

They will include things like the company name, author, file name, etc.

You will typically see this sort of comment on open source code.

```GDScript
"""
This file is part of:
Godot Game Engine
https://godotengine.org
***********************
Copyright (c) 2007 -2021 Juan Linietsky, Ariel Manzur
"""
```

## Debugging

Debugging comments are used when you want to apply brute force debugging techniques on your code.

An example would be commenting out print statements (which print things to console).

```GDScript
if(x < 10):
    # print(x)
    x = x + 1
```

## Code Description

Generally used o make others understand the intent of a line of code.

This type of comment should be used only when needed.

Sometimes if used, it is a sign of lousy variable naming convention.

The following is an example of a Code Description comment.

```GDScript
# Player health
var x = 100
```

# Conditional Statements

There are two different types of conditional statements in `GDScript`.

- `if/elif/else` statements
- `match` statements
- Ternary-if Expressions

## The `if` keyword

```GDScript
if 2 > 1:
    do_something()
elif 2 < 1:
    do_other()
else:
    do_other_thing()
```

## The `match` keyword

```GDScript
match <expression>:
    <pattern(s)>:
        <block>
    <pattern(s)> when <guard expression>:
        <block>
    _:
        print("Default")
```

```GDScript
match x:
	1:
		print("We are number one!")
	2:
		print("Two are better than one!")
	"test":
		print("Oh snap! It's a string!")

"""
Matches a constant expression, an identifier, or an attribute access (A.B):
"""
match typeof(x):
	TYPE_FLOAT:
		print("float")
	TYPE_STRING:
		print("text")
	TYPE_ARRAY:
		print("array")

"""
A binding pattern introduces a new variable. Like the wildcard pattern, it matches everything - and also gives that value a name. It's especially useful in array and dictionary patterns:
"""
match x:
	1:
		print("It's one!")
	2:
		print("It's one times two!")
	var new_var:
		print("It's not 1 or 2, it's ", new_var)

"""
Array pattern
Every single element of the array pattern is a pattern itself, so you can nest them.

Open-ended array: An array can be bigger than the pattern by making the last subpattern ...
"""
match x:
	[]:
		print("Empty array")
	[1, 3, "test", null]:
		print("Very specific array")
	[var start, _, "test"]:
		print("First element is ", start, ", and the last is \"test\"")
	[42, ..]:
		print("Open ended array")

"""
Dictionary pattern
Works in the same way as the array pattern. Every key has to be a constant pattern.
"""
match x:
	{}:
		print("Empty dict")
	{"name": "Dennis"}:
		print("The name is Dennis")
	{"name": "Dennis", "age": var age}:
		print("Dennis is ", age, " years old.")
	{"name", "age"}:
		print("Has a name and an age, but it's not Dennis :(")
	{"key": "godotisawesome", ..}:
		print("I only checked for one entry and ignored the rest")

"""
You can also specify multiple patterns separated by a comma. These patterns aren't allowed to have any bindings in them.
"""
match x:
	1, 2, 3:
		print("It's 1 - 3")
	"Sword", "Splash potion", "Fist":
		print("Yep, you've taken damage")
```

### Pattern Guards

Only one branch can be executed per match. Once a branch is chosen, the rest are not checked. If you want to use the same pattern for multiple branches or to prevent choosing a branch with too general pattern, you can specify a guard expression after the list of patterns with the when keyword:

```GDScript
match point:
	[0, 0]:
		print("Origin")
	[_, 0]:
		print("Point on X-axis")
	[0, _]:
		print("Point on Y-axis")
	[var x, var y] when y == x:
		print("Point on line y = x")
	[var x, var y] when y == -x:
		print("Point on line y = -x")
	[var x, var y]:
		print("Point (%s, %s)" % [x, y])
```

## Ternary-if Expressions

`var x = [value] if [expression] else [value]`

# While Loop

With the `while` keyword, you can run the block of code for as long as the while loop's condition continues to be true.

```GDScript
var x: int = 0
while x < 10:
    print(x)
    x = x + 1
```

With the `break` keyword, you can get out of a loop.

```GDScript
var x: int = 0
while x < 10:
    break

    print(x)
    x = x + 1
```

# For Loop

A for loop is a control flow statement that allows code to be executed repeatedly.

```GDScript
for x in 10:
    print(x)

var arrayE = [10, 20, 30]
for x in arrayE:
    print(x)
```

# Arrays

Are a collection of values/items stored together. In `GDScript`, arrays can contain values of different data types.

```GDScript
var example = []
var anotherEx = [1, "hello", true]

print(anotherEx[0])
```

## Length

```GDScript
var example = [1,2,3]

var length = example.size()
```

## Sub Arrays

You can have arrays inside of arrays.

```GDScript
var subArary = [ [1,2], [9,10]]

var subArrayValueOne = subArray[0][0]
var subArrayValueTwo = subArray[1][1]
```

## Push and Pop Methods

To push a value to either the front or back of an array, use the `push` method:

```GDScript
var example = [1, 2, 3]

example.push_front(0) -> [0, 1, 2, 3]
example.push_back(4) -> [0, 1, 2, 3, 4]
```

To pop a value out of an array, you can use the `pop` method:

```GDScript
var example = [1, 2, 3]

example.pop_front() -> [2, 3]
example.pop_back() -> [3]

```

## Shallow Copy

A shallow copy copies the array except for sub-arrays.

This means that all nested arrays and dictionaries will be shared with the original array.

A shallow copy uses the `duplicate` method with the false value passed inside the parentheses.

```GDScript
var example = [ 1,2,3, [1,2] ]

var anotherArray = example.duplicate(false) -> anotherArray = [1,2,3,[1,2]]

anotherArray.push_front(4)

print(example) -> [1,2,3,[1,2]]

anotherArray[3][0] = 100

print(example) -> [1,2,3,[100,2]]
print(anotherArray) -> [1,2,3,[100,2],4]
```

## Deep Copy

A deep copy copies the array, including sub-arrays.

This means that all nested arrays and dictionaries will not be shared with the original array.

To do a deep copy, use the duplicate method with the value true passed inside the parentheses.

```GDScript
var example = [ 1,2,3, [1,2] ]

var anotherArray = example.duplicate(true) -> anotherArray = [1,2,3,[1,2]]

anotherArray.push_front(4)

print(example) -> [1,2,3,[1,2]]

anotherArray[3][0] = 100

print(example) -> [1,2,3,[1,2]]
print(anotherArray) -> [1,2,3,[100,2],4]
```

# Enumerations

`Enums`, also referred to as enumerations, are a data type that contains a fixed set of constants.

## Global Enumerations

```GDScript
enum {LEFT, RIGHT, UP, DOWN}

# Same as writing
const LEFT = 0
const RIGHT = 1
const UP = 2
const DOWN = 3
```

## Local Enumerations

```GDScript
enum MOVE_SET {LEFT, RIGHT, UP, DOWN}

MOVE_SET.LEFT # 0
MOVE_SET.RIGHT # 1
MOVE_SET.UP # 2
MOVE_SET.DOWN # 3
```

# Dictionaries

Dictionaries, also referred to as a key-value store, are associative containers that contain values referenced by keys.

`var simpleDictionary = {"name": "John"}`

In the code above, the key name, while the value is "John"

You are also able to use other `datatypees` besides strings as keys:

```GDScript
var integerDictionary = {1: "John"}
var floatDictionary = {2.13: "Jane"}
var booleanDictionary = {true: "Sarah"}
```

## Accessing Dictionaries

```GDScript
- Create Dictionaries
var simpleDictionary = {"name": "John"}
var integerDictionary = {1: "Jane"}
var floatDictionary = {2.13: "Josh"}
var booleanDictionary = {true: "Sarah"}

- Retrieve values
var getJohn = simpleDictionary["name"] # "John"
var getJane = integerDictionary[1] # "Jane"
var getJosh = floatDictionary[2.13] # "Josh"
var getJohn = booleanDictionary[true] # "Sarah"

- You can use dot notation if retrieving string keys
var getJohnAgain = simpleDictionary.name # "John"
```

## Assigning Values to an Existing Key

```GDScript
var simpleDictionary = {"name": "John"}

- One way
simpleDictionary["name"] = "Jane"

- Another way
simpleDictionary.name = "Jane Doe"
```

## Creating New Key-Value Pair

```GDScript
var simpleDictionary = {"name": "Jane"}

simpleDictionary["birthdate"] = "December 2020"

simpleDictionary.age = 0
```

## Comparing Dictionaries key-value pairs

If you compare dictionaries with a comparison operator, you will return false even if the dictionaries compared are exactly the same:

```GDScript
var simpleDictionary = {"name": "Jane"}
var sameDictionary = {"name": "Jane"}

if(simpleDictionary == sameDictionary):
    - Block of code never runs
```

To get the desired results when comparing dictionaries, use the hash method:

```GDScript
var simpleDictionary = {"name": "Jane"}
var sameDictionary = {"name": "Jane"}

if(simpleDictionary.hash() == sameDictionary.hash()):
    - Block of code runs
```

## Delete a key-value pair

To delete a key-value pair, use the erase method:

```GDScript
var simpleDictionary = {"name": "Jane"}

simpleDictionary.erase("name")
```

# Functions

A function is a block of organized and reusable code used to perform a single, related task/action.

Functions are also referred to as methods, procedures, or sub-routines.

On top of that, functions are always part of a class and can return back values if needed.

## Simple Function

```GDScript
func simpleExample():
    pass
```

In this case, the `simpleExample()` function does nothing.

The `pass` keyword does nothing except preventing the compiler from showing the empty function soft error.

The `pass` keyword can also be used in loops to avoid the empty loop error.

## Function with Parameters

You can pass values into a function through the function’s parameter (the parenthesis):

```GDScript
func simpleExample(parameter):
    pass
```

## Function with Specific Data Type Parameters

You can also force a single data type onto a parameter value:

```GDScript
func simpleExample(parameter: String):
    pass
```

In this case, our `simpleExample` function parameter can only take in string values.

You can also set the default value of a parameter:

```GDScript
func simpleExample(parameter := "default value"):
    pass
```

In this case, we would like our parameter to take in only string values, and if none is provided the default value will be the literal string “default value”.

Keep in mind that the := infers the data type.

## Function with Specified Return Type

You can declare what type of value is returned from the function using the `->` symbol and the return keyword:

### VOID

The `void` data type specifies that your function does not return back anything. When using the `void` data type, you do not have to provide the return keyword.

```GDScript
func simpleExample() -> void:
    return

func simpleExample() -> int:
    return 10

func simpleExample() -> float:
    return 2.13

func simpleExample() -> bool:
    return true
```

# Scope

The scope is the region of a computer program where a name binding is valid. Name binding is just a fancy word for saying “variables”.

Scopes can vary in range in a programming application.

These can be from small for loops and if statements to entire classes.

## Levels of Scope

- Global Scope
- Class/File/Module Scope
- Function Scope
- Code Block Scope

### Global Scope

Global scope is a class, variable, or function that can be used anywhere in the Godot Application.

An example would be the Node class:

```GDScript
extends Node

- The rest of your class
```

### Class Scope

A class scope is a variable or function that can be used anywhere in the class file.

```GDScript
extends Node -> Global Scope Class Name Node

- Class variables that can be used anywhere in the class file
var health: String = 100
var speed: float = 10.0
```

### Function Scope

A variable/value that can only be used inside of a function

```GDScript
extends Node # Global Scope Class Name Node

#Class Scope
var health: String = 100
var speed: float = 10.0

func example():
    # variable functionVariable can only be used inside of the function `example()`
    var functionVariable = 10
```

### Code Block Scope

A variable/value that can only be used inside of a code block.

Example for code blocks would be the if statement, match statement, for & while loops, etc:

```GDScript
extends Node - Global Scope Class Name Node

- Class Scope
var health: String = 100
var speed: float = 10.0

func example():
    - Function Scope
    var functionVariable = 10
    if(true):
        - Code Block Scope
        - variable message exists only inside this one if statement
        var message = "Hi!"
        print(message)
```

# Classes

Classes describe an aggregate of data fields such as variables and defines the operations, such as methods.

Think of a class as a blueprint for creating objects, with initial value states, and implementation behavior.

In `GDScript`, by default, all script classes are unnamed classes.

This means you can only reference a class by its relative path.

## Absolute Path

- Absolute Path on Windows: "C:\Data\Filepath"
- Relative Path through `GDScript`: "res://path/to/file.gd"

## Basic Class Format

Use the `extends` keyword in a class file to let Godot know which Global Godot class your script file inherits from.

The `extends` keyword determines what Node functions are available to you.

Classes can also have class/member variables and functions.

Class/member variables are available in the entire class file.

```GDScript
extends Node2D

var playerHealth: int = 100
var playerSpeed: float = 5.0

func getPlayerHealth() -> int:
    return playerHealth
```

If you omit the `extends` keyword, your class will inherit from the Reference global class:

## Extends from Global Reference Class

```GDScript
var playerHealth: int = 100
var playerSpeed: float = 5.0

func getPlayerHealth() -> int:
    return playerHealth
```

## Naming a Class

Use the `class_name` keyword to name a class and add it to the global scope.

The newly created class will be available in other `.gd` files and scenes in Godot.

- "player.gd"

```GDScript
extends Node2D

class_name Player

- class variables and functions
```

- "scene.gd"

```GDSCript
extends Node2D

var playerInstanceObject = Player.new()
```

## Class Inheritance

A `GDScript` class can inherit from the following:

- Global Class
- Another Class
- An Inner Class

To inherit from a class, use the `extends` keyword:

- animal.gd

```GDSCript
extends Node2D # Inherits from the Global Node2D class

class_name Animal
```

- horse.gd

```GDScript
extends Animal # Inherits from the Global Node2D class

class_name Horse
```

In this case, the Animal class is called a superclass, while the Horse class is called the subclass.

When a subclass inherits from a superclass, the subclass gets all the functions and class variables of the superclass.

### Overriding a Superclass Function

You can override a superclass function by merely writing out the function in the subclass.

- animal.gd

```GDScript
extends Node2D # Inherits from the Global Node2D class

class_name Animal

func attack() -> void:
    print("Animal Attacks")
```

- horse.gd

```GDScript
extends Animal

# Horse class has the health variable and the getHealth() method

class_name Horse

func attack() -> void:
    print("Horse Attacks") # Override function attack()
```

### Inner Class

An inner class is a class inside of a class.

```GDScript
extends Node

- class instance object
var object = InnerClass.new()

func _ready():
    var getInnerValue = object.getA()
    print(getInnerValue)

class InnerClass:
    - member variables
    var another = 100

    func getAnother():
        return another
```

## Class Objects

A class object is an instance of a class. A class object can also be referred to as a class instance, instanced object, or class object.

- player.gd

```GDScript
extends Node2D

class_name Player

- class variables and functions
```

- escene.gd

```GDScript
extends Node2D

var playerInstanceObject = Player.new()
```

## Class Constructors

The class constructor is a particular function in which it is called every time a class object is created.

You define a class constructor using the `_init()` method:

- player.gd

```GDSCript
extends Node2D

class_name Player

var playerHealth: int

_init(startingHealth:int = 100):
    playerHealth = startingHealth
```

- scene.gd

```GDScript
extends Node2D

var playerInstanceObject = Player.new(200)
print(playerInstanceObject.playerHealth) # 200
```

## Virtual Method

A virtual method is a method that can be redefined in a derived class.

It is used when a method’s basic functionality is the same, but sometimes more is needed in the derived class.

## Classes as a Data Type

A data type is an attribute of data that tells the compiler or interpreter how the programmer intends to use the data.

In Godot, `GDScript` classes are reference types (objects).

`var example: Node2D = Node2D.new() - variable example is a Node2D data type`

You are also able to cast data types:

`var example: Node = Node2D.new() as Node - cast Node2D instanced object as Node`

## Duck Typing

In programming, duck typing is a type system used in dynamic programming languages. The type or class of an object is less important than the method it defines.

With duck typing, you check if a class has a given method or attribute.

## The `is` Keyword

For duck typing and checking for null values, we will need to use the `is` keyword.

The `is` keyword is used to check the data type of a given object and returns a boolean value:

```GDScript
5 is int - true
Frog is Animal - Does the Frog Class inherit from the Animal Class and is not empty?
```

- Example

```GDScript
- Animal Class
extends Node
class_name Animal

func fly():
   print('Animal flies')

- Duck Class
extends Animal
class_name Duck

func fly():
   print('this duck flies')

- Circle Class
extends Node
class_name Circle

func fly():
   print('Circles are flying???')

- Node Class
extends Node2D

var animal = Animal.new()
var duck = Duck.new()
var circle = Circle.new()

- No Type Safety
"""
In this case we can pass it in everything and the function call will work
as long as the class object has that specific function name

letItFly(animal)
letItFly(duck)
letItFly(circle)
"""
func letItFly(flyingObject):
   flyingObject.fly()


- With Type Safety
"""
But what if we want type safety?
Say we only want Classes and Sub-Classes of the 'Animal' class???
"""
func animalFlies(animalObject: Animal):
   animalObject.fly() # comes with auto complete


"""
The problem is that an error will be thrown if the class is a null value

For Example:
   var nullObject: Animal - Null Instantiation w/ type safety

In this case nullObject will make it through the animalFlies() method without warning.
The game will crash when a null object tries to call the 'fly()' because it does not exist on a null object

In this case we have to check that null values are not sneaking through
"""

- Check for the objects casted as Nulls
var nullObject: Animal

func animalFliesSafely(animalObject: Animal):

   - Option 1
   if animalObject == null:
      print('object/value does not fly')
      return

   - Option 2
   if (animalObject is Animal) == false:
      print('Animal Class not part of Inheritance Chain')
      return

   - Do whatever you want; you're an animal!
   print('continue on ;)')
   animalObject.fly() - without a null check, throws an error if null
```

## Static Functions

A static function is a member function of a class that can be called even when an object has not been initialized.

A static class cannot access any variables of its class except for static variables.

Godot `GDSCript` does not have static variables.
You do not need to create a class instance to use a static function.

It’s best to use static functions when you don’t depend on any class members (variables).

- animal.gd

```GDScript
extends Node2D

class_name Animal

static func printHi() -> void:
    print("Hello!")
```

- other.gd

```GDScript
extends Node2D

_ready():

    Animal.printHi()
```

## Export Keyword

In Godot, class members can be exported to the Godot application using the `export` keyword.

A benefit of using the `export` keyword is that it’s easier to edit the values of member variables.

```GDScript
export var example = "Hello!"
```

The variable example will now be viewable in the Godot Application.

### Export with Data Type Safety

`export(String) var example`

The value will default to an empty string:

`export(int) var example`

The value will default to 0.

### Export with Enumeration

`export(int, "Up", "Down") var example`

The choices available are up or down, and the value will default to 0.

### Export with Integer Range

`export(int, 20) var example`

You can input a value between 0 - 20

`export(int, 10, 20) var example`

You can input a value between 10 - 20

## Setters & Getters

In programming, `setters` and `getters` are functions used to control the access of variables. They are quite useful when creating classes.

For each member variable, a `getter` function will return the variable value. The `setter` function will update or “set” a value to a member variable.

To create a setter/getter method, use the `setget` keyword followed the name of the setter and getter method.

`var <variable name> = <assignment value> setget <setter name> , <getter name>`

A Basic Getter/Setter Function:

```GDScript
extends Node
class_name Human

var uniqueName = "John" setget setFunction, getFunction

func setFunction(param1):
   uniqueName = param1

func getFunction():
   return uniqueName
```

You are also able to pick and choose whether a member variable will only use a `setter` or `getter` method.

To create only a `setter` method for a variable:

```GDScript
extends Node
class_name Human

var uniqueName = "John" setget setFunction

func setFunction(param1):
   uniqueName = param1
```

To use only a setter, start with adding a comma , followed by the name of the setter method:

```GDScript
extends Node
class_name Human

var uniqueName = "John" setget , getFunction

func getFunction():
   return uniqueName
```

## Memory Management

Game programming is part coding and part of memory management.

Understanding memory management can help you understand where problems are happening with your game. Such issues may include lag or random game freezes.

### Reference Class

In Godot `GDScript`, all classes that don’t define an inheritance through the extends keyword will inherit from the reference class by default.

The Reference class is the base class for any game object that keeps a reference count.

Reference counting is a memory management technique.

This means that the class will release itself from memory when it is no longer used.

This works because an object will be released from memory when the reference count is 0.

### Object Class

If you would like to have a game object stay in memory even when it is no longer being used, you will have to inherit from the Object class.

```GDScript
extends Object
```

To free a game object which inherits from the object class from memory, you will have to call the `free` method.

Many of Godot’s built-in Classes inherit from the Object class. This includes the `Node` class and the `Node2D` class.

Many problems beginners have when programming with Godot is freeing Nodes from memory.

- An example of freeing a Sprite Node from memory
- Sprite Node ultimately inherits from Object class

```GDScript
extends Sprite

class_name MainCharacter

_exit_tree():
    free() # unsafe
```

Another way of deleting from memory:

- An example of freeing a Sprite Node from memory
- Sprite Node ultimately inherits from Object class

```GDScript
extends Sprite

class_name MainCharacter

_exit_tree():
    queue_free() # safe
```

## Signals

Godot Offers a way to emit messages from one object to another through the use of signals.

To create a signal, you need to create an `observer` class and a `subject` class.

A `subject` class emits a `signal` to the `observer` class. In contrast, the `observer` class performs an action once it has received a `call/signal` from the `subject` class.

In a sense, the `subject` class is expected to fire a `signal`; an `observer` needs to subscribe to a `subject`.

Both the `subject` class and the `emitter` class must be present on the scene tree. That means both classes need to be a node on the scene tree.

`Subject_Class` -> sends a `signal` to -> `Observer_Class`

To create a Subject class, use the `signal` keyword.

`signal <signal name>`

To send signals to observables, you need to call the `emit_signal` method.

The emitted signal has one mandatory argument and optional argument if you want to pass data to the observables.

`emit_signal(<signal name>, <optional data to pass>)`

To create an observable, you need to create a variable instance of the Node on the scene tree, followed by calling the signals `connect` method.

The `connect` method takes in 3 mandatory arguments and additional optional arguments if you want to pass data to the observables.

`connect(<signal name>, <node you want to call function in>, <function to call>)`

Let’s take a look at a complete example:

- Subject Class
- Name in Scene: Player
- node Type: Sprite

```GDScript
extends Sprite
signal healthChanged # create the signal called healthChanged

var check: int = 0
var playerHealth: int = 100

func _process(deltaTime):
    if check < 1:
    check = check + 1
    changeHealth(-100)

func changeHealth(value):
    playerHealth = playerHealth + value
    emit_signal("healthChanged", playerHealth)
```

In this example, we have a Node on the Scene tree called Player, and we would like to create a signal that emits every time the players' health has changed.

On top of that, we pass the value of the players current health to the observables.

In this case, we want to know when the method called `changeHealth(value)` has been called.

The Player Node is considered the subject class.

- Oberver Class
- Name in Scene: Health
- node Type: Node2D

```GDScript
extends Node2D

onready var PlayerNode = get_node('Player')

func _ready():
    PlayerNode.connect("healthChanged", self, "doSomething")

func doSomething(playerHealth):
    print('We changed value of health to: ', playerHealth)
```

The script above is attached to the scene in a Node called Health.

You create an instance to the Player node with `onready var PlayerNode = get_node('Player')`.

Then you connect to its signal with `PlayerNode.connect("healthChanged", self, "doSomething")`.

# Coroutines and Yield

- Coroutines: A computer component that generalizes subroutines for non-preemptive multitasking by allowing execution to be suspended and resumed.
- Subroutines: a set of instructions designed to perform a frequently used operation within a program

## Sequential Processing

Sequential processing runs code line by line in sequence, from start to finish in the order it is received in.

In `GDScript`, your code runs sequentially unless otherwise specified (threads).

Let’s take a look at this example:

```GDScript
func _ready():
    addHealth(10)
    print('finished!')

func addHealth(lifePoints):
    print('lifePoints called!')
```

## How to use Coroutines

To use coroutines, you will need to use two methods, the `yield` method and the `resume` method.

The `yield` method pauses a function, while the `resume` method will continue the yielded method.

```GDScript
func _ready():
    var pausedFunction = addHealth(10)
    print('finished!')
    pausedFunction.resume() - resume the addHealth call

func addHealth(lifePoints):
    yield() - pause the function
    print('lifePoints called!')
```

# Threads

Thread is short for thread execution. It is a way for a program to divide itself into two or more simultaneously running tasks.

Threads are a form of concurrent processing, often referred to as multi-tasking. They are used to balance the processing power across CPU’s and cores.

Concurrency is when the execution of multiple tasks is interleaved. Compared to being executed sequentially one after another.

To create a thread, you will need to instantiate a class from the `Thread` global class.

To start a thread, you will need to use the threads `start` method.

```GDScript
var thread = Thread.new()
thread.start(<Object Instance>, <String Method>)
```
