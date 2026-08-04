Subset: 

- $A \subseteq B : \forall x\, (x \in A \to x \in B) \;$
- Proper subset:
- $A \subset B : \forall x\, (x \in A \to x \in B) \text{ and } A \ne B$

## Set identities

![](images/set-identities-01.png)

![](images/set-identities-02.png)

![](images/set-identities-03.png)

## Inclusion-exclusion principle

$$|A_1 \cup A_2 \cup \dots \cup A_n| = |A_1| + |A_2| + \dots + |A_n|$$

$$- \big[\, |A_1 \cap A_2| + |A_1 \cap A_3| + \dots + |A_{n-1} \cap A_n| \,\big]$$

$$+ \big[\, |A_1 \cap A_2 \cap A_3| + |A_1 \cap A_2 \cap A_4| + \dots + |A_{n-2} \cap A_{n-1} \cap A_n| \,\big]$$

$$+ \cdots+ (-1)^{n-1} |A_1 \cap A_2 \cap \dots \cap A_n|$$

## Cartesian Product

$$A \times B = \{(a, b) \ | \ a \in A, b \in B\}$$

## Power Set

$$\mathcal{P}(S) = \{\, A \mid A \subseteq S \,\}$$

$$\text{For set S with } n \text{ elements, } \left| \mathcal{P}(S) \right| = 2^n$$

## Partition

The partition of set A is the set of nonempty sets,$\{A_1, \ldots, A_n\} \text{ where } A_1 \cup \ldots \cup A_n = A, \text{ and } A_i \cap A_j = \varnothing, \; \forall\, i,j \in \{1, \ldots, n\}, \; i \neq j$

![](images/partition-01.png)

## Common questions

### Prove by set identities

![](images/prove-by-set-identities-01.png)

![](images/prove-by-set-identities-02.png)

### Element chasing - LHS and RHS subsets of each other

![](images/element-chasing-lhs-and-rhs-subsets-of-e-01.png)

![](images/element-chasing-lhs-and-rhs-subsets-of-e-02.png)

### Membership table

![](images/membership-table-01.png)

$$\text{Prove that }(A \Delta B)\Delta B = A \text{ using a membership table.}$$

![](images/membership-table-02.png)
