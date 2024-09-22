# Web Server

A web server is just a computer that serves data over a network, typically the Internet.

Servers run software that listens for incoming requests from clients. When a request is received, the server responds with the requested data.

```
|---------|
|  Phone  | -------------------------|
|_________|                          |
                                     |            |---------------|
|---------|                          |            |               |
|  Phone  | -------------------------|----------> |     Server    |
|_________|                          |            |               |
                                     |            |---------------|
|---------|                          |
| Laptop  | -------------------------|
|_________|
```

Any server worth its salt can handle many requests at the same time. In Go, we do this by spawning a new `goroutine` for each request.

## GOROUTINES IN SERVERS

In Go, `goroutines` are used to serve many requests at the same time, but not all servers are quite so performant.

Go was built by Google, and one of the purposes of its creation was to power Google's massive web infrastructure. Go's `goroutines` are a great fit for web servers because they're lighter weight than operating system threads, but still take advantage of multiple cores. Let's compare a Go web server's concurrency model to other popular languages and frameworks.

## NODE.JS / EXPRESS.JS

In JavaScript land, servers are typically single-threaded. A Node.js server (often using the Express framework) only uses one CPU core at a time. It can still handle many requests at once by using an `async` event loop. That just means whenever a request has to wait on I/O (like to a database), the server puts it on pause and does something else for a bit.

This might sound horribly inefficient, but it's not too bad. Node servers do just fine with the I/O workloads associated with most CRUD apps (Where processing is offloaded to the Database). You only start to run into trouble with this model when you need your server to do CPU-intensive work.

## PYTHON / DJANGO / FLASK

Django and Flask are two of the most popular back-end Python frameworks. They're both built on top of the WSGI standard, which is a specification for how web servers and web applications should communicate.

Generally speaking, Python application code only processes a single request at a time. This means that if a request is being processed, the application won't do anything else until it's finished.

The only reason this isn't completely debilitating is there is a separate WSGI process (for example uwsgi) that handles the concurrency of the application code. It can spawn multiple processes of the Python application to handle different requests at once.

In other words, uwsgi + Flask or uwsgi + Django are both needed to handle the same things that a single Node.js or Go server does alone.

## FILE SERVERS

A _file-server_ is a kind of simple web server that serves static files from the host machine. File-servers are often used to serve static assets for a website, things like:

- HTML
- CSS
- JavaScript
- Images

## Workflow tips

Servers are interesting because they're always running. They run forever, waiting for requests to come in, processing them, sending responses, and then waiting for the next request.

## Debugging a server

The simplest way (minimal tooling) is to:

- Write some code
- Build and run the code
- Send a request to the server using a browser or some other HTTP client
- See if it did what you expected.
- If it didn't, add some logging or fix the code, and go back to step 2.

## Restarting a server

I usually use a single command to build and run my servers, assuming I'm in my main package directory:

```console
go run .
```

This builds the server and runs it in one command.

## Custom Handlers

We have been using the `http.FileServer` function, which simply returns a built-in http.Handler.

An `http.Handler` is just an interface:

```go
type Handler interface {
	ServeHTTP(ResponseWriter, *Request)
}
```

Any type with a `ServeHTTP` method that matches the `http.HandlerFunc` signature above is an `http.Handler`. **To handle an incoming HTTP request, all a function needs is a way to write a response and the request itself.**

**Readiness endpoints are commonly used by external systems to check if our server is ready to receive traffic.**

I recommend using the `mux.HandleFunc` to register your handler. Your handler can just be a function that matches the signature of `http.HandlerFunc`:

```go
handler func(http.ResponseWriter, *http.Request)
```

## STATEFUL HANDLERS

It's frequently useful to have a way to store and access state in our handlers. For example, we might want to keep track of the number of requests we've received, or we may want to pass around an open connection to a database, or credentials to an API.

### STEPS

Create a `struct` that will hold any stateful, in-memory data we'll need to keep track of.

```go
type apiConfig struct {
	fileserverHits int
}
```

Next, write a new middleware method on a `*apiConfig` that increments the `fileserverHits` counter every time it's called. Here's the method signature I used:

```go
func (cfg *apiConfig) middlewareMetricsInc(next http.Handler) http.Handler {
	// ...
}
```

Wrap the `http.FileServer` handler with the middleware method we just wrote. For example:

```go
mux.Handle("/app/*", apiCfg.middlewareMetricsInc(handler))
```

Create a new handler that writes the number of requests that have been counted as plain text in this format to the HTTP response:

`Hits: x`

Where x is the number of requests that have been processed. This handler should be a method on the `*apiConfig struct` so that it can access the `fileserverHits` data.

## MIDDLEWARE

Middleware is a way to wrap a handler with additional functionality. It is a common pattern in web applications that allows us to write DRY code. For example, we can write a middleware that logs every request to the server. We can then wrap our handler with this middleware and every request will be logged without us having to write the logging code in every handler.

### ROUTING

The Go standard library has a lot of powerful HTTP features and comes equipped with method-based pattern matching for routing.

There are other powerful routing libraries like `Gorilla Mux` and `Chi`.

We can limit which endpoints are available via which HTTP methods.

```go
mux.HandleFunc("POST /articles", handlerArticlesCreate)
mux.HandleFunc("DELETE /articles", handlerArticlesDelete)
```

## ROUTING - PATTERNS

A pattern is a string that specifies the set of URL paths that should be matched to handle HTTP requests. Go's `ServeMux` router uses these patterns to dispatch requests to the appropriate handler functions based on the URL path of the request. As we saw in the previous lesson, patterns help organize the handling of different routes efficiently.

As previously mentioned, patterns generally look like this: `[METHOD ][HOST]/[PATH]`. Note that all three parts are optional.

### Rules and Definitions

#### Fixed URL Paths

A pattern that exactly matches the URL path. For example, if you have a pattern /about, it will match the URL path /about and no other paths.

#### Subtree Paths

If a pattern ends with a slash /, it matches all URL paths that have the same prefix. For example, a pattern `/images/` matches `/images/`, `/images/logo.png`, and `/images/css/style.css`. As we saw with our `/app/*` path, this is useful for serving a directory of static files or for structuring your application into sub-sections.

#### Longest Match Wins

If more than one pattern matches a request path, the longest match is chosen. This allows more specific handlers to override more general ones. For example, if you have patterns `/` (root) and `/images/`, and the request path is `/images/logo.png`, the `/images/` handler will be used because it's the longest match.

#### Host-specific Patterns

We won't be using this but be aware that patterns can also start with a `hostname`.This allows you to serve different content based on the Host header of the request. If both host-specific and non-host-specific patterns match, the host-specific pattern takes precedence.

When a request is made to one of these endpoints with a method other than GET, the server should return a 405 (Method Not Allowed) response (this is handled automatically!).

## Admin Namespace

One of the advantages of a monolithic architecture is that it's fairly simple to inject data directly into the HTML of a web page.

## Deployment Options

### Monolithic deployment

Deploying a monolith is straightforward. Because your server is just one program, you just need to get it running on a server that's exposed to the internet and point your DNS records to it.

You could upload and run it on classic server, something like:

- AWS EC2
- GCP Compute Engine (GCE)
- Digital Ocean Droplets
- Azure Virtual Machines

Alternatively, you could use a platform that's specifically designed to run web applications, like:

- Heroku
- Google App Engine
- Fly.io
- AWS Elastic Beanstalk

### Decoupled deployment

With a decoupled architecture, you have two different programs that need to be deployed. You would typically deploy your back-end to the same kinds of places you would deploy a monolith.

For your front-end server, you can do the same, or you can use a platform that's specifically designed to host static files and server-side rendered front-end apps, something like:

- Vercel
- Netlify
- GitHub Pages

Because the front-end bundle is likely just static files, you can host it easily on a CDN (Content Delivery Network) inexpensively.

### More powerful options

    If you want to be able to scale your application up and down in specific ways, or you want to add other back-end servers to your stack, you might want to look into container orchestration options like Kubernetes and Docker Swarm.
