# Introduction

A sample space, $`\Omega`$, is the set of all possible outcomes of some experiment.\
An event is a subset of the sample space.

## Examples

### Discrete Sample Space

Experiment: Roll a die until a ’1’ appears.\
Sample space $`\Omega = \{(1), (2, 1), (3, 1), \ldots, (2, 2, 1), \ldots, (2, 3, 4, 5, 6, 1, \ldots)\}`$.\
Event that the sum of values is 5: $`\{(4, 1), (2, 2, 1)\}`$\
*Tuples* () *consider the order of elements in it. Sets {} do not.*

### Continuous Sample Space

Experiment: Output any real number in $`[0, 1)`$.\
Sample space $`\Omega = [0, 1)`$.\
Example of Events: $`\emptyset`$, \[0, 1), \[0.1, 0.3\], \[0.1, 0.3\] $`\cup`$ (0.5, 0.7)\
*For continuous sample space, we should define events in terms of (operations of) intervals.*

## Probability Distribution

#### Definition

Let $`\Omega`$ be the sample space and $`\mathcal{E}`$ be the set of all events (where an event is a subset of $`\Omega`$). A probability distribution/measure is a function $`P: \mathcal{E} \rightarrow [0,1]`$, if it satisfies the following axioms:

1.  $`0 \leq P(A) \leq 1, \quad \forall A \in \mathcal{E}`$

2.  $`P(\Omega) = 1`$

3.  $`A_1, A_2, \ldots \text{ are disjoint events in }\mathcal{E} \Rightarrow P(\cup_{i=1}^{\infty} A_i) = \sum_{i=1}^{\infty} P(A_i)`$

#### Properties

1.  $`P(\emptyset) = 0`$

2.  $`A \cap B = \emptyset \Rightarrow P(A \cup B) = P(A) + P(B)`$

3.  $`P(A^C) = 1 - P(A)`$

4.  $`A \subset B \Rightarrow P(A) \leq P(B)`$

5.  $`P(A \cup B) = P(A) + P(B) - P(A \cap B)`$

## Independent vs Disjoint events

An independent event does not affect the probability of occurence of another independent event. They are related by
``` math
P(A \cap B) = P(A)P(B)
```
Disjoint events can never occur at the same time. If A and B are disjoint events, then
``` math
A \cap B = \emptyset \Rightarrow P(A \cap B) = 0
```
In general, independent events are not disjoint and disjoint events are not independent. The only exception is the trivial case, when one of the events is impossible i.e. $`P(A)=0`$, hence satisfying both equations above.
