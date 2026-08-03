# Greedy Search

<div class="algorithm">

</div>

    function greedy(P = ⟨S, s₀, A, τ, c, G⟩):
        agenda ← {s₀}                     # agenda is a set
        while agenda ≠ ∅:
            C ← arg min_{s ∈ agenda} h(s)
            s' ← any element of C
            for a ∈ A:
                s'' ← τ(s', a)
                if s'' ∈ G:               # goal found?
                    return "done"
                agenda ← agenda ∪ {s''}   # goal not found, add s'' to agenda

- We have seen $`g(s)`$, the path cost *to* some node.

- Heuristics estimate cost of cheapest path *from* some node to the solution.
  ``` math
  h: S\rightarrow \mathbb{R}
  ```
  Heuristics should be cheap to compute, otherwise we just use the resources to search.

- Greedy search expands node with cheapest expected cost ($`h(s)`$) to solution.

- Greedy search is an informed version of DFS; both focus on one path.

- Just like DFS, greedy search does not guarantee the optimal solution. It is myopic as it ignores how expensive it was to reach a node.
