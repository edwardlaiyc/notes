Start at midpoint; repeatedly halve the search range.

Doubling array size only requires one more step.

Worst-case: (logN + 1) number of steps → O(log N)

```
def binary_search(array, search_value):

    lower_bound = 0
    upper_bound = len(array) - 1

    number_of_steps = 0

    while lower_bound <= upper_bound:

        midpoint = (upper_bound + lower_bound) // 2
        value_at_midpoint = array[midpoint]
        number_of_steps += 1

        if search_value == value_at_midpoint:
            return midpoint, number_of_steps

        elif search_value < value_at_midpoint:
            upper_bound = midpoint - 1

        elif search_value > value_at_midpoint:
            lower_bound = midpoint + 1

    return "Not found", number_of_steps  #no such value
```
