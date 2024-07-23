# REGEX

"Regex" for short, is a programming-language-agnostic way of searching for patterns in text.

In Python, we can use the `re` module to work with regex. It has a `findall` function that will return a list of all the matches in a string. See examples below.

## Regex for matching a particular word

```python
import re

text = "I'm a little teapot, short and stout. Here is my handle, here is my spout."
matches = re.findall(r"teapot", text)
print(matches) # ['teapot']
```

- `r"teapot"` is a regex pattern.
- The `r` tells Python to treat the string as a "raw" string, which means we don't have to escape backslashes
  The pattern `teapot` will match any exact occurrences of the word "teapot" in the input.

## Regex for phone number

```python
text = "My phone number is 555-555-5555 and my friend's number is 555-555-5556"
matches = re.findall(r"\d{3}-\d{3}-\d{4}", text)
print(matches) # ['555-555-5555', '555-555-5556']
```

- `\d` matches any digit
- `{3}` means "exactly three of the preceding character"
- `-` is just a literal - that we want to match

## Regex for text between parentheses

```python
text = "I have a (cat) and a (dog)"
matches = re.findall(r"\((.*?)\)", text)
print(matches) # ['cat', 'dog']
```

- `\(` and `\)` are literal parentheses that we want to match
- `.*?` matches any number of characters (except for line terminators) between the parentheses

## Regex for emails

```python
text = "My email is lane@example.com and my friend's email is hunter@example.com"
matches = re.findall(r"\w+@\w+\.\w+", text)
print(matches) # ['lane@example.com', 'hunter@example.com']
```

- `\w` matches any word character (alphanumeric characters and underscores)
- `+` means "one or more of the preceding character"
- `@` is just a literal @ symbol that we want to match
- `\.` is a literal . that we want to match (The . is a special character in regex, so we escape it with a leading backslash)
