# REFERENCES

- [Book](https://craftinginterpreters.com/introduction.html)
- [Code](https://github.com/munificent/craftinginterpreters/wiki/Lox-implementations)

# The Parts of Language

It all begins with the bare text of the user's source code:

`var average=(min+max)/2;`

## Front End

### Scanning

The first step is **scanning** also known as **lexing** or **lexical analysis**.

A **lexer** takes in the linear stream of characters and chunks them together into a series of something more akin to "words". In programming languages, each of those words is called a **token**. Some tokens are single characters, like `(` and `,`. Others may be several characters long, like numbers `123`, string literals `"hi!"`, and identifiers `min`.

**Lexical** comes from the Greek root "lex", meaning "word".

Some characters in a source file don't actually mean anything. White space is often insignificant, and comments, by definition, are ignored by the language. The lexer usually discards these, leaving a clean sequence of meaningful tokens.

Taking for example the line of code in the beginning.

`var`-`average`-`=`-`(`-`min`-`+`-`max`-`)`-`/`-`2`-`;`

### Parsing

The next step is **parsing**. This is where our syntax gets a **grammar** -- the ability to compose larger expressions and statements out of smaller parts.

A **parser** takes the flat sequence of tokens and builds a tree structure that mirrors the nested nature of the grammar. These trees have a couple of different names -- **parse tree** or **abstract syntax tree** -- depending on how close to the bare syntactic structure of the source language they are.

```text
                                    |--> Expr.Literal | 2 |
                                    |
Stmt.Var |average| -> Expr.Binary | / |                |--> Expr.Variable | max |
                                    |                  |
                                    |--> Expr.Binary | + |
                                                       |
                                                       |--> Expr.Variable | min |
```

### Static Analysis

The first two stages are pretty similar across all implementations. Now, the individual characteristics of each language start coming into play.

In an expression like `a + b`, we know we are adding `a` and `b`, but we don't know what those names refer to. Are they local variables? Global? Where are they defined? Etc.

The first bit of analysis that most languages do is called **binding** or **resolution**. For each **identifier**, we find out where that name is defined and wire the two together. This is where **scope** comes into play -- the region of source code where a certain name can be used to refer to a certain declaration.

If the language is statically typed, this is when we type check. Once we know where `a` and `b` are declared, we can also figure out their types. Then if those types don't support being added to each other, we report a **type error**.

All this semantic insight that is visible to us from analysis needs to be stored somewhere:

- Can be stored right back as attributes on the syntax tree itself — extra fields in the nodes that not are initialized during parsing but get filled in later.

- Can be store data in a lookup table off to the side. Typically, the keys to this table are identifiers — names of variables and declarations. We call it a symbol table and the values it associates with each key tell us what that identifier refers to.

- The most powerful bookkeeping tool is to transform the tree into an entirely new data structure that more directly expresses the semantics of the code. That’s the next section.

Everything up to this point is considered the **front end** of the implementation.
Now we are moving to the **middle end**
And later we are going to the **back end**

## Middle End

### Intermediate Representations

We can think of the compiler as a pipeline where each stage's job is to organize the data representing the user's code in a way that makes the next stage simpler to implement.

The **front end** of the pipeline is specific to the source language the program is written in. The **back end** is concerned with the final architecture where the program will run.

In the middle, the code any be stored in some **intermediate representation** (**IR**) that isn't tightly tied to either the source or destination forms. The IR acts as an interface between these two languages.

This lets you support multiple source languages and target platforms with less effort. Say you want to implement Pascal, C, and Fortran compilers, and you want to target x86, ARM, and, I dunno, SPARC. Normally, that means you’re signing up to write nine full compilers: Pascal→x86, C→ARM, and every other combination.

A shared intermediate representation reduces that dramatically. You write one front end for each source language that produces the IR. Then one back end for each target architecture. Now you can mix and match those to get every combination.

There’s another big reason we might want to transform the code into a form that makes the semantics more apparent...

### Optimization

Once we understand what the user's program means, we are free to swap it out with a different program that has the _same semantics_ but implements them more efficiently -- we can **optimize** it.

A simple example is **constant folding**: if some expression always evaluates to the exact same value, we can do the evaluation at compile time and replace the code for the expression with its result. If the user typed in this:

`pennyArea = 3.14159 * (0.75 / 2) * (0.75 / 2);`

We could do all of that arithmetic in the compiler and change the code to:

`pennyArea = 0.4417860938;`

## Back End

### Code Generation

The last step is converting it to a form the machine can actually run. In other words, **generation code** (or **code gen**), where "code" here usually refers to the kind of primitive assembly-like instructions a CPU runs and not the kind of "source code" a human might want to read.

Now we have to make a decision. Do we generate instructions for a real CPU or a virtual one? If we generate real machine code, we get an executable that the OS can load directly onto the chip.

Speaking the chip’s language also means your compiler is tied to a specific architecture. If your compiler targets x86 machine code, it’s not going to run on an ARM device.

Instead of instructions for some real chip, we can produced code for a hypothetical, idealized machine. We generally call this bytecode because each instruction is often a single byte long.
