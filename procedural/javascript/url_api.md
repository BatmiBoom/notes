## URL API

The `URL` API is built into JavaScript. You can create a _new URL object_:

```javascript
const urlObj = new URL("https://example.com/example-path");
// And then you can extract just the hostname
urlObj.hostname;
```

Properties of the URL object:

- protocol
- username
- password
- hostname
- port
- pathname
- search
- hash
