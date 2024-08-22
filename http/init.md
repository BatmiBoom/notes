# HTTP

## Communicating on the web

Instagram would be pretty terrible if you had to manually copy your photos to your friend's phone when you wanted th shore them. Modern applications need to be able to communicate information between devices over the internet

- Gmail doesn't just store your emails in variables on your computer, it stores them on computers in their data centers
- You don't lose your slack messages if you drop your computer in a lake, those messages exist on Slack's servers

## How does web communication work

When two computers communicate with each other, they need to use the same rules. An english speaker can't communicate verbally with a Japanese speaker, similarly, two computers need to speak the same language to communicate

This "language" that computers use is called a protocol. The most popular protocol for web communication is HTTP, which stands for `Hypertext Transfer Protocol`

## REQUESTS and RESPONSES

At the heart of HTTP is a simple request-response sysetm. The "requesting" computer, also known as the **client**, asks another computer for some information. That computer, **the server** sends back a response with the information that was requested

```text
|-----------|    Request    |------------|
|  Client   |-------------->|   Server   |
| (browser) |               |------------|
|           |
| - phone   |    Response   |------------|
| - laptop  |<--------------|   Server   |
| - desktop |               |------------|
| - etc     |
|___________|
```

- A "client" is a computer making an HTTP request
- A "server" is a computer responding to an HTTP request
- A computer can be a client, a server, both, or neither. "Client" and "server" are just words we use to describe what computers are doing within a communication system.
- Clients send requests and receive responses
- Servers receive requests and send responses

## HTTP URLS

A URL, or **Uniform Resource Locator**, is essentially the address of another computer, or "server" on the internet. Part of the URL specifies how to reach the server, and part of it tells the server what information we want.

The `http://` at the beginning of a website URL specifies that the `http` protocol will be used for communication.

Other communication protocols use URLs as well, (hence "Uniform Resource Locator").

That's why we need to be specific when we're making HTTP requests by prefixing the URL with: `http://`

### URL PATHS

The URL Path comes right after the domain (or port if one is provided) in a URL string.

In this URL, the path is `/root/next`:

- `http://testdomain.com/root/next`

**What PATHS meant in the early internet**

In the early days of the internet, and sometimes still today, many web servers simply served raw files from the server's file system. For example, if I wanted you to be able to access some text documents, I could start a web server in my documents directory. If you made a request to my server you would be able to access different documents by using the path that matched my local file structure.

If I had a file in my local /documents/hello.txt, you could access it by making a GET request to http://example.com/documents/hello.txt.

**How PATHS are used today**

Most modern web servers don't use that simple mapping of `URL path -> file path`. Technically, a URL path is just a string that the web server can do what it wants with, and modern websites take advantage of that flexibility. Some common examples of what paths are used for include:

- The hierarchy of pages on a website, whether or not that reflects a server's file structure
- Parameters being passed into an HTTP request, like an ID of a resource
- The version of the API
- The type of resource being requested

### URL QUERY PARAMETERS

A _URL's query parameters_ appear next in the URL structure but are not always present - they're optional. For example:

`https://www.google.com/search?q=boot.dev`

`q=boot.dev` is a query parameter. Like headers, query parameters are key / value pairs. In this case, q is the key and boot.dev is the value.

**MULTIPLE QUERY PARAMETERS**

We mentioned that query parameters are key/value pairs - that means we can have multiple pairs!

`http://example.com?firstName=lane&lastName=wagner`

In the example above:

- `firstName = lane`
- `lastName = wagner`

The `?` separates the query parameters from the rest of the URL. The `&` is then used to separate every pair of query parameters after that.

## Javascript's FETCH API

- [FETCH API](../javascript/javascript_http.md)

## Web clients

A web client isa device making request to a web server.

A client can be any type of device but is often something users physically interact with. For example:

- A desktop computer
- A mobile phone
- A tablet

In a website or web application, we call the user's device the "front-end".

A front-end client makes requests to a back-end server

## Web Servers

### Listening and serving data

Similar to how a server at a restaurant brings food to the table, a web server serves web resources, such as web pages, images, and other data. The server is turned on and "listening" for inbound requests constantly so that the second it receives a new request, it can send an appropiate response.

### The server is the back-end

While the "front-end" of a website or web app is the device the user interacts with, the "back-end" is the server that keeps all the data housed in a central location

### A server is just a computer

"Server" is just the name we give to a computer that is taking on the role of serving data across a network connection. A good server is turned on and available 24 hours a day, 7 days a week. While your laptop can be used as a server, it makes more sense to use a computer in a data center that's designed to be up and running constantly.

## DNS

### Web Addresses

In the real world, we use addresses to help us find where a friend lives, where a business is located, or where a party is beign thrown. In computing, web clients find other computers over the internet using **Internet Protocol or IP** addresses.

An IP address is a numerical label that serves two main functions:

1. Location Addressing
2. Network Identification

#### Domain Names and IP Addresses

Each device connected to the internet has a unique IP address. When we browse the internet, the domains we navigate to are all associated with a particular IP address!

For example. this Wikipedia URL points to a page about miniature pigs:
`https://en.wikipedia.org/wiki/Miniature_pig`

The _domain_ portion of the URL is `en.wikipedia.org`

`en.wikipedia.org` converts to a specific IP address, and that IP address tells your computer exactly where to communicate with that Wikipedia page.

Deploying a real website to the internet is actually quite simple. It involves only a couple of steps:

- Create a server that hosts your website files and connect it to the internet
- Acquire a domain name
- Connect the domain name to the IP address of your server
- Your server is accessible via the internet!

**Using the URL Api in Javascript**

- [URL API](../javascript/url_api.md)

**What is the DOMAIN NAME SYSTEM**

DNS, or the "Domain Name System", is the phonebook of the internet. Humans connect to websites through domain names, like boot.dev. DNS "resolves" these domain names to find the associated IP addresses so that web clients can load the resource for the specific address

**How does it work?**

ICANN is a not-for-profit organaztion that manages DNS for the entire internet.

Whenever your computer attempts to resolve a domain name, it contacts one of ICANN's "root nameservers" whose address is included in your computer's networking configuration.
From there, that nameserver can gather the domain records for a specific domain name from their distributed DNS database.
If you think of DNS as a phonebook, ICANN is the publisher that keeps the phonebook in print and available.

## SubDomains

A subdomain prefixes a domain name, allowing a domain to route network traffic to many different servers and resources.

For example, the boot.dev website that you're on right now is hosted on a different computer than our blog. Our blog, found at blog.boot.dev is hosted on our "blog" subdomain

## Uniform Resource Identifiers (URI)

A URI, or Uniform Resource Identifier, is a unique character sequence that identifies a resource that is (almost always) accessed via the internet.

Just like JS has syntax rules, so do URIs. These rules help ensure uniformity so that any program can interpret the meaning of the URI in the same way.

URIs come in two main types:

- URLs ( Uniform Resource Locator )
- URNs ( Uniform Resource Name )

```text
|-------------------------------------|
|                                     |
|         URI (identifier)            |
|        ISBN 0-486-27557-4           |
|                                     |
|                                     |
|                                     |
|                                     |
|  |-------------| |---------------|  |
|  |  URN (name) | | URL (locator) |  |
|  | urn:isbn:...| | https://go..  |  |
|  |             | |               |  |
|  |_____________| |_______________|  |
|                                     |
|                                     |
|_____________________________________|
```

## Sections of a URL

URL = http://dragonslayer:pwn3d@fantasy.com:8080/maps?sort=rank#id

| Protocol | Username     | Password | Domain  | Port | Path | Query    | Fragment |
| -------- | ------------ | -------- | ------- | ---- | ---- | -------- | -------- |
| http:    | dragonslayer | pwn3d    | fantasy | 8080 | maps | sort=ran | id       |

- The protocol is required
- Usernames and passwords are optional
- A domain is required
- The default port for a given protocol is used if one is not provided
- The default (/) path is used if one isn't provided
- A query is optional
- A fragment is optional

### THE PROTOCOL

The "protocol", aslo referred to as the "scheme", is the first component of a URL. Its purpose is to define the rules by which the data being communicated is displayed, encoded or formatted.

Some examples of different URL protocols:

- http (http://example.com)
- https
- ftp
- mailto (mailto:noreply@fantasyquest.app)

**Not all schemes require a "//"**

The "http" in a URL is always followed by ://. All URLs have the colon, but the // part is only included for schemes that have an authority component. As you can see above, the mailto scheme doesn't use an authority component, so it doesn't need the slashes.

### URL Ports

The port in a URL is a virtual point where network connections are made. Ports are managed by a computer's operating system and are numbered from 0 to 65,535. It should be noted that port 0 is reserved for the system API and technically not an actual port.

Whenever you connect to another computer over a network, you're connecting to a specific port on that computer, which is being listened to by a specific piece of software on that computer. A port can only be used by one program at a time, which is why there are so many possible ports.

The port component of a URL is often not visible when browsing normal sites on the internet, because 99% of the time you're using the default ports for the HTTP and HTTPS schemes: 80 and 443 respectively.

Whenever you aren't using a default port, you need to specify it in the URL. For example, port 8080 is often used by web developers when they're running their server in "test mode" so that they don't use the "production" port "80".

**http://google.com:80/q=bootdev == http://google.com/q=bootdev**

### URL Paths

In the early days of the internet, a URL's path often was a reflection of the file path on the server to the resource the client was requesting.

For example, if the website https://exampleblog.com had a web server running within its /home directory, then a request to the https://exampleblog.com/site/index.html URL might expect the index.html file from within the /home/site directory to be returned.

Websites used to be very simple. They were just a collection of text documents stored on a server. A simple piece of server software could handle incoming HTTP requests and respond with the documents according to the path component of the URLs.

On many modern web servers, a URL's path isn't a reflection of the server's filesystem hierarchy. Paths in URLs are essentially just another type of parameter that can be passed to the server when making a request.

Conventionally, two different URL paths should denote different resources. For example, different pages on a website, or maybe different data types from a game server.

### Query Paramters

Query parameters in a URL are not always present. In the context of websites, query parameters are often used for marketing analytics or for changing a variable on the web page. With website URLs, query parameters rarely change which page you're viewing, though they often will change the page's contents.

That said, query parameters can be used for anything the server chooses to use them for, just like the URL's path.

**HOW GOOGLE USES QUERY PARAMETERS**

- Open a new tab and go to https://google.com.
- Search for "hello world"
- Take a look at your current URL. It should start with https://www.google.com/search?q=hello+world
- Change the URL to say https://www.google.com/search?q=hello+universe
- Press "enter"
- You should see new search results for the query "hello universe".

Google chose to use query parameters to represent the value of your search query. It makes sense - each search result page is essentially the same page as far as structure and formatting are concerned - it's just showing you different results based on the search query.

## HTTP HEADERS

An HTTP header allows clients and servers to pass additional information with each request or response. Headers are just case-sensitive key-value pairs that pass additional metadata about the request or response

HTTP requests from a web browser carry with them many headers, including but not limited to:

- The type of client (e.g Google Chrome)
- The Operating System (e.g Windows)
- The preferred language (e.g English)

As developers, we can also define custom headers in each request

## HEADERS API

The `Headers` API allows us to perform various actions on our request and response headers such as retrieving, setting, and removing them. We can access the headers object through properties

- `Request.headers`
- `Response.headers`

**WHY ARE HEADERS USEFUL?**

Headers are useful for several reasons:

- Design
- Security,
- Metadata or data about the request.

A good example of a use case for headers is authentication. Often times a user's credentials are included in request headers. Credentials don't have much to do with the request itself, but simply authorize the requester to be allowed to make the request in question.

## HTTP GET

The `GET` method is used to 'get' a representation of a specified resource. You are not taking the data away from the server, but rather getting a representation, or copy, of the resource in its current state. A get request is considered a safe method to call multiple times because it doesn't alter the state of the server

## HTTP POST

An `POST` request sends data to a server, typically to create a new resource.

The `body` of the request is the payload sent to the server. The special `Content-Type` header is used to tell the server the format of the body: `application/json` for JSON data in our case.

`POST` requests are generally not safe methods to call multiple times because that would create duplicate records. For example, you wouldn't want to accidentally send a tweet twice.

The difference between `PUT` and `POST` is that `PUT` is idempotent: calling it once or several times successively has the same effect (that is no side effect), where successive identical POST may have additional effects, like passing an order several times.

## HTTP PUT

The HTTP PUT method creates a new resource or replaces a representation of the target resource with the contents of the request's body. In short, it updates a resource's properties.

## HTTP PATCH

The PATCH method is intended to partially modify a resource.

Long story short, PATCH isn't nearly as popular as PUT, and many servers, even if they allow partial updates, will still just use the PUT method for that.

## HTTP DELETE

The delete request does exactly as you would expect: it deletes a specified resource.

## HTTP STATUS CODE

When looking at requests we can check on the Status Code of the request to get some information if the request was successful or not

- 100-199: Informational responses. These are very rare.
- 200-299: Successful responses. Hopefully, most responses are 200's!
- 300-399: Redirection messages. These are typically invisible because the browser or HTTP client will automatically do the redirect.
- 400-499: Client errors. You'll see these often, especially when trying to debug a client application
- 500-599: Server errors. You'll see these sometimes, usually only if there is a bug on the server.

## RESTFUL APIS

[rest](./restful_apis.md)

## HTTPS

[https](./https.md)
