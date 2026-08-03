# Bi-directional search

- Search from goal state backwards as well as initial state forwards. Each direction can use different search strategies.

- Involves iteratively determining predecessor nodes to goal, and those before it.

- Performs two $`b^{d/2}`$ searches instead of one $`b^d`$ search.

- **Example** For $`b=10`$, $`d=6`$, BFS examines 1,000,000 nodes, while Bidrectional search examines 2,000 nodes.

If $`d`$ is large, it it still impractical.
