# FETCH API

The `fetch` function is made available to us by JavaScript language running in the browser, all we have to do is provide it with parameters it requires.

## Using FETCH

```javascript
const response = await fetch(url, settings);
const responseData = await response.json();
```

- `response` is the data that comes bacck from the server
- `url` is the URL we are making a request to
- `settings` is an object containing some request-specific settings
- `await` keyword tells JavaScript to wait until the response comes back from the server before continuing
- `response.json()` converts the response data from the server into a JS object

## Making a GET request

The `fetch` method accepts an optional `init` object parameter as its second argument that we can use to define things like:

- **method**: The HTTP method of the request, like GET
- **headers**: The headers to send
- **mode**: Used for security, we'll talk about this in future courses
- **body**: The body of the request. Often encoded as JSON

```js
async function getUsers(url, apiKey) {
  const r = await fetch(url, {
    method: "GET",
    mode: "cors",
    headers: {
      "X-API-Key": apiKey,
    },
  });

  return await r.json();
}
```

## Making a POST request

An HTTP POST request sends data to a server, typically to create a new resource.

### Adding a Body

The `body` of the request is the payload that is beign sent to the server with the request, its type is indicated by the `Content-Type` header - for us, that's going to be JSON. `POST` requests are generally not safe methods to call multiple times, because it alters the state of the server. You wouldn't want to accidentally create 2 accounts for the same user.

```js
await fetch(url, {
  method: "POST",
  mode: "cors",
  headers: {
    "Content-Type": "application/json",
  },
  body: JSON.stringify(data),
});
```

## Making a PUT request

The HTTP PUT method creates a new resource or replaces a representation of the target resource with the contents of the request's body. In short, it updates a resource's properties.

```js
await fetch(url, {
  method: "PUT",
  mode: "cors",
  headers: {
    "Content-Type": "application/json",
  },
  body: JSON.stringify(data),
});
```

## PATCH

The PATCH method is intended to partially modify a resource.

Long story short, PATCH isn't nearly as popular as PUT, and many servers, even if they allow partial updates, will still just use the PUT method for that.

## Making a DELETE request

The delete request does exactly as you would expect: it deletes a specified resource.

```js
// This deletes the location with ID: 52fdfc07-2182-454f-963f-5f0f9a621d72
const url =
  "https://api.boot.dev/v1/courses_rest_api/learn-http/locations/52fdfc07-2182-454f-963f-5f0f9a621d72";

await fetch(url, {
  method: "DELETE",
  mode: "cors",
});
```

**WHY DO WE USE HTTP METHODS?**

Primary purpose of HTTP methods is to indicate to the server what we want to do with the resource we're trying to interact with. At the end of the day, an HTTP method is just a string, like GET, POST, PUT, or DELETE, but by convention, backend developers almost always write their server code so that the methods correspond with different "CRUD" actions.

The "CRUD" actions are:

- Create
- Read
- Update
- Delete

As it happens, the 4 most common HTTP methods map nicely to the CRUD actions:

- POST = create
- GET = read
- PUT = update
- DELETE = delete

```

```
