Lomuto partition:

```
def lomuto(arr, low, high):
    
    # choose last element as pivot
    pivot = arr[high] 
    
    # pointer i tracks where to place pivot
    i = low

    # pointer j iterates through array
    for j in range(low, high):
        
        # If current element is smaller than pivot
        if (arr[j] < pivot):
            
            # swap array[i] and array[j]
            array[i], array[j] = array[i], array[j]
            i += 1
    # swap pivot and array[i]
    arr[i], arr[high] = arr[high], arr[i]
    return (i)
```

Hoare’s partition:

```
def hoares(arr, low, high):

    # choose last element as pivot
    pivot = arr[high]
    a = low
    b = high - 1

    while True:

        # Move a right until value > pivot
        while a <= b and (arr[a] < pivot):
            a += 1

        # Move b left until value < pivot
        while a <= b and (arr[b] > pivot):
            b -= 1
        if (a < b):
            # Swap values
            arr[a], arr[b] = arr[b], arr[a]
        else:
            # Break out if pointers met
            break
    # Swap pointer with pivot
    arr[a], arr[high] = arr[high], arr[a]
    return a
```

Quicksort algorithm

```
def quicksort(arr, left, right)
    if (left < right):
        pivot = partition(arr, left, right)
        quicksort(arr, left, pivot-1)
        quicksort(arr, pivot+1, right)
```

Comparison:

Hoare’s better performance and efficiency than Lomuto.

But Lomuto’s uses a single pointer compared to Hoare’s double pointer, so Loumto’s is simpler.

It may be better to use Lomuto’s if Hoare’s has insignificant efficiency gain.

|   | Lomuto’s | Hoare’s |
|---|---|---|
| Efficiency | Less efficient  Degrades quicksort to O(N2) when array is already sorted. | More efficient, does three times less swaps on average. Degrades quicksort to O(N2) when array is already sorted. |
| Implementation | One pointer, simpler to implement | Two pointers |

| Best case | Average case | Worst case |
|---|---|---|
| O(N log N) Each partition divides array into two equal parts. There are then log2N calls to reach subarray of size 1. Each level of call needs O(N) time as each subarray processes a different part of the array. Thus total time O(N log N). | O(N log N) Each partition function takes O(N) time. Approximately divides array into half each time, O(log N) levels. | O(N2) When array is partitioned into sizes (N-1) and 1. May occur when pivot is repeatedly the smallest or largest element. There are (N-1) calls, and O(N) time each call. So total time is O(N2). |
