# Sorting Algorithms

Algorithms to sorts datastructures like arrays, trees, etc.

## Bubble Sort

Bubble sort is named for the way elements "bubble up" to the top of the list.

Bubble sort repeatedly steps through a slice and compares adjacent elements, swapping them if they are out of order. It continues to loop over the slice until the whole list is completely sorted.

Big O complexity is `O(n^2)`. Because the while loop is gonna loop the len(nums) amounts of times, and the inner loop the same `T(n) = n * n = n ^ 2`

Upper Bound is `O(n^2)` and Lower Bound is `O(n)`

Bubble sort is famous for how easy it is to write. It's one of the slowest sorting algorithms, but can be useful for a quick script or when the amount of data to be sorted is guaranteed to be small.

```python
def bubble_sort(nums: list[int]):
    end_of_list = len(nums)
    swapping = True
    while swapping:
        swapping = False
        for i in range(1, end_of_list):
            if nums[i - 1] > nums[i]:
                nums[i], nums[i - 1] = nums[i - 1], nums[i]
                swapping = true

        end_of_list -= 1

    return nums
```

## Merge Sort

Merge sort is a recursive sorting algorithm and its quite a bit faster than bubble sort.

### Divide and Conquer

Merge sort is a _divide and conquer algorithm_:

- Divide : divide the large problem into smaller problems, and recursively solve the smaller problems
- Conquer : Combine the result of the smaller problem to solve the large problem

In merge sort specifically we:

#### Divide

- Divide the array into two (equal) halves
- Recursively sort the two halves

#### Conquer

- Merge the two halves to form a sorted array

### Algorithm

The algorithm consists of two separte functions, `merge_sort` and `merge`.

`merge_sort()` -> divides the input array into two halves, calls itself for the two halves, and then merges the two sorted halves

`merge()` -> merges the two sorted lists back into a single sorted list. At the lowest level of recursion, the two "sorted" lists will each have a lenght of `1`. Those single element lists will be merged into a sorted list of lenght two.

Big O complexity is `O(nlog(n))`

Why use it?

- Fast: Merge sort is much faster than bubble sort, being `O(n*log(n))` instead of `O(n^2)`.
- Stable: Merge sort is also a stable sort which means that values with duplicate keys in the original list will be in the same order in the sorted list.
- Extra memory: Most sorting algorithms can be performed using a single copy of the original array. Merge sort requires an extra array in memory to merge the sorted subarrays.
- Recursive: Merge sort requires many recursive function calls, and function calls can have significant resource overhead.

```python
def merge(a, b):
    final_list = []

    a_i = 0
    b_i = 0

    while a_i < len(a) and b_i < len(b):
        if a[a_i] <= b[b_i]:
            final_list.append(a[a_i])
            a_i += 1
        else:
            final_list.append(b[b_i])
            b_i += 1

    while a_i < len(a):
        final_list.append(a[a_i])
        a_i += 1
    while b_i < len(b):
        final_list.append(b[b_i])
        b_i += 1

    return final_list

def merge_sort(a):
    if len(a) < 2:
        return a

    sorted_left_side = merge_sort(a[:len(a)//2])
    sorted_right_side = merge_sort(a[len(a)//2:])

    return merge(sorted_left_side, sorted_right_side)
```

## Insertion Sort

Builds a final sorted list one item at a time. It's much less efficient on arge lists than more advanced algorithms like quicksort or merge sort.

Big O -> `O(n^2)` because potentially is has to traverse the list n times (for loop) and n times (while loop) `n * n = n^2`

Why Use Insertion Sort?

- Simple implementation, easy to write
- Fast for very small data sets
- Faster than other simple sorting algorithms like Bubble Sort
- Adaptive: Faster for partially sorted data sets
- Stable: Does not change the relative order of elements with equal keys
- In-Place: Only requires a constant amount of memory
- Online: Can sort a list as it receives it

```python
def insertion_sort(nums):
    for i in range(len(nums)):
        j = i
        while j > 0 and nums[j-1] > nums[j]:
            nums[j], nums[j-1] = nums[j-1], nums[j]
            j -= 1

    return nums
```

## Quick Sort

Efficient sorting algorithm that's widely used in production sorting implementations.

Big O -> `O(n*log(n))`. In the worst case, and assuming we dont take any steps to protect ourselves, it can break down to `O(n^2)`.

`partition()` has a single for-loop that ranges from the lowest index to the highest index in the array. By itself, the `partition()` functions is `O(n)`. The overall complexity of quicksort is dependent on how many times `partition()` is called.

In the worst case, the input is already sorted. An already sorted array results in the pivot being the largest or smallest element in the partition each time. When this is the case, `partition()` is called a total of `n` times.

In the best case, the pivot is the middle of each sublist which results in `log(n)` calls to `partition()`

Like merge sort, quick sort is a divide and conquer algorithm.

### Why Use Quick Sort?

- Pros:
  - Very fast in the average case
  - In-Place: Saves on memory, doesn't need to do a lot of copying and allocating
- Cons:
  - More complex implementation
  - Typically unstable: changes the relative order of elements with equal keys

### Divide

- Select a pivot element that will preferably end up close to the center of the sorted pack.
- Move everything onto the "greater than" or "less than" side of the pivot.
- The pivot is now in its final position.
- Recursively repeat the operation on both sides of the pivot.

### Conquer

- The array is sorted after all elements have been through the pivot operation.

```python
def quick_sort(nums, low, high):
    if low < high:
        i = partition(nums, low, high)
        quick_sort(nums, low, i - 1)
        quick_sort(nums, i + 1, high)

    return nums


def partition(nums, low, high):
    pivot = nums[high]
    i = low
    for j in range(low, high):
        if nums[j] < pivot:
            nums[j], nums[i] = nums[i], nums[j]
            i += 1

    nums[i], nums[high] = nums[high], nums[i]

    return i
```

### Fixing Quick Sort Big O

There are two approaches to fix the worst case escenario:

1. Shuffle input randomly before sroting. This can trivially be done in `O(n)` time
2. Actively find the median of a sample of data from the partition. this can be done in `O(1)` time.

#### Random Approach

The random approach is easy to code, works practically all of the time, and as such is often used.

The idea is to quickly shuffle the list before sorting it. The likelihood of shuffling into a sorted list is astrnomically unlikely, and is also more unlikely the larger the input

#### Median Approach

One of the most popular solutions is to use the "median of three" approach. Three elements (for example: the first, middle, and last elements) of each partition are chosen and the median is found between them. That item is then used as the pivot.

This approach has the advantange that it can't break down to `O(n^2)` time because we are guaranteed to never use the worst item in the partition as the pivot. That said, it can stil be slower because a true median isn't used.

## Selection Sort

Similar to bubble sort in that it works by repeatedly swapping items in a list. However, its slightly more efficient than bubble sort because it only makes one swap per iteration.

```python

def selection_sort(nums):
    for i in range(len(nums)): # 0 .. n
        smallest_idx = i
        for j in range(smallest_idx + 1, len(nums)): # i + 1 .. n, i + 2 .. n, ...
            if nums[j] < nums[smallest_idx]:
                smallest_idx = j

        nums[i], nums[smallest_idx] = nums[smallest_idx], nums[i]

    return nums
```
