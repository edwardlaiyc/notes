Repeatedly compare adjacent elements and swap if out of order.

Largest element at last index after first pass.

Comparisons + Worst case Swaps = 2[(N – 1) + … + 1] = N² – N

O(N²), quadratic time.

Best case O(N)

![](images/bubble-sort-01.png)

Naive:

```
def bubble_sort(arr):

    # Outer loop to iterate through the list n times
    for n in range(len(arr) - 1, 0, -1):

        # Inner loop to compare adjacent elements
        for i in range(n):
            if arr[i] > arr[i + 1]:
                # Swap elements if they are in the wrong order
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
```

Break if already sorted:

```
def bubble_sort(arr):

    # Outer loop to iterate through the list n times
    for n in range(len(arr) - 1, 0, -1):

        # Initialize swapped to track if any swaps occur
        swapped = False
        # Inner loop to compare adjacent elements
        for i in range(n):
            if arr[i] > arr[i + 1]:
                # Swap elements if they are in the wrong order
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                # Mark that a swap has occurred
                swapped = True

        # If no swaps occurred, the list is already sorted
        if not swapped:
            break
```

Optimise number of swaps:

```
def optimized_bubble_sort(arr):
    n = len(arr)
    while n > 1:
        last_swap = 0  # Track the last index where a swap occurs
        for i in range(1, n):
            if arr[i - 1] > arr[i]:
                arr[i - 1], arr[i] = arr[i], arr[i - 1]  # swap
                last_swap = i  # update last swap position
        n = last_swap  # shrink the boundary
    return arr
```
