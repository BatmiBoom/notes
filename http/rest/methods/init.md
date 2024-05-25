# Difference Between POST & PUT & PATCH

**PUT**:

- Purpose: The PUT method is used to create a new resource or replace an existing resource with a new representation.
- Idempotent: PUT is considered idempotent, meaning that making multiple identical PUT requests should have the same effect as a single request.
- Usage: When using PUT, the entire representation of the resource is sent in the request payload. If the resource already exists, it is replaced entirely with the new representation sent in the request.

- Generally, in practice, use **PUT** for **UPDATE** operations.
- The HTTP specification clearly mentions that **PUT** method requests for the attached entity (in the request body) to be stored on the server that hosts the supplied Request-URI.
- If the Request-URI refers to an already existing resource – a total update operation will happen, otherwise create operation should happen if Request-URI is a valid resource URI (assuming the client is allowed to determine the resource identifier).
- Is **idempotent**. So if we retry a request multiple times, that should be equivalent to a single request invocation.
- When we want to modify a singular resource that is already a part of resource collection. **PUT** replaces the resource in its entirety. Use **PATCH** if the request updates part of the resource.
- Though **PUT** is idempotent, we should not cache its response.

Usage:

- Use HTTP PUT when you want to update or create a specific resource at a known URI in an idempotent manner.
  This is suitable for scenarios where you have full control over resource replacement.

**POST**:

- Purpose: The POST method is used to submit data to be processed by the resource identified by the URI. It can be used to create a new resource or append data to an existing resource.
- Non-Idempotent: POST is considered non-idempotent, meaning that making the same POST request multiple times may result in different outcomes or create duplicate resources.
- Usage: When using POST, the request payload contains the data to be processed or appended. The server determines the location of the new resource and returns the appropriate response, which may include the URI of the newly created resource.

- Always use **POST** for CREATE operations.
- The **POST** method requests that the origin server accept the entity attached in the request as a new subordinate of the resource identified by the Request-URI in the Request-Line.
- It essentially means that **POST** Request-URI should be of a collection URI.
- Is NOT **idempotent**. So if we retry the request N times, we will end up having N resources with N different URIs created on the server.
- When you want to add a child resource under resources collection.
- Responses to this method are not cacheable, unless the response includes appropriate Cache-Control or Expires header fields.

Usage:

- Use HTTP POST when you need to submit data for processing, create new resources without specifying a URI, or perform non-idempotent operations.

**PATCH**:

- Purpose: The PATCH method is used to partially update an existing resource. It applies modifications to the resource, rather than replacing it entirely.
- Idempotent (in theory): PATCH is intended to be idempotent, but its actual implementation can vary. In practice, it’s recommended to implement PATCH requests in an idempotent manner to ensure consistent behavior.
- Usage: When using PATCH, the request payload contains instructions on how the resource should be modified. The server applies these changes to the existing resource while leaving the unmodified parts unchanged.
