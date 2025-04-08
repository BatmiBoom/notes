# Building Images

Docker can build images automatically by reading the instructions from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image.

Dockerfile are amazing because they allow us to define the environment our applications are meant to use in code. We can even commit the Dockerfiles to Git alongside our source code.

- [KEYWORDS](./docker_keywords.md)

## Creating a Dockerfile

Create a single file called `Dockerfile` in your working directory.

Inside the Dockerfile add these lines of text:

```Dockerfile
# This is a comment

# Use a lightweight debian os
# as the base image
FROM debian:stable-slim

# execute the 'echo "hello world"'
# command when the container runs
CMD ["echo", "hello world"]
```

## Build a new image from the Dockerfile:

```bash
docker build . -t helloworld:latest
```

`-t helloworld:latest` tags the image with the name "helloworld" and the "latest" tag. Names are used to organize your images, and tags are used to keep track of different versions.

Run your image in a new container:

```bash
docker run helloworld
```

If all went well, you'll see "hello world" printed to the console!

Next, run docker ps. You'll notice that your container isn't running anymore! All it did was print and exit. Just like regular programs, docker containers can execute simple commands that exit quickly, or they can execute servers that run until killed.

You can see the stopped container by running docker ps -a. Feel free to delete the Dockerfile, we don't need it anymore.

## Dockerizing a server

Let's dockerize a web server. We're gonna use this code as a server

The example is gonne be in `example/server`

```go
package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

func main() {
	m := http.NewServeMux()

	m.HandleFunc("/", handlePage)

	const addr = ":8080"
	srv := http.Server{
		Handler:      m,
		Addr:         addr,
		WriteTimeout: 30 * time.Second,
		ReadTimeout:  30 * time.Second,
	}

	// this blocks forever, until the server
	// has an unrecoverable error
	fmt.Println("server started on ", addr)
	err := srv.ListenAndServe()
	log.Fatal(err)
}

func handlePage(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/html")
	w.WriteHeader(200)
	const page = `<html>
                    <head></head>
                    <body>
                        <p> Hello from Docker! I'm a Go server. </p>
                    </body>
                  </html>
                  `
	w.Write([]byte(page))
}
```

## Build your app server

Run go build to build your web server, the compiled program's name will be the same name as the parent directory.

## Make sure you can run your server

If you can't run your server normally, it will be hard to get it running in Docker.
If the server starts up and is listening on a port, you're good to go.

## Creating the image

Now that you know how to run your server manually, let's run it in Docker! First, we need to create a Dockerfile in the root of your server's repo. Let's start with a simple lightweight Debian Linux OS again.

```Dockerfile
FROM debian:stable-slim
Copy icon
Add server dependencies
We need to add any files our server requires to run from our host system to the image. Add a COPY command on the next line of your Dockerfile. In the case of a simple compiled Go server, all we need is the program itself!

# COPY source destination
COPY main /bin/main

# Run the server on image startup
CMD ["/bin/goserver"]
```

It's also worth mentioning that the `ADD` command would also work here, but `COPY` is the better choice for us because we don't need the extra functionality that `ADD` offers.

## Build your server's docker image

`docker build . -t goserver:latest`

Run your docker container

`docker run -p 8080:8080 goserver`

You should be able to access your server like before, but this time it's running inside of Docker!

## Creating an environment

You may be thinking, "What's the point of dockerizing this simple service"? Well, at the moment, there are only a couple of benefits:

- Anyone with Docker can run your image, regardless of their OS
- You could deploy your image on any cloud service that uses images (most of them). Kubernetes, which is something we'll cover later, is a way to build entire production back-end architectures using dockerized apps.
- If your server is written in Python, you can bundle the required interpreter inside of your image. Users won't need to download and configure their own Python versions.
- That said, because our app is so simple, there's just not much environment required, and one of the best things about Docker is that it allows you to ship an entire environment!

## The "port" your server binds to should be configurable

Alter the code of your application so that it reads an environment variable called PORT.

Test your code by setting an environment variable within your shell and running your server. To set an environment variable in Bash:

```bash
export PORT=8080
```

To make sure you set it correctly you can read it from your shell:

```bash
echo $PORT
```

## Environment variables are great

Environment variables are a platform-agnostic way to configure your applications. When running your code locally, you can use variables local to your machine: a local database for example. Then, when running in production you can swap out the connection string for a production database; all without changing your committed code.

Update your Dockerfile to set the PORT environment variable at build time

Use the `ENV` command. You'll need to do it before the `CMD` command.

```Dockerfile
ENV PORT=8080
```

If all goes well, your app will still run in the browser. Now your application is configurable, but your image still ships a specific configuration that's ready to go.

Run and submit the tests. from your working directory.

## Dockerizing something like python

With go programs is easy because we don't need to export the go compiler, but with a python script for example we have to include the interpreter

The code for this project will be in `example/bookbot`

```python
def main():
    book_path = "books/frankenstein.txt"
    text = get_book_text(book_path)
    num_words = get_num_words(text)
    chars_dict = get_chars_dict(text)
    chars_sorted_list = chars_dict_to_sorted_list(chars_dict)

    print(f"--- Begin report of {book_path} ---")
    print(f"{num_words} words found in the document")
    print()

    for item in chars_sorted_list:
        if not item["char"].isalpha():
            continue
        print(f"The '{item['char']}' character was found {item['num']} times")

    print("--- End report ---")


def get_num_words(text):
    words = text.split()
    return len(words)


def sort_on(d):
    return d["num"]


def chars_dict_to_sorted_list(num_chars_dict):
    sorted_list = []
    for ch in num_chars_dict:
        sorted_list.append({"char": ch, "num": num_chars_dict[ch]})
    sorted_list.sort(reverse=True, key=sort_on)
    return sorted_list


def get_chars_dict(text):
    chars = {}
    for c in text:
        lowered = c.lower()
        if lowered in chars:
            chars[lowered] += 1
        else:
            chars[lowered] = 1
    return chars



def get_book_text(path):
    with open(path) as f:
        return f.read()


main()
```

We're going to create a Dockerfile for this script, we can start with

```Dockerfile
FROM debian:stable-slim
COPY main.py main.py
COPY books/ books/
CMD ["python", "main.py"]
```

- Note 1: We need the actual code. We're copying the Python code, as well as the data our program needs from the books directory.
- Note 2: No Port. Bookbot isn't a web server, it's just a script that runs once and exits. It doesn't need to bind to a port.

If we build the image as it is and run it, we are gonna get an error `The Python executable was not found`

**We need to add the entire Python runtime to our image to be able to run Python code in a container!**

Before the first COPY line, let's install Python. We'll use the RUN command, and because this is a Debian/Linux image, we'll use apt to get some dependencies, then we'll build the Python source code.

I've included the full Dockerfile you'll need here, along with some annotations about how it works.

```Dockerfile
# Build from a slim Debian/Linux image
FROM debian:stable-slim

# Update apt
RUN apt update
RUN apt upgrade -y

# Install build tooling
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev

# Download Python interpreter code and unpack it
RUN wget https://www.python.org/ftp/python/3.10.8/Python-3.10.8.tgz
RUN tar -xf Python-3.10.*.tgz

# Build the Python interpreter
RUN cd Python-3.10.8 && ./configure --enable-optimizations && make && make altinstall

# Copy our code into the image
COPY main.py main.py

# Copy our data dependencies
COPY books/ books/

# Run our Python script
CMD ["python3.10", "main.py"]
```

## Rebuild the image

```bash
docker build -t bookbot .
```

It might take a few minutes to build the image. Again, this is the beauty of a language like Go. Many other programming languages either have long build times or long configuration steps.

## Run the image

```bash
docker run bookbot
```

If Bookbot ran, then you did it correctly! We've bundled up Bookbot, its required data, and its required runtime all into a nice little container image!
