# Requests

`net/http` is the package use to make request.

- http.Client to make HTTP requests. `http.Get` function uses the `http.DefaultClient` under the hood.

## GET REQUEST

```main.go
func getSpells() ([]byte, error) {
	res, err := http.Get("https://api.fantasyquest.com/spell")
	if err != nil {
		return []byte{}, fmt.Errorf("error making request: %w", err)
	}
	defer res.Body.Close()

	data, err := io.ReadAll(res.Body)
	if err != nil {
		return []byte{}, fmt.Errorf("error reading response: %w", err)
	}
	return data, nil
}
```

- `http.Get` uses the `http.DefaultClient` to make a request to the given URL
- `res` is the HTTP response that comes back from the server
- `defer res.Body.Close()` ensures that the response body is properly closed after reading. Not doing so can cause memory issues.
- `io.ReadAll` reads the response body into a slice of bytes []byte called data

## POST REQUEST

Like `http.Get`, the standard library's `http.Post` function can be used to send simple POST requests.

If we want to send something more complicated like have a `X-API-Key` header, the simple `http.Post` function won't work. Instead, we need to use `http.NewRequest`:

```main.go
func createUser(url, apiKey string, data User) (User, error) {
	jsonData, _ := json.Marshal(data)

	req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonData))
	if err != nil {
		return User{}, err
	}

	req.Header.Set("Content-Type", "application/json")
    req.Header.Set("X-API-Key", apiKey)

	client := http.Client{}
	res, err := client.Do(req)
	if err != nil {
		return User{}, err
	}
	defer res.Body.Close()

	var u User
	decoder := json.NewDecoder(res.Body)
	err = decoder.Decode(&u)
	if err != nil {
		return User{}, err
	}

	return u, nil
}

type User struct {
	CharacterName string `json:"characterName"`
	Class         string `json:"class"`
	Level         int    `json:"level"`
	PvpEnabled    bool   `json:"pvpEnabled"`
	User          struct {
		Name     string `json:"name"`
		Location string `json:"location"`
		Age      int    `json:"age"`
	} `json:"user"`
}
```

## PUT REQUEST

The `PUT` method creates or more commonly, updates the target resource with the contents of the request's body. Unlike `GET` and `POST`, there is NO `http.Put` function. You will have to create a raw `http.Request` that an `http.Client` can `Do`.

`PUT` request are **idempotent** meaning it's safe to make the request multiple times without changing the server state. That is the difference with `POST` request

```main.go
func updateUser(baseURL, id, apiKey string, data User) (User, error) {
	fullURL := baseURL + "/" + id

	jsonData, _ := json.Marshal(data)

	req, err := http.NewRequest("PUT", fullURL, bytes.NewBuffer(jsonData))
	if err != nil {
		return User{}, err
	}

	req.Header.Set("Content-Type", "application/json")
    req.Header.Set("X-API-Key", apiKey)

	client := http.Client{}
	res, err := client.Do(req)
	if err != nil {
		return User{}, err
	}
	defer res.Body.Close()

	var u User
	decoder := json.NewDecoder(res.Body)
	err = decoder.Decode(&u)
	if err != nil {
		return User{}, err
	}

	return u, nil
}

type User struct {
	CharacterName string `json:"characterName"`
	Class         string `json:"class"`
	ID            string `json:"id"`
	Level         int    `json:"level"`
	PvpEnabled    bool   `json:"pvpEnabled"`
	User          struct {
		Name     string `json:"name"`
		Location string `json:"location"`
		Age      int    `json:"age"`
	} `json:"user"`
}
```

## DELETE REQUEST

The `DELETE` method does exactly what you expect: it deletes a specified resource.

```main.go
// This deletes the location with ID: 52fdfc07-2182-454f-963f-5f0f9a621d72
url := "https://api.boot.dev/v1/courses_rest_api/learn-http/locations/52fdfc07-2182-454f-963f-5f0f9a621d72"
req, err := http.NewRequest("DELETE", url, nil)
if err != nil {
	fmt.Println(err)
    return
}

client := &http.Client{}
res, err := client.Do(req)
if err != nil {
	fmt.Println(err)
    return
}
res.Body.Close()

if res.StatusCode > 299 {
    fmt.Println("request to delete location unsuccessful")
    return
}
fmt.Println("request to delete location successful")
```

## Status Code Property

The `http.Response` object has a `.StatusCode` property that contains the status code of the response.

```main.go
func getUserCode(url string) int {
	res, err := http.Get(url)
	if err != nil {
		return 0
	}
	defer res.Body.Close()

	return res.StatusCode
}
```

## Handling ERRORS

### Network Errors

This happen when there are problems reaching the server, like DNS failures, connectivity issues, or timeouts. You can detect these errors by checking the error returned by the HTTP request function.

```main.go
res, err := http.Get("https://example.com/api/resource")
if err != nil {
    log.Printf("Network error: %v", err)
    return
}
defer res.Body.Close()
```

### Non-OK Responses

Even if the request is successful, the server may return a non-OK HTTP status code (e.g., 404 Not Found, 500 Internal Server Error). These responses need to be handled separately from network errors.

```main.go
res, err := http.Get("https://example.com/api/resource")
if err != nil {
    fmt.Println("a network error occurred")
    return
}
defer res.Body.Close()

if res.StatusCode != http.StatusOK {
    fmt.Println("status code != 200")
    return
}
```

> A successful response usually has a status code of `http.StatusOK` (200), but it can be any code between 200 and 299.
