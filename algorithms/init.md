# Algorithms

An algorithm is a fancy word that essentially means "good instructions". Here's an example of a simple algorithm that explains how to find the smallest number in a list.

- [Basics](./basics_algorithms.md)
- [Sorting Algorithms](./sorting_algorithms.md)
- [N vs NP](./n_vs_np.md)
- [Breadth First Search](./breadth_first_search.md)
- [Depth Fist Search](./depth_first_search.md)

In math and programming, an algorithm is a finite sequence of well-defined, computer-implementable instructions. Algorithms are always unambiguous and are used as specifications for real world implementations

In short, an algorithm is:

- Defined: there are a specific sequence of steps that performs a task
- Unambiguous: there is a "correct" and "incorrect" interpretation of the steps
- Implementable: it can be implemented in code or using hardware

## Exponents

An exponent indicated how many times a number is to be multiplied by itself.

For example `5 ** 3 = 5 * 5 * 5`

Anything raised to the 0 is gonna be equal to 1 `n ** 0 = 1`

Implement this formula : `estimated_spread = average_audience_followers * ( num_followers^1.2 )`

```python
from functools import reduce

def get_estimated_spread(audiences_followers):
    average_audience_followers = (reduce(lambda a, b: a+b, audiences_followers))/len(audiences_followers)
    num_followers = len(audiences_followers)

    return average_audience_followers * (num_followers ** 1.2)
```

## Geometric Sequences

A geometric progression, also known as a geometric sequence, is a mathematical sequence of non-zero numbers where each term after the first is found by multiplying the previous one by a fixed, non-zero number called the common ratio. For example, the sequence 2, 6, 18, 54, ... is a geometric progression with common ratio 3. Similarly 10, 5, 2.5, 1.25, ... is a geometric sequence with common ratio 1/2.

Example:
A company earn 100$ in profits its first year, and based on historical data we can predict that they are gonna doble the next year

100, 200, 400, 800, ... if we can say that the prediction is this one, across the years

We have a geometric sequence -> Each number in the sequence is a fixed multiple of the number before it

The fixed multiple -> `r = 2 ( 100 -> n=1, 100 * 2 -> n=2, 100 * 2 * 2 -> n=3, 100 * 2 * 2 * 2)`

We can calculate the profit of the company 600 years into the future with this formula:
`a sub n = a sub 1 * r ** (n-1)`
`a sub 600 = 100 (a sub 1, first number in the sequence) * 2 ** (600 - 1)`
`n` -> is the number that we care about, that we want to know, in this case is `600`

#### Assignment

While the influencers who use our platform are really great at taking selfies, most aren't super great at math. We need to write a tool that predicts an influencer's follower growth over time.

Complete the get_follower_prediction function.

- "fitness" influencers follower count quadruple each month
- "cosmetic" influencers follower count triple each month
- All other influencers follower count double each month

For example, if a fitness influencer starts with 10 followers, then after 1 month they should have 40 followers. After 2 months, they would have 160 followers. etc.

```python
def get_follower_prediction(follower_count, influencer_type, num_months):
    if influencer_type == "fitness":
        return (follower_count * 4) * (4 ** (num_months - 1))

    if influencer_type == "cosmetic":
        return (follower_count * 3) * (3 ** (num_months - 1))

    return (follower_count * 2) * (2 ** (num_months - 1))
```

## Logarithm

A logarithm is the inverse of an exponent, we can see the link
`2 ** 3 = 2 * 2 * 2 = 8 -> log2(8) = 3`

- Base matches the number we are going to multiple
- The number we trying to get te logarithm of is the result of the exponent version
- And the exponent ( the amount of times that we have to multiple ) is the result of the log

`N ** E = X -> logN(X) = E`

logBASE(N) -> The times that we need to multiply the base by itself to achieve n

`log2(16) = 4` -> log base 2 of 16 -> `2 * 2 * 2 * 2 = 16. 4 times we have tu multiply 2 to get 16`

Some more examples:

- log2(2) = 1
- log2(4) = 2
- log2(8) = 3
- log2(16) = 4
- log2(32) = 5
- log10(100) = 2
- log10(1000) = 3
- log10(10000) = 4

### Logarithms in python

We have to import the math library and use the `math.log()` function

```python
import math

print(f"Logarithm base 2 of 16 is: {math.log(16, 2)}") # Logarithm base 2 of 16 is: 4.0
```

## Factorials

In math, the factorial of a positive integer `n`, written `n!`, is the product of all positive integers less than and equal to `n`.

`5! = 5 * 4 * 3 * 2 * 1`

The results of a factorial grow even faster than exponentiation!

`n!` grows faster than `2 ** n`

Grow representation -> log \< exponential \< factorial

### Ordering problems have factorial growth

Factorials are useful when trying to count how many different orders there are for things

For example: How many different ways can a deck of card be arranged?

- The first card could be any of the 52 cards
- The second card can be any of the 51 remaining card
- The third card can be any of the 50 remaining cards, and so on

This means we have 52 options multiplied by 51 options multiplied by 50 options, and so on.
52 _ 51 _ 50 .... _ 2 _ 1 = 52!

```python
def num_possible_orders_for_posts(num_posts):
    result = 1
    for i in range(1, num_posts + 1):
        result *= i

    return result

```

## Exponential Decay

In physics, exponential decay is a process where a quantity decreases over time at a rate proportional to its current value

`N(t) = (N sub 0)e ** (-lambda * t)`

N(t) -> Is the quantity at time t
N sub 0 - N(0) is te initial quantity, that is, quantity at time t = 0

```python
def decayed_followers(intl_followers, fraction_lost_daily, days):

    return intl_followers * (1 - fraction_lost_daily) ** days
```

## Logarithm Scale

In some cases, data can span several orders of magnitude, making it difficult to visualize on a linear scale. A logarithm scale can belp by compressing the data so that its easier to understand

For example, at Socialytics we have inlfuencers with follower counts ranging from 1 to 1000000000.
If we want to plot the follower count of each influencer on a graph, it would be difficult to see the differences between the smaller follower counts. We can use a logarithmic scale to compress the data so that its easier to visualize

```python
import math

def log_scale(data, base):
    new_scale = []

    for d in data:
        new_scale.append(math.log(d, base))

    return new_scale

log_scale([1, 10, 100, 1000], 10)
```

## Big O Notation

Big O is a characterization of algorithms according the their worst-case growth rates

We write Big-O notation like this:
`O(formula)`

Where formula describes how an algorithms run time or space requirements grow as the input size grows

- `O(1)` == constant -> Best Escenario -> Excelent Performance
- `O(n)` == linear
- `O(n ** 2)` == squared
- `O(2 ** n)` == exponential
- `O(n!)` == factorial -> Worst Escenario -> Horrible Performance

```python
# O(n)
def get_product(nums):
    if len(nums) == 0:
        return 0
    product = 1
    for num in nums:
        product *= num
    return product

# O(1)
def get_first_number(nums):
    if len(nums) == 0:
        return None

    return nums[0]

# O(n ** 2)
def get_product_combos(nums):
    combos = []
    for num in nums:
        for second_num in nums:
            combos.append(num * second_sum)

    return combos
```

When we want to answer question like "How does it take to run the program" or "How fast it is" or "How much memory does it use". To respond those question we benchmark our solution

- Benchmark -> Run the program and take the time that takes to run

- Big O -> doesnt necesarally anwser this questions, instead it tell us how much worse will this function be to run, or how much longer it will take us to run this function, as the imput grows

- Big O is all about calculating how much longer a piece of software will take to run, as the imput size of that software increases

### O(N) - Order "N"

`O(n)` is very common - Any algorithm which has its numbers of steps grow at the same rate as its imput size is classified as `O(n)`

For example, our find min algorithm from earlir is O(n):

1. Set min to positive infinity
1. For each number in the list, compare it to min. If its smaller, set min to that number
1. min is now set to the smaleest number in the list

The input to the find min algorithm is a list of size n. Because we loop over each item in the input once, we add one step to our algorithm for each item in our list.

As we use find min with larger and larger inputs, the length of time it takes to execute the function grows at a steady linear pace. For example, if it takes the computer 2 milliseconds to compute each iteration of the loop, we would see something like this:

```python
find_min(1 item) # 2 milliseconds
find_min(2 items) # 4 milliseconds
find_min(3 items) # 6 milliseconds
find_min(4 items) # 8 milliseconds
find_min(5 items) # 10 milliseconds

```

### O(n^2)

Is still reasonably quick. In terms of security and cryptographi worries, "n squared" is quite fast, though in terms of snappy user interfaces things can get slow if the size of the imput grows too much.
A common way that an algorithm will fall into the `O(n^2)` class is by using a nested loop, where the number of iterations of each loop is equal to the number of items in the input

```python
def does_name_exist(first_names, last_names, full_name):
    for name in first_names:
        for last_name in last_names:
            if f"{name} {last_name}" == full_name:
                return True

    return False

# does_name_exist(10 first and last names) = 1 second to complete
# does_name_exist(100 first and last names) = 100 seconds
# does_name_exist(1,000 first and last names) = 10,000 seconds
# does_name_exist(10,000 first and last names) = 1,000,000 seconds

```

### O(nm)

Is very similar to `O(n^2)`. The difference is that instead of a single input that we care about, there are 2. If n and m increase at the same rate, then `O(nm)` is effectively the same as `O(n^2)`. However, if n or m increases faster or slower, then its useful to track their complexity separately.

```python
def get_avg_brand_followers(all_handles, brand_name):
    appearance = 0
    for handles in all_handles:
        for handle in handles:
            if handle.startswith(brand_name):
                appearance += 1

    return appearance / len(all_handles)

all_handles = [
    ["cosmofan1010", "cosmogirl", "billjane321"],
    ["cosmokiller", "gr8", "cosmojane3"],
    ["iloveboots", "paperthin"]
]

brand_name = "cosmo"

get_avg_brand_followers(all_handles, brand_name)
```

In regard to Big O, the number of influencers (the number of lists `all_handles`) matters. That's our n. However, the average number of followers each influencer has (the length of the lists `handles`) is just as important. That's our m.

### Constants Don't Matter

Big-O notation only describes the theoretical growth rate of algorithms, rather than the actual running time of the algorithm when implemented on a given computer. As such, when doing Big O analysis, we don't let ourselves get bogged down in details.

For example, take a look at the following functions:

```python
def print_names_once(names):
    for name in names:
        print(name)

def print_names_twice(names):
    for name in names:
        print(name)
    for name in names:
        print(name)
```

`print_names_once` will take half the time to run as `print_names_twice`. The funny thing about Big O analysis is that WE DONT CARE

Both function have the same rate of growth, `O(n)`. You might be tempted to say, "print_names_twice should be `O(2*n)`" but you would be missing the whole point of Big O.

In Big O analysis we drop all constants because they dont affect the _change_ in the runtime, just the runtime itself

If the curves have the same shape they are the same **order**. We can also look at the growth rate over time, how much T takes when N increases. For linear algoriths the increase of T per N is gonna be the linear.

`O(2*n)` -> `O(n)`
`O(10 * 2^n)` -> `O(n^2)`

### Order 1

`O(1)` means that no matter the size of the input, there is no growth in the runtime of the algorithm.

In python, the `dictionary` data structure offers the ability to look items up by key, which is an operation that is independent of the size of the dictionary. In other words, dictionary lookups are `O(1)`.

```python
def find_last_name(names_dict, first_name):
    if first_name in names_dict:
        return names_dict[first_name]

    return None
```

### Order Log N

`O(log(n))` algorithms are only slightly sloer than `O(1)`, but quite faster than `O(n)`.
They do grow according to the input size, `n`, but only according to the log of the input

O(n):
| n | time |
|---|------|
|8 |8 ms |
|64 | 64 ms|
|1024 | 1024 ms|
|1048576| 1048576 ms|

O(log(n)):
|n |time|
|--|---|
|8 |3 ms|
|64 |6 ms|
|1024 |10 ms|
|1048576| 20|

#### Bynary Search

A binary search algorithm is a common example of `O(log(n))` algorithm. Binary Searches work on sorted list of elements

The algorithm is as follows:

Given an array of n elements sorted from least to greatest, and a target value:

- Set low=0 and high=n-1.
- While low \<= high:
  - Set median (the position of the middle element) to (low+high)//2, which is the greatest integer less than or equal to (low+high)/2
  - If array\[median\] \< target, set low to median+1
    Otherwise set high to median-1
- If (low != n) AND (array\[low\] == target), return True; the target was found, otherwise return False

Because at each iteration of the search we are halving the size of the search space, the algorithm has a complexity of log2, or O(log(n)).

> Binary Searches ares fast

```python
def binary_search(target, arr):
    low = 0
    high = len(arr) - 1

    while low <= high:
        median = (low + high) // 2

        if arr[median] < target:
            low = median + 1
        else:
            high = median - 1

    if low < len(arr) and arr[low] == target:
        return True
    else:
        return False
```

```python
# data = [
#     {'name': 'Pennywise', 'followers': 40},
#     {'name': 'Bill', 'followers': 50},
# ]
# target = 40

def binary_search_dict(data, target):
    low = 0
    high = len(data) - 1

    while low <= high:
        median = (low + high) // 2

        if data[median]["followers"] < target:
            low = median + 1
        else:
            high = median -1

    if low < len(data) and data[low]["followers"] == target:
        return data[low]["name"]

    return None
```

- Name Count: Is should be `O(n)` on the total number of names, but `O(mn)` if you consider `m` to be the numbers of lists and `n` to be the average lenght of a list.

```python
def count_names(list_of_lists, target_name):
    count = 0
    for list in list_of_lists:
        for name in list:
            if name == target_name:
                count += 1

    return count
```

### Order 2^n - Exponential

Is the first Big O class that we've dealt with that falls into the scary _exponential_ category of algorithms.

Algorithms that grow at an exponential rate become impossible to compute after so few iterations that they are almost worthless in practicality.

Compute the _power set_ of a set. A power set is the set of all possible subsets of a set.

For example the set `{1, 2, 3}` has the power set:
`{{}, {1}, {2}, {3}, {1, 2}, {1, 3}, {2, 3}, {1, 2, 3}}`

```python
def power_set(input_set):
    if len(input_set) == 0:
        return [[]]

    subsets = []
    first = input_set[0]
    remaining = input_set[1:]
    remaining_subsets = power_set(remaining)
    for subset in remaining_subsets:
        subsets.append([first] + subset)
        subsets.append(subset)
    return subsets

```

#### Polynomial vs Exponental

Polynomial time describes any algorithm with a run time that doesn't increase faster than n^k, where k is any constant and n is the size of the input.

Polynomial Time

- `O(1)`
- `O(n)`
- `O(n*log(n))`
- `O(n^2)`
- `O(n^3)`

Polynomial functions ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â¦ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã¢â‚¬Å“scale well". They are fast enough to be generally useful.
Small changes to the size of the input do not typically induce enormous changes to the overall runtime.

Exponential Time

- `O(2^n)`
- `O(n^n)`
- `O(n!)` (technically this is factorial time, but let's lump them together for simplicity)

Exponential functions scale terribly.
Small changes to the size of the input induce huge changes in the overall runtime.

Polynomial Time -> P is a complexity class that refers to all algorithms that fall into the "polynomial" category

**There are two rules that generally holds**:

- Problems that fall into class P are easy, fast, and practical to solve on computers.
- Problems that don't fall into P are hard, slow and impractical.

```python
# Transform fib function from O(n^3) to O(n)

def fib(n): # Exponential time -> O(2^n)
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fib(n - 1) + fib(n - 2)

def fib(n): # Polinomail Time -> O(n)
    if n == 0:
        return 0

    grandparent = 0
    parent = 1
    current = 1

    for i in range(n - 1):
        parent = current
        current = parent + grandparent
        grandparent = parent

    return current
```

### Upper Bounds

Can be tought of as a sloppy guess that is no less than the exact answer. For example, if an algorithm is best described as `O(n)` it also has an upper bound of `O(n^2)` or even `O(n!)` if we want to be sloppy

### BIG O REVIEW

- `O(1)` -> constant -> _Best The algorithm always takes the same amount of time, regardless of how much data there is. Example: Looking up an item in a list by index_
- `O(log n)` -> logarithmic -> _Great Algorithms that remove a percentage of the total steps with each iteration. Very fast, even with large amounts of data. Example: Binary search_
- `O(n)` -> linear -> _Good 100 items, 100 units of work. 200 items, 200 units of work. This is usually the case for a single, non-nested loop. Example: unsorted array search._
- `O(n log n)` -> "linearithmic" -> _Okay This is slightly worse than linear, but not too bad. Example: mergesort and other "fast" sorting algorithms._
- `O(n^2)` -> quadratic -> _Slow The amount of work is the square of the input size. 10 inputs, 100 units of work. 100 Inputs, 10,000 units of work. Example: A nested for loop to find all the ordered pairs in a list._
- `O(n^3)` -> cubic -> _Slower If you have 100 items, this does 100^3 = 1,000,000 units of work. Example: A doubly nested for loop to find all the ordered triples in a list._
- `O(2^n)` -> exponential -> _Horrible We want to avoid this kind of algorithm at all costs. Adding one to the input doubles the amount of steps. Example: Brute-force guessing results of a sequence of n coin flips._
- `O(n!)` -> factorial -> _Even More Horrible The algorithm becomes so slow so fast, that is practically unusable. Example: Generating all the permutations of a list._

### Exponential Growth Sequences

```python
def exponential_growth(n, factor, days):
    result = [n]

    for i in range(1, days + 1):
        result.append(result[i - 1] * factor)

    return result
```
