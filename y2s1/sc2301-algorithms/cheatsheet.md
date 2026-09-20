::: {.cheatsheet}
::: {.cheatsheet-sheet}
::: {.cheatsheet-column}
::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Asymptotic Notation & Limits
:::

Asymptotic notation describes how running time grows as input size $n \to \infty$ ($f(n) \ge 0$). Limit ratio $L = \lim_{n \to \infty} \frac{f(n)}{g(n)}$.

| Notation | Formal Definition ($\forall n \ge n_0$) | Limit | Plain Meaning |
|---|---|---|---|
| $O(g)$ | $\exists c>0, n_0>0 : f(n) \le c \cdot g(n)$ | $L < \infty$ | Grows no faster than $g$ ($\le$) |
| $\Omega(g)$ | $\exists c>0, n_0>0 : f(n) \ge c \cdot g(n)$ | $L > 0$ | Grows at least as fast as $g$ ($\ge$) |
| $\Theta(g)$ | $\exists c_1, c_2, n_0 : c_1 g \le f \le c_2 g$ | $0 < L < \infty$ | Grows at the same rate ($=$) |
| $o(g)$ | $\forall c>0, \exists n_0>0 : f(n) < c \cdot g(n)$ | $L = 0$ | Grows strictly slower ($<$) |
| $\omega(g)$ | $\forall c>0, \exists n_0>0 : f(n) > c \cdot g(n)$ | $L = \infty$ | Grows strictly faster ($>$) |

- Big bounds ($O, \Omega, \Theta$) require finding only one constant $c > 0$. Little bounds ($o, \omega$) must hold true for every chosen constant $c > 0$.
- To prove $f(n) = \Theta(g(n))$, you must prove both $f(n) = O(g(n))$ and $f(n) = \Omega(g(n))$.
- If the limit ratio oscillates and never settles on a value, you cannot use the limit test. You must write out the formal inequality directly.
- Parity example: if $f(n)=n$, and $g(n)=1$ for even $n$ and $n^2$ for odd $n$, neither function bounds the other because values alternate forever.

::: {.cheatsheet-subsection-title}
Loop Invariants & Program Interruptions
:::

- **Loop Invariant Proof Steps:**
  1.  *Initialization:* Show the statement is true before the first iteration starts.
  2.  *Maintenance:* Show that if the statement is true before an iteration, it remains true before the next iteration.
  3.  *Termination:* Show that when the loop ends, the statement proves the algorithm sorted or solved the input correctly.
- **Interrupting an Algorithm Early:**
  - *Insertion Sort:* Every swap removes exactly one out-of-order pair. The number of out-of-order pairs never increases. If stopped early and restarted, it always continues making forward progress toward sorted order.
  - *Mergesort / Quicksort:* Recursive algorithms track subproblem bounds on the call stack. Restarting from the outer loop resets indices and can cause infinite loops or corrupted state.
:::::

::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Mergesort
:::

Divides the array into two equal halves, sorts each half recursively, and merges the two sorted halves into a single sorted array.

- **Worst-Case Recurrence:** $W(1)=0$, $W(n) = 2W(n/2) + n - 1$. This solves to $W(n) = n \lg n - n + 1 = \Theta(n \log n)$. Merging takes at most $n - 1$ comparisons because the final comparison places the last two elements together.
- **Best-Case Recurrence:** $B(1)=0$, $B(n) = 2B(n/2) + \lfloor n/2 \rfloor$. This solves to $B(n) = \frac{1}{2} n \lg n = \Theta(n \log n)$. This happens when every element in one half is smaller than every element in the other half, so the merge loop exits early after $\lfloor n/2 \rfloor$ comparisons.
- **Average Case:** Because both best and worst cases run in $\Theta(n \log n)$ time, the average case is squeezed between them and is also $\Theta(n \log n)$.
- **Standard Buffered Mergesort:** Allocates an auxiliary buffer of size $O(n)$ to merge elements in $\Theta(n \log n)$ data movements. Its recursion call stack reaches a tree depth of $\lceil \lg n \rceil$, giving an extra $O(\log n)$ stack frames. Because the $O(n)$ data buffer dominates the $O(\log n)$ stack space, the total auxiliary space is $O(n)$. It is strictly stable because equal keys are taken from the left subarray first.
- **In-Place Mergesort (Lecture Slide Variant):** Merges by shifting elements directly inside the array without an external buffer. While it allocates no extra data buffer ($O(1)$ heap space), its recursive calls still require $O(\log n)$ auxiliary space on the call stack. It takes $O(n^2)$ data movements due to shifting, and is unstable because inserting duplicate items at index $a+1$ flips their original relative order.
- **Finding Min and Max Together:** Comparing elements in pairs at the base level follows $W(n) = 2W(n/2) + 2$ with base case $W(2) = 1$. This solves to $1.5n - 2$ comparisons, saving $25\%$ over checking elements one by one ($2n - 2$).
::::

::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Limits of Comparison Sorting
:::

- **Decision Tree Model:** We represent any comparison sort as a binary tree where internal nodes are comparisons ($A[i] : A[j]$), branches are outcomes ($\le$ or $>$), and leaves are output permutations.
- **Why Comparison Sorts Cannot Beat $\Omega(n \log n)$ :**
  - An algorithm must be able to output all $n!$ possible arrangements, so the tree must have at least $n!$ leaves.
  - A binary tree of height $h$ can have at most $2^h$ leaves, giving $2^h \ge n!$.
  - Taking the logarithm gives $h \ge \lg(n!) = \Omega(n \log n)$.
  - The height $h$ represents the worst-case comparison count. Therefore, no comparison sort can run faster than $\Omega(n \log n)$ in the worst case.
- **Minimum Comparisons Needed Even in the Best Case:**
  - Every valid leaf must have a depth of at least $n - 1$ comparisons.
  - If an algorithm made fewer than $n - 1$ comparisons, its comparison graph would be broken into at least two disconnected pieces.
  - Because items in separate pieces were never compared, the algorithm cannot know their true relative order, meaning an adversary could force a mistake.
- **Bypassing the Limit:** Counting Sort and Radix Sort run in linear time $O(n)$ because they use integer array indexing rather than pairwise comparisons.
::::

::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Quicksort
:::

Divides the array around a chosen pivot, moves smaller values to the left and larger values to the right, and recursively sorts each half.

- **Course Partition Steps:**
  1.  Find midpoint `mid = (low + high) / 2` and swap `slot[low]` with `slot[mid]`.
  2.  Set `pivot = slot[low]` and set pointer `last_small = low`.
  3.  Scan index $i$ from $low+1$ to $high$. If `slot[i] < pivot`, increment `last_small` and swap `slot[last_small]` with `slot[i]`.
  4.  Swap `slot[low]` with `slot[last_small]` to put the pivot into its final resting position, then return `last_small`.
- **Complexities:** Best and average cases run in $\Theta(n \log n)$ time. The worst case runs in $\Theta(n^2)$ time when the pivot is always the extreme smallest or largest item. Space on the recursion stack takes $O(\log n)$ average and $O(n)$ worst case. It is in-place and unstable.
- **Three-Way Partitioning (Values 0, 1, 2):** Maintains three pointers: $r$ for 0s, $u$ for unexamined values, and $b$ for 2s.
  - If $A[u] == 0$: swap $A[r]$ with $A[u]$, then advance both $r++$ and $u++$.
  - If $A[u] == 1$: advance $u++$.
  - If $A[u] == 2$: swap $A[b]$ with $A[u]$, then decrement $b--$ without moving $u$.
  - Runs in $\Theta(n)$ time using $O(1)$ extra space.
- **Median-of-Three Adversary:** Even when picking the median of the first, middle, and last elements, an adversary can arrange values so the pivot is always the second smallest, shrinking the subproblem by only 2 elements each time and forcing $\Theta(n^2)$ total comparisons.
::::

::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Master Sorting Comparison
:::

| Algorithm | Best | Worst | Aux Space | In-Pl? | Stab? |
|---|---|---|---|---|---|
| Insertion Sort | $\Theta(n)$ | $\Theta(n^2)$ | $O(1)$ | Yes | **Yes** |
| Mergesort (In-Pl) | $\Theta(n\lg n)$ | $\Theta(n\lg n)$ | $O(\lg n)$ stk | Yes | **No** |
| Mergesort (Buffer) | $\Theta(n\lg n)$ | $\Theta(n\lg n)$ | $O(n)$ | No | **Yes** |
| Heapsort | $\Theta(n\lg n)$ | $\Theta(n\lg n)$ | $O(1)$ | Yes | **No** |
| Quicksort | $\Theta(n\lg n)$ | $\Theta(n^2)$ | $O(\lg n)$ avg, $O(n)$ wst | Yes | **No** |
| Counting Sort | $\Theta(n+k)$ | $\Theta(n+k)$ | $\Theta(n+k)$ | No | **Yes\*** |
| Radix Sort | $\Theta(dn)$ | $\Theta(dn)$ | $\Theta(n+k)$ | No | **Yes** |

\*Counting sort is stable only when placing elements using a backward scan.
::::
::::::::::::::

::: {.cheatsheet-column}
::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Insertion Sort
:::

Maintains a sorted section on the left. It takes the next unsorted element and shifts larger items right until the element finds its correct spot.

- **Best Case:** $\Theta(n)$ time. Runs $n - 1$ comparisons and $0$ swaps when the array is already sorted in ascending order.
- **Worst Case:** $\Theta(n^2)$ time. Runs $\frac{n(n-1)}{2}$ comparisons and swaps when the array is reverse sorted.
- **Average Case:** $\Theta(n^2)$ time. Takes $\frac{n^2+n-2}{4}$ comparisons on random inputs.
- **Space & Stability:** It is in-place ($O(1)$ extra space) and strictly stable.
- **Behavior on Equal Elements:** The check `slot[j] < slot[j-1]` evaluates to false on duplicate keys. The inner loop breaks immediately, taking only 1 comparison and 0 swaps.
- **Comparisons vs Swaps:** Reaching maximum comparisons does not always require maximum swaps. In an array like $[n, n-1, \dots, 3, 1, 2]$, the last element compares against every preceding item, hitting the maximum comparison count even though not every step swaps.
::::

::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Heapsort & Priority Queues
:::

A heap is an almost-complete binary tree stored sequentially in an array starting at index 1 that satisfies the parent-child heap property.

- **1-Indexed Array Rules (Node $i$, Size $n$):**
  - Parent: $\lfloor i/2 \rfloor$; Left Child: $2i$; Right Child: $2i + 1$.
  - Leaf Check: node $i$ is a leaf if $2i > n$.
  - Last Internal Node: the last node with children is $\lfloor n/2 \rfloor$.
  - Height: $\lfloor \lg n \rfloor = \Theta(\log n)$.
- **Max-Heap Rule:** Every parent node is larger than or equal to its children. The largest element is always at root index 1.
- **Restoring the Heap (`fixHeap`):** Compares the two children, then compares the larger child against the sinking value. It takes at most 2 comparisons per level, running in $O(\log n)$ time.
- **Building a Heap (`constructHeap`):** Calls `fixHeap` backward from $\lfloor n/2 \rfloor$ down to index 1. It runs in $\Theta(n)$ time because most nodes sit near the bottom with short sink distances: $\sum \lceil \frac{n}{2^{h+1}} \rceil O(h) = O(n)$.
- **Exact Best Case for Heap Building:** An array already sorted in descending order requires exactly $n - 1$ comparisons and 0 swaps because every parent is already larger than its children.
- **Heapsort Execution:** First builds a max-heap in $\Theta(n)$ time. Then repeatedly swaps the root $H[1]$ with the last element $H[i]$, shrinking the heap and calling `fixHeap` on the remaining elements.
- **Properties:** Runs in $\Theta(n \log n)$ time for best, worst, and average cases. It is in-place ($O(1)$ extra space) and unstable.
- **Merging $k$ Sorted Lists:** Place the first element of each list into a min-heap of size $k$ in $O(k)$ time. Repeatedly extract the minimum and insert the next element from that list in $O(\log k)$ time. Total time is $O(n \log k)$ using $O(k)$ extra space.
::::

::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Non-Comparison Linear Sorts
:::

- **Counting Sort Steps (Values from $0$ to $k$):**
  1.  Count frequencies into an array $C[0 \dots k]$ in $\Theta(n)$ time.
  2.  Calculate prefix sums via $C[i] = C[i] + C[i-1]$ in $\Theta(k)$ time.
  3.  Loop backward from $j = n-1$ down to 0: decrement $C[A[j]]$ first to translate the 1-based count into a 0-based index, then write $B[C[A[j]]] = A[j]$.
- **Complexity:** Runs in $\Theta(n + k)$ time and uses $\Theta(n + k)$ space. Runs in linear $\Theta(n)$ time when the range $k$ is $O(n)$.
- **Scan Direction and Stability:**
  - Scanning backward from $n-1$ down to 0 preserves original order and is strictly stable.
  - Scanning forward from 0 up to $n-1$ still sorts numbers correctly, but completely reverses the order of duplicate elements.
- **Radix Sort:** Sorts $d$-digit numbers digit by digit from least significant to most significant using Counting Sort on each pass.
  - Runs in $\Theta(d(n + k))$ time. Runs in linear $\Theta(n)$ time for numbers with a fixed number of digits.
  - Must use a stable sorting method on each digit so that ties on higher digits do not ruin the sorted order of earlier lower digits.
::::

::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Graph Traversals & Search Invariants
:::

- **Storing Graphs:**
  - *Adjacency Matrix:* Takes $\Theta(V^2)$ space. Checking an edge takes $\Theta(1)$ time. Traversals take $\Theta(V^2)$ time because the code must read entire rows of length $|V|$.
  - *Adjacency List:* Takes $\Theta(V + E)$ space. Checking an edge takes $O(\text{deg}(u))$ time. Traversals take $\Theta(V + E)$ time because the code checks only real edges.
- **Covering Disconnected Graphs:** A single BFS or DFS from one vertex visits only that vertex\'s connected component. Visiting all vertices requires an outer loop over every vertex in $V$.
- **Vertex Color Meaning:**
  - `White` means unvisited. `Grey` means currently on the frontier queue or call stack. `Black` means fully explored.
  - **Color Barrier Rule:** An edge can never connect a `Black` node directly to a `White` node. Every path from explored to unvisited areas must go through a `Grey` node.
- **Detecting Cycles:** A directed graph has a cycle if and only if DFS hits a neighbor that is currently colored `Grey`.
- **Topological Ordering:** Only valid for directed graphs without cycles. Prepend nodes to a list as soon as they turn `Black`. If edge $(u, v)$ exists, node $v$ finishes before node $u$.
::::

::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Dijkstra\'s Algorithm (Shortest Paths)
:::

Finds the shortest paths from a single starting vertex $s$ to all other vertices. Edge weights must be non-negative ($w \ge 0$).

- **Core Invariant:** When a vertex $u$ is removed from the priority queue and marked into set $S$, its recorded distance $u.d$ is guaranteed to be its final shortest path from $s$.
- **Relaxing an Edge:** For neighbor $v$ of $u$, if $S[v] == 0$ and $v.d > u.d + w(u, v)$, update $v.d = u.d + w(u, v)$ and set predecessor $v.\pi = u$.
- **Running Time:** Using a simple array takes $O(V^2)$ time. Using a binary min-heap takes $O((V + E) \log V)$ time.
- **Subgraph Property:** If you delete edges to form a smaller graph $G_1 \subseteq G$, the shortest path between any two nodes in $G_1$ can only stay the same or get longer.
- **Edge Weights:** Zero weights ($w = 0$) work correctly. Negative weights cause Dijkstra to fail because the algorithm never updates vertices already marked in set $S$.
- **Adding a Constant Fails:** You cannot fix negative weights by adding a positive constant $+C$ to every edge. Paths with more edges receive more copies of $C$ than paths with fewer edges, which can change which path is the shortest.
- **Counting Shortest Paths:**
  - Set `v.paths = 0` for all vertices and set `s.paths = 1`.
  - If $v.d > u.d + w(u, v)$ (strictly shorter path): reset `v.paths = u.paths`.
  - If $v.d == u.d + w(u, v)$ (tie for shortest): add counts `v.paths += u.paths`.
::::

::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Minimum Spanning Trees (MST)
:::

Connects all $|V|$ vertices in an undirected graph without cycles using exactly $|V|-1$ edges while minimizing the total sum of edge weights.

- **The Cut Rule:** If you split the graph into two groups, the lightest edge connecting the two groups belongs to an MST.
- **The Cycle Rule:** In any cycle, the strictly heaviest edge cannot belong to any MST.
- **Unique Weights:** If every edge has a distinct weight, the graph has only one unique MST.
- **Negative Weights Work:** Both Prim\'s and Kruskal\'s algorithms work correctly on negative edges. MST algorithms compare individual edge weights rather than accumulating path sums. Adding a constant $+C$ to every edge leaves the chosen tree unchanged.
- **Maximum Spanning Tree:** You can find a Maximum Spanning Tree by sorting edges from heaviest to lightest or by negating all edge weights.
- **Reconstructing Graphs from Clues:**
  1.  Pick the subset of $|V|-1$ weights that adds up to the target MST total weight.
  2.  Use the given path distances between vertices to determine how vertices connect along tree paths.
  3.  Draw the tree, then insert unused non-tree edges ensuring each non-tree edge is the heaviest edge in its cycle with the tree.

::: {.cheatsheet-subsection-title}
Prim\'s vs. Kruskal\'s Algorithms
:::

| Feature | Prim\'s Algorithm | Kruskal\'s Algorithm |
|---|---|---|
| **Growth** | Grows one tree outward from a root | Merges separate trees globally |
| **Next Pick** | Lightest edge connecting to current tree | Lightest overall edge that avoids cycles |
| **Data Structure** | Min-Heap / Priority Queue | Priority Queue + Union-Find |
| **Running Time** | $O(E \log V)$ (best on dense graphs) | $O(E \log E) = O(E \log V)$ |
| **Small Weights** | Cannot easily be accelerated | Runs in $O(E \log^* V)$ via Counting Sort |
:::::

::: {.cheatsheet-panel}
::: {.cheatsheet-section-title}
Union-Find (Disjoint Sets)
:::

Keeps track of elements partitioned into separate groups.

- **QuickFind:** Stores group IDs in an array. Finding a group takes $\Theta(1)$ time, but merging two groups takes $\Theta(N)$ time because it scans the array.
  - *Common Code Bug:* You must save original group IDs into temporary variables `pid = id[p]` and `qid = id[q]` before the loop. Checking `id[i] == id[p]` inside the loop corrupts the target ID as soon as index $i$ reaches $p$.
- **QuickUnion:** Stores parent links. Finding and merging both take $O(N)$ time because tree branches can degenerate into long straight chains.
- **Weighted QuickUnion:** Always links the root of the smaller tree below the root of the larger tree.
  - *Tree Height Proof:* The height cannot exceed $\log_2 N$. A node only moves one level deeper when its tree is merged under an equal or larger tree, meaning the component size at least doubles. A group of size 1 can double at most $\log_2 N$ times before reaching the maximum size of $N$.
  - Both `find` and `union` operations run in $O(\log N)$ time.
- **Path Compression:** Points nodes directly toward their root when traversing upward. It runs in almost linear $O(N + M \log^* N)$ time, where $\log^* N \le 5$ for all practical inputs.
- **Kruskal Group Count Rule:** Starts with $|V|$ separate groups. Every accepted edge merges two groups, dropping the count by exactly 1 per edge until 1 group remains.
::::
::::::::::::::::::
:::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::


