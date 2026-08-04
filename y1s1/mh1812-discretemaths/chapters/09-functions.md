A function assigns every element in its domain to one and only one element in its codomain.

$$f: X \Rightarrow Y, (\forall x \in X, \exists y \in Y, y = f(x)) \land (\forall x_1, x_2 \in X, f(x_1) \neq f(x_2) \to x_1 \neq x_2)$$

Range of a function is a subset of the codomain, containing all the images.

## Injective

$$\text{Injective/one-to-one } f: \forall x_1, x_2 \in X, f(x_1) = f(x_2) \rightarrow x_1 = x_2$$

OR

$$\text{Injective/one-to-one } f: \forall x_1, x_2 \in X, x_1 \neq x_2 \rightarrow f(x_1) \neq f(x_2)$$

$$\text{For injective } f: X \rightarrow Y, \ |X| \leq |Y|$$

$$\text{For } f: A \rightarrow B, \ |A| = m, \ |B| = n \text{ with } n >= m, \text{ how many injective functions } f \text{ are there?}$$

$$n(n-1)(n-2)...(n-m+1) = nPm$$

## Surjective

$$\text{Surjective/onto function }f: X \rightarrow Y, \forall y \in Y \ \exists x \in X, f(x) = y$$

$$\text{For surjective }f: X \rightarrow Y, \ |X| \geq |Y|$$

$$\text{For } f: A \rightarrow B, \ |A| = m, \ |B| = n, \ m \geq n, \text{ how many surjective functions } f \text{ are there?}$$

$$n! \, \left\{ \begin{matrix} m \\ n \end{matrix} \right\}$$

$\, \left\{ \begin{matrix} m \\ n \end{matrix} \right\}$is the number of ways to partition a set of m objects into n non-empty subsets (Stirling number).

![](images/surjective-01.png)

## Bijective

$$\text{Bijective / one-to-one correspondence function }f \text{ is both injective and surjective.}$$

$$\text{Bijective }f: X \rightarrow Y, \ |X| = |Y|$$

$$\text{For }f: A \rightarrow B, \ |A| = m, \ |B| = n, \ m=n, \text{ how many bijective functions }f \text{ are there?}$$

$$n(n-1)(n-2)...(1) = n!$$

## Identity function

$$\text{On a set A, } i_A: A \rightarrow A, i_A(x) = x.$$

## Inverse function

$$\text{For }f^{-1} \text{ to be defined, }f \text{ has to be bijective.}$$

$$\text{For }f: X \rightarrow Y, \ f^{-1}: Y \rightarrow X, \ \forall x \in X, \ \forall y \in Y, \ f(x) = y \iff f^{-1}(y) = x.$$

$$\text{If }f \text{ bijective, then } f^{-1} \text{ bijective.}$$

## Composite function

$$g \circ f: X \rightarrow Z: (g \circ f)(a) = g(f(a)), \text{ where } f: X \rightarrow Y \text{ and } g: Y \rightarrow Z.$$

$$\text{If } f, g \text{ injective, then } g \circ f \text{ is injective.}$$

$$\text{But if } g \circ f \text{ injective, } g \text{ need not be injective. } g \text{ needs to be injective only on the range of } f.$$

![](images/composite-function-01.png)

$$\text{If } f, g \text{ surjective, then } g \circ f \text{ is surjective.}$$

$$\text{But if } g \circ f \text{ is surjective, }f \text{ need not be surjective.}$$

$$\text{Range of } f \text{ just needs to cover enough of domain of } g, \text{ to map onto range of } g.$$

![](images/composite-function-02.png)

## Special functions

### Floor, ceiling functions

$$\lceil -\pi \rceil = -3$$

$$\lfloor -\pi \rfloor = -4$$

$$\text{Number of integers from 1000 to 2023 inclusive which are divisible by 6} = \lfloor \frac{2023}{6} \rfloor - \lfloor \frac{999}{6} \rfloor$$

### Pigeonhole principle

$$\text{ For n items placed into k containers, } n \ge k \;,$$

$$\text{then at least one container must contain} \ge \left\lceil \frac{n}{k} \right\rceil \text{items.}$$

Mapping one finite set to a smaller finite set cannot be an injective function.

Example question

In a party of 6 people, prove that there exists at least 3 people who are all friends or all strangers.

Take some person A, he can be friends/strangers with 5 other people (B, C, D, E, F). By pigeonhole principle, there are at least $\left\lceil \frac{5}{2} \right\rceil = 3$ people with whom he has the same relationship with. WLOG, suppose A is friends with B,C,D. Then look at the relationships between B, C, D. If any 2 of them are friends, suppose B & C are friends, then A, B, C form the 3 people who are friends with each other. If none of B, C, D are friends with each other, then we have the 3 people who are strangers with each other. 

### Countability

$$\text{A set is countable if a bijection can be formed from } \mathbb{N} \text{ to that set.}$$

$$\mathbb{Z}, \ \mathbb{Q}, \ \text{algebraic numbers are countable.}$$

$$\mathbb{R} \ \text{is uncountable.}$$

$$f(x) = \begin{cases}\frac{n}{2} & \text{if } x \text{ even} \\ - \frac{n + 1}{2} & \text{if } x \text{ odd }\end{cases}$$

![](images/countability-01.png)

![](images/countability-02.png)

![](images/countability-03.png)
