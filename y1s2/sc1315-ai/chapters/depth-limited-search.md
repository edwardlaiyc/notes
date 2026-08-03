# Depth Limited Search

<div class="algorithm">

</div>

    function DLS(P = ⟨S, s₀, A, τ, c, G⟩, limit ∈ ℕ):
        depth(s) ← 0  for all s ∈ S
        agenda ← newStack()
        agenda.push(s₀)
        while not agenda.isEmpty():
            s ← agenda.pop()
            for a ∈ A:
                s' ← τ(s, a)              # expand s
                if s' ∈ G:
                    return "done"
                depth(s') ← depth(s) + 1
                if depth(s') ≤ limit:
                    agenda.push(s')       # goal not found
        return "no solution"

- DFS might not terminate if it expands wrong branch with no solution on it. DLS imposes some depth limit on exploring branches.
