The computer keeps track of recursion using a call stack

![](images/recursion-01.png)

Stack overflow: When there is no base case, causing infinite recursion. The computer keeps pushing the function onto the call stack, until the computer runs out of short-term memory to hold all the data.

```
def countdown(number):
  print(number)
  countdown(number - 1)
```

Dynamic programming through memoisation: Solves overlapping subproblems (unnecessary recursive calls) by remembering previously computed functions.

Can be implemented using hash table.

Original recursive implementation:

```
def fibo(n):
  if n <=1:
    return n
  else
    return fibo(n-1) + fibo(n-2)
```

The number of recursive calls almost doubles each time n increases by 1. O(2^N) time.

Using dynamic programming:

```
def fibo(n, memo):
  if n <=1:
    return n

  if n not in memo:
    memo[n] = fibo(n-1, memo) + fibo(n-2,memo)

  return memo[n]
```

Number of calls becomes 2N-1. O(N) time.
