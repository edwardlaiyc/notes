# Revision Cheatsheet

This page collects the exam methods, formulas and traps from Chapters 1 to 10 in one place. The chapters explain **why** each method works. This page says **what to do**.

**About past papers.** The past-year papers are from SC2001, the sister course. Their questions on **string matching** (Boyer-Moore, Rabin-Karp) and **NP-completeness** match SC2301 Weeks 11 and 12, whose lectures are not released yet. A few older papers also test hashing, binary search and the travelling salesman heuristics, which are not in the SC2301 syllabus.

---

## 1. Running Times at a Glance

### 1.1 Sorting

| Algorithm | Best | Average | Worst | Extra space | Stable |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Insertion sort | $n$ | $n^2$ | $n^2$ | $O(1)$ | Yes |
| Mergesort | $n \log n$ | $n \log n$ | $n \log n$ | $O(n)$ buffer, or $O(\log n)$ stack in place | Buffer version: yes. Lecture in-place version: no |
| Heapsort | $n \log n$ | $n \log n$ | $n \log n$ | $O(1)$ | No |
| Quicksort | $n \log n$ | $n \log n$ | $n^2$ | $O(\log n)$ to $O(n)$ stack | No |
| Counting sort | $n + k$ | $n + k$ | $n + k$ | $O(n + k)$ | Yes (backward final loop) |
| Radix sort | $d(n+k)$ | $d(n+k)$ | $d(n+k)$ | $O(n + k)$ | Yes |

All are $\Theta(\cdot)$. Any comparison sort needs $\Omega(n \log n)$ comparisons in the worst case and at least $n - 1$ in the best case.

### 1.2 Heap operations

| getMax | fixHeap | deleteMax | insert | constructHeap | heapSort |
| :--- | :--- | :--- | :--- | :--- | :--- |
| $O(1)$ | $O(\log n)$ | $O(\log n)$ | $O(\log n)$ | $O(n)$ | $O(n \log n)$ |

### 1.3 Graphs

| Algorithm | Adjacency list | Adjacency matrix | Notes |
| :--- | :--- | :--- | :--- |
| BFS, DFS, topological sort | $O(\lvert V \rvert + \lvert E \rvert)$ | $\Theta(\lvert V \rvert^2)$ | |
| Dijkstra, Prim | $O((\lvert V \rvert + \lvert E \rvert) \log \lvert V \rvert)$ with a heap | $O(\lvert V \rvert^2)$ with an array | array better for dense graphs |
| Kruskal | $O(\lvert E \rvert \log \lvert E \rvert) = O(\lvert E \rvert \log \lvert V \rvert)$ | | sorting dominates |

### 1.4 Union-find ($N$ objects)

| Version | union | find | $M$ operations |
| :--- | :--- | :--- | :--- |
| QuickFind | $N$ | $1$ | $MN$ |
| QuickUnion | $N$ | $N$ | $MN$ |
| Weighted QuickUnion | $\log N$ | $\log N$ | $N + M \log N$ |
| WQUPC | $\approx 1$ | $\approx 1$ | $N + M \log^* N$ |

### 1.5 Dynamic programming

| Problem | Time | Space |
| :--- | :--- | :--- |
| Fibonacci (memo or bottom-up) | $O(n)$ | $O(n)$, or $O(1)$ with two variables |
| LCS | $O(nm)$, traceback $O(n + m)$ | $O(nm)$ |
| 0/1 knapsack | $O(nC)$, pseudo-polynomial | $O(nC)$ |

---

## 2. Counting Comparisons in Sorts

### 2.1 Insertion sort

* Iteration $i$ (for $i = 1 \dots n-1$): compare `slot[i]` leftwards. Each "left is bigger" comparison is followed by a swap. Stop at the first "left is not bigger" (1 extra comparison), or at index 0 (no extra comparison).
* **Comparisons in iteration $i$** = swaps + 1, unless the element reaches index 0 (then = swaps).
* **Total swaps** = number of inversions (pairs in the wrong order).
* Best (sorted): $n - 1$ comparisons, 0 swaps. Worst: $n(n-1)/2$. Average: $(n-1)(n+2)/4 \approx n^2/4$.
* Equal keys: 1 comparison, 0 swaps (strict `<`).
* To build a **best** input, sort it. To build a **worst** input for comparisons, make every new element travel to index 0, or stop only at index 0 against the smallest element, for example the reversed order, or the smallest element first and the rest reversed.

### 2.2 Mergesort

* One merge of two sorted halves with $n$ elements in total: worst $n - 1$ (the halves interleave), best $n/2$ (one half entirely smaller). Lecture in-place version: equal keys place 2 elements per comparison.
* Total: add up the merges level by level. $W(n) = n \lg n - n + 1$, $B(n) = \frac{n}{2} \lg n$ for $n = 2^k$.
* `merge()` is called $n - 1$ times. A 2-element range goes straight to `merge()`.
* Ascending **and** descending inputs are best cases.

### 2.3 Quicksort partition (middle pivot)

1. `mid = (low + high) / 2` (round down). Swap `slot[mid]` and `slot[low]`. Pivot = `slot[low]`. `last_small = low`.
2. For $i = low+1 \dots high$: if `slot[i] < pivot`, then `last_small++` and swap `slot[last_small]` and `slot[i]`.
3. Swap `slot[low]` and `slot[last_small]`. Return `last_small`.

* One partition of $k$ elements: exactly $k - 1$ comparisons.
* Worst case: the pivot is the min or max of its range every time: $n(n-1)/2$.
* A partition leaves one side empty exactly when its pivot is the min or max of the range.

### 2.4 Heaps (1-indexed: children $2k$, $2k+1$; parent $\lfloor k/2 \rfloor$)

* **fixHeap** with key $k$ at an empty slot: compare the two children (1), compare $k$ with the larger (1). If $k$ is not smaller, stop. Else move the larger child up, and repeat one level down. A node with one child costs 1 comparison.
* **constructHeap:** run fixHeap on the subtree at each node from $\lfloor n/2 \rfloor$ down to 1. Write the array after each node.
* **deleteMax:** take `H[1]`. Move the **last** element into the root position with fixHeap on the heap of size $n - 1$.
* Decreasing input: construction costs exactly $n - 1$ comparisons, no moves (the best case).

---

## 3. Graph Traces

### 3.1 BFS and DFS

* Follow the neighbour order the question gives (alphabetical or reverse). BFS: queue; mark a vertex when it **enters** the queue. DFS: go to the first unvisited neighbour; backtrack when none is left.
* The BFS tree gives shortest paths by number of edges. Draw each vertex's tree edge to the vertex that discovered it.

### 3.2 Dijkstra table (rows $S$, $d$, $\pi$)

1. Start: $d(s) = 0$, the rest $\infty$; $S$ all 0; $\pi$ all null.
2. Each iteration: pick the vertex with $S = 0$ and smallest $d$; set $S = 1$. For each edge to a vertex $v$ with $S = 0$: if $d(u) + w(u, v) < d(v)$, update $d(v)$ and set $\pi(v) = u$.
3. Write the full table after each iteration. Read paths backwards with $\pi$.

Check: vertices join $S$ in non-decreasing $d$; a vertex in $S$ never changes.

### 3.3 Prim table

Same table, but the update is: if $w(u, v) < d(v)$, set $d(v) = w(u, v)$ and $\pi(v) = u$. The fringe = vertices with $S = 0$ and $d < \infty$. MST edges are $(\pi(v), v)$. MST weight = sum of final $d$.

### 3.4 Kruskal with weighted QuickUnion

1. Sort the edges by weight. Go through them in order.
2. For edge $(u, v)$: find both roots. Same root: **reject** (it would close a cycle). Different: **accept**, and union.
3. Union rule: the smaller tree's root points to the larger tree's root. **On a tie, $q$'s root goes under $p$'s root** for `union(p, q)`. Add the sizes at the new root.
4. Stop after $|V| - 1$ accepted edges.

The number of components starts at $|V|$ and drops by 1 at each accepted edge.

### 3.5 Building a graph and its MST from clues

Some questions give the edge weights, the MST weight, and some distances measured **in the MST**, and ask you to draw a matching graph.

1. Choose $|V| - 1$ of the weights that add up to the MST weight. These are the tree edges.
2. Use the distance clues to place the tree edges: a tree distance is either one edge or a sum of edges along the tree path.
3. Add the remaining weights as non-tree edges. Each must be the **heaviest** edge on the cycle it creates with the tree (the MST property), so that no algorithm would prefer it.
4. Check: run Kruskal mentally on your graph. It must return your tree.

---

## 4. Proof Templates

### 4.1 Asymptotic notation

* **Show $f = O(g)$:** give explicit $c$ and $n_0$, and show $f(n) \le c\,g(n)$ for all $n \ge n_0$. Or use the limit $f/g \to L < \infty$.
* **Show $f \ne O(g)$:** assume $c$, $n_0$ exist. Pick one $n \ge n_0$ (and larger than $c$, or with the right parity) that breaks $f(n) \le c\,g(n)$. Contradiction.
* **$\Theta \iff O$ and $\Omega$:** for ($\Leftarrow$), take $n_0 = \max(n_1, n_2)$ and combine the two inequalities.
* **Not comparable:** use a function that switches between two shapes on even and odd $n$.

### 4.2 Loop invariant

State the invariant in terms of the loop variable. Then: **initialization** (true before the first iteration), **maintenance** (one iteration keeps it true), **termination** (at the stopping value, it gives correctness). Rewrite a `for` loop as a `while` loop to see the final value of the variable.

### 4.3 Graphs and greedy

* **Dijkstra fails with a negative edge:** a vertex is finalized, then a path through a later vertex with a negative edge would be cheaper, but the algorithm never revisits it. Give a 3-vertex example.
* **Adding a constant to all weights changes shortest paths:** compare a 1-edge path with a 2-edge path.
* **Unique MST for distinct weights:** take the lightest edge in which two MSTs differ; swap it into the other tree; that tree gets lighter. Contradiction.
* **An edge must be in the MST:** use the cut rule: it is the unique lightest edge crossing some split of the vertices.

### 4.4 Principle of optimality (DP)

Assume an optimal solution contains a part that is not optimal for its sub-problem. Replace that part with a better one. The whole solution improves. Contradiction.

---

## 5. Recurrences

### 5.1 Master theorem for $W(n) = a\,W(n/b) + f(n)$

Compare $f(n)$ with $n^{\log_b a}$:

| Case | Condition | Answer |
| :--- | :--- | :--- |
| 1 | $f(n) = O(n^{\log_b a - \varepsilon})$ | $\Theta(n^{\log_b a})$ |
| 2 | $f(n) = \Theta(n^{\log_b a} \log^k n)$, $k \ge 0$ | $\Theta(n^{\log_b a} \log^{k+1} n)$ |
| 3 | $f(n) = \Omega(n^{\log_b a + \varepsilon})$ **and** $a f(n/b) \le c f(n)$, $c < 1$ | $\Theta(f(n))$ |

It does **not** apply to: $W(n-1)$ or $W(n-2)$ terms, two different sub-problem sizes, non-constant $a$, or a $\log$ gap such as $f(n) = n/\lg n$ against $n^{\log_b a} = n$.

### 5.2 Closed forms worth knowing

| Recurrence | Solution |
| :--- | :--- |
| $W(n) = 2W(n/2) + n - 1$, $W(1) = 0$ | $n \lg n - n + 1$ |
| $W(n) = 2W(n/2) + 2$, $W(2) = 1$ | $\frac{3n}{2} - 2$ |
| $W(n) = W(n/2) + c$ | $\Theta(\log n)$ |
| $W(n) = W(n-1) + n$ | $\Theta(n^2)$ |
| $W(n) = 2W(n-1) + 1$, $W(1) = 1$ | $2^n - 1$ |
| $W(n) = aW(n-1) + c$, $a > 1$ | $\Theta(a^n)$ |
| $W(n) = W(\sqrt{n}) + 1$ | $\Theta(\log \log n)$ |

Sums: $1 + 2 + \dots + n = \frac{n(n+1)}{2}$. $1 + 2 + 4 + \dots + 2^{k-1} = 2^k - 1$. $\sum_{j \ge 0} r^j = \frac{1}{1 - r}$ for $0 < r < 1$. $a^{\log_b n} = n^{\log_b a}$.

### 5.3 Iteration method

Expand 3 or 4 levels until you see the pattern. Write the general level $i$. Find how many levels reach the base case ($i = \log_b n$, or $i = n - 1$). Substitute and sum.

### 5.4 Substitution method

1. Guess $T(n) \le c\,g(n)$.
2. Base case: check it, and choose $c$ (or start from a larger $n$) to make it hold.
3. Inductive step: assume it for smaller values; derive **exactly** $T(n) \le c\,g(n)$ with the **same** $c$.
4. If a lower-order term gets in the way, strengthen the guess: $T(n) \le c\,g(n) - d$.

### 5.5 Characteristic equation for $a_n = A\,a_{n-1} + B\,a_{n-2}$

1. $t^2 - At - B = 0$. Find the roots.
2. Distinct roots $r, s$: $a_n = C r^n + D s^n$. One repeated root $r$: $a_n = C r^n + D n r^n$.
3. Use $a_0$, $a_1$ to find $C$, $D$. Check $a_2$.

Linear homogeneous with constant coefficients means: each $a_{n-i}$ to the first power; no constant or $n$ term; coefficients do not depend on $n$. The degree is the furthest step back.

---

## 6. Amortized Analysis

| Method | What you do |
| :--- | :--- |
| Aggregate | Total cost $T(n)$ of $n$ operations, divided by $n$. |
| Accounting | Charge each operation a fixed amount; extra is saved credit; credit never negative. |
| Charging | Expensive operations bill their cost back to earlier cheap ones; each is billed $O(1)$. |
| Potential | $\hat{c} = c + \Phi_{\text{after}} - \Phi_{\text{before}}$; $\Phi$ never below its start. |

* Table doubling: amortized 3 per insertion. $\Phi = 2n - m$.
* Double when full, **halve when 1/4 full**. Both operations amortized $O(1)$.
* Binary counter increment: amortized $< 2$ flips. $\Phi$ = number of 1s. Adding DECREMENT allows $\Theta(nk)$.
* A step that costs $i$ only when $i$ is a power of 2 (and 1 otherwise): total $< 3n$, amortized $O(1)$.

---

## 7. Dynamic Programming Answers

For "give a recursive definition / draw the subproblem graph / write a bottom-up algorithm / give the complexity":

1. **Define** $F(\dots)$ in words.
2. **Recursion:** consider the last decision; one term per choice; max, min or sum; base cases.
3. **Subproblem graph:** draw the original problem and arrows to the sub-problems it uses, down to the base cases. Label nodes with values if asked.
4. **Bottom-up code:** a table with one cell per sub-problem; set the base cases; nested loops in an order where every needed cell is ready; return the cell of the original problem.
5. **Complexity:** cells $\times$ work per cell. Space: the table.
6. **Plain recursion without memo:** write its recurrence; it is usually exponential.

* **LCS cell:** match: upper-left + 1. No match: max(above, left), above on a tie.
* **Knapsack cell** `profit[r][c]` (capacity $r$, objects $1..c$): $\max(\text{profit}[r][c-1],\ p_c + \text{profit}[r - w_c][c-1])$ when $w_c \le r$.

---

## 8. True/False Traps

**Notation**

* "At least $O(n^2)$" means nothing. Use $\Omega$.
* $\log_2 n = \Theta(\log_{10} n)$. $2^n \ne \Theta(3^n)$.

**Sorting**

* Insertion sort average is $\Theta(n^2)$, not $n \log n$. It is incremental, not divide and conquer.
* Insertion sort's worst case for comparisons is not only the reversed array.
* Mergesort is $\Theta(n \log n)$ in every case.
* Heapsort is $\Theta(n \log n)$ in every case, in place, not stable. Heap construction is $O(n)$.
* Quicksort: worst case $\Theta(n^2)$ for any pivot rule that does not find the true median. After partition, only the pivot is in its final place. In place, not stable.
* Choosing the smallest element as pivot gives the **worst** case, not the best.
* Counting and radix sorts are not comparison sorts, so the $\Omega(n \log n)$ bound does not apply.

**Graphs**

* Sparse graph: use an adjacency list. Dense: a matrix is fine.
* A black vertex never has a white neighbour (BFS or DFS). It can have a grey one.
* BFS from one source does not reach other components. The lecture's DFS (with its outer loop) visits every vertex.
* Dijkstra: zero weights fine, negative weights not; directed or undirected; cycles fine; one source per run.
* Prim and Kruskal handle negative weights. Distinct weights give one MST; equal weights can give several.
* Kruskal can find a maximum spanning tree (sort heaviest first).
* A shortest path need not lie on the MST.
* Removing edges never makes a shortest path shorter.

**Recurrences, amortized, DP**

* The master theorem needs a polynomial gap ($n^{\varepsilon}$) in cases 1 and 3, and regularity in case 3.
* Amortized is not average-case. A single operation can still be expensive.
* DP sub-problems overlap; divide and conquer sub-problems are independent. Greedy commits to the locally best choice; DP computes all choices and takes the best.
* Knapsack $O(nC)$ is pseudo-polynomial.
