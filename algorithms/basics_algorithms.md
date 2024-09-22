# BASIC

Collection of basic algorithms and different ways of implement it

## Find minimum

1. Set `minimum` to positive infinity: `float("inf")`
1. For each number in the list `nums`, compare it to `minimum`. If `num` is smaller, set `minimum` to `num`
1. `minimum` is now set to the smallest number in the list.

```python

# O(N)
def find_minimum(nums):
    min = float("inf")

    for n in nums:
        if n < min:
            min = n

    return min

# O(LOGN)
def find_minimum(nums):
    return nums.sort()[0]
```

## Sum an array of numbers

1. Create `count` variable
2. Traverse the array
3. Add to `count` the current value
4. return `count`

```python
# O(N)
def sum(nums: list[int]) int:
    count = 0

    for n in nums:
        count += n

    return count

# Recursive O(?)
def sum(nums):
   return sum_number(nums)

def sum_number(nums):
    if nums == []:
        return 0

    return nums[0] + sum_number(nums[1:])

```

## Average

```python

# O(N)
def average_followers(nums):
    if not nums:
        return None

    count = 0
    for n in nums:
        count += n

    return count/len(nums)

# O(?) Recursive
def average_followers(nums):
   if not nums:
       return None

   return sum_number(nums)/len(nums)

def sum_number(nums):
    if nums == []:
        return 0

```

## Median

```python
def median_followers(nums):
    n = len(nums)
    sorted_list = sorted(nums)

    if n == 0:
        return 0

    if n % 2 == 0:
        return (sorted_list[n//2 - 1] + sorted_list[n//2]) / 2

    return sorted_list[n//2]
```
