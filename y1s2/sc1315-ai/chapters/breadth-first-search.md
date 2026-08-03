# Breadth First Search

<div class="algorithm">

</div>

    function bfs(P = ⟨S, s₀, A, τ, c, G⟩):
        agenda ← newQueue()
        agenda.enQueue(s₀)
        while not agenda.isEmpty():
            s ← agenda.deQueue()          # expand s
            for a ∈ A:
                s' ← τ(s, a)
                if s' ∈ G:                # goal found?
                    return "done"
                agenda.enQueue(s')        # goal not found, add s' to queue

- Utilise queue for FIFO

- Expand all nodes on depth $`n`$ before expanding any on depth $`n+1`$.

- For $`b`$ the branching factor and $`d`$ the depth at which the solution occurs, then BFS takes $`O(b^d)`$ (i.e. explores $`1 + b + b^2 +\ldots + b^d`$).

Evaluation

- Completeness: BFS guaranteed to find a solution if it exists.

- Time complexity: is exponential in depth of the tree. If solution at shallower depths, BFS is good approach.

- Space complexity: Requires storing at least entire frontier of $`b^d`$. Susceptible to combinatorial explosion for larger problems.

- Optimality: Solution found will be optimal.
