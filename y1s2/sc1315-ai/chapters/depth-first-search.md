# Depth First Search

<div class="algorithm">

</div>

    function dfs(P = ⟨S, s₀, A, τ, c, G⟩):
        agenda ← newStack()
        agenda.push(s₀)
        while not agenda.isEmpty():
            s ← agenda.pop()              # expand s
            for a ∈ A:
                s' ← τ(s, a)
                if s' ∈ G:                # goal found?
                    return "done"
                agenda.push(s')           # goal not found, add s' to stack

- Utilise stack for LIFO

- Expands one branch at a time till the deepest node

Evaluation

- Completeness: Not guaranteed to find a solution if one exists

- Time complexity: If it finds a solution, it takes much less time than BFS

- Space complexity: Current branch - $`d`$ nodes at depth $`d`$.

- Optimality: Solution found not guaranteed to be optimal.
