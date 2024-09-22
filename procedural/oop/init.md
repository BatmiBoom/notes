# What is Object-Oriented Programming?

Object Oriented programming, or "OOP" for short, is a way of writing code that relies on the concepts of classes and objects. The main benefit of writing your code in an object-oriented way is to structure your program into simple, reusable pieces of code.

## Clean Code

Object-oriented programming and other paradigms like functional programming are all about making code easier to work with and understand. We call code that is easy to work with "clean code".

Clean code is not

- A way to make your programs run faster
- A way to make your program use less memory
- Necessary to create certain kinds of programs
- Something unique to OOP

Clean code is

- Designed to make code easier to work with in many situations
- Something that helps humans model the real world
- A way to make finding and fixing bugs easier
- A way to make new feature development faster
- The best way to stay sane as a software engineer

## DRY Code

Don't repeat yourself (DRY)

We don't want too much of our code doing the same thing. When code is duplicated, it leads to many potential problems.

It's not a big deal when two lines are the same and exist right next to each other. However, imagine if we had done this several hundred times in ten or twenty different code files! All of the sudden, it makes a lot of sense to stop repeating yourself and write more reusable functions. We call that DRY code.

You should avoid writing the same code in multiple places. Repeating code can be bad because:

- If you need to change it, you have to change it in multiple places
- If you forget to change it in one place, you'll have a bug
- It's more work to write it over and over again

## Classes

A class is a special type of value in an object-oriented programming language like Python. Just like a string, integer or float, a class is essentially a custom type that has some special properties.

An object is an instance of a class type. In this example, health is an instance of an integer type.

`health = 50`

In object-oriented programming, we create special types called "classes". And each instance of a class is called an "object".

### Create

In Python, you just need to use the class keyword, and you can set custom properties in the following way. It is a common convention in Python to capitalize the first character in the name of your class.

```python
class Soldier:
    health = 5
```

Then to create an instance of a Soldier we simply call the class. Notice that a class isn't a function. It doesn't take input parameters directly.

```python
first_soldier = Soldier()
print(first_soldier.health) # prints "5"
```

### Methods

What makes classes cool is that they allow us to define custom methods on them. A method is a function that is associated with a class, and it has access to all the properties of the object.

```python
class Soldier:
    health = 5

    def take_damage(self, damage):
        self.health -= damage

soldier_one = Soldier()
soldier_one.take_damage(2)
print(soldier_one.health) # prints "3"
```

#### The specia "self" value

As you can see, methods are nested within the class declaration. Methods always take a special parameter as their first argument called self. The self variable is a reference to the object itself, so by using it you can read and update the properties of the object.

Notice that methods are called directly on an object using the dot operator.

#### Methods can return values

If a normal function doesn't return anything, it's typically not a very useful function. In contrast, methods often don't return anything explicitly because they may mutate the properties of the object instead. That's exactly what we did in the last assignment.

However, they can return values!

```python
class Soldier:
    armor = 2
    num_weapons = 2

    def get_speed(self):
        speed = 10
        speed -= self.armor
        speed -= self.num_weapons
        return speed

soldier_one = Soldier()
print(soldier_one.get_speed()) # prints "6"
```

#### Constructors ( or Initializers )

It's quite rare in the real world to see a class that defines properties in the way we've been doing it.

```python
class Soldier:
    name = "Legolas"
    armor = 2
    num_weapons = 2
```

It's much more practical to use a constructor. In Python, the constructor is the **init**() method, and it is called when a new object is created.

So, with a constructor, the code would look like this.

```python
class Soldier:
    def __init__(self):
        self.name = "Legolas"
        self.armor = 2
        self.num_weapons = 2
```

However, because the constructor is a method, we can now make the name, starting armor and number of weapons configurable with some parameters.

```python
class Soldier:
    def __init__(self, name, armor, num_weapons):
        self.name = name
        self.armor = armor
        self.num_weapons = num_weapons

soldier = Soldier("Legolas", 5, 10)
print(soldier.name) # prints "Legolas"
print(soldier.armor) # prints "5"
print(soldier.num_weapons) # prints "10"
```

Instance : In object-oriented programming, an instance is a concrete occurrence of any object... "Instance" is synonymous with "object" as they are each a particular value... "Instance" emphasizes the distinct identity of the object. The creation of an instance is called instantiation.

#### Class Variables vs Instance Variables

Instance Variables:

Instance variables vary from object to object and are declared in the constructor.

```python
class Wall:
    def __init__(self):
        self.height = 10

south_wall = Wall()
south_wall.height = 20 # only updates this instance of a wall
print(south_wall.height) # prints "20"

north_wall = Wall()
print(north_wall.height) # prints "10"
```

Class Variables:

Class variables remain the same between instances of the same class and are declared at the top level of a class definition.

```python
class Wall:
    height = 10

south_wall = Wall()
print(south_wall.height) # prints "10"

Wall.height = 20 # updates all instances of a Wall

print(south_wall.height) # prints "20"
```

Generally speaking, stay away from class variables. Just like global variables, class variables are usually a bad idea because they make it hard to keep track of which parts of your program are making data updates. However, it is important to understand how they work because you may see them out in the wild.

## OOP CONCEPTS

### Encapsulation

Encapsulation is one of the strongest tools in your tool belt as a software engineer. As we covered in chapter one, writing code that machines understand is easy, but writing code that humans can understand is very difficult.

Encapsulation is the practice of hiding information inside a "black box" so that other developers working with the code don't have to worry about it.

A basic example of encapsulation is a function. The caller of a function doesn't need to worry too much about what happens inside, they just need to understand the inputs and outputs.
`acceleration = calc_acceleration(initial_speed, final_speed, time)`

#### Encapsultion in OOP

In the context of object-oriented programming, we can practice good encapsulation by using private and public members. The idea is that if we want the users of our class to interact with something directly, we make it public. If they don't need to use a certain method or property, we make that private to keep the usage instructions for our class simple.

#### Encapsulation in Python

To enforce encapsulation in Python, developers prefix properties and methods that they intend to be private with a double underscore.

```python
class Wall:
    def __init__(self, height):
        # this stops us from accessing the __height
        # property directly on an instance of a Wall
        self.__height = height

    def get_height(self):
        return self.__height
```

Python is a very dynamic language, and that makes it difficult for the interpreter to enforce some of the safeguards that languages like Go do. That's why encapsulation in Python is achieved mostly by convention rather than by force

Prefixing methods and properties with a double underscore is a strong suggestion to the users of your class that they shouldn't be touching that stuff. If a developer wanted to break convention, there are ways to get around the double underscore rule.

### Abstraction

Abstraction is one of the key concepts of object-oriented programming. The goal of abstraction is to handle complexity by hiding unnecessary details. As you can see, abstraction and encapsulation typically go hand in hand, and if we aren't careful with our definitions, they can seem like the same thing.

#### Abstraction vs encapsulation

While definitions are always changing, I like to think about abstraction and encapsulation in the following way.

Abstraction is a technique that helps us identify what information and behavior should be encapsulated, and what should be exposed.

Encapsulation is the technique for organizing the code to encapsulate what should be hidden, and make visible what is intended to be visible.

So are we encapsulating or abstracting our code when we make private data and methods?

Both. Almost always we are doing both. The process of using the double underscore is an encapsulation method. The process of deciding which data deserves to be hidden behind the double underscore is an abstraction. Let's look at a concrete example.

```python
import random

my_random_number = random.randrange(5)
```

In this example, we're using the random library to generate a random number. As it turns out, generating random numbers is a really hard problem. The operating system actually uses the physical hardware state of the computer as an input to seed the randomness. However, the developers of the random library have abstracted that complexity away and encapsulated a lot of that data and behavior so we don't need to worry about it. We just say "I want a random number from 0 to 4" and the library takes care of it for us.

The decision to take a single number as input to the randrange function was a decision of abstraction. When writing production-level software, getting the abstractions right is crucial, because they are the hardest things to change later. Think about the consequences of the random package maintainers changing the input parameters to the randrange function! It would break code all over the world.

### How OOP Developers Think

As we saw in the last exercise variables can be private, but methods can be private as well. In other words, we can encapsulate behavior as well as data.

#### Grouping Data and Behavior

Classes in object-oriented programming are all about grouping data and behavior together in one place: an object. Object-oriented programmers tend to think about programming as a modeling problem. They think, "how can I write a Human class that simulates the data and behavior of a real human?"

### Inheretance

We've made it to the Holy-grail of object-oriented programming: inheritance. Inheritance is the defining trait of object-oriented languages. Non-OOP languages like Go and Rust provide encapsulation and abstraction features as almost every language does. Inheritance on the other hand tends to be unique to class-based languages like Python, Java, and Ruby.

#### What is inheretance

Inheritance allows one class (aka "the child class") to inherit the properties and methods of another class (aka "the parent class").

This powerful language feature helps us avoid writing a lot of the same code twice. It allows us to DRY (don't repeat yourself) up our code.

In Python, one class can inherit from another using the following syntax.

```python
class Animal:
    # parent "Animal" class

class Cow(Animal):
    # child class "Cow" inherits "Animal"
```

To use the constructor of the parent class, we can use Python's built-in super() method.

```python
class Animal:
    def __init__(self, num_legs):
        self.num_legs = num_legs

class Cow(Animal):
    def __init__(self):
        # call the parent constructor to
        # give the cow some legs
        super().__init__(4)
```

#### When i should use inheritance?

Inheritance is a powerful tool, but it is a really bad idea to try to overuse it. Inheritance should only be used when every instance of the child class can also be considered the same type as the parent class.

When a child class inherits from a parent, it inherits everything. If you only want to share some functionality, inheritance probably is not the best answer. In that case, you would probably just want to share some functions, or maybe make a new parent class that both classes inherit from.

#### Inheretance Hierarchy

There is no limit to how deeply we can nest an inheritance tree. For example, a Cat can inherit from an Animal that inherits from LivingThing. That said, we should always be careful that each time we inherit from a base class the child is a strict subset of the parent. You should never think to yourself "my child's class needs a couple of the parent's methods, but not these other ones" and still decide to inherit from that parent.

#### Multiple chidren

So far we've worked with linear class inheritance. In reality, inheritance structures often form trees, not lines. A class can have as many direct child classes as the programmer wants.

### What is Polymorphism?

While inheritance is the most unique trait that object-oriented languages claim to have, polymorphism is probably the most powerful.

Polymorphism is the ability of a variable, function or object to take on multiple forms. For example, in a programming language that supports inheritance, classes in the same hierarchical tree may have methods with the same name but different behaviors.

```python
class Creature():
    def move(self):
        print("the creature moves")

class Dragon(Creature):
    def move(self):
        print("the dragon flies")

class Kraken(Creature):
    def move(self):
        print("the kraken swims")

for creature in [Creature(), Dragon(), Kraken()]:
    creature.move()
# prints:
# the creature moves
# the dragon flies
# the kraken swims
```

In this example, the child classes, Dragon and Kraken are overriding the behavior of their parent class's move() method.

Take a look at the Greek roots of the word "polymorphism".

- "poly" means "many".
- "morph" means "to change" or "form".

Polymorphism in programming is the ability to present the same interface (function or method signatures) for many different underlying forms (data types).

A classic example is a Shape class that Rectangle, Circle, and Triangle can inherit from. With polymorphism, each of these classes will have different underlying data. The circle needs its center point coordinates and radius. The rectangle needs two coordinates for the top left and bottom right corners. The triangle needs coordinates for the corners.

By making each class responsible for its data and its code, you can achieve polymorphism. In the shapes example, each class would have its own draw_shape() method. This allows the code that uses the different shapes to be simple and easy, and more importantly, it can treat shapes as the same even though they are different. It hides the complexities of the difference behind a clean abstraction.

```python
shapes = [Circle(5, 5, 10), Rectangle(1, 3, 5, 6)]
for shape in shapes:
    print(shape.draw_shape())
```

This is in contrast to the functional way of doing things where you would have had separate functions that have different function signatures, like draw_rectangle(x1, y1, x2, y2) and draw_circle(x, y, radius).

When overriding methods, use the same function signature

If you change the function signature of a parent class when overriding a method, it could be a disaster. The whole point of overriding a method is so that the caller of your code doesn't have to worry about what different things are going on inside the methods of different object types.

### Operator Overloading

Another kind of built-in polymorphism in Python is the ability to override how an operator works. For example, the + operator works for built-in types like integers and strings.

```python
print(3 + 4) # prints "7"

print("three " + "four") # prints "three four"
```

Custom classes on the other hand don't have any built-in support for those operators:

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

p1 = Point(4, 5)
p2 = Point(2, 3)
p3 = p1 + p2

# TypeError: unsupported operand type(s) for +: 'Point' and 'Point'
```

However, we can add our own support! If we create an **add**(self, other) method on our class, the Python interpreter will use it when instances of the class are being added with the + operator.

Here's an example:

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __add__(self, point):
        x = self.x + point.x
        y = self.y + point.y
        return Point(x, y)

p1 = Point(4, 5)
p2 = Point(2, 3)
p3 = p1 + p2
# p3 is (6, 8)
```

Now, when `p1 + p2` is executed, under the hood the Python interpreter just calls `p1.__add__(p2)`.

As we discussed in the last assignment, operator overloading is the practice of defining custom behavior for standard Python operators. Here's a list of how the operators translate into method names.

| Operation           | Operator | Method   |
| ------------------- | -------- | -------- |
| Addition            | +        | add      |
| Subtraction         | -        | sub      |
| Multiplication      | *       | mul      |
| Power               | \*\*     | pow      |
| Division            | /        | truediv  |
| Floor Division      | //       | floordiv |
| Remainder (modulo)  | %        | mod      |
| Bitwise Left Shift  | \<\<       | lshift   |
| Bitwise Right Shift | >>       | rshift   |
| Bitwise AND         | &        | and      |
| Bitwise OR          | |       | or       |
| Bitwise XOR         | ^        | xor      |
| Bitwise NOT         | ~        | invert   |

### Overloading built-in methods

Last but not least, let's take a look at some of the built-in methods we can overload in Python. While there isn't a default behavior for the arithmetic operators like we just saw, there is a default behavior for printing a class.

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y


p1 = Point(4, 5)
print(p1) # prints "<Point object at 0xa0acf8>"
```

That's not super useful! Let's teach instances of our Point object to print themselves. The **str** method (short for "string") lets us do just that. It takes no inputs but returns a string that will be printed to the console when someone passes an instance of the class to Python's print() function.

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __str__(self):
        return f"({self.x},{self.y})"

p1 = Point(4, 5)
print(p1) # prints "(4,5)"
```

Note: the `__repr__` method works in a similar way, you'll see it from time to time.
