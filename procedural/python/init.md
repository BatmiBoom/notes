# Python

Is a simple, intepreted and dinamically tpyed Language

Code = is just a series of instructions that computers can follow. Computers obey each instruction, one after another

Programs can be comprised of many instructions,

## Variables

Are how we store data in our program. A variable is a name that we define that will point to some data. For example, i could define a new variable called `my_height` and set its value to `100`.

### Creating Variables

To create a new variable in python:

```python
my_new_variable = 2
this_can_be_called_anything = 3
```

Variables are called variables because they can hold any value and that value can change

```python
acceleration = 10
acceleration = 20
```

### Math

```python
sum = a + b
difference = a - b
product = a * b
division = a / b
floor_division = a // b
exponents = 3 ** 2
modulo = 8 % 3
```

- Division produces a float
- Floor Division is like a normal division except the result is floored afterward, which means the remainder is removed. The result is an `integer` insted of a `float`
- Modulo operator is the remainder of the division

#### Scientific Notation

You can add the letter `e` or `E` followed by a positive or negative integer to specify that you're using scientific notation

```python
print(16e3)
# Prints 16000.0

print(7.1e-2)
# Prints 0.071
```

In a nutshell, the number following the `e` specifies how many places to move the decimal to the right for a positive number, or to the left for a negative number.

#### Binary Numbers

Binary Numbers are just "base 2" numbers. They work the same way as "normal" base 10 numbers, but with 2 symbols instead of 10

Each 1 in binary number represents a greater multiple of 2. In a 4-digit number, that means you have eight places, the four's place, the two's place, and the one's place. Similar to how in decimal you wuold have the thousandth's place, the hundredth's place, the ten's place, and the one's place

```
0001 = 1
0010 = 2
0011 = 3
0100 = 4
0101 = 5
0110 = 6
0111 = 7
1000 = 0
```

| 1   | 0   | 0   | 1   | 1   | 0   | 1   | 1   | Total |
| --- | --- | --- | --- | --- | --- | --- | --- | ----- |
| 128 | 0   | 0   | 16  | 8   | 0   | 2   | 1   | = 155 |

##### Bitwise "&" operator

Are similar to logical operators, but instead of operating on boolean values, they apply the same logic to all the bits in a value. For example, say you had the numbers `5` and `7` represented in binary. You could perform a bitwise `AND` operation an the result would be 5

0101 (5) & 1001 (7) = 0101 (5)

A `1` in binary is the same as `True`, while `0` is `False`. So really a bitwise operation is just a bunch of logical operations that are completed in tandem

Ampersand `&` is the bitwise `AND` operator in python. `AND` is the name of the bitwise operation, while ampersand `&` is the symbol for that operation.

```python
5 & 7 = 5
5 & 2 = 0
```

F = false
T = true

0101 & 0111 = FTFT = 0101 = 5
0101 & 0010 = FFFF = 0000 = 0

##### Bitwise "|" operator

The bitwise `OR` operator

0101 | 0111 = FTTT = 0111 = 7
0101 | 0010 = FTTT = 0111 = 7

##### Binary Notation

When writing a nmber in binary, the prefix `0b` is used to indicate that what follows is a binary number.

- 0b0101 = 5
- 0b0111 = 7

### Basic Variable Types

#### String Type

"strings" are raw text in coding speak. They are calle "strings" because they are a list of characters strung together. Strings are declared in Python by using double quotes.

```python
name_with_single_quotes = 'boot.dev'
name_with_double_quotes = "boot.dev"
```

#### Split

The .split() method is called on a string. If you don't pass it any arguments, it will just split the words in the string on the whitespace.

```python
message = "hello there sam"
words = message.split()
print(words) # Prints: ["hello", "there", "sam"]
```

#### Numeric Types

Numbers are surrounded by quotes when created, but they can have decimals and negative signs

##### Integer

`x = 5`

##### Float

`x = 5.2`

When we need to compare for min or max, float has an interesting function

````python
negative_infinity = float('-inf') # Starter for max
positive_infinity = float('inf') # Starter for min

#### Boolean Type

A "boolean" or "bool" is a type that can only have one of two values: `True` and `False`. As you may have heard computers really only use 1's and 0's. These 1's and 0's are just `Boolean` values

0 = False
1 = True

```python
is_tall = True
````

#### NoneType Variables

Not all variables have a value. We can declare an "empty" variable by setting it to `None`

### Dynamic Typing

Python is dynamically typed. All this means is that a variable can store any type, and that type can change

### Multi-variable declaration

`sword_name, sword_damage, sword_lenght = "Excalibur", 10, 200`

## Functions

Functions allow us to reuse and organize code. For example, say we've written some code that calculates the area of a circle, we can define a new function called area_of_circle using the `def` keyword.

```python
def area_of_circle(r):
    pi = 3.14
    result = pi * r * r
    return result
```

Functions can hace multiple parameters (which is just a fancy name for "inputs"). For example:

```python
def subtract(a, b):
    result = a - b
    return result
```

**You can not call a function until after the definition**

### Order of functions

All functions must be defined before they're used.
You might think this would make structuring python code hards because the order of the functions needs to be just right. As it turns out, there's is a simple trick that makes it super easy.

Most python developers solve this problems, by defining all the functions in their programm first, the finally calling the "entry point" function last. Conventionally this "entry point" function is usually called main to keep things simple and consistent

```python
def main():
    health = 10
    armor = 5
    add_armor(health, armor)

def add_armor(h, a):
    new_health = h + a
    print_health(new_health)

def print_health(new_health):
    print(f"The player now has {new_health} health")

# call entrypoint last
main()
```

When no return value is specified in a function, it will automatically return `None`.

```python
def my_func():
    print("I do nothing")
    return None

def my_func():
    print("I do nothing")
    return
```

### Multiple return values

1. We can return more than one value from a function
1. When we call this function, we need to assing all the returned values to an equal number of variables by seprating them with commas.

```python
# returns email, age, and status of the user
def get_user():
    return "name@domain.com", 21, "active"

email, age, status = get_user()
```

### Parameters vs Arguments

Parameters are the names used for inputs when defining a function. Arguments are the names of the inputs supplied when a function is called.

To reiterate, arguments are the actual values that go into the function, say 42.0, "the dark knight", or True. Parameters are the names we use in the function definition to refer to those values, which at the time of writing the function, could be anything.

### Default Values for function arguments

Python has a way to specify a default value for function arguments. This can be convenient if a function has arguments that are essentially "optional", and you as the function creator want to use a specific default value in case the caller doesn't provide one.

A default value is created by using the assignment (=) operator in the function signature.

```python
def get_greeting(email, name="there"):
    print("Hello", name, "welcome! You've registered your email:", email)
```

If the second parameter is omitted, the default "there" value will be used in its place. As you may have guessed, for this structure to work, optional arguments that have defaults specified come after all the required arguments.

### Scope

Scope refers to where a variable or function name is available to be used. For example, when we create variables in a function (by giving names to our parameters for example), that data is not available outside of that function.

```python
def subtract(x, y):
    return x - y
result = subtract(5, 3)
print(x)
```

When the subtract function is called, we assign 5 to the variable x, but x only exists in the code within the subtract function. If we try to print x outside of that function, then we won't get a result. In fact, we'll get a big fat error.

#### Global Scope

So far we've been working in the global scope. That means that when we define a variable or a function, that name is accessible in every other place in our program, even within other functions.

For example:

```python
pi = 3.14

def get_area_of_circle(radius):
    return pi * radius * radius

```

Because pi was declared in the parent "global" scope, it is usable within the get_area_of_circle() function.

### Process for solving hard coding problems

1. Read the lesson first! Figure out the examples before writing your own code.
1. Read the assignment. Understand the goal of the assignment before you start writing code.
1. Start writing code.
1. Add print() statements. Don't wait until you've written a lot of code to start testing. Add print() statements and use the Run button to see if your code is doing what you expect at each step. It's easier to find issues in small bits of code than in large blocks of code.
   Keep running, printing, and fixing until you're confident your code is working.
1. Submit your code. If the assignment you're working on has unit tests, no need to remove your debugging print() statements. If the assignment you're working on is testing console output, be sure to remove your print() statements before submitting.
1. Compare your code to the instructor's. You will not be penalized for looking at the solution after you have successfully completed the assignment.

### Stack trace

A stack trace (or "traceback") is a scary-looking error message that the Python interpreter prints to the console when it encounters certain problems. Stack traces are most common (at least for you right now) when you're trying to run invalid Python code.

You need to get used to figuring out scary error messages as a programmer. We might as well start now.

```python
PythonError: Traceback (most recent call last):
  File "<exec>", line 5, in <module>
  File "<string>", line 1, in <module>
  File "/home/pyodide/main.py", line 3
    msg = f"You have {strength} strength, {wisdom} wisdom, and {dexterity} dexterity for a total of {total} stats.
                                                                                                                  ^
IndentationError: unindent does not match any outer indentation level
```

### Comparison operators

When coding its necessary to be able to compare two values. `Boolean logic` is the name for these kind of comparison operations that always result in `True` or `False`

The operators:

- `<` "less than"
- `>` "greater than"
- `<=` "less than or equal to"
- `>=` "greater than or equal to"
- `==` "equal to"
- `!=` "not equal to"

### If statements

its often useful to only execuet code if a certain condition is met:

```python
if CONDITION:
    # do some stuff here

# code after the if block will run regardless

# e.g
if bob_score > bill_score:
    print("Bob Wins!")
print("Game complete")
```

#### If-else

An if statement can be followed by zero or more elif (which stands for "else if") statements, which can be followed by zero or one else statement. For example:

```python
if score > high_score:
    print('High score beat!')
elif score > second_highest_score:
    print('You got second place!')
elif score > third_highest_score:
    print('You got third place!')
else:
    print('Better luck next time')

```

### Loops

Loops are a programmer's best friend. Loops allow us to do the same operation multiple times without having to write it explicitly each time.

A "for loop" in Python is written like this:

```python
for i in range(0, 10): # right side not inclusive
    print(i)

# prints 0 1 2 3 4 5 6 7 8 9
```

#### Range continued

The range() function we've been using in our for loops actually has an optional 3rd parameter: the "step".

```python
for i in range(0, 10, 2):
    print(i)

# prints 0 2 4 6 8
```

The "step" parameter determines how much to add to i in each iteration of the loop. You can even go backwards:

```python
for i in range(3, 0, -1):
    print(i)

# prints: 3 2 1
```

### Lists

A natural way to organize and store data is in a List. Some languages call them "arrays", but in Python we just call them lists. Think of all the apps you use and how many of the items in the app are organized into lists.

Lists in Python are declared using square brackets, with commas separating each item:

`inventory = ["Iron Breastplate", "Healing Potion", "Leather Scraps"]`

Lists can contain items of any data type, in our example above we have a List of strings.

#### Indexes

Each item in a list has an index that refers to its spot in the list
`names = ["Bob", "Lane", "Alice", "Breanna"]`

- Index 0: Bob
- Index 1: Lane
- Index 2: Alice
- Index 3: Breanna

We access items in a list directly by using their index. Indexes start at 0 (the first item) and increment by one with each successive item. The syntax is as follows:

```python
best_languages = ["JavaScript", "Go", "Rust", "Python", "C"]
print(best_languages[1])
# prints "Go", because index 1 was provided
```

The length of a List can be calculated using the len() function.

```python
best_languages = ["JavaScript", "Go", "Rust", "Python", "C"]
print(len(best_languages))
# prints 5
```

The length of the list is equal to the number of items present. Don't be fooled by the fact that the length is not equal to the index of the last element, in fact, it will always be one greater.

#### Updates

We can also change the item that exists at a given index. For example, we can change Leather to Leather Armor in the inventory list in the following way:

```python
inventory = ["Leather", "Healing Potion", "Iron Ore"]
inventory[0] = "Leather Armor"
# inventory: ['Leather Armor', 'Healing Potion', 'Iron Ore']
```

#### Appending

It's common to create an empty list then fill it with values using a loop. We can add values to the end of a list using the .append() method:

```python
cards = []
cards.append("nvidia")
cards.append("amd")
# the cards list is now ['nvidia', 'amd']
```

##### Pop

.pop() is the opposite of .append(). Pop removes the last element from a list and returns it for use. For example:

```python
vegetables = ["broccoli", "cabbage", "kale", "tomato"];
last_vegetable = vegetables.pop()
# vegetables = ['broccoli', 'cabbage', 'kale']
# last_vegetable = 'tomato'
```

#### Counting the items on a list

Remember that we can iterate (count) over all the elements in a list using a loop. For example, the following code will print each item in the sports list.

```python
for i in range(0, len(sports)):
    print(sports[i])
```

#### No-index syntax

If you don't need the index number you can use the following syntax:

```python
trees = ['oak', 'pine', 'maple']
for tree in trees:
    print(tree)
# Prints:
# oak
# pine
# maple
```

tree, the variable declared using the in keyword, directly accesses the value in the list rather than the index of the value. If we don't need to update the item and only need to access its value then this is a more clean way to write the code.

#### Slicing Lists

Python makes it easy to slice and dice lists to work only with the section you care about. One way to do this is to use the simple slicing operator, which is just a colon :.

With this operator, you can specify where to start and end the slice, and how to step through the original. List slicing returns a new list from the existing list.

The syntax is as follows:
`my_list[ start : stop (not inclusive) : step ]`

```python
scores = [50, 70, 30, 20, 90, 10, 50]
print(scores[1:5:2])
# Prints [70, 20]
```

##### Omittings sections

You can also omit various sections ("start", "stop", or "step"). For example, numbers\[:3\] means "get all items from the start up to (but not including) index 3". numbers\[3:\] means "get all items from index 3 to the end".

Using only the step section

```python
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
numbers[::2] # Gives [0, 2, 4, 6, 8]

```

Negative indices

```python
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
numbers[-3:] # Gives [7, 8, 9]
```

#### Concatenate

Concatenating two lists (smushing them together) is easy in Python, just use the + operator.

```python
total = [1, 2, 3] + [4, 5, 6]
print(total) # [1, 2, 3, 4, 5, 6]
```

#### Contains

Checking whether a value exists in a list is also really easy in Python, just use the in keyword.

```python
fruits = ["apple", "orange", "banana"]
print("banana" in fruits) # True
```

#### Deletion

Python has a built-in keyword del that deletes items from objects. In the case of a list, you can delete specific indexes or entire slices.

```python
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]

# delete the fourth item
del nums[3]
print(nums) # Output: [1, 2, 3, 5, 6, 7, 8, 9]

# delete the second item up to (but not including) the fourth item
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
del nums[1:3]
print(nums) # Output: [1, 4, 5, 6, 7, 8, 9]

# delete all elements
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
del nums[:]
print(nums) # Output: []
```

#### Join

The .join() method is called on a delimiter (what goes between all the words in the list), and takes a list of strings as input.

```python
list_of_words = ["hello", "there", "sam"]
sentence = " ".join(list_of_words)
print(sentence)
# Prints: "hello there sam"
```

### Tuples

Tuples are collections of data that are ordered and unchangeable. You can think of a tuple as a List with a fixed size. Tuples are created with round brackets:

```python
my_tuple = ("this is a tuple", 45, True)
print(my_tuple[0]) # this is a tuple
print(my_tuple[1]) # 45
print(my_tuple[2]) # True
```

While it's typically considered bad practice to store items of different types in a List it's not a problem with Tuples. Because they have a fixed size, it's easy to keep track of which indexes store which types of data.

Tuples are often used to store very small groups (like 2 or 3 items) of data. For example, you might use a tuple to store a dog's name and age.

Note: There is a special case for creating single-item tuples. You must include a comma so Python knows it's a tuple and not regular parentheses.
`dog = ("Fido",)`

Because Tuples hold their data, multiple tuples can be stored within a list. Similar to storing other data in lists, each tuple within the list is separated by a comma. When accessing tuples the first index relates to which tuple you want to access, the second relates to the values within that tuple.

```python
my_tuples = [("this is the first tuple in the list", 45, True),("this is the second tuple in the list", 21, False)]
print(my_tuples[0][0]) # this is the first tuple in the list
print(my_tuples[0][1]) # 45
print(my_tuples[1][0]) # this is the second tuple in the list
print(my_tuples[1][2]) # False
```

### Dictionaries

Dictionaries in Python are used to store data values in key -> value pairs. Dictionaries are a great way to store groups of information.

```python
# use curly braces
# add key-value pairs
car = {
  "brand": "Tesla",
  "model": "3",
  "year": 2019
}
```

Because dictionaries rely on unique keys, you can't have two of the same key in the same dictionary. If you try to use the same key twice, the first value will simply be overwritten.

- Dictionaries are hash tables
- Dictionaries handle collisions gracefully, two distinct keys will never overwrite each other's values. If there is a collision that for some crazy, unlikely reason can't be handled, a failure is reported
- Hash tables are stored in contiguous blocks (the same place) in memory
- Each entry in the table is actually a combination of the three values: hash, key, value
- New dictionaries start with 8 slots and grow when they become 2/3 full

#### Accesing values:

```python
car = {
    'make': 'tesla',
    'model': '3'
}
print(car['make']) # Prints: tesla
```

#### Settings dictionaries values

You don't need to create a dictionary with values already inside. It is common to create a blank dictionary then populate it later using dynamic values. The syntax is the same as getting data out of a key, just use the assignment operator (=) to give that key a value.

```python
names = ["jack bronson", "jill mcarty", "john denver"]

names_dict = {}
for name in names:
    # .split() returns a list of strings
    # where each string is a single word from the original
    name_lst = name.split()

    # here we update the dictionary
    names_dict[name_lst[0]] = name_lst[1]

print(names_dict) # Prints: {'jack': 'bronson', 'jill': 'mcarty', 'john': 'denver'}
```

#### Updating dictionaries values

If you try to set the value of a key that already exists, you'll end up just updating the value of that key.

```python
full_names = ["jack bronson", "james mcarty", "jack denver"]

names_dict = {}
for full_name in full_names:
    # .split() returns a list of strings
    # where each string is a single word from the original
    names = full_name.split()
    first_name = names[0]
    last_name = names[1]
    names_dict[first_name] = last_name

print(names_dict)
# {
#   'jack': 'denver',
#   'james': 'mcarty'
# }
```

#### Deleting dictionarie values

You can delete existing keys using the del keyword.

```python
names_dict = {
    'jack': 'bronson',
    'jill': 'mcarty',
    'joe': 'denver'
}

del names_dict['joe']

print(names_dict) # Prints: {'jack': 'bronson', 'jill': 'mcarty'}
```

Notice that if you try to delete a key that doesn't exist, you'll get an error.

#### Checking for existence

If you're unsure whether or not a key exists in a dictionary, use the in keyword.

```python
cars = {
    'ford': 'f150',
    'tesla': '3'
}

print('ford' in cars) # Prints: True

print('gmc' in cars) # Prints: False
```

#### Iterating over a dictionary

```python
fruit_sizes = {
    "apple": "small",
    "banana": "large",
    "grape": "tiny"
}

for name in fruit_sizes:
    size = fruit_sizes[name]
    print(f"name: {name}, size: {size}")

# name: apple, size: small
# name: banana, size: large
# name: grape, size: tiny
```

As of Python version 3.7, dictionaries are ordered. In Python 3.6 and earlier, dictionaries were unordered.

### Sets

Sets are like Lists, but they are unordered and they guarantee uniqueness. Only ONE of each value can be in a set.

```python
fruits = {'apple', 'banana', 'grape'}
print(type(fruits)) # Prints: <class 'set'>

print(fruits) # Prints: {'banana', 'grape', 'apple'}
```

#### Add values

```python
fruits = {'apple', 'banana', 'grape'}
fruits.add('pear')
print(fruits) # Prints: {'banana', 'grape', 'pear', 'apple'}
```

Note: No error will be raised if you add an item already in the set.

#### Empty set

Because the empty bracket {} syntax creates an empty dictionary, to create an empty set, you need to use the set() function.

```python
fruits = set()
```

#### Iterate over values

```python
fruits = {'apple', 'banana', 'grape'}
for fruit in fruits:
    print(fruit)
    # Prints:
    # banana
    # grape
    # apple
```

### Errors and Exceptions in python

You've probably encountered some errors in your code from time to time if you've gotten this far in the course. In Python, there are two main kinds of distinguishable errors.

- syntax errors
- exceptions

#### Syntax Errors

A syntax error is just the Python interpreter telling you that your code isn't adhering to proper Python syntax.

#### Exceptions

Even if your code has the right syntax, however, it may still cause an error when an attempt is made to execute it. Errors detected during execution are called "exceptions" and can be handled gracefully by your code. You can even raise your own exceptions when bad things happen in your code.

Python uses a try-except pattern for handling errors.

```python
try:
  10 / 0
except Exception as e:
  print(e)

# prints "division by zero"
```

The try block is executed until an exception is raised or it completes, whichever happens first. In this case, a "divide by zero" error is raised because division by zero is impossible. The except block is only executed if an exception is raised in the try block. It then exposes the exception as data (e in our case) so that the program can handle the exception gracefully without crashing.

#### Syntax for raising an exception

An error or exception is raised when something bad happens, but as long as our code handles it as users expect it to, it's not a bug. A bug is when code behaves in ways our users don't expect it to.

`raise Exception("something bad happened")`
