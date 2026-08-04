```
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

head = Node("once")
head.next = Node("upon")
head.next.next = Node("a")
head.next.next.next = Node("time")
```

Each node contains some data, and a link that stores the next node’s memory address

|   | Array | Linked List |
|---|---|---|
| Read value | O(1) | Worst case at the end, O(N) |
| Search value | Linear search O(N) | O(N) |
| Insertion at beginning | Worst case, O(N) | Best case O(1) |
| Insertion at middle | Average case O(N) | Average case O(N) |
| Insertion at end | Best case O(1) | Worst case O(N) N+1 steps |
| Deletion | O(N) Best case delete at end, O(1) | O(N) Best case delete first node, 1 step |
| Implement a stack | Make last entry of the array the top of stack. Push and pop operations take O(1) time. Elements are stored in contiguous memory location, limiting the size of the stack. | Use the head of the linked list as the top of stack. Push and pop operations take O(1) time. Takes twice the memory space compared to array, but doesn’t need to be stored in contiguous memory. |

Use case for linked lists: when need to make many insertions and deletions when iterating through a list, to reduce shifting steps.

Doubly linked list: each node contains 2 links, for the previous and next nodes’ addresses.

Takes only O(1) time for both insertion at the end and deletion from the front, making it ideal for implementing a queue. (An array requires O(N) time for deletion from the front).

```
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
        self.prev = None
```
