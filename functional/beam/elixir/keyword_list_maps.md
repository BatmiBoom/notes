# Keyword lists and maps

Associative data structures. Associative data structures are able to associate a key to a certain value. Different languages call these different names like dictionaries, hashes, associative arrays, etc.

## Keyword lists

Are a data-structure used to pass options to functions. Imagine you want to split a string of numbers. We can use `String.split/2`

```elixir
String.split("1 2 3", " ") # ["1", "2", "3"]
```

However, what happens if there is an additional space between the numbers:

```elixir
String.split("1  2 3", " ") # ["1", "", "2", "", "3"]
```

As you can see, there are now empty strings in our results. Luckily, the `String.split/3` function allows the trim option to be set to true:

```elixir
String.split("1  2 3", " ", [trim: true]) # ["1", "2", "3"]
```

`[trim: true]` is a keyword list. Furthermore, when a keyword list is the last argument of a function, we can skip the brackets and write

```elixir
String.split("1  2 3", " ", trim: true)
```

Keyword lists are simply lists. In particular, they are lists consisting of 2-item tuples where the first element (the key) is an atom and the second element can be any value. Both representations are the same:

```elixir
[{:trim, true}] == [trim: true] # true
```

Since keyword lists are lists, we can use all operations available to lists.

You can read the value of a keyword list using the brackets syntax. This is also known as the access syntax, as it is defined by the Access module:

```elixir
list = [a: 1, b: 2]
list[:a] # 1
list[:b] # 2
```

In case of duplicate keys, values added to the front are the ones fetched:

```elixir
new_list = [a: 0] ++ list # [a: 0, a: 1, b: 2]
new_list[:a] # 0
```

Keyword lists are important because they have three special characteristics:

- Keys must be atoms.
- Keys are ordered, as specified by the developer.
- Keys can be given more than once.

In order to manipulate keyword lists, Elixir provides the `Keyword` module. Also keyword lists are simply lists, and as such they provide the same linear performance characteristics as them: the longer the list, the longer it will take to find a key, to count the number of items, and so on.

## do-blocks and keywords

As we have seen, keywords are mostly used in the language to pass optional values. In fact, we have used keywords in earlier chapters.

```elixir
if true do
  "This will be seen"
else
  "This won't"
end

```

It happens that do blocks are nothing more than a syntax convenience on top of keywords. We can rewrite the above to:

`if true, do: "This will be seen", else: "This won't"`

Pay close attention to both syntaxes. In the keyword list format, we separate each key-value pair with commas, and each key is followed by :. In the do-blocks, we get rid of the colons, the commas, and separate each keyword by a newline. They are useful exactly because they remove the verbosity when writing blocks of code. Most of the time, you will use the block syntax, but it is good to know they are equivalent.

## Maps as key-value pairs

A map is created using the `%{}` syntax:

```elixir
map = %{:a => 1, 2 => :b} # %{2 => :b, :a => 1}
map[:a] # 1
map[2] # :b
map[:c] # nil
```

Compared to keyword lists, we can already see two differences:

- Maps allow any value as a key.
- Maps' keys do not follow any ordering.

In contrast to keyword lists, maps are very useful with pattern matching. When a map is used in a pattern, it will always match on a subset of the given value:

```elixir
%{} = %{:a => 1, 2 => :b} # %{2 => :b, :a => 1}
%{:a => a} = %{:a => 1, 2 => :b} # %{2 => :b, :a => 1}
a # 1
%{:c => c} = %{:a => 1, 2 => :b} # \*\* (MatchError)
```

As shown above, a map matches as long as the keys in the pattern exist in the given map. Therefore, an empty map matches all maps.

The `Map` module provides a very similar API to the Keyword module with convenience functions to add, remove, and update maps keys:

```elixir
Map.get(%{:a => 1, 2 => :b}, :a) # 1
Map.put(%{:a => 1, 2 => :b}, :c, 3) # %{2 => :b, :a => 1, :c => 3}
Map.to_list(%{:a => 1, 2 => :b}) # [{2, :b}, {:a, 1}]
```

## Maps of predefined keys

We have used maps as a key-value data structure where keys can be added or removed at any time.

However, it is also common to create maps with a pre-defined set of keys. Their values may be updated, but new keys are never added nor removed.

We define such maps using the same syntax as in the previous section, except that all keys must be atoms:

```elixir
map = %{:name => "John", :age => 23} # %{name: "John", age: 23}
```

As you can see from the printed result above, Elixir also allows you to write maps of atom keys using the same key: value syntax as keyword lists.

When the keys are atoms, in particular when working with maps of predefined keys, we can also access them using the map.key syntax:

```elixir
map = %{name: "John", age: 23} # %{name: "John", age: 23}
map.name # "John"
map.agee # (KeyError)
```

There is also syntax for updating keys, which also raises if the key has not yet been defined:

```elixir
%{map | name: "Mary"} # %{name: "Mary", age: 23}
%{map | agee: 27} # (KeyError)
```

This is also the syntax used to power another Elixir feature called `Structs`, which we will learn later on.

## Nested data structures

Elixir provides conveniences for manipulating nested data structures via the `get_in/1`, `put_in/2`, `update_in/2`, and other macros giving the same conveniences you would find in imperative languages while keeping the immutable properties of the language.

Imagine you have the following structure:

```elixir
users = [
    john: %{
        name: "John",
        age: 27,
        languages: ["Erlang", "Ruby", "Elixir"]
    },
    mary: %{
        name: "Mary",
        age: 29,
        languages: ["Elixir", "F#", "Clojure"]
    }
]
```

We have a keyword list of users where each value is a map containing the name, age and a list of programming languages each user likes. If we wanted to access the age for john, we could write:

```elixir
users[:john].age # 27
```

It happens we can also use this same syntax for updating the value:

```elixir
users = put_in users[:john].age, 31
```

The `update_in/2` macro is similar but allows us to pass a function that controls how the value changes. For example, let's remove "Clojure" from Mary's list of languages:

```elixir
users = update_in users[:mary].languages,
    fn languages -> List.delete(languages, "Clojure") end
```

- Use keyword lists for passing optional values to functions
- Use maps for general key-value data structures
- Use maps when working with data that has a predefined set of keys
