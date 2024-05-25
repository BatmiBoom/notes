# Error Handling in JS

- First, an error is thrown

```js
const speed = car.speed;
// The code crashes with the following error:
// "Reference Error: car is not defined"
```

- Trying and catching errors

```js
try {
  const speed = car.speed;
} catch (err) {
  console.log(`An error was thrown: ${err}`);
}
```

- Handling a new error object

```js
let err = new Error("This is the error message");

try {
  // computation
} catch (err) {
  console.log(`An error was thronw: ${err.message}`);
}
```

"Error handling" is code that can handle expected edge cases in your program. Error handling is an automated process that we design into our production code to protect it from things like weak internet connections, bad user input, or bugs in other people's code that we have to interface with.

Examples of error handling:

- Using a try/catch block to detect an issue with user input
- Using a try/catch block to gracefully fail when no internet connection is available

# ASYNC/AWAIT MAKES ERROR HANDLING EASIER

try and catch are the standard way to handle errors in JavaScript, the trouble is, the original Promise API with .then didn't allow us to make use of try and catch blocks.

Luckily, the async and await keywords do allow it, yet another reason to prefer the newer syntax.
