## Definition

$$f : A \to \mathbb{R} \text{ is continuous at } a \in A \text{ if } \forall \, \varepsilon > 0, \, \exists \, \delta > 0 \text{ such that }$$

$$\forall x \in A, \; |x - a| < \delta \implies |f(x) - f(a)| < \varepsilon.$$

**A function is continuous at isolated points in the domain. Define an open interval such that a is the only element in the interval. Then f(a) = f(x) for all x in the interval.

$$\text{If } a \text{ is a limit point of the domain A,}$$

$$f(x) \text{ is continuous on a set } A \;\Longleftrightarrow\;\forall \, a \in A, \; \lim_{x \to a} f(x) = f(a).$$

Proving that f is continuous at x=c means showing that lim(x → c){f(x)} = f(c).

$$f \in C(a) \;\Longleftrightarrow\; f \text{ is continuous at } a.$$

Elementary functions are continuous on their natural domains.

    E.g. constants and powers of x, exponential, logarithm, (inverse) trigo.

## Composite functions

$$\text{If } \lim_{x \to a} g(x) = L \text{ and } f \in C(L),\text{ then } \lim_{x \to a} f(g(x)) = f\!\left( \lim_{x \to a} g(x) \right) = f(L).$$

## Intermediate Value Theorem

$$\text{If } f(x) \in C([a,b]) \text{ and } f(a) \ne f(b),$$

$$\text{then } \forall \, y \in \bigl( \min(f(a), f(b)), \max(f(a), f(b)) \bigr),$$

$$\exists \, c \in (a,b) \text{ such that } f(c) = y.$$

Further implication: if f(a) and f(b) have different signs, there exists a root for f(x) = 0.

![](images/intermediate-value-theorem-01.png)

If f is not continuous, IVT may not hold:

![](images/intermediate-value-theorem-02.png)

If f is not continuous on closed interval, IVT may not hold:

![](images/intermediate-value-theorem-03.png)

## Min/max theorem

$$\text{If } f(x) \in C([a,b]),$$

$$\text{then there exist points } x_m, x_M \in [a,b] \text{ such that } f(x_m) \le f(x) \le f(x_M).$$

The function is bounded.

f has to be continuous on a closed interval.

Counter-example: for any x in (1, 3), we can always find a number that’s larger.

Pick x=2.9, we can find some y such that x < 2.99 < 2.999 < 2.9999 < … < y

![](images/min-max-theorem-01.png)

## Injective (one-to-one) function

$$f : A \to \mathbb{R}, \text{ for } x_1, x_2 \in A, \;x_1 \ne x_2 \implies f(x_1) \ne f(x_2).$$

## Inverse function

$$\text{If } f : A \to \mathbb{R} \text{ is injective, (and also surjective)}$$

$$f^{-1} : f(A) \to \mathbb{R}, \quad f^{-1}(y) = x \;\Longleftrightarrow\; f(x) = y.$$

$$\text{If } f : I \to \mathbb{R} \text{ is continuous and injective,}\text{ then } f^{-1} \text{ is also continuous.}$$
