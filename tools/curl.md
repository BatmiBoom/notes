# CURL

Is a command-line tool for transferring data using various protocols, like HTTP and HTTPS.

Among other things, developers use `curl` for:

- Quick testing: make HTTP requests with a single command.
- Automation: can seamlessly be integrated into scripts and automation workflows.
- Debugging: easily see requests and responses.

## GET REQUEST

The simplest `curl` command makes a `GET` request to the provided URL, for example:

```bash
curl https://jsonplaceholder.typicode.com/users/1
```

The response body is written to `stdout`

Because the output is written to `stdout` you can combine it with other commands, e.g. redirecting the output to a file.

```bash
curl https://jsonplaceholder.typicode.com/users/1 > user1.json
```

`curl` supports a number of options and commands. Check their tutorial page or the man page for more information. We will only be covering the basics.

```bash
man curl
```

## POST REQUEST

Making a `POST` request with `curl` is almost as simple as a `GET` request. Use the `-X POST` option to specify the request method and the `-d` option to pass data.

Here's how to make a POST request:

```bash
curl -X POST http://example.com/resource -d "param1=value1&param2=value2"
```

This command makes an HTTP `POST` request to `http://example.com/resource` with the data `param1=value1&param2=value2`. The server's response body is written to `stdout`.

If you need to send `JSON` data, use the `-H` option to set the `Content-Type` header and the `-d` option to pass the JSON data:

```bash
curl -X POST http://example.com/resource -H "Content-Type: application/json" -d '{"key1":"value1","key2":"value2"}'
```
