# GO SERVERS

Processing HTTP requests with Go is primarily about two things: `handlers` and `servemuxes`.

If you’re coming from an MVC-background, you can think of `handlers` as being a bit like `controllers`. Generally speaking, they're responsible for carrying out your application logic and writing response headers and bodies.

Whereas a `servemux` (also known as a router) stores a mapping between the predefined URL paths for your application and the corresponding handlers. Usually you have one `servemux` for your application containing all your routes.

Go's `net/http` package ships with the simple but effective `http.ServeMux`, plus a few functions to generate common handlers including `http.FileServer()`, `http.NotFoundHandler()` and `http.RedirectHandler()`.

```go
package main

import (
	"log"
	"net/http"
)

func main() {
	// Use the http.NewServeMux() function to create an empty servemux.
	mux := http.NewServeMux()

	// Next we use the mux.Handle() function to register this with our new
	// servemux, so it acts as the handler for all incoming requests with the URL
	// path /foo.
	mux.Handle("/foo", rh)

	log.Print("Listening...")

	// Then we create a new server and start listening for incoming requests
	// with the http.ListenAndServe() function, passing in our servemux for it to
	// match requests against as the second argument.
	http.ListenAndServe(":8080", mux)
}
```

## CUSTOM HANDLERS

The handlers that ship with net/http are useful, but most of the time when building a web application you'll want to use your own custom handlers instead.

The first thing to explain is that anything in Go can be a handler so long as it satisfies the `http.Handler` interface, which looks like this:

```go
type Handler interface {
    ServeHTTP(ResponseWriter, *Request)
}
```

To help demonstrate, let's create a custom handler which responds with the current time in a specific format. Like this:

```go
type timeHandler struct {
	format string
}

func (th timeHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	tm := time.Now().Format(th.format)
	w.Write([]byte("The time is: " + tm))
}
```

The exact code here isn't too important.

All that really matters is that we have an object `timeHandler struct`, and we've implemented a method with the signature `ServeHTTP(http.ResponseWriter, *http.Request)` on it.

That's all we need to make a **handler**.

```main.go
package main

import (
	"log"
	"net/http"
	"time"
)

type timeHandler struct {
	format string
}

func (th timeHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	tm := time.Now().Format(th.format)
	w.Write([]byte("The time is: " + tm))
}

func main() {
	mux := http.NewServeMux()

	// Initialise the timeHandler in exactly the same way we would any normal
	// struct.
	th := timeHandler{format: time.RFC1123}

	// Like the previous example, we use the mux.Handle() function to register
	// this with our ServeMux.
	mux.Handle("/time", th)

	log.Print("Listening...")
	http.ListenAndServe(":3000", mux)
}
```

- Incoming HTTP request, hands it off to our `servemux`.
- The `servemux` then looks up the appropriate `handler` based on the request path
- The `servemux` then calls the `ServeHTTP()` method of the handler, which in turn writes out the HTTP response.

The eagle-eyed of you might have also noticed something interesting: the signature for the `http.ListenAndServe()` function is `ListenAndServe(addr string, handler Handler)`, but we passed a `servemux` as the second argument.

We were able to do this because the `http.ServeMux` type has a `ServeHTTP()` method, meaning that it too satisfies the `http.Handler` interface.

For me it simplifies things to think of `http.ServeMux` as just being a special kind of handler, which instead of providing a response itself passes the request on to a second handler. This isn't as much of a leap as it first sounds — chaining handlers together is very commonplace in Go.

### FUNCTIONS AS HANDLERS

For simple cases we can write the handler as a simple function instead:

```go
func timeHandler(w http.ResponseWriter, r \*http.Request) {
    tm := time.Now().Format(time.RFC1123)
    w.Write([]byte("The time is: " + tm))
}
```

This function itself is not a handler. But we can coerce it into being a handler by converting it to a `http.HandlerFunc` type.

Any function which has the signature `func(http.ResponseWriter, \*http.Request)` can be converted into a `http.HandlerFunc` type. This is useful because `http.HandlerFunc` objects come with an inbuilt `ServeHTTP()` method.

```main.go
package main

import (
    "log"
    "net/http"
    "time"
)

func timeHandler(w http.ResponseWriter, r \*http.Request) {
    tm := time.Now().Format(time.RFC1123)
    w.Write([]byte("The time is: " + tm))
}

func main() {
    mux := http.NewServeMux()

    // Convert the timeHandler function to a http.HandlerFunc type.
    th := http.HandlerFunc(timeHandler)

    // And add it to the ServeMux.
    mux.Handle("/time", th)

    log.Print("Listening...")
    http.ListenAndServe(":3000", mux)

}
```

In fact, converting a function to a `http.HandlerFunc` type and then adding it to a `servemux` like this is so common that Go provides a shortcut: the `mux.HandleFunc()` method.

```main.go
func main() {
    mux := http.NewServeMux()

    mux.HandleFunc("/time", timeHandler)

    log.Print("Listening...")
    http.ListenAndServe(":3000", mux)

}
```

### PASSING VARIABLES TO HANDLERS

Most of the time using a function as a handler like this works well. But there is a bit of a limitation when things start getting more complex.

You've probably noticed that, unlike the method before, we've had to hard-code the time format in the `timeHandler` function.

A neat approach is to put our handler logic into a closure, and close over the variables we want to use, like this:

```main.go
package main

import (
    "log"
    "net/http"
    "time"
)

func timeHandler(format string) http.Handler {
    fn := func(w http.ResponseWriter, r \*http.Request) {
        tm := time.Now().Format(format)
        w.Write([]byte("The time is: " + tm))
    }
    return http.HandlerFunc(fn)
}

func main() {
    mux := http.NewServeMux()

    th := timeHandler(time.RFC1123)
    mux.Handle("/time", th)

    log.Print("Listening...")
    http.ListenAndServe(":3000", mux)

}
```

The `timeHandler()` function now has a subtly different role. Instead of coercing the function into a handler, we are now using it to return a handler.

- It creates `fn`, an anonymous function which accesses — or closes over — the format variable forming a closure.
- The closure has the signature `func(http.ResponseWriter, \*http.Request)`.
- Our `timeHandler()` function then returns this converted closure.

In this example we've just been passing a simple string to a handler. But in a real-world application you could use this method to pass database connection, template map, or any other application-level context. It's a good alternative to using global variables, and has the added benefit of making neat self-contained handlers for testing.

You might also see this same pattern written as:

```go
func timeHandler(format string) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r \*http.Request) {
        tm := time.Now().Format(format)
        w.Write([]byte("The time is: " + tm))
    })
}
```

Or using an implicit conversion to the http.HandlerFunc type on return:

```go
func timeHandler(format string) http.HandlerFunc {
    return func(w http.ResponseWriter, r \*http.Request) {
        tm := time.Now().Format(format)
        w.Write([]byte("The time is: " + tm))
    }
}
```
