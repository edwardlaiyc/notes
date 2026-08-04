Takes one value at a time, places it into the right place in the sorted portion.

- 4 steps: removal, comparison, shift, insertion.
- Removals = Insertions = N - 1
- Comparisons = Shifts = 1 + … + (N - 1) = (N² - N)/2
- Worst case (reversed array): N² + N – 2 → O(N²).
- Best case (only comparison): N – 1 → O(N).

Average = N² / 2

Varies from O(N), to O(N²), better than Selection Sort for nearly-sorted data.

![](images/insertion-sort-01.png)

```
def insertionSort(arr):
    n = len(arr)  # Get the length of the array

    if n <= 1:
        return  # If the array has 0 or 1 element, it is already sorted, so return

    for i in range(1, n):  # Iterate over the array starting from the second element
        key = arr[i]  # Store the current element as the key to be inserted in the right position
        j = i-1

        while j >= 0 and key < arr[j]:  # Move elements greater than key one position ahead
            arr[j+1] = arr[j]  # Shift elements to the right
            j -= 1

        arr[j+1] = key  # Insert the key in the correct position

    return arr
```

Binary search in Insertion Sort:

```
def binary_search(arr, key, start, end):
    """
    A helper function that performs binary search on a sorted subarray to find
    the correct position to insert the key.
    """

    no_steps = 0
    while start <= end:
        mid = (start + end) // 2
        if arr[mid] < key:
            start = mid + 1
        else:
            end = mid - 1

        no_steps += 1

    return start, no_steps

def optimized_insertion_sort(arr):
    total_no_steps = 0
    # Traverse through the array starting from the second element
    for i in range(1, len(arr)):
        key = arr[i]

        # Use binary search to find the position where key should be inserted
        pos, bs_no_steps = binary_search(arr, key, 0, i - 1)
        total_no_steps += bs_no_steps

        # Shift elements to the right to make space for the key at its correct position
        for j in range(i, pos, -1):
            arr[j] = arr[j - 1]

        arr[pos] = key

    return arr, total_no_steps
```

Check for duplicate numbers

```
def has_duplicate(array):
    # create an array to store the number of occurencies for each element
    existing_numbers = [0] * 11

    for i in range(len(array)):
        if existing_numbers[array[i]] == 1:
            return True
        else:
            existing_numbers[array[i]] = 1

    return False
```
