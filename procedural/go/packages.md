# PACKAGES

Every GO program is made up of packages

You have probably noticed the `package main` at the top of all the programs you have been writing.

A package named 'main' has an entry point at the `main()` function. A `main` package is compiled into an executable program

A package by any other name is a "library package". Libraries have no entry point. Libraries simply export functionality that can be used by other packages.

```go
package main

import (
	"fmt"
	"math/rand"
)

func main() {
	fmt.Println("My favorite number is", rand.Intn(10))
}
```

This program is an executable. It is a "main" package and imports from the `fmt` and `math/rand` library packages.

## NAMING

By convention, a package's name is the same as the last element of its import path. For instance, the `math/rand` package comprises files that begin with:

`package rand`

That said, package names aren't required to match their import path. For example, i could write a new package with the path `github.com/mailio/rand` and name the package `random`

`package random`

While the above is possible, it is discouraged for the sake of consistency.

**ONE PACKAGE / DIRECTORY**

A directory of Go code can have at most one package. All .go files in a single directory must all belong to the same package. If they don't an error will be thrown by the compiler. This is true for main and library packages alike.

## MODULES

Go programs are organized into packages. A package is a directory of Go code that's all compiled together. Functions, types, variables, and constants defined in one source file are visible to all other source files within the same package (directory).

A repository contains one or more modules. A module is a collection of Go packages that are released together.

**A GO REPOSITORY TYPICALLY CONTAINS ONLY ONE MODULE, LOCATED AT THE ROOT OF THE REPOSITORY.**

A file named go.mod at the root of a project declares the module. It contains:

- The module path
- The version of the Go language your project requires
- Optionally, any external package dependencies your project has

The module path is just the import path prefix for all packages within the module. Here's an example of a go.mod file:

```go.mod
module github.com/bootdotdev/exampleproject

go 1.22.1

require github.com/google/examplepackage v1.3.0
```

Each module's path not only serves as an import path prefix for the packages within but also indicates where the go command should look to download it. For example, to download the module golang.org/x/tools, the go command would consult the repository located at https://golang.org/x/tools.

> An "import path" is a string used to import a package. A package's import path is its module path joined with its subdirectory within the module. For example, the module github.com/google/go-cmp contains a package in the directory cmp/. That package's import path is github.com/google/go-cmp/cmp. Packages in the standard library do not have a module path prefix.

**A NOTE ON GOPATH**

The `$GOPATH` environment variable will be set by default somewhere on your machine (typically in the home directory, ~/go). Since we will be working in the new "Go modules" setup, you don't need to worry about that. If you read something online about setting up your `GOPATH`, that documentation is probably out of date.

These days you should avoid working in the `$GOPATH/src` directory. Again, that's the old way of doing things and can cause unexpected issues, so better to just avoid it.

## CREATE A NEW PROJECT

- Create folder
- Inside folder, run this command:
  `go mod init {REMOTE}/{USERNAME}/modulename`

Where {REMOTE} is your preferred remote source provider (i.e. github.com) and {USERNAME} is your Git username. If you don't use a remote provider yet, just use example.com/username/hellogo

Inside `hellogo`, create a new file called `main.go`

Conventionally the file in the `main` package that contains the `main()` function is called `main.go`

## RUN A PROJECT

`go run main.go`

The`go run` command is used to quickly compile and run a Go package. The compiled binary is not saved in your working directory. Use `go build` instead to compile production executables

`go run` helps to quickly do some testing or debugging

## BUILD A PROJECT

`go build` compiles go code into an executable program. Make sure you are in your repo to run this command. Is run from the same level as where the file `go.mod` is.

## INSTALL GLOBALLY ON MACHINE

`go install` compiles and installs the program globally. You can the run it from the cmd, like any other path available command.

**TIP ABOUT "NOT FOUND"**
If you get an error regarding "program not found" it means you probably don't have your Go environment setup properly. Specifically, `go install` is adding your binary to your `GOBIN` directory, but that may not be in your `PATH`.

## LIBRARY PACKAGE

Create a _sibling_ directory in the parent directory of the `hellogo` directory:

```bash
mkdir mystrings
```

Initialize a module:

```bash
go mod init {REMOTE}/{USER}/mystrings
```

Then create a new file `mystring.go` and add this code

```go
package mystrings

func Reverse(s string) string {
  result := ""
  for _, v := range s {
    result = string(v) + result
  }
  return result
}
```

`go build` won't build an executable from a library package. However, go build will still compile the package and save it to our local build cache. It's useful for checking for compile errors.

Now we can go to our `main.go` file and add:

```go
package main

import (
	"fmt"

	"{REMOTE}/{USERNAME}/mystrings"
)

func main() {
	fmt.Println(mystrings.Reverse("hello world"))
}
```

Don't forget to replace {REMOTE} and {USERNAME} with the values you used before. Then edit hellogo's go.mod file to contain the following:

```go
module example.com/username/hellogo

go 1.22.1

replace example.com/username/mystrings v0.0.0 => ../mystrings

require (
	example.com/username/mystrings v0.0.0
)
```

> Note: ../mystrings means look in the parent directory of hellogo for the mystrings sibling directory.

Be aware that using the "replace" keyword like we did in the last assignment isn't advised, but can be useful to get up and running quickly. The proper way to create and depend on modules is to publish them to a remote repository. When you do that, the "replace" keyword can be dropped from the go.mod. **This works for local-only development**

## INSTALL REMOTE PACKAGES

We can install remote packages with the command `go get`

## CLEAN PACKAGES

Learning to properly build small and reusable packages can take your Go career to the next level.

**Rules of thumb**

1. HIDE INTERNAL LOGIC ( A.K.A Encapsulation ):

   Oftentimes an application will have complex logic that requires a lot of code. In almost every case the logic that the application cares about can be exposed via an API, and most of the dirty work can be kept within a package. For example, imagine we are building an application that needs to classify images. We could build a package:

   ```go
   package classifier

    // ClassifyImage classifies images as "hotdog" or "not hotdog"
    func ClassifyImage(image []byte) (imageType string) {
    if hasHotdogColors(image) && hasHotdogShape(image) {
    return "hotdog"
    } else {
    return "not hotdog"
    }
    }

    func hasHotdogShape(image []byte) bool {
    // internal logic that the application doesn't need to know about
    return true
    }

    func hasHotdogColors(image []byte) bool {
    // internal logic that the application doesn't need to know about
    return true
    }
   ```

   We create an API by only exposing the function(s) that the application-level needs to know about. All other logic is unexported to keep a clean separation of concerns. The application doesn’t need to know how to classify an image, just the result of the classification.

2. DON’T CHANGE APIS

   The unexported functions within a package can and should change often for testing, refactoring, and bug fixing.

   A well-designed library will have a stable API so that users aren’t receiving breaking changes each time they update the package version. In Go, this means not changing exported function’s signatures.

3. DON’T EXPORT FUNCTIONS FROM THE MAIN PACKAGE

   A main package isn't a library, there's no need to export functions from it.

   Any capitalized function in Go is exported, which means that other programs can import and call those functions. Main packages can contain exported functions, but as a general rule don’t do it. It is confusing to future readers of the code, and in most cases accomplishes nothing.

4. PACKAGES SHOULDN'T KNOW ABOUT DEPENDENTS

   Perhaps one of the most important and most broken rules is that a package shouldn’t know anything about its dependents. In other words, a package should never have specific knowledge about a particular application that uses it.

   ```go
   package classifier

    // ClassifyImage uses a slightly different algorithm if
    // the image comes from boot.dev
    func ClassifyImage(image []byte, isBootdotdevImage bool) (imageType string) {
        return hasHotdogColors(image) && hasHotdogShape(image)
    }
   ```

   Here is an example of a clear violation of this rule. An image classifier shouldn’t have knowledge of a “boot.dev image”, which we can infer is an application that happens to depend on this package. The author should have made different types of classifiers for general use, and then the dependents of the package would be able to choose the correct one. Two apps that depend on the same package needn’t know about each other.
