# Iterative Deepening

<div class="algorithm">

</div>

    function ID(P = ⟨S, s₀, A, τ, c, G⟩):
        limit ← 1
        while true:
            if DLS(P, limit) == "done":   # goal found?
                return "done"
            else:
                limit ← limit + 1

- If we only perform DLS until depth $`d`$, but the solution is found at $`d+1`$, we never find the solution.

- Iterative Deepening repeats DLS (calls DLS as subroutine) at increasing depths till solution is found.

- We need to regenerate nodes up till depth $`d-1`$ when we do DLS for depth $`d`$.

- This is tradeoff of time for memory.\
  **Example** $`b=10`$, $`d=5`$. BFS would require examining 111,111 nodes, with memory requirement of 100,000 nodes. Iterative deepening search 123,456 nodes, with memory requirement of only 50 nodes. Takes 11% longer with 2000% reduction in memory.
