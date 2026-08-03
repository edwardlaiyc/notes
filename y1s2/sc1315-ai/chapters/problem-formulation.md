# Problem Formulation

A problem, $`\mathcal{P}`$, is defined by the following elements:

``` math
\mathcal{P} = \langle S, s_0, A, \tau, c, G \rangle
```

where:

- $`S`$ is the state space

- $`s_0 \in S`$ is the initial state

- $`A = \{a_1, \dots, a_k\}`$ is set of actions or operations

- $`\tau : S \times A \to S`$ is the state transition function

- $`c : S \times A \times S \to \mathbb{R}`$ is the cost function

- $`G \subseteq S`$ defines the goal to be achieved.

A solution
``` math
\vec{a} = (a_0, a_1, \dots, a_n) \in \text{soln}(\mathcal{P})
```
which induces a state sequence
``` math
(s_0, s_1, \dots, s_{n+1})
```
has an associated cost:
``` math
c(\vec{a}) = \sum_{i=0}^{n} c(s_i, a_i, s_{i+1})
```

A solution $`\vec{a}^*`$ is **optimal** if it minimises corresponding cost:
``` math
\vec{a}^* \in \arg \min_{\vec{a} \in \text{soln}(\mathcal{P})} c(\vec{a})
```
