# Tries

At its core, a trie is often represented as a nested tree of dictionaries where each key is a character, and it maps to the next character in the word. For example, the words "hello", "help" and "hi" would be represented as:

```python
{
    "h": {
        "e": {
            "l": {
                "l": {
                    "o": {
                        "*": True
                    }
                },
                "p": {
                    "*": True
                }
            }
        },
        "i": {
            "*": True
        }
    }
}
```

A trie is also often referred to as a "prefix tree" because it can be used to efficiently find all of the words that start with a given prefix.

```python
class Trie:
    def __init__(self):
        self.root = {}
        self.end_symbol = "*"
```

## Trie - Add

```python
class Trie:
    def add(self, word):
        current = self.root
        for c in word:
            if not c in current:
                current[c] = {}

            current = current[c]

        current[self.end_symbol] = True
```

## Trie - Exists

```python
class Trie:
    def exists(self, word)
        current = self.root
        for letter in word:
            if letter not in current:
                return False
            current = current[letter]
        return self.end_symbol in current
```

### Using a Trie for Prefix Matching

You would typically be interested in a trie if you want to do some kind of prefix matching. For example, if you wanted to find all the words in a dictionary that start with a given prefix, a trie works great!

Remember, a hashtable is only good for exact matches. A trie allows you to look up all of the words that match a given prefix. For example, given this trie:

```python
{
    "h": {
        "e": {
            "l": {
                "l": {
                    "o": {
                        "*": True
                    }
                },
                "p": {
                    "*": True
                }
            }
        },
        "a": {
            "r": {
                "d": {
                    "*": True
                }
            }
        }
    }
}
```

We could quickly find all the words that start with "hel" and get:

- hello
- help

### Trie - Return Words With Prefix

```python
class Trie:
    def words_with_prefix(self, prefix):
        words = []

        current = self.root
        for c in prefix:
            if c not in current:
                return []

            current = current[c]

        return self.search_level(current, prefix, words)

    def search_level(self, cur, cur_prefix, words):
        if self.end_symbol in cur:
            words.append(cur_prefix)

        for key in sorted(cur.keys()):
            if self.end_symbol != key:
                self.search_level(cur[key], cur_prefix + key, words)

        return words
```

### Trie - Substring Exists

Tries are super efficient when it comes to finding substrings in a large document of text.

If we just split on whitespace and matched against a dictionary, we would miss substrings. For example, if we had the word "darn" in our dictionary, we would allow the word "darnit" to slip through undetected. That's why we'll use a trie.

```python
class Trie:
    def find_substring(self, document):
        matches = set()
        for i in range(len(document)):
            level = self.root
            for j in range(i, len(document)):
                ch = document[j]
                if ch not in level:
                    break
                level = level[ch]
                if self.end_symbol in level:
                    matches.add(document[i : j + 1])
        return matches
```

### Trie - Longets Common Prefix

Longest common prefix of a list of words. This feature can be used to display suggestions when users are searching for something

```python
class Trie:
    def longest_common_prefix(self):
        current = self.root
        prefix = ""
        while True:
            n_children = len(current.keys())
            if n_children == 1:
                letter = list(current.keys())[0]
                if letter == self.end_symbol:
                    break

                prefix += letter
                current = current[letter]

            if n_children > 1 or n_children == 0:
                break

        return prefix
```

### Trie - Advanced Word Filter

Now that we have built the Trie class, we want to provide an advanced word filter to catch variations of bad words efficiently. For example, if the bad word is 'darn', we want to filter variations like 'd@rn', 'd4rn', or 'd@rn1t'.

```python
    def advanced_find_matches(self, document, variations):
        matches = set()
        for i in range(len(document)):
            level = self.root
            for j in range(i, len(document)):
                ch = document[j]
                if ch in variations:
                    ch = variations[ch]
                if ch not in level:
                    break
                level = level[ch]
                if self.end_symbol in level:
                    matches.add(document[i : j + 1])
        return matches`
```
