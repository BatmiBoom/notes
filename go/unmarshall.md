# UNMARSHALL

As a language designed for the web, Go provides extensive support for working with `JSON` data.

## ENCODING AND DECODING WITH STRUCT TAGS

Go takes a unique approach for working with JSON data. The best way to think about JSON data in Go is as an encoded struct. When you encode and decode a struct to JSON, the key of the JSON object will be the name of the struct field unless you give the field an explicit JSON tag.

```go
type User struct {
    FirstName string `json:"first_name"` // key will be "first_name"
    BirthYear int `json:"birth_year"` // key will be "birth_year"
    Email string // key will be "Email"
}
```

## EXAMPLE MARSHAL JSON FROM STRUCT (ENCODE)

The `encoding/json` package exposes a `json.Marshal` function that allows us to generate the `JSON` encoding of any value, assuming that type has an encoder implemented. The good news is, all the default types in Go have an encoder created out-of-the-box, and you’ll usually be working with `structs` containing default-type fields.

```go
func Marshal(v interface{}) ([]byte, error)
```

As you can see, `Marshal()` takes a value as input, and returns the encoded `JSON` as a slice of bytes on success, or an error if something went wrong.

```go
dat, _ := json.Marshal(User{
    FirstName: "Lane",
    BirthYear: 1990,
    Email: "example@gmail.com",
})
fmt.Println(string(dat))

// prints:
// {"first_name":"Lane","birth_year":1990,"Email":"example@gmail.com"}
```

## EXAMPLE UNMARSHAL JSON TO STRUCT (DECODE)

```go
func Unmarshal(data []byte, v interface{}) error
```

Similarly, the `json.Unmarshal()` function takes some encoded `JSON` data and a pointer to a value where the encoded `JSON` should be written, and returns an error if something goes wrong.

```
dat := []byte(`{
    "first_name":"Lane",
    "birth_year":1990,
    "Email":"example@gmail.com"
}`)

user := User{}
err := json.Unmarshal(dat, &user)
if err != nil {
    fmt.Println(err)
}

fmt.Println(user)
// prints:
// {Lane 1990 example@gmail.com}
```

## EXAMPLE - GO JSON HTTP SERVER

Building a `JSON` API in Go is simple, you don’t even need a framework to get access to convenient high-level HTTP support. I typically start by writing two little helper functions, `respondWithJSON` and `respondWithError`.

```go
func respondWithJSON(w http.ResponseWriter, code int, payload interface{}) error {
    response, err := json.Marshal(payload)
    if err != nil {
    return err
    }
    w.Header().Set("Content-Type", "application/json")
    w.Header().Set("Access-Control-Allow-Origin", "\*")
    w.WriteHeader(code)
    w.Write(response)
    return nil
}
```

`respondWithJSON` makes it easy to send a `JSON` response by simply providing the handler’s `ResponseWriter`, an HTTP status code, and a payload to be marshaled.

```go
func respondWithError(w http.ResponseWriter, code int, msg string) error {
    return respondWithJSON(w, code, map[string]string{"error": msg})
}
```

The `respondWithError` function wraps the `respondWithJSON` function and always sends an error message. Now let’s take a look at how to build a full HTTP handler.

```go
func handler(w http.ResponseWriter, r *http.Request) {
    defer r.Body.Close()
    type requestBody struct {
        Email string `json:"email"`
        Password string `json:"password"`
    }
    type responseBody struct {
        Token string `json:"token"`
    }

    dat, err := io.ReadAll(r.Body)
    if err != nil {
        respondWithError(w, 500, "couldn't read request")
        return
    }

    params := requestBody{}
    err = json.Unmarshal(dat, &params)
    if err != nil {
        respondWithError(w, 500, "couldn't unmarshal parameters")
        return
    }

    // do stuff with username and password

    respondWithJSON(w, 200, responseBody{
        Token: "example-auth-token",
    })
}
```

Since the `json.Marshal` and `json.Unmarshal` function work on the `[]byte` type, it’s really easy to send those bytes over the wire or write them to disk.

## EXAMPLE - READING AND WRITING JSON FILES

I use `JSON` files to store configuration from time to time. Go makes it easy to read and write `JSON` files.

## WRITE JSON TO A FILE IN GO

```go
type car struct {
    Speed int `json:"speed"`
    Make string `json:"make"`
}

c := car{
    Speed: 10,
    Make: "Tesla",
}

dat, err := json.Marshal(c)
if err != nil {
    return err
}

err = io.WriteFile("/tmp/file.json", dat, 0644)
if err != nil {
    return err
}
```

## READ JSON from a file in Go

```go
type car struct {
    Speed int `json:"speed"`
    Make string `json:"make"`
}

dat, err := io.ReadFile("/tmp/file.json")
if err != nil {
    return err
}

c := car{}
err = json.Unmarshal(dat, &c)
if err != nil {
    return err
}
```

## TAG OPTIONS - OMITEMPTY

When marshaling data you can leave out a key completely if the key’s value contains a zero value using the `omitempty` tag.

```go
type User struct {
    FirstName string `json:"first_name,omitempty"`
    BirthYear int `json:"birth_year"`
}

// if FirstName = "" and BirthYear = 0
// marshaled JSON will be:
// {"birth_year":0}

// if FirstName = "lane" and BirthYear = 0
// marshaled JSON will be:
// {"first_name":"lane","birth_year":0}
```

## TAG OPTIONS - IGNORE FIELD

Unexported (lowercase) fields are ignored by the marshaler. If you want to ignore additional fields you can use the - tag.

```go
type User struct {
    // FirstName will never be encoded
    FirstName string `json:"-"`
    BirthYear int `json:"birth_year"`
}
```

## DEFAULT ENCODING TYPES

`JSON` and Go types don’t match up 1-to-1. Below is a table that describes the type relationships when encoding and decoding.

| Go Type     | JSON Type                   |
| ----------- | --------------------------- |
| bool        | boolean                     |
| float64     | number                      |
| string      | string                      |
| nil pointer | null                        |
| time.Time   | RFC 3339 timestamp (string) |

You will notice that the `float32` and `int` types are missing. Don’t worry, you can certainly encode and decode numbers into these types, they just don’t have an explicit type in the `JSON` specification. For example, if you encode an integer in `JSON`, it’s guaranteed not to have a decimal point. However, if someone converts that `JSON` value to a floating-point number before you decode it, you’ll get a runtime error.

It’s rare to encounter an error when marshaling `JSON` data, but `unmarshalling` `JSON` can often cause errors. Here are some things to watch out for:

Any type conflicts will result in an error. For example, you can’t unmarshal a string into a int, even if the string value is a stringified number: "speed": "42".

A floating-point number can’t be decoded into an integer.

A null value can’t be decoded into a value that doesn’t have a nil option. For example, if you have a number field that can be null, you should unmarshal into a \*int

A time.Time can only decode an RFC 3339 string - other kinds of timestamps will fail

## CUSTOM JSON MARSHALING

While most types have a default way to encode and decode `JSON` data, you may want custom behavior from time to time. Luckily, the `json.Marshal` and `json.Unmarshal` respect the `json.Marshaler` and `json.Unmarshaler` interfaces. To customize your behavior you just need to overwrite their methods `MarshalJSON` and `UnmarshalJSON` respectively.

```go
type Marshaler interface {
MarshalJSON() ([]byte, error)
}
```

```go
type Unmarshaler interface {
UnmarshalJSON([]byte) error
}
```

One of the most common scenarios for me is want to encode and decode timestamps in a different format, usually due to interoperability with another language like JavaScript.

```go
type Group struct {
    ID string `json:"id"`
    CreatedAt unixTimestamp `json:"created_at"`
}

type unixTimestamp time.Time

func (ut unixTimestamp) MarshalJSON() ([]byte, error) {
    s := strconv.Itoa(int(time.Time(ut).Unix()))
    return []byte(s), nil
}

func (ut *unixTimestamp) UnmarshalJSON(dat []byte) error {
    unix, err := strconv.Atoi(string(dat))
    if err != nil {
        return err
    }
    *ut = unixTimestamp(time.Unix(int64(unix), 0))
    return nil
}

func main() {
    g := Group{
        ID: "my-id",
        CreatedAt: unixTimestamp(time.Unix(1619544689, 0)),
    }
    dat, \_ := json.Marshal(g)
    fmt.Println(string(dat))
    // prints
    // {"id":"my-id","created_at":1619544689}

    newG := Group{}
    json.Unmarshal(dat, &newG)
    fmt.Println(newG)
    // prints
    // {my-id {0 63755141489 0x1694c0}}
}
```

## ARBITRARY JSON WITH MAP[STRING]INTERFACE

It’s unfortunate when this is the case, but sometimes we have to work with arbitrary `JSON` data. For example, you need to decode some `JSON` data, but you aren’t sure what the key structure or shape of the data is.

The best way to handle this case is to `unmarshal` the data into a `map[string]interface{}`

```go
dat := []byte(`{
    "first_name": "lane",
    "age": 30
}`)

m := map[string]interface{}{}
json.Unmarshal(dat, &m)
for k, v := range m {
    fmt.Printf("key: %v, value: %v\n", k, v)
}

// prints
// key: first_name, value: lane
// key: age, value: 30
```

I want to point out that `map[string]interface{}` should only be used when you absolutely have to. If you have a priori knowledge of the shape of the data, please use a `struct` or some other concrete type. Avoid the dynamic typing provided by interfaces when working with `JSON`, if you want, you can always use anonymous `structs` for one-off usage.

## STREAMING JSON ENCODINGS

Sometimes you don’t have the luxury of reading all the `JSON` data to or from a []byte. If you need to be able to parse data as it’s streamed in or out of your program the encoding/json package provides Decoder and Encoder types.

```go
func NewDecoder(r io.Reader) *Decoder
func NewEncoder(w io.Writer) *Encoder
```

Take a look at the following example. It decodes data from standard in, adds a new key "id" with a value of "gopher-man" and writes the result to standard out.

```go
dec := json.NewDecoder(os.Stdin)
enc := json.NewEncoder(os.Stdout)
for {
    v := map[string]interface{}{}
    if err := dec.Decode(&v); err != nil {
        log.Fatal(err)
    }
    v["id"] = "gopher-man"
    if err := enc.Encode(&v); err != nil {
        log.Fatal(err)
    }
}
```

## PRETTY PRINTING JSON

By default, the `json.Marshal` function compresses all the whitespace in the encoded data for efficiency. If you need to print out your `JSON` data so that it’s more easily readable you can pretty-print it using the `json.MarshalIndent` function.

```go
func MarshalIndent(v interface{}, prefix, indent string) ([]byte, error)
```

You can customize how you want your pretty JSON to be formatted, but if you just want it to have proper tabs and newlines you can do the following.

```go
type user struct {
    Name string
    Age int
}

json, err := json.MarshalIndent(user{Name: "lane", Age: 30}, "", " ")
if err != nil {
    return err
}

fmt.Println(string(json))
// prints
// {
// "Name": "lane",
// "Age": 30
// }
```

## FASTER JSON ENCODING AND DECODING

Sometimes performance is key, and when you need to squeeze every bit of power out of your CPU cycles you may notice that the standard library’s `JSON` marshaling and `unmarshalling` isn’t as performant as you might like. There’s a fairly popular library out there called `ffjson` that can speed up your marshaling performance by ~2-3x.

`ffjson` generates static `MarshalJSON` and `UnmarshalJSON` functions for structures in Go. The generated functions reduce the reliance upon runtime reflection to do serialization and are generally 2 to 3 times faster. In cases where `ffjson` doesn’t understand a Type involved, it falls back to encoding/json, meaning it is a safe drop in replacement. By using `ffjson` your `JSON` serialization just gets faster with no additional code changes.
