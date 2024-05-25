# Non deterministic polynomial time

`NP` is the set of problems whose solutions can be verified in `polynomial time`, but not ncessarily solved in `polynomial time`

`NP` is a complexity class ued to classify decision problems.

- `NP` is the set of decision problems solvable in polynomial time by a nondeterministic Turing machine.
- `NP` is the set of decision problems verifiable in polynomial time by a deterministic Turing machine.

## Verified and Solved

Say we are using InsertingSort algorithm.

_Verified_: Means that we can verfied an awnser in Polynomail Time, with Inserting Sort if we have an already sorted algorithm it will take `O(n)` to finish.
_Solved_: Means that the worst case escenario is inside Polynomial Time. In the case of Inserting Sort `O(nlog(n))`

## P is in NP

Because all the problems that can be solved in polynomail time can also be verified in polynomial time, all the problems in `P` are also in `NP`.

```text
___________________
|      NP         |
|                 |
|_________________|
||     P         ||
||_______________||
-------------------
```

## The oracle

A good way of thinking about problems in `NP` is to imagine that we have a magic oracle that gives us potential solutions to problems. Here would be our process for finding if a problem is in `NP`:

- Present the problem to the magic oracle
- The magic oracle gives us a potential solution
- We verify in polynomial time that the solution is correct

If we are able to do the verification in polynomail time, the problem is in `NP`, otherwise, it isn't.

## NP-Complete

Some, but not all problems in `NP` are also cnsidered to be NP-Complete.

A problem in `NP` is also `NP-Complete` if every other problem in `NP` can be reduced into it in polynomial time.

### How is a problem "reduced"?

Any problem, let's call it Problem A, can be reduced to a different problem, Problem B, if there is an algorithm (called a reducer) that changes an algorithm that solves Problem B into an algorithm that solves Problem A.

Algorithm to solve B -> reducer -> Algorithm to solve A

We say that "Problem A is reducible to problem B" if the reducer from the above can be run in polynomial time.

### What Does That Mean With NP-Complete?

If we have an algorithm that solves an NP-complete problem, it has been proven that we can quickly reduce that algorithm into a new algorithm to solve any other problem in NP.

Verify how much guesses someone has to make to guess the password in base of the lenght, can only use the 26 letters lower-case

```python
def get_num_guesses(length):
    possibilities = 0
    for i in range(length):
        possibilities += 26 ** (i + 1)

    return possibilities
```

## Does P Equal NP?

The P versus NP problem is a major unsolved problem in computer science. It asks whether every problem whose solution can be quickly verified (which means it is in NP) can also be solved quickly (which would mean it is also in P).

The question is "Are all NP problems really just P problems?"

The answer is, "we don't know, but probably not".

### Why do we care?

All problems in NP (you know, hard ones like the traveling salesman problem) have been proven to also be solved if we can find a solution to any NP-Complete problem.

If a single NP-complete problem can be shown to be solved quickly (in polynomial time) then that means that ALL problems in NP can be solved in polynomial time.

In other words, if anyone figures out how to solve any NP-Complete problem in polynomial time, it means that P really does equal NP.

## NP-Hard

A problem is NP-hard if every problem in NP can be reduced into it in polynomial time.

All NP-complete problems are NP-hard, but not all NP-hard problems are NP-complete. The determining factor between NP-complete and NP-hard is that not all NP-hard problems are in NP.

```text
|-----------------|
|    NP-Hard      |
|-----------------|
|    NP-Complete  |
||---------------||
|      NP         |
|                 |
|_________________|
||     P         ||
||_______________||
```

## Subset Sum Problem

It should take a list of integers nums and an integer target, and return True if there exists a subset of nums that adds up to target, and False otherwise. We'll use a recursive, brute-force approach to solve the problem. Brute-force just means we'll try every possible combination to see if any of them add up to the target.

```python
def subset_sum(nums, target):
    return find_subset_sum(nums, target, len(nums) - 1)

def find_subset_sum(nums, target, index):
    if target == 0:
        return True

    if index < 0 and target != 0:
        return False

    if nums[index] > target:
        return find_subet_sum(nums, target, index - 1)
    else:
        return find_subset_sum(nums, target, index - 1) or find_subset_sum(nums, target - nums[index], index - 1)
```
