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

### Virtual Machine

If your compiler produces bytecode, since there is no chip that speaks that bytecode, it's your job to translate. We have two options:

- We can write a little mini-compiler for each target architecture that converts the bytecode to native code for that machine.
- We can write a **virtual machine** (VM), a program that emulates a hypothetical chip supporting your virtual architecture at runtime.

Running bytecode in a VM is slower that translating it to native code ahead of time because every instruction must be simulated at runtime each time it executes. In return, you get simplicity and portability. Implement your VM in C and you can run your language on any platform that has a C compiler. This is how the second interpreter we build in this book works.

> The term “virtual machine” also refers to a different kind of abstraction. A system virtual machine emulates an entire hardware platform and operating system in software. This is how you can play Windows games on your Linux machine, and how cloud providers give customers the user experience of controlling their own “server” without needing to physically allocate separate computers for each user.

> The kind of VMs we’ll talk about in this book are language virtual machines or process virtual machines if you want to be unambiguous.

### Runtime

At this point we have hammered the user's program into a form that we can execute. The last step is running it. If we compiled it to machine code, we simply tell the operating system to load the executable and off it goes. If we compiled it to bytecode, we need to start up the VM and load the program into that.

In both cases, we usually need some services that our language provides while the program is running. For example, if the language automatically manages memory, we need a garbage collector going in order to reclaim unused bits. If our language supports “instance of” tests so you can see what kind of object you have, then we need some representation to keep track of the type of each object during execution.

All of this stuff is going at runtime. In a fully compiled language, the code implementing the runtime gets inserted directly into the resulting executable. In, say, Go, each compiled application has its own copy of Go’s runtime directly embedded in it. If the language is run inside an interpreter or VM, then the runtime lives there. This is how most implementations of languages like Java, Python, and JavaScript work.

## Shortcuts and Alternate Routes

That’s the long path covering every possible phase you might implement. Many languages do walk the entire route, but there are a few shortcuts and alternate paths.

### Single-pass compilers

Some simple compilers interleave parsing, analysis, and code generation so that they produce output code directly in the parser, without ever allocating any syntax trees or other IRs. These single-pass compilers restrict the design of the language. You have no intermediate data structures to store global information about the program, and you don’t revisit any previously parsed part of the code. That means as soon as you see some expression, you need to know enough to correctly compile it.

> Syntax-directed translation is a structured technique for building these all-at-once compilers. You associate an action with each piece of the grammar, usually one that generates output code. Then, whenever the parser matches that chunk of syntax, it executes the action, building up the target code one rule at a time.

### Tree-Walk interpreters

Some programming languages begin executing code right after parsing it to an AST (with maybe a bit of static analysis applied). To run the program, the interpreter traverses the syntax tree one branch and leaf at a time, evaluating each node as it goes.

This implementation style is common for student projects and little languages, but is not widely used for general-purpose languages since it tends to be slow. Some people use “interpreter” to mean only these kinds of implementations. Our first interpreter rolls this way.

### Transpilers

Writing a complete back end for a language can be a lot of work. If you have some existing generic IR to target, you could bolt your front end onto that. But if you don't have that you can treated some other language as if it were an intermediate representation?

You write a front end for your language. Then, in the back end, instead of doing all the work to lower the semantics to some primitive target language, you produce a string of valid source code for some other language that's about as high level as yours. Then, you use the existing compilation tools for that language as your escape route off the mountain and down to something you can execute.

They use to call this a **source-to-source compiler** or a **transcompiler**.

The front end — scanner and parser — of a transpiler looks like other compilers. Then, if the source language is only a simple syntactic skin over the target language, it may skip analysis entirely and go straight to outputting the analogous syntax in the destination language.

If the two languages are more semantically different, you’ll see more of the typical phases of a full compiler including analysis and possibly even optimization. Then, when it comes to code generation, instead of outputting some binary language like machine code, you produce a string of grammatically correct source code in the target language.

### Just-in-time compilation

This last one is less a shortcut and more a dangerous alpine scramble best reserved for experts. The fastest way to execute code is by compiling it to machine code, but you might not know what architecture your end user’s machine supports.

You can do the same thing that the JVM, and most JavaScript interpreters do. On the end user’s machine, when the program is loaded — either from source in the case of JS, or platform-independent bytecode for the JVM — you compile it to native code for the architecture their computer supports. Naturally enough, this is called just-in-time compilation. Most hackers just say “JIT”

The most sophisticated JITs insert profiling hooks into the generated code to see which regions are most performance critical and what kind of data is flowing through them. Then, over time, they will automatically recompile those hot spots with more advanced optimizations.

> This is, of course, exactly where the HotSpot JVM gets its name.

## Compilers and Interpreters

- Compiling is an implementation technique that involves translating a source language to some other. When you generate bytecode or machine code, you are compiling. When you transpile to another high-level language, you are compiling too.
- When we say a language implementation “is a compiler”, we mean it translates source code to some other form but doesn’t execute it. The user has to take the resulting output and run it themselves.
- Conversely, when we say an implementation “is an interpreter”, we mean it takes in source code and executes it immediately. It runs programs “from source”.

Some implementations are clearly compilers and not interpreters. GCC and Clang take your C code and compile it to machine code. An end user runs that executable directly and may never even know which tool was used to compile it. So those are compilers for C.

In older versions of Matz’s canonical implementation of Ruby, the user ran Ruby from source. The implementation parsed it and executed it directly by traversing the syntax tree. No other translation occurred, either internally or in any user-visible form. So this was definitely an interpreter for Ruby.

But what of CPython? When you run your Python program using it, the code is parsed and converted to an internal bytecode format, which is then executed inside the VM. From the user’s perspective, this is clearly an interpreter — they run their program from source. But if you look under CPython’s scaly skin, you’ll see that there is definitely some compiling going on.

The answer is that it is both. CPython is an interpreter, and it has a compiler. In practice, most scripting languages work this way, as you can see:

| Compiler    | Interpreter | Both    |
| ----------- | ----------- | ------- |
| javac       | MRI (Ruby)  | C#      |
| gcc         | jlox        | Haskell |
| typescript  | PHP3        | Lua     |
| coffescript |             | clox    |
| rust        |             | Go      |
| clang       |             | PHP4    |

That overlapping region in the center is where our second interpreter lives too, since it internally compiles to bytecode. So while this book is nominally about interpreters, we’ll cover some compilation too.

[LOX LANGUAGE](./lox.md)
