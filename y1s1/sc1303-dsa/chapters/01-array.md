Uses contiguous memory. Elements stored in a single, continuous block of memory without gaps.

This means memory addresses can be calculated instantly.

Read: O(1)

Linear search: max N steps → O(N)

If sorted, binary search: O(logN)

Insertion at front: N+1 steps → O(N)

Insertion at end: 1 step → O(1)

Delete at front: N steps → O(N)

Delete at end: 1 step → O(1)

Reverse an array:

```
def reverse_array(arr):
    left = 0
    right = len(arr) - 1
    steps = 0

    # Swap elements until pointers meet
    while left < right:
        arr[left], arr[right] = arr[right], arr[left]
        left += 1
        right -= 1
        steps += 1

    return arr, steps

# Example Test
arr = [1, 2, 3, 4, 5]
print(reverse_array(arr))

([5, 4, 3, 2, 1], 2)
```
