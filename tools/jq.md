# JQ

Is a powerful command-line tool for processing `JSON` data. It's use for:

- **Parse JSON**: easily read and extract data from JSON responses.
- **Manipulate JSON**: modify JSON data on the fly.
- **Filter JSON**: find exactly what you're looking for within large JSON structures.

## BASICS

We have a file

```user.json
{
    "name": "John",
    "age": 30,
    "city": "New York"
}
```

To extract the `name` field, we can do:

```bash
jq '.name' user.json
```

### jq with cURL

`jq` is frequently used with `curl` to parse `JSON` responses directly from HTTP requests.

For example, to fetch `JSON` data from an API and extract a field we can use the object identifier index:

```bash
curl https://jsonplaceholder.typicode.com/users/1 | jq .username
```

To get a field from each element in an array you can use the `array/object` value iterator `.[]`, which can in turn be combined with the identifier index:

```bash
curl https://jsonplaceholder.typicode.com/users | jq '.[].username'
# "Bret"
# "Antonette"
# "Samantha"
# "Karianne"
# "Kamren"
# "Leopoldo_Corkery"
# "Elwyn.Skiles"
# "Maxime_Nienow"
# "Delphine"
# "Moriah.Stanton"
```

#### Multiple Fields

```bash
curl https://jsonplaceholder.typicode.com/users/1 | jq '.name, .email'
# "Leanne Graham"
# "Sincere@april.biz"
```

`jq` is extremely powerful.
