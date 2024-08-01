# Writing Gleam

This guide shows you how to create and develop a Gleam project.

## The project

In this guide we’re going to make a small command line program for printing environment variables.

In use it’ll look like this:

```console
gleam run get USER
# USER=lucy
```

## Creating a project

Gleam’s build tool is built into the gleam program you installed earlier. It supports creating new projects, building, testing, and running them, along with managing dependencies from the Hex package manager.

First create a new Gleam project by running the gleam new command in a terminal. I’m going to call mine vars.

```console
# Create the project
gleam new vars

# Navigate into the project directory
cd vars
```

You’ll now have a project with this structure:

```console
.
├── .github/workflows/test.yml
├── .gitignore
├── README.md
├── gleam.toml
├── src/vars.gleam
└── test/vars_test.gleam
```

- `README.md` file is where you’d write introductory documentation for your project in markdown format.
- `gleam.toml` file contains the configuration for the project.
- `src/` contains the program source.
- `test/` contains additional code for testing the project.
- `.gitignore` contains configuration for the git version control system.
- `.github/workflows/test.yml` defines a GitHub Actions workflow that will run the project’s tests if you push it to a GitHub repository.

Altogether this is called a Gleam package, regardless of whether it’s a library or a program that is run directly.

## Running the project

The _entrypoint_ for the program is the function called `main` in the module with the same name as the package itself. `gleam new` will have generated one for you that looks like this:

```gleam
// In src/vars.gleam
import gleam/io

pub fn main() {
  io.println("Hello from vars!")
}
```

In the terminal run this command to run the project.

```console
gleam run
```

If you wanted to run a different module in your package, or a module from a dependency, you could run `gleam run -m modulename`.

You can run `gleam run --target javascript` to run the project on a JavaScript runtime instead of Erlang, though for the rest of this guide we’ll continue with Erlang.

## Adding dependencies

Gleam can run in constrained environments like embedded systems or browsers, so some functionality is not included in the standard library, such as reading command line inputs and environment variables. For our program to do these we’ll need to add some dependencies that provide this functionality.

The Gleam Package Index can be used to find packages. In this case we want to use `envoy` for environment variables and `argv` for reading command line input. Add them to your package with this command:

```console
gleam add envoy arg
```

If you look at the `gleam.toml` file you’ll see that the dependencies have been added to the `[dependencies]` section.

```toml
name = "vars"
version = "1.0.0"

[dependencies]
gleam_stdlib = ">= 0.34.0 and < 2.0.0"
envoy = ">= 1.0.1 and < 2.0.0"
argv = ">= 1.0.2 and < 2.0.0"

[dev-dependencies]
gleeunit = ">= 1.0.0 and < 2.0.0"
```

The >= 1.0.1 and < 2.0.0 version constraint means that the project wants any version greater than or equal to 1.0.1, but less than 2.0.0, which will maximise compatibility while avoiding breaking changes as Hex packages adhere to semantic versioning.

There is now also a `manifest.toml` file which locks all the dependency packages to specific versions. It’s recommended to check this file into your version control system to ensure that anyone who downloads and runs your project will get the same versions of the dependencies. This manifest file isn’t uploaded to Hex so it is not used when other projects depend on your project.

If you wish to update the dependencies to the latest versions that are compatible with your version constraints you can run `gleam update`.

You can also use path dependencies to depend on packages on your computer rather than from Hex.

```toml
[dependencies]
my_other_package = { path = "../my_other_package" }
```

## Using dependencies

The `argv` module from the package of the same name exports a function called load that can be used to read the command line arguments. Update the code in `src/vars.gleam` to use this function.

```gleam
import argv
import envoy
import gleam/io
import gleam/result

pub fn main() {
  case argv.load().arguments {
    ["get", name] -> get(name)
    _ -> io.println("Usage: vars get <name>")
  }
}

fn get(name: String) -> Nil {
  let value = envoy.get(name) |> result.unwrap("")
  io.println(format_pair(name, value))
}

fn format_pair(name: String, value: String) -> String {
  name <> "=" <> value
}
```

Pattern matching is being used to call the `get` function or print a help message based on the command line arguments.

The `get` function uses the `envoy` module from the package of the same name to read the environment variable and print it or a message if it doesn’t exist. A helper function `format_pair` is used to format the output.

Give it a try! Run `gleam run get TERM` in the terminal to recompile and run the program.

## Testing your code

To call the `format_pair` function from a module in the `test/` directory we will need to make it `public`. We don’t want it to be part of the public API of the package, so we’ll move it to an internal module, which by default are modules named `packagename/internal` and `packagename/internal/*`.

Public functions in these modules can be imported by other modules, but they’re considered to be part of the package’s internal implementation and as such are not documented or expected to give the same stability guarantees as functions in the public API.

```vars.gleam
import argv
import envoy
import gleam/io
import gleam/result
import vars/internal

pub fn main() {
  // Omitted for brevity
}

fn get(name: String) -> Nil {
  let value = envoy.get(name) |> result.unwrap("")
  io.println(internal.format_pair(name, value))
}
```

```src/vars/internal.gleam
pub fn format_pair(name: String, value: String) -> String {
  name <> "=" <> value
}
```

Open up the `test/vars_test.gleam` file and write a test for the `format_pair`.

```test/vars_test/gleam
import gleeunit
import gleeunit/should
import vars/internal

pub fn main() {
  gleeunit.main()
}

pub fn format_pair_test() {
  internal.format_pair("hello", "world")
  |> should.equal("hello=world")
}
```

Running `gleam test` will call the `main` function in `vars_test`, which will in turn run the tests.

Your test main function can do anything you like, but by default Gleam projects are generated using `gleeunit`, a simple test runner. With it any public function in the `test/` directory with a name ending in `_test` will be run as a test.

## Sharing your program

The program we have just made is a cli program, so we’ll want to bundle it up into a single file that can be easily shared with others.

As we’re using the Erlang target we can do this using `escript`, which is part of the Erlang runtime. Add the `gleescript` package as a dependency.

```console
gleam add --dev gleescript
```

The `--dev` flag is used to indicate that this package is only used for building, developing, and testing the project, and should not be included in the final production builds. The build tool will then add `gleescript` to the `[dev-dependencies]` section rather than the regular `[dependencies]` section.

Once added run `gleam run -m gleescript` to compile your package into an `escript` file, which will be written to `./vars`.

```console
# Compile the program to an escript
gleam run -m gleescript

# Make the escript executable
chmod +x ./vars

# Run the program
./vars get USER
escript ./vars get USER # On Windows
```

This vars file can be run on any computer that has a compatible version of Erlang installed. Typically this will be within a few major versions of the version of Erlang on the computer used to compile the `escript`.
