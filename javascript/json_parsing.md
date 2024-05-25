# JSON Parsing

JavaScript Object Notation, or JSON, is a standard for representing structured data based on JS's object syntax.

JSON is commonly used to transmit data in web apps using HTTP

## Syntax

```json
{
  "movies": [
    {
      "id": 1,
      "genre": "Action",
      "title": "Iron Man",
      "director": "Jon Favreau"
    },
    {
      "id": 2,
      "genre": "Action",
      "title": "The Avengers",
      "director": "Joss Whedon"
    }
  ]
}
```

## Parsing HTTP responses as json

JS provides us with some easy tools to help us work with JSON. The `response` object offers us some methods that help us interact with the response. One such method is the `.json()` method. The `.json()` method takes the response stream returned by a fetch request and returns a `promise` that resolves into a JS object parsed from the JSON body of the HTTP Response.

```js
const resp = await fetch(...)
const jsObjectResponse = await resp.json()
```

JSON is a stringified representation of a JavaScript object, which makes it perfect for saving to a file or sending in an HTTP request. Remember, an actual JavaScript object is something that exists only within your program's variables. If we want to send an object outside our program, for example, across the internet in an HTTP request, we need to convert it to JSON first.

## Sending JSON

**`JSON.stringify()`**

Is particular useful for **sending** JSON.

It takes a JS object or value as input and converts it into a string. This is useful when we need to serialize the objects into strings to send them to our server or store them in a database

## Parsing JSON

**`JSON.parse()`**

Takes a JSON string as input and constructs the JS value/object described by the string. This allows us to work with the JSON as an object

```js
const json = '{"title": "Avengers Endgame", "Rating":4.7, "inTheaters":false}';
const obj = JSON.parse(json);

console.log(obj.title);
// Avengers Endgame
```
