## Sets

A is subset of B: $A \subset B, \text{ i.e. } \forall a \in A,\; a \in B.$

$$\text{Complement of set } A = A^{C} = U \setminus A$$

Interval I is subset of ℝ: $\forall x, y, c \in \mathbb{R} \text{ such that } x, y \in I,\, x < c < y, \text{ we have } c \in I.$

Set A is open, if $\forall x \in A,\, \exists \delta > 0 \text{ such that } (x - \delta,\, x + \delta) \subset A.$

    e.g. Open sets: (a, b), ℝ, ∅

    e.g. Not open sets: [a, b), [a, ∞)

Set A is closed, if the complement ℝ \ A is open.

    E.g. [a, b) is not open and also not closed.

## Logic

$$p \to q; \text{contrapositive: } \neg q \to \neg p.$$

$$(p \Leftrightarrow q) \Leftrightarrow (p \to q) \land (q \to p)$$

## Function

Function f assigns every element in domain X to only one element in codomain Y.

$$\text{For } f: A \to B,\; K \subset A,\; f(K) \text{ is the image of } K.\quad f(A) \text{ is the range of } f.$$

Natural domain is the largest set A⊂ℝ such that the function makes sense.

Codomain is often the real numbers.

If domain A⊂ℕ, the function is a sequence, denoted by (an).

$$\text{Increasing function } f: A \to \mathbb{R}: \forall x_1, x_2 \in A,\, x_1 < x_2 \Rightarrow f(x_1) \le f(x_2)$$

$$\text{Decreasing function } f: A \to \mathbb{R}: \forall x_1, x_2 \in A,\, x_1 < x_2 \Rightarrow f(x_1) \ge f(x_2)$$

Strictly increasing/decreasing: remove equality.

Monotonic means either entirely increasing or entirely decreasing.

## Bounded function

$$f: A \to \mathbb{R}: \exists M > 0 \text{ such that } \forall x \in A,\, |f(x)| \le M$$

## Periodic function

$$f: A \to \mathbb{R}: \exists T > 0 \text{ such that } \forall x \in A,\, f(x + T) = f(x)$$

## Odd and even functions

$$\text{Odd function } f: A \to \mathbb{R}: \forall x \in A,\, f(-x) = -f(x)$$

$$\text{Even function } f: A \to \mathbb{R}: \forall x \in A,\, f(-x) = f(x)$$

The only function that is both odd and even is the zero function, f(x) = 0.
