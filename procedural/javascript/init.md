- [JavaScript](#javascript)
  - [Single line comments](#single-line-comments)
  - [Multi line comments](#multi-line-comments)
  - [Line endings with semi-colons](#line-endings-with-semi-colons)
  - [Declaring Variables with "CONST"](#declaring-variables-with-"const")
    - [CONST is "better" than "let"](#const-is-"better"-than-"let")
  - [Declaring variables with "LET"](#declaring-variables-with-"let")
  - [Strings](#strings)
    - [Indexing into strings](#indexing-into-strings)
  - [Numbers](#numbers)
    - [Operatoins](#operatoins)
    - [Plus Plus](#plus-plus)
  - [Logical Operators](#logical-operators)
  - [Camel Case in JS](#camel-case-in-js)
  - [Template Literals in JS](#template-literals-in-js)
  - [Null Variables](#null-variables)
  - [Undefined Variables](#undefined-variables)
    - [A NOTE ON 'UNDEFINED' VS 'NULL'](#a-note-on-'undefined'-vs-'null')
  - [Comparison Operators](#comparison-operators)
  - [IF, ELSE IF, ELSE](#if,-else-if,-else)
    - [Ternary Operator in JS](#ternary-operator-in-js)
  - [Functions](#functions)
    - [Function Ordering](#function-ordering)
    - [Multiple Return Values](#multiple-return-values)
    - [Functions as values](#functions-as-values)
      - [CALLBACKS](#callbacks)
        - [WHEN TO USE CALLBACKS](#when-to-use-callbacks)
  - [SCOPE](#scope)
  - [VAR, LET and CONST](#var,-let-and-const)
  - [FAT Arrow functions](#fat-arrow-functions)
    - ['FUNCTION' keyword](#'function'-keyword)
    - [FAT Arrow](#fat-arrow)
    - [WHAT ARE THE DIFFERENCES BETWEEN THE TWO?](#what-are-the-differences-between-the-two?)
  - [Arrays](#arrays)
    - [Index into an array](#index-into-an-array)
    - [Push to an array](#push-to-an-array)
    - [Array length](#array-length)
    - [Array Operations](#array-operations)
      - [Concatenate](#concatenate)
      - [Includes](#includes)
    - [Slicing Arrays](#slicing-arrays)
  - [Loops](#loops)
    - [Break from loops in JS](#break-from-loops-in-js)
    - [Continue from loops in JS](#continue-from-loops-in-js)
    - [Loop Structure](#loop-structure)
    - [FOR-OF Loops](#for-of-loops)
  - [OBJECTS in JS](#objects-in-js)
    - [Syntactic sugar for creating objects in JS](#syntactic-sugar-for-creating-objects-in-js)
    - [Updating and Adding Keys to Objects](#updating-and-adding-keys-to-objects)
    - [Nesting Properties](#nesting-properties)
    - [Optional Chaining in JS `?.`](#optional-chaining-in-js-`?.`)
    - [Object Methods](#object-methods)
    - [Initializing Keys](#initializing-keys)
    - [Strings as Keys](#strings-as-keys)
    - [FAT ARROW Functions and 'THIS'](#fat-arrow-functions-and-'this')
  - [Errors IN JS](#errors-in-js)
    - [The error object](#the-error-object)
    - [Throwing your own errors](#throwing-your-own-errors)
  - [The JS RUNTIME](#the-js-runtime)

# Javascript

JS powers the dynamic behavior on nearly all websites. While it originally was only used for website development, the language has continued to evolve and grow over time.

Today, JS is a general purpose programming language

## Single line comments

```javascript
// this code prints a greeting
console.log("Hello"); // you can also use comments inline
```

## Multi line comments

```javascript
/*
    the code found below
    will print 'Hello, World!'
    to the console
*/
console.log("Hello");
```

## Line endings with semi-colons

In languages like C, C++, and Java, a semicolon is used as a terminator in various statements. For example, in js:

```javascript
console.log("Hello World");
```

Notice the `;` at the end of the line. In JS, semicolons are optional (90% of the time) as a terminating character.

## Declaring Variables with "CONST"

The `const` keyword can also be used to create variables. There is a very important difference between `let` and `const`. The variables declared with `let` can be reassigned. Variables declared with `const` can not be reassigned later

```javascript
let name = "John";
name = "Jane";
console.log(name);
// print: Jane

const name = "John";
name = "Jane";
// TypeError: Assignment to constant variable.
```

### CONST is "better" than "let"

In general, if you don't plan to change the value of a variable later, use const. This will save you from unexpected bugs and confusion! If you need to mutate a variable for some reason though, it's okay to use let.

## Declaring variables with "LET"

The `let` keyword is used to create new variables. We've already written some strings directly in `console.log` statements, so now lets practice using them as variables

```javascript
let name = "John";
console.log(name);
// prints: John
```

## Strings

Can be writt usin either single quotes or double quotes

### Indexing into strings

Square brackets are used to access individual characters inside a string. The chars are numbered starting with 0, and running up to length-1.

```javascript
const greetings = "Hello";
greetings[0]; // 'H'
greetings[1]; // 'e'
greetings[2]; // 'l'
greetings[3]; // 'l'
greetings[4]; // 'o'

greeting[greeting.length - 1]; // 'o'
```

## Numbers

Numbers without a decimal part are called `Integers` and fractions are `Floats`. Constrast this to JavaScript where all numbers are just a `number` type.

You're already familiar with the number type. Numbers aren't surrounded by quotes when created, but they can have decimals and negative signs.

```javascript
let x = 5;

let x = 5.2;

let x = -5;
```

### Operatoins

```javascript
2 + 1; // Addition

2 - 1; // Subtraction

2 * 2; // Multiplication

3 / 2; // Division
```

### Plus Plus

In python, to increment a variable we had to use the `+=` operator. That operator works in JavaScript too, but JS also has a `++` operator for when you only want to increment by `1`.

```javascript
let startRating = 4;
startRating += 1; // 5
startRating++; // 6
startRating += 4; // 10
```

## Logical Operators

In python the logical operators were simply their English names:

- `and`
- `or`
- `not`

In JS the equivalent operators have symbols:

- `&&`
- `||`
- `!`

## Camel Case in JS

In python we use `snake_case` to write variable names. In JS, the convention we encourage is to use `camelCase`

## Template Literals in JS

In Javascript, you can use a template literal to interpolate dynamic values into a string template. Template literal are JS version of Python f-strings.

```javascript
const shadeOfRed = 101;
console.log(`the shade is ${shadeOfRed}`);
```

Template literals _must start and end with a backtick_, and anything inside of the dollar-sign bracket enclosure is automatically cast to a string.

- To "cast" means to convert from one type to another, like converting from a number to a string.
- To "interpolate" means to insert something into something else. In this case, template literals allow us to interpolate dynamic values into a string template - it's super useful!

## Null Variables

Similar to Python `None` type, JS has the `null` value, JS has the `null` value. Just like you would use `None` in Python to set a "default" value of some kind, you could use `null` for the same thing in JS.

```javascript
let profilePic = null;

const dataFromBackend = waitForDataFromBackend();

profilePic = dataFromBackend.profilePic;
```

**Null is not a specific string**
**Null values are "FALSY"**

"Falsy" means that a value evaluates to `false` when cast to a boolean. Here are some examples of "falsy" values:

- `false` (false boolean)
- `''` (empty string)
- `0` (number zero)

Here are some truthy values:

- `true` (true boolean)
- `1` (a non-zero number)
- `'name'` (a string with more than zero characters)

## Undefined Variables

Not all variables have a value, some dont even have a `null` value. In JS we can declare an empty or undefined variabl:

```javascript
let emptyVar;
```

The value of `emptyVar` in this instance is `undefined` until we use the assignmet operator, `=`, to give it a value.

**Undefined is not a specific string**
**Undefined is also falsy**

### A NOTE ON 'UNDEFINED' VS 'NULL'

In my opinion, the way JavaScript deals with null and undefined is really bad language design. Most programming languages, like Python, just have one null, none, or nil type of value. JavaScript Unfortunately has 2: null and undefined.

In a nutshell, undefined literally means that the variable was never assigned a value, whereas the null value must be assigned explicitly.

My recommendation to you is to keep it that way. If you need a "nonetype" value, assign the null value. Try to avoid explicitly assigning the undefined value. In short, prefer null!

## Comparison Operators

You're already familiar with thse inequality operators, and they work as you would expect in JS:

```javascript
5 < 6; // evaluates to true
5 > 6; // evaluates to false
5 >= 6; // evaluates to false
5 <= 6; // evaluates to true
```

The equality operators however are a bit... strange. To compare two values to see if they are same or different, you use an extra `=` sign:

```javascript
5 === 6; // evaluates to false
5 !== 6; // evaluates to true
```

The more common equality operators have unintuitive behavior and frankly should be avoide:

```javascript
5 == 6; // evaluates to false
5 == "5"; // evaluates to true

5 != 6; // evaluates to true
5 != "5"; // evaluates to false
```

The "strict equals" (===) and "strict not equals" (!==) compare both the value AND the type. The "loose equals" (==) and "loose not equals" (!=) just compare the value. That means that with loose equals, the string '5' and the number 5 are considered "equal" - which is basically just something that you shouldn't be comparing in good code.

## IF, ELSE IF, ELSE

if/else blocks are very similar in Python and JS. There are a few key differences:

- The condition _must_ be iniside parentheses
- The body should be within brackets
- it's `else if` not `elif`

```javascript
if (height > 100) {
  console.log("you're tall!");
} else if (height > 60) {
  console.log("you're average height");
} else if (height > 50) {
  console.log("you could be taller");
} else {
  console.log("you're short");
}
```

### Ternary Operator in JS

Sometimes using 3-5 lines of code to write an if/else block is overkill. The ternary operator provides a simpler alternative in some scenarios.

```javascript
const price = isMember ? "$2.00" : "$10.00";
// If isMember is true then evaluate to $2.00, otherwise evaluate to $10.00.
```

Ternary's latin root means "3", and it's the only JavaScript operator that takes three operands.

A condition followed by a question mark (?)
An expression to execute if the condition is truthy followed by a colon (:)
The expression to execute if the condition is falsy.

## Functions

To create a new function, you'll use the `function` keyword. Similar to other blocks like `if` and `else`, the body of the function is surrounded by brackets:

```javascript
function main() {
  const sum = getSum(5, 6);
  console.log(`The sum is ${sum}`);
}

function getSum(a, b) {
  return a + b;
}

main();
```

### Function Ordering

In python, a function had to be defined before it could be used. In Js that's not the case. Like most other programming languages, as long as the function is defined somewhere in the code, it can be called even before the definition.

```javascript
console.log(getLabel(3));
// prints 'awful'

function getLabel(numStars) {
  if (numStars > 7) {
    return "great";
  } else if (numStars > 3) {
    return "okay";
  } else {
    return "awful";
  }
}
```

### Multiple Return Values

In Python, you'll recall that we could return multiple values from a function.

```python
def get_user():
    return "name@domain.com", 21, "active"

email, age, status = get_user()
```

However, in JS, that's not allowed!. The common workaround used is to return an `object` that contains multiple values. You're still just returning a single `object`

### Functions as values

"Functions as values", or "first-class" functions are supported by JS. That means that functions themselves can be passed around as data.

```javascript
function sayHello() {
  console.log("Hello there!");
}

function doTwice(f) {
  f();
  f();
}

doTwice(sayHello);
// Prints:
// Hello there!
// Hello there!
```

#### CALLBACKS

Another name for this sort of thing is a "callback". In this case, the sayHello function is a callback function that's passed into the doTwice function for it to execute later. Callbacks are very common in front-end applications. You'll often see code that essentially says

> "When the 'sign up' button is clicked, do X"

What's X? Well, it's a function! So you essentially connect functions to UI components (like buttons) so they can be called later when the element is clicked.

##### WHEN TO USE CALLBACKS

The #1 rule of programming in my book is "KISS" (Keep it simple, stupid)

When callbacks are needed in application code, they are usually being passed to functions imported from a library or framework. Applications rarely define their own functions which accept callbacks, while libraries and frameworks commonly do because they need to stay application agnostic.

For example, the `requestAnimationFrame()` is part of every web browser's JavaScript API. It needs to accept a callback because it needs to be able to run an arbitrary piece of code the next time the browser redraws the webpage. It can't hard-code the behavior because it needs to support every web application imaginable.

## SCOPE

Deals with where values and functions can be accessed in your code. For example, you'll likely write code at sme point, or see code at some point where the bug is related to a variable beign "out of scope"

Some "scopes" include:

- Global Scope - Values in the global scope are accesible everywhere
- File or Module Scope - Values can only be accessed fro within the same code file
- Function Scope - Values can only be accessed within the same function
- Block Scope - Values can only be accessed within that { ... } codeblock

```javascript
function getCar() {
  const car = "Volvo";
  // code here can use 'car'
}

// code here can NOT use 'car'
```

```javascript
const car = "Volvo";
// code here can use 'car'

function getCar() {
  console.log(car);
  // code here CAN use 'car'
}
```

## VAR, LET and CONST

The `var` keyword is one such piece of "legacy code". `var` is similar to `let` and `const` in that it allows us to define a new variable. Like `let`, `var` creates "mutable" or "changeable" variable. However, unlike let, var is less safe because it does some strange things with scope.

Basically, `var` works as you would expect within function scopes, but not within block scopes. An "if" statement is an example of a block scope.

```javascript
function printX(shouldSet) {
  if (shouldSet) {
    var x = 2;
  }
  console.log(x);
  // Prints: 2
}
printX(true);
```

```javascript
function printX(shouldSet) {
  if (shouldSet) {
    let x = 2;
  }
  console.log(x);
  // ReferenceError: x is not defined
}
printX(true);
```

The `let` behavior makes much more sense because it treats block scope the same as function scope, which is what almost every other programming language does as well.

**Always use let and const, never var.**

## FAT Arrow functions

Fat arrow functions, or "arrow functions" are another way to define functions in JS. Arrow functions are _newer_ than the `function` keyword, however, unlike the `let/var` issue, arrow functions are sometimes more appropiate, not always.

### 'FUNCTION' keyword

```javascript
const add = function (x, y) {
  return x + y;
};
```

### FAT Arrow

```javascript
const add = (x, y) => {
  return x + y;
};
```

### WHAT ARE THE DIFFERENCES BETWEEN THE TWO?

- Fat arrow functions are always declared as variables - usually consts, while the function keyword may or may not be a variable.
- Fat arrow functions handle object scoping in a more intuitive way (we'll talk about this in later chapters)
- A few other minor differences

## Arrays

JS arrays are the equivalent of Python lists. Arrays have nearly identical syntax in JS and Python

One importanet thing about an array is that items in an array are not required to be of the same type

```javascript
const numbers = [1, 2, 3, 4, 5];
const strings = ["banana", "apple", "pear"];
```

### Index into an array

Just like we already saw with strings, you can get items from an array using square brackets.

```javascript
const strings = ["banana", "apple", "pear"];
console.log(strings[0]);
```

### Push to an array

In JS, we `.push()` instead of `.append()`

```javascript
const drinks = [];
drinks.push("lemonade");
console.log(drinks);
// Prints: ['lemonade']
drinks.push("root beer");
console.log(drinks);
// Prints: ['lemonade', 'root beer']
```

### Array length

The `length` property returns the current lenght of an array

```javascript
const foods = ["burger", "fries", "pizza"];
console.log(foods.length);
```

### Array Operations

#### Concatenate

There are a couple of ways to concatenate two arrays (smushing them together) in JavaScript.

- The `.concat()` method.

```javascript
let nums = [1, 2, 3];
nums = nums.concat([4, 5, 6]);
console.log(nums);
// Prints: [1, 2, 3, 4, 5, 6]
```

- The spread syntax

```javascript
const nums = [1, 2, 3];
const newNums = [...nums, 4, 5, 6];
console.log(newNums);
// Prints: [1, 2, 3, 4, 5, 6]
```

This comes down to personal preference, but I prefer the spread syntax. It's newer, but I also like it because, in my opinion, the .concat method can be confusing. I would expect the .concat method to mutate the array in place, but instead, it returns a new array.

#### Includes

Checking whether a value exists in an array is really easy, just use the `.includes()` method

```javascript
fruits = ["apple", "orange", "banana"];
console.log(fruits.includes("orange"));
// Prints: true
```

### Slicing Arrays

JS makes it easy to slice and dice arrays to work only with the section you care about.

The syntax is as follows `slice(fromIndex, untilIndex)`

```javascript
const animals = ["ant", "bison", "camel", "duck", "elephant"];

console.log(animals.slice(2));
// ["camel", "duck", "elephant"]

console.log(animals.slice(2, 4));
// ["camel", "duck"]

console.log(animals.slice(1, 5));
// ["bison", "camel", "duck", "elephant"]

console.log(animals.slice(-2));
// ["duck", "elephant"]

console.log(animals.slice(2, -1));
// ["camel", "duck"]

console.log(animals.slice());
// ["ant", "bison", "camel", "duck", "elephant"]
```

While JS doesn't support negative indexing in the built-in array index syntax, the `slice()` method does support negative indexes

**const** arrays can be modified through their operation methods, but no through the assignmente symbol `=`

## Loops

A traditional "for loop" in JS is written like this:

```javascript
for (let i = 0; i < 10; i++) {
  console.log(i);
}
```

This kind of syntax is common in many C-style languages. Python's range syntax is a bit unique.

In English, the code says:

1. Start with i equals 0. (let i = 0)
1. If i is not less than 10, exit the loop.
1. Log i to the console. (console.log(i))
1. Add 1 to i. (i++)
1. Go back to step 2
1. The result is that the numbers 0-9 are logged to the console in order.

### Break from loops in JS

The `break` keyword can be used to break from a loop early.

```javascript
for (let i = 0; i < 10; i++) {
  if (i === 3) {
    break;
  }
  console.log(i);
}
```

### Continue from loops in JS

The `continue` keyword can be used to break out of a _single iteration_ of a loop early

```javascript
for (let i = 0; i < 10; i++) {
  if (i % 2 === 0) {
    continue;
  }
  console.log(i);
}
```

### Loop Structure

We can generalize the structure of a for-loop as follows:

```javascript
for (INIT; CONDITION; POST) {
  // do stuff
}
```

- `INIT` runs once at the beginning of the loop. Here we typically initialize a variable for use within the loop. Conventionally this variable is simply called i for simplicity.
- `CONDITION` is run before execution of each iteration of the loop. If the condition evaluates to true then the loop body is executed, otherwise the loop is broken and ends.
- `POST` is evaluated at the end of each iteration. This is typically used to modify the value of a variable.

### FOR-OF Loops

With newer versions of JS we can use a clean syntax to loop over an array without keeping track of the index manually

- INDEX-BASED iteration:

```javascript
let woods = ["oak", "pine", "maple"];
for (let i = 0; i < woods.length; i++) {
  console.log(woods[i]);
}
```

- NEW SYNTAX

```javascript
let woods = ["oak", "pine", "maple"];
for (let wood of woods) {
  console.log(wood);
}
```

In the example above, the wood variable is declared using the of keyword, and it directly accesses the value in the array rather than the index of the value. If we don't need to update the item, and only need to access its value then this is a more clean way to write the code. You can use either const or let in a loop header, depending on if the loop changes the variable.

**When use this NEW SYNTAX?**

- You need to iterate over an entire array
- You need to go in ascending order
- You don't need access to the index value
- You don't need to make updates to the array's items

As it turns out, all of those conditions are usually true, so you'll use the for-of syntax often. That said, there are absolutely times when one of the conditions isn't true, so the traditional i-based for loop is the necessary alternative.

## OBJECTS in JS

JavaScript has an Object type. Objects are single variables that can hold more complex information than the basic types like String, Number and Boolean, though they contain properties that are often those basic types.

For example, we may want to store data about a fruit. We can do so in a single variable:

```javascript
const apple = {
  name: "Apple",
  radius: 2,
  color: "red",
};

console.log(apple.name); // prints "Apple"
console.log(apple.radius); // prints "2"
console.log(apple.color); // prints "red"
```

In a way, JavaScript's objects are used in a similar way to Python's dictionary: as a key/value store.

**Objects are how we get around JavaScript's limitation of only being able to return 1 value from a function.**

### Syntactic sugar for creating objects in JS

The following pieces of JS code are equivalent:

```javascript
const name = "Apple";
const radius = 2;
const color = "red";
const apple = {
  name: name,
  radius: radius,
  color: color,
};

const name = "Apple";
const radius = 2;
const color = "red";
const apple = {
  name,
  radius,
  color,
};
```

Prefer the 2nd example - it's more concise, but just as easy to understand. The 2nd syntax basically says "the existing variable name is what I want the key in the object to be, so just use that"

### Updating and Adding Keys to Objects

You can update and even add new keys using the . operator as well:

```javascript
const apple = {
  name: "Apple",
  radius: 2,
  color: "red",
};

apple.ranking = 3;
apple.color = "green";
```

### Nesting Properties

Objects can contain other objects! This means we can have properties that are potentially nested quite deep.

```javascript
const tournament = {
  referee: {
    name: "Sally",
    age: 25,
  },
  prize: {
    units: "dollars",
    value: 100,
  },
};
```

We access nested properties the same way: `tournament.referee.name`

### Optional Chaining in JS `?.`

With the dot syntax we can try to access properties that doesnt exist. But JS has a system to prevent that the operator `?.`

```javascript
const tournament = {
  prize: {
    units: "dollars",
    value: 100,
  },
};

const h = tournament.referee.height;
// TypeError: Cannot read properties of undefined (reading 'height')
```

Instead, we should use the optional chaining operator if we're unsure whether the `referee` object exists or not:

```javascript
const tournament = {
  prize: {
    units: "dollars",
    value: 100,
  },
};

const h = tournament.referee?.height;
// h is simply undefined, no error
```

**WHEN TO USE OPTIONAL CHAINING**

- Use ?. only where it is expected that an object may not exist.

For example, if according to our business logic, users must exist but addresses are optional, we would write:

```javascript
user.address?.street;
```

not

```javascript
user?.address?.street;
```

We don't want to overuse it because if we expect that all users have objects, and we come across one that doesn't we want an error thrown so we can see it and go fix the problem. Errors make debugging easier.

### Object Methods

JavaScript objects can have methods, just like in Python.

Methods are functions that are defined on an object. They can access and change the properties of the object in question.

In the context of a method, the `this` keyword refers to the object as a whole.

```javascript
const person = {
  firstName: "Lane",
  lastName: "Wagner",
  getFullName() {
    return this.firstName + " " + this.lastName;
  },
};

console.log(person.getFullName());
```

As you can see, within the scope of the getFullName() method, this refers to the object itself and we can access the object's properties.

Just like how the contents of a `const array` can change, the properties of a `const object` can change as well. Remember, the rule with **const is simply that the name itself can't be reassigned.**

### Initializing Keys

If a key doesn't exist but we try to access it, we will get a value of undefined. One way we can check for this is by using the not ! operator. Because undefined is considered "falsy". The syntax is fairly simple:

```javascript
const balances = {
  lane: 100,
  breanna: 150,
  john: 200,
};

// if bob doesn't have a balance yet
// create a new key for him with a value of 0
if (!balances.bob) {
  balances.bob = 0;
}

let days = {
  monday: "workday",
  wednesday: "workday",
  saturday: "vacation",
};

if (!days.monday) {
  console.log("Monday is not a day");
}

if (!days.sunday) {
  console.log("Sunday is not a day");
}
```

### Strings as Keys

Just like Python dictionaries, we can use a bracket notation to access the properties of objects, as opposed to the dot operator we have been using so far.

```javascript
const desk = {
  wood: "maple",
  width: 100,
};

console.log(desk.wood);
// prints "maple"

console.log(desk["wood"]);
// also prints "maple"
```

Bracket notation is powerful, it allows us to use dynamically created strings as keys rather than hard-coding them as we have been doing.

```javascript
const animals = ["cat", "cat", "cat", "dog", "dog", "rat"];

const animalCounts = {};

for (let animal of animals) {
  // here we initialize the count to 0 if the key doesn't exist yet
  if (!animalCounts[animal]) {
    animalCounts[animal] = 0;
  }

  // here we increment the count
  animalCounts[animal]++;
}

/*
animalCounts = {
  cat: 3,
  dog: 2,
  rat: 1
}
*/
```

Using strings as keys is a great way to ensure uniqueness in a `set`

```javascript
const getCountsByTitle = (movies) => {
  const movieCounts = {};
  for (const movie of movies) {
    if (!movieCounts[movie]) {
      movieCounts[movie] = 0;
    }

    movieCounts[movie]++;
  }

  return movieCounts;
};

function test(movies) {
  const counts = getCountsByTitle(movies);
  for (const [movie, count] of Object.entries(counts)) {
    console.log(`'${movie}' has ${count} reviews`);
  }
  console.log("---");
}

test([
  "Ice Age",
  "The Forgotten",
  "The Northman",
  "American Psycho",
  "Ice Age",
  "Ice Age",
  "American Psycho",
]);
```

### FAT ARROW Functions and 'THIS'

**In JavaScript, the `this` keyword is practically _always_ accessible.**

**When you are not using FAT ARROWS**:

- If you're in an object, `this` is bound to that object
- If you're in the global, or "top-level" scope, `this` is bound to the "global" object

**FAT ARROW functions preserve `this`**

```javascript
const author = {
  firstName: "Lane",
  lastName: "Wagner",
  getName() {
    return `${this.firstName} ${this.lastName}`;
  },
};
console.log(author.getName());
// Prints: Lane Wagner

const author = {
  firstName: "Lane",
  lastName: "Wagner",
  getName: () => {
    return `${this.firstName} ${this.lastName}`;
  },
};
console.log(author.getName());
// Prints: undefined undefined
// because the parent scope (the scope outside of the author object)
// never defined .firstName and .lastName properties
```

So, the big takeaway is that when you use the non-fat-arrow function syntax, you sometimes get a different `this` object, depending on how the function (or method) was defined and called.

With a fat-arrow function, the `this` keyword will always refer to the same object that its parent scope would. In essence, fat arrow functions "preserve" the `this` context. For that reason, some developers and frameworks prefer fat arrow functions in many situations. It can alleviate some confusion around the `this` object.

## Errors IN JS

The fundamentals of error handling in JS and Python are similar. However, instead of beign called `Ecexptions`, they're just called `Errors`

```javascript
try {
  const car = {};
  console.log(car.make.name);
} catch (err) {
  console.log(err.message);
} finally {
  console.log("I will always run");
}
```

- The try block is executed until an error is thrown or it completes, whichever happens first.
- The catch block is only executed if an error is raised in the try block. It then exposes the error as an error object (err in our case) so that the program can handle the error gracefully without crashing.
- The finally block will always run, regardless of whether or not an error was thrown

**FINALLY IS NOT AS COMMON**

The `finally` block is optional, and personally, I rarely use it. If you want something to run regardless of a thrown error in the try block, you can usually just put it after the try/catch block.

### The error object

Has two powerful properties:

- name
- message

### Throwing your own errors

**Syntax**

```javascript
throw new Error("something went wrong");
```

## The JS RUNTIME

A runtime environment is, put simply, _where your program runs._

The runtime determines which global objects your program can access, which in urn affects which APIs are available and how your code is interpreted and executed

**Example of RUNTIME**

- A browser (and techincally, each browser's runtime can be slightly different as well)
- Node.js
- A web workers within a browser
- Deno.js
- Bun

Originally, JavaScript only ran in browsers. Today, it runs in many places. Browsers are still the most common, but Node.js is extremely popular as a runtime, especially for backend development.

**How do the RUNTIME differ?**

- Performance - Some runtimes run JS code faster or slower under different conditions.
- APIs - The runtime exposes APIs to your code. For example, in a browser you can access the canvas API for drawing, but that's not available in Node. On the other hand, Node.js has some cryptography libraries available by default.
- Global object - In the browser, the global object is called window, in Node it's called global. The properties and methods available on that global object are quite different depending on the runtime.
