# JSON

Is a standard for representing structured data based on JavaScript's object syntax. It is commonly used to transmit data in web apps via HTTP.

JSON supports the following primitive data types:

- Strings `"Hello, World!"`
- Numbers `42` or `3.14`
- Booleans `true`
- Null `null`

And the following collection types:

- Arrays `[1, 2, 3]`
- Object literals `{"key": "value"}`

**Keys** are always strings, and the **values** can be any data type, including other objects.

The following is valid JSON data:

```json
{
  "movies": [
    {
      "id": 1,
      "title": "Iron Man",
      "director": "Jon Favreau",
      "favorite": true
    },
    {
      "id": 2,
      "title": "The Avengers",
      "director": "Joss Whedon",
      "favorite": false
    }
  ]
}
```
