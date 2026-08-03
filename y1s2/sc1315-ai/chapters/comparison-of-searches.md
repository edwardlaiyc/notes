# Comparison of searches

<div class="table-wrap">

| **Strategy**         | **Selection from frontier** | **Path found** | **Space**  |
|:---------------------|:----------------------------|:---------------|:-----------|
|  Breadth-first       | First node added (FIFO)     | Fewest arcs    | $`O(b^d)`$ |
|  Depth-first         | Last node added (LIFO)      | $`\times`$     | $`O(bd)`$  |
|  Iterative deepening | N/A                         | Fewest arcs    | $`O(bd)`$  |
|  Uniform cost        | Minimal $`c(p)`$            | Least cost     | $`O(b^d)`$ |
|  Greedy              | Minimal $`h(p)`$            | $`\times`$     | $`O(b^d)`$ |
|  A\*                 | Minimal $`c(p) + h(p)`$     | Least cost     | $`O(b^d)`$ |

</div>

<div class="table-wrap">

|                                              |
|:--------------------------------------------:|
|           $`b`$ = branching factor           |
|     $`d`$ = depth of shallowest solution     |
| $`\times`$ = not guaranteed to find solution |
|       blue = uninformed, red = informed      |

</div>
