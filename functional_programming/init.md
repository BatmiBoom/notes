# What is functional programming?

FP is a paradigm where programs compose functions rather than mutate state (setting and updating variables)

- Fp is mora about delcaring what you want to happen, rather than how you want it to happen
- Imperative (or procedural) programming declares what should happen, but also exactly how it should happen

Examples:

IMPERATIVE

```python
num = get_a()
num = transform_a(num)
num = transform_b(num)

return num
```

FUNCTIONAL

```python
return transform_b(transform_a(get_a()))
```

```python
def get_median_font_size(font_sizes):
    """
    Functional style.
    - Inmutable Variables
    - Sin Loops
    - Pure function
    """
    if not font_sizes:
        return None

    font_sizes = sorted(font_sizes)
    leng = len(font_sizes)
    print(font_sizes)
    middle = leng // 2
    if leng % 2 == 0:
        return (font_sizes[middle - 1] + font_sizes[middle]) / 2
    else:
        return font_sizes[middle]
```

The importante distinction is that in the functional example, we don't need to mutate the values of any variables
There is no statefulness ("state" : is simply the condition or quality of an entity at an instant time, and to be
stateful is to rely on these moments in time and to change the output given the determined inputs and state.)

## Functional vs OOP

FP is similta rto oop in the sense that its all about writing clean code that is easy to understand and maintain.
OOP and FP apporaches arent even really enemies! The core pillars of OOP are:

- Encapsulation
- Abstraction
- Inheritance
- Polymorphism

Of those four, the only one that really conflicts with FP is inheritance (and the mutable classes that typically come along with it).
The other three are perfectly compatible with FP, and FP use them all the time

## Immutability

A core tenet of functional programming is the data should be immutable. Once a value is created, it cannot be changed.
This is in contract to mutable data, wich can be changed after it is created

As a general rule, immutable data is easier to reason about. If you know that a value will never cange, you dont have to sit and puzzle
about its current state. You can just look at it and know what it is

### Tuples vs Lists

They are both store ordered-collections of values. The diference is that tuples are immutable and lists are mutable
You can append to a list, but you can not append to a tuple. Instead, you can concatenate tuples together to form a new tuple

```python
my_list = [1,2,3]
my_list.append(4)
```

```python
my_tuple = (1,2,3)
my_new_tuple = my_tuple + (4,)
```

### Declarative Programming

FP is about beign declarative. When practicing fp we prefer to declare what we want the computer to do, rather thant the exact step-by-step
impementation details.

### Scripting is imperative

In contrast, scripting is about beign imperative. When scripting, we write out the exact step-by-step implementation details

```python
import boto3

ec2 = boto3.resource('ec2')

instance = ec2.create_instances(
    ImageId = 'ami-asdasd',
    MinCount = 1,
    MaXCount = 1,
    InstanceType = 't2.micro',
)

print("Launched instance with id: {instance[0].id}")
```

### Classes vs Functions

#### Should I use functions or classes?

If you're unsure, default to functions. I typically find myself only reaching for classes when the data and behavior I'm trying to model fit naturally into a class-based approach. I've found this to more often be the case for things like games, simulations, and GUIs

- Classes encourage you to think about the worlds as a collection of objects.
  Objects bundle behavior, data, and state together in a way tht draws boundaries between instances of thing (like chess pieces on a board)
- Functions encourage you to think about the world as a series of transformatios on data.
  functions take data as input, transform it, and return it as output. E.x, a function might take the state of a chess board and move as input, and return the new state of the board as output

### Anonymous functions

AF are true to form in that they have no name. In Python, we call these lambda functions after lambda calculus.

```python
lambda x: x+1
```

This is a function that takes in a single argument x and returns the result of x + 1. We can assign this function to a variable and call it like any other funtion.

```python
add_one = lambda x: x + 1
print(add_one(2))
```

This allows us to create functions on the fly and pass them around as data! Its functions as values.

Example of lambda in use

```python
def categorize_file(filename):
    categories = {
        '.txt' : 'Text',
        '.docx' : 'Document',
        '.py' : 'Code',
    }

    get_category = lambda extension: categories.get(extension, 'Unknown')

    return get_category(filename[filename.rfind(".") :])
```

### First Class and Higher Order Functions

A progamming language is said to support first-class functions when functions in that language are treated like any other variable.
That function can be passed as an argument to other functions, can be returned by another function and can be assigned as a value to a variable

- First-class function: A function that is treated like any other value
- High-order functoin: A function that accepts another function as an argument or returns a function

#### First-Class Example

```python
def square(x):
  return x * x

f = square

print(f(5))
```

#### Higher-Order Example

```python
def square(x):
  return x * x

def my_map(func, arg_list):
  result = []
  for i in arg_list:
    result.append(func(i))

  return result

squares = my_map(square, [1,2,3,4,5])
print(squares)
```

#### Map

"Map", "filter" and "reduce" are three functions that are commonly used in functional programming.
They are also the names of three most common high-order functions in fp languages

In python, the built-in map function takes a function and an iterable, and returns a new iterable where the function has been applied to each element of the original iterable
This allows us to compose functions that operate on entire lists without having to write a loop and store state in variables.

```python
def square(x)
  return x * x

nums = [1,2,3,4,5]
squared_nums = map(square, nums)
print(list(squared_nums))
```

Example

```python
def change_bullet_style(document):
    return "\n".join(map(convert_line, document.split("\n")))

def convert_line(line):
    old_bullet = "-"
    new_bullet = "*"
    if len(line) > 0 and line[0] == old_bullet:
        return new_bullet + line[1:]
    return line
```

```python
def remove_invalid_lines(document):
    return "\n".join(filter(lambda x: not x.startswith("-"), document.split("\n")))
```

#### Reduce

The `functools.reduce()` function is a function that takes a function and a list of values, and applies the function to each value in the list, accumalting a result as it goes.

Example:

```python
import functools

def add(sum, y):
    return sum + y

numbers = [1, 2, 3, 4, 5]
sum = functools.reduce(add, numbers)
```

```python
import functools

def accumulate(doc, sentence):
    return f"{doc}. {sentence}"

def accumulate_first_sentences(sentences, n):
    if n <= 0 or not sentences:
        return ""

    return functools.reduce(accumulate, sentences[:n]) + "."
```

#### Intersect

The `set_a.intersection(set_b)` of two sets is a new set that contains all of the elements that are in both original sets

Example:

```python
def get_common_formats(formats1, formats2):

    return set(formats1).intersection(set(formats2))
```

#### Zip

The `zip()` function takes to iterables, and returns a new iterable where each element is a tuple containing one element from each of the original iterables. The iterables need to be the same len

Example:

```python
valid_formats = [
    "docx",
    "pdf",
    "txt",
    "pptx",
    "ppt",
    "md",
]

def pair_document_with_format(doc_names, doc_formats):
    result = list(zip(doc_names, doc_formats))

    return filter(lambda x: x[1] in valid_formats, result)
```

### Pure Functions

A pure function is a function that has two properties:

- Return the same result if given the same arguments. They are deterministic.
- Do not change the external state of the program. For example, they do not change any variables outside of their scope
- Do not perform any I/O operations (like reading from disk, accesing the internet, or writing from the console)
- Do not call any functions that do any of the above

Example:

```python
import random

def multiply_by2(nums): # Pure f
    products = []
    for num in nums:
        products.append(num*2)
    return products

balance = 1000
cars = []

def buy_car(new_car): # Impure f: modifies global state
    cars.append(new_car)
    balance -= 69

def roll_die(num_sides): # Impure f: Does not return the same result if given the same result
    return random.randint(1, num_sides)

```

#### Reference vs Value

Depending on the type of value you pass into a function in Python, the function will either be able to mutate the original value or not. This is because Python passes some values by reference and others by value

- Pass by reference: A function can mutate the origina value that was passed into it
- Pass by value: A function can not mutate the original value that was passed into it, it gets a copy

Types passed by reference:

- Lists
- Dictionaries
- Sets

Types passed by value:

- Integers
- Floats
- Strings
- Booleans
- Tuples

#### Input and output

I/O = we are talking about the parts of our program that interact with the outside world. Outside world just means anything that's not in-memory of our running program

Examples:

- Reading/Writing from a file on the hard drive
- Making a network request across the internet
- Reading/Writing from a database
- Even simply printing to the console is considered io!

### NO-OP

It's easy to tell that a function is impure if it doesn't return anything. If a function doesnt return anything, the only reason to call it, is for its side effects

If a pure function dont return anything, it's a no-op, or no operation, which is a fancy way of saying that it doesnt do anything, and it therefore useless

#### Useless NO-OP

```python
def square(x):
    x * x
```

#### Useful side-effect (but-impure)

```python
y = 5
def add_to_y(x): # Changes the value of y (global scope variable) pass by value because primitive
    y += x
```

Assignment:

```python
def markdown_to_text(doc_content):
    first_step = list(map(remove_pound_character_from_sentence, doc_content.split("\n")))
    second_step = map(remove_asterisks_from_words, first_step)

    return "\n".join(second_step)


def remove_pound_character_from_sentence(sentence):
    return sentence.lstrip("# ")

def remove_asterisks_from_words(sentences):
    return " ".join(map(remove, sentences.split(" ")))

def remove(word):
    if len(word) > 1:
        return word.strip("*")

    return word
```

#### Memoization

As its core, memoization is just a specific type of caching. Its when we cache (store a copy of) the result of a computation so taht we dont have to compute it again in the future

For example

```python
def add(x,y):
    return x + y
```

The call to `add(5,7)` will always resolve to the value of 12. Once we know that `add(5,7)` can be replaced with 12, we can just store the value `12` somewhere so that we dont have to compute it again in the future

```python
def word_count_memo(document, memos):
    m = memos.copy()

    if document in m:
        return m[document], m

    m[document] = word_count(document)
    return m[document], m

def word_count(document):
    count = len(document.split())
    return count
```

#### Referential Transparency

A great thing about pure functions is that they're always referentially transparent. That's just a fancy way of saying "you can replace a function call with its would-be return value because its the same every time".

Memoization is a trafeoff. Between memory and speed. If you have a function thats called often, but its not very expesive to compute, then its probably not worth memoizing because you'll be bloating the amount of ram your program uses storing the results of the function

### Rescursion

Is a famously tricky concept to grasp. A recursive function is simply a function that calls itself

```python
def sums(nums):
    if len(nums) == 0 # Base Case -> In this case, end of list
        return 0

    # add the first number to the sum of the rest of the numbers
    return nums[0] + sum(nums[1:])
```

Lets break it down

#### Base Case

The "base case" of a recursive function is the part of the function that does not call itself. its what stops the insanity. Without a base case, a recursive function would call itself forever.
In the example above, we know we've reached the end of the list, so we return 0 to stop the recursion:

```python
if len(nums) == 0:
    return 0
```

#### Solve a small problem

We take a small step towards solving the problem. In this case, we add the first number in the list to the sum of the rest of the numbers `return nums[0] + sums(nums[1:])`

#### Recurse

Finally, we need to actually call the function again, but with a smaller input, In this case, we call `sum` with the rest of the numbers in the list `return nums[0] + sums(nums[1:])`

Example : Factorial of n! = ex `5! = 5 * 4 * 3 * 2 * 1`

```python
def factorial(n):
    if n == 1:
        return 1

    return n * factorial(n - 1)
```

```python
def zipmap(keys, values):
    if not keys or not values:
        return {}

    dict = zipmap(keys[1:], values[1:])

    dict[keys[0]] = values[0]
    return dict

zipmap(["name", "age", "city"], ["Alice", 25, "Wonderland"])
```

#### Recursion on a tree

Recursion is often used in "tree-like" structures. For example, its often used to iterate over nested python dictionaries, classes that link to one another or files in a nested directory file system

```python
def list_files(current_node, current_path=""):
    file_list = []
    for node in current_node:
        node_vals = current_node[node]
        if node_vals is None:
            file_list.append(current_path + "/" + node)
        else:
            file_list.extend(list_files(node_vals, current_path + "/" + node))
    return file_list

test = {
    "Documents": {
        "Proposal.docx": None,
        "Report": {"AnnualReport.pdf": None, "Financials.xlsx": None},
    },
     "Downloads": {"picture1.jpg": None, "picture2.jpg": None},
}
list_files(test)
```

```python
def count_nested_levels(nested_documents, target_document_id, level=1):
    for id in nested_documents:
        if id == target_document_id:
            return level
        found_level = count_nested_levels(nested_documents[id], target_document_id, level + 1)
        if found_level != -1:
            return found_level
    return -1

nested_docs = {1: {2: {3: {}, 4: {5: {}}}, 6: {}, 7: {8: {9: {10: {}}}}}}

count_nested_levels(nested_docs, 3, 3)
```

```python
def reverse_string(s):
    new_string = ""
    if not s:
        return new_string

    return reverse_string(s[1:]) + s[0]
```

### Functoin Transformation

A function that takes in a function (or functinos) as input, and returns a new function

```python
def multiply(x, y):
    return x * y

def add(x, y):
    return x + y

def self_math(math_func):
    def inner_func(x):
        return math_func(x, x)
    return inner_func

square_func = self_math(multiply)
double_func = self_math(add)

print(square_func(5))

print(double_func(5))
```

```python
def get_logger(formatter):
    def inner_func(*args):
        print(formatter(*args))
    return inner_func
```

```python
def doc_format_checker_and_converter(conversion_function, valid_formats):
    def inner_func(filename, content):
        if filename.split(".")[1] in valid_formats:
            return conversion_function(content)
        raise ValueError("Invalid file format")
    return inner_func

result = doc_format_checker_and_converter(
    capitalize,
    ["txt", "md", "doc"]
)(
    "sample.txt",
    "I really don't feel like screaming today."
)
```

#### Why transform?

- When would i use function transformations in the real world?
- Isnt it simplerto just define functions at the top level of the code, and call them as needed?

We dont just transfrom functions on the fly for the fun of it! We only use advanced techniques like function transformations when they make our code simpler than it would otherwise be

##### Code Reusability

Using generalized functions to create variations of the same function to reduce code duplication is acommon pattern in programming. Function transformations are jst one way to do it

```python
def formatter(pattern):
    def inner_func(text):
        result = ""
        i = 0
        while i < len(pattern):
            if pattern[i:i+2] == '{}':
                result += text
                i += 2
            else:
                result += pattern[i]
                i += 1
        return result
    return inner_func

# It's easy to create new formatters now!
bold_formatter = formatter("**{}**")
italic_formatter = formatter("*{}*")
bullet_point_formatter = formatter("* {}")

print(bold_formatter("Hello"))
# **Hello**
print(italic_formatter("Hello"))
# *Hello*
print(bullet_point_formatter("Hello"))
# * Hello
```

### Clousures

Is a function that references variables from outside its own function body. What this means is that under the hood the function definition and its environment are bundled together into a single entity.

```python
def concatter():
	doc = ""
	def inner_func(word):
		# "nonlocal" tells Python to use the doc
		# variable from the enclosing scope
		nonlocal doc
		doc += word + " "
		return doc
	return inner_func

harry_potter_aggregator = concatter()
harry_potter_aggregator("Mr.")
harry_potter_aggregator("and")
harry_potter_aggregator("Mrs.")
harry_potter_aggregator("Dursley")
harry_potter_aggregator("of")
harry_potter_aggregator("number")
harry_potter_aggregator("four,")
harry_potter_aggregator("Privet")

print(harry_potter_aggregator("Drive"))
# Mr. and Mrs. Dursley of number four, Privet Drive
```

Each successive call to `harry_potter_aggregator` mutates that same `doc` variable. When `concattter()` is calledd, you can think of it as creatin a new stateful function that remembers the value of doc as its used

#### NONLOCAL

Many programming languages dnot require to use the nonlocal keyword to access variables from an enclosing scope, they will just use them automatically if a local variable of that name doesnt exist. Python does, so dont forget it

```python
def word_count_aggregator():
    count = 0
    def inner_func(sentence):
        nonlocal count
        for word in sentence.split(" "):
            count +=1
        return count

    return inner_func
```

The whole point of a clousure is that its stateful. Its a function that 'remembers' the values from the enclosing scope even after the enclosing scope has finished executing.

### Currying

Function currying is just a specific type of function transformations. Its when we translate a function that takes multiple arguments into a sequence of functinos, each with a single argument.

```python
def sum(a):
  def inner_sum(b):
    return a + b
  return inner_sum

print(sum(1)(2))
```

The `sum` function only takes a single input `a`, and returns a new function that takes a single input, `b`. This new function when called with a value for `b` will return the sum of `a` and `b`

```python
def converted_font_size(font_size):
    def inner_func(doc_type):
        if doc_type == "txt":
            return font_size
        if doc_type == "md":
            return font_size * 2
        if doc_type == "docx":
            return font_size * 3
        raise ValueError("Invalid doc type")
    return inner_func
```

### Decorators

Decorators are Python-specifc way to modify or ennhance existing functions. They're just Pythonic syntatic sugar for higher-order functions (and sometimes closures)

A function that can be used as a decorator if it takes a function as an argument and returns a new function. The new function can then be used in place of the original function. Again, this is typically used to modify or enhance the behavior of original function

```python
def vowel_counter(func_to_wrap):
    vowel_cunt = 0

    def wrapper(doc):
        nonlocal vowel_count
        for char in doc:
            if char in vowels:
                vowel_count += 1
        print(f"Vowel Count: {vowel_count}")

@vowel_count
def process_doc(doc):
    print(f"Document: {doc}")

procces_doc("Hello")
# Prints:
# Vowel Count: 2
# Document: Hello
```

Decorator are just syntathic sugar for higher-order functions, which means its just a fancy way of doing the exact same thing.

The example above is the same as

```python
def process(doc):
    print(f"Document: {doc}")

process_with_count = vowel_counter(procees)
process_with_count("Hello")
```

```python
def file_type_aggregator(func_to_wrap):
    # dict of file_type -> count
    counts = {}

    def wrapper(doc, file_type):
        nonlocal counts

        if file_type not in counts:
            counts[file_type] = 0

        counts[file_type] = 1
        result = func_to_wrap(doc, file_type)

        return result, counts

    return wrapper


@file_type_aggregator
def process_doc(doc, file_type):
    return f"Processing doc: {doc} with File Type: {file_type}"

process_doc("Welcome to the jungle", "txt")
# ('Processing doc: Welcome to the jungle with File Type: txt', {'txt': 1})
```

#### Args and Kwargs

In python, *args and *kwargs are Pythonic syntax that allows a function to accept and deal with a variable number of arguments in a function

- \*args collects positional arguments into a tuple
- \*kwargs collects keyword arguments into a dictionary

```python
def print_arguments(*args, *kwargs):
    print(f"Positional arguments: {args}")
    print(f"Keyword arguments: {kwargs}")

print_arguments("hello", "world", a=1, a=2)
# Positional arguments: ('hello', 'world')
# Keyword arguments: {'a': 1, 'b': 2}
```

##### Positional Arguments

They're the arguments that are passed in by position

```python
def sub(a, b):
    return a - b

res = sub(3, 2)
```

##### Keyword Arguments

This are passed in by name, order does not matter

```python
def sub(a, b):
    return a - b

res = sub(b=3, a=2)
```

Any positional argument must come before keyword arguments. Python will try to match up the arguments you pass in with the arguments in the function definition by position first, and the by name

This will not work:

```python
sub(b=3, 2)
```

Example:

```python
def args_logger(*args, **kwargs):
    for arg in args:
        print(f"* {arg}")

    for karg in sorted(kwargs.items()):
        print(f"* {karg[0]}: {karg[1]}")
```

If your decorator doesnt care about te specific arguments of the function its decorating, then you can use the `*args` and `*kwargs` syntax to make it more generic.

Additionaly, not every decorator needs to be a closure. That is, we dont need the returned function to have some stateful piece of data. Sometimes, we just want to modify the behavior of the function we're decorating.

```python
def log_call_count(func_to_wrap):
    count = 0

    def wrapper(*args, **kwargs):
        nonlocal count
        count += 1
        print(f"Called {count} times")
        return func_to_wrap(*args, **kwargs)

    return wrapper

@log_call_count
def add_with_log(a, b):
    return a + b

add_with_log(2, 3)
# Prints: Called 1 times
add_with_log(4, 5)
# Prints: Called 2 times
```

```python
def markdown_to_text_decorator(func):
    def wrapper(*args, **kwargs):
        converted_args = []
        for arg in args:
            converted_args.append(convert_md_to_txt(arg))
        for key, value in kwargs.items():
            kwargs[key] = convert_md_to_txt(value)
        return func(*converted_args, **kwargs)

    return wrapper


def convert_md_to_txt(doc):
    lines = doc.split("\n")
    for i in range(len(lines)):
        line = lines[i]
        lines[i] = line.lstrip("# ")
    return "\n".join(lines)

@markdown_to_text_decorator
def concat(first_doc, second_doc):
    return f"""
            First: {first_doc}
            Second: {second_doc}
            """


@markdown_to_text_decorator
def format_as_essay(title, body, conclusion):
    return f"""
            Title: {title}
            Body: {body}
            Conclusion: {conclusion}
            """
```

### Sum Types

Product types are the "opossite" of sum types. A product type is a type that is made up of multiple instances of other types, For example, tuples, dictionaries and classes are product types because they are **collection** of other types

```python
person = {
    "is_fat": True,
    "is_tall": False
}
```

In the case of the above dictionary, the total number of possible values for a pair of boolean values is 4 (the product of 2*2). If you hace a dictionary of 3 booleans, the total number of possible values would be 8 (the product of 2 * 2 \* 2).

A key idea in functional programming is that product types are tricky because your code has to handle every possible combination of values. For certain types, this can be a lot of combinations!

```python
def size_of_seat(person):
    if person.is_tall and person.is_fat:
        return 'XL'
    elif person.is_tall and not person.is_fat:
        return 'L'
    elif not person.is_tall and person.is_fat:
        return 'M'
    else:
        return 'S'

```

#### Integers, Strings, Floats, etc.

While on their own, integers, string, and floats are not product types, they do have the same problem when it comes to writing clean code: there are an infinite number of possible values

In functional programming, we are constantly looking for ways to limit the number of possible values a variable can have. The fewer possible values a variable can have, the easier it is to reason about, debug, and test

#### What is a sum type?

A sum type is a type that can be one of several other types. For example, a single boolean is a sum type because it can only be either True or False

A string isnt a useful sum type because it can be any string. Its not limited to a specific set of values. However, if we define a value that con only be one of a specific set of strings, then we have a sum type

Python does not support sum types, the closest we can get is to pretend that Python has sum types by writing our code in a way that manually checks for and handles potential invalid values:

```python
def color_to_hex(color):
    if color == "green":
        return '#00FF00'
    if color == "blue":
        return '#0000FF'

    return Exception('Unknown color')
```

### Enums in python

Enums are a way to represent a fixed set of values in python. An enum is a kind of sum type

Python doesnt support sum types, but it has enums, which are a kind of sum type, but because Python is dynamically typed, it still doesnt really enforce it before runtime in any meaningful way

```python
from enum import Enum

class Color(Enum):
    RED = 1
    GREEN = 2
    BLUE = 3

def color_to_hex(color):
    if color == Color.RED:
        return '#FF0000'
    if color == Color.GREEN:
        return '#00FF00'
    if color == Color.BLUE:
        return '#0000FF'
    raise Exception('Unknown color')
```

While we still have to have that pesky `raise Exception('Unknown color')` code, there are a few advantages to using Python's enums:

1. At least we now have a consistent syntax for defining and using sum types in Python. This is a huge improvement over the previous example where we were arbitrarily defining strings like `color_green` `color_blue` and then checking for those specific values.
2. Rather than storing a big old string in memory, we can store a single integer (e.g "red" is represented by `1`). This is a small performance improvement, but its still an improvement.
3. Even thought we store an integer, we can still refer to the values by name (e.g `Color.RED` insted of 1). This makes our code much more readable.
4. We can also get the human-readable name of a value by using `Color.RED.name`, which is useful for debugging
