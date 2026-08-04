## Differentiability

f(x) is differentiable at a point x=a if the derivative at that point exists, i.e. the below limit exists.

$$f'(a) = \frac{d}{dx} f(x) \bigg|_{x=a} = \lim_{x \to a} \frac{f(x) - f(a)}{x - a} = \lim_{h \to 0} \frac{f(a + h) - f(a)}{h}.$$

$$f'(x) = \frac{d}{dx} f(x) = \lim_{h \to 0} \frac{f(x + h) - f(x)}{h}$$

### Proving that f is not differentiable at a

Left-side not equals right-side limit

$$\text{If } \lim_{h \to 0^-} \frac{f(a + h) - f(a)}{h} \neq \lim_{h \to 0^+} \frac{f(a + h) - f(a)}{h},$$

$$\text{then } \lim_{h \to 0} \frac{f(a + h) - f(a)}{h} \text{ does not exist, and } f \text{ is not differentiable at } a.$$

Caveat

$$f'(a) \text{ may exist even if } \lim_{x \to a} f'(x) \text{ does not exist.}$$

Counter Example:

$$f(x) =  \begin{cases} x^2 \sin\left(\frac{1}{x}\right) & \text{for } x \neq 0 \\ 0 & \text{for } x = 0\\ \end{cases}$$

$$\text{We find that } f'(0) = 0 \text{ (by definition of derivative).}$$

$$\text{However, for } x \neq 0:$$

$$f'(x) = 2x \sin\left(\frac{1}{x}\right) - \cos\left(\frac{1}{x}\right),$$

$$\text{and the limit } \lim_{x \to 0} f'(x) \text{ does not exist.}$$

## Differentiability implies continuity

$$D(a) \subset C(a)$$

- Reason: To be differentiable, the graph must be smooth and unbroken (no sharp or discontinuous points).
- Contrapositive: $\text{If } f \text{ is not continuous at } a, \text{ then } f \text{ is not differentiable at } a.$
- Reason: Not continuous → there exists some discontinuous points / sharp points at which the derivative does not exist.

![](images/differentiability-implies-continuity-01.png)

![](images/differentiability-implies-continuity-02.png)

## Differentiation rules

Assuming $f', \; g'$ exist,

| Sum rule | $(\alpha f + \beta g)' = \alpha f' + \beta g'$ |
|---|---|
| Product rule | $(fg)' = f'g + fg'$ |
| Quotient rule | $\left(\frac{f}{g}\right)' = \frac{f'g - fg'}{g^2}$ |
| Chain rule | $(f(g))' = f'(g) \cdot g'$ |

![](images/master-list-01.png)

## Applications:

### Linear approximation

$$\text{When } x \approx a, \; f(x) \approx f(a) + f'(a)(x - a).$$

### Rate of change

given $\frac{dx}{dt}$, find y(x) , then implicitly differentiate to find $\frac{dy}{dt}$

### Minima/maxima

$$x_0 \in A \text{ is a global maximum if } \forall x \in A, \; f(x) \le f(x_0).$$

$$f : A \to \mathbb{R}, \; x_0 \text{ is a local maximum if } \exists \, (a,b) \text{ such that }$$

$$x_0 \in (a,b) \text{ and } f(x) \le f(x_0) \text{ for all } x \in (a,b) \cap A.$$

*We need to define an open interval, otherwise we can classify any point, x0, as a local max in a function like f(x) = x, by taking [x0 - 1, x0].

$$\text{If } a \text{ is a local maximum or minimum point of a function } f,$$

$$\text{whose domain contains some interval } (a - \delta, a + \delta) \text{ for some } \delta > 0,$$
$$\text{ and if } f \text{ is differentiable at } a,$$

$$\text{then } f'(a) = 0.$$

** the reverse implication is not true

** there can be other local minima/maxima where f’(c) ≠ 0.

Finding local minima/maxima:

1. f’(c) = 0 (critical point)
1. f’(c) d.n.e (critical point)
1. End points of a closed interval.
1. Isolated points in the domain.

Isolated points are both local maxima and minima. Use the definition of local minima/maxima to show.

To determine if each point is minima or maxima, use 1st or 2nd derivative test.

*If the result of 2nd derivative test is 0, we have no conclusion, use 1st derivative test.

Global minima/maxima will be the smallest/largest of all the local minima/maxima.

**If finding global minima/maxima on open interval, compare the local minima/maxima with $\lim_{x \to a^+} f(x), \; \lim_{x \to b^-} f(x)$ or $\lim_{x \to +\infty} f(x), \; \lim_{x \to -\infty} f(x)$.

### L’hopital rule

$$\text{If } \lim_{x \to a} \frac{f(x)}{g(x)} \text{ is of indeterminate form } [0/0] \text{ or } [\infty/\infty],$$
$$\text{and } f, g \in D((a - \delta, a + \delta) \setminus \{a\}) \text{ and } g'(x) \ne 0,$$

$$\text{then } \lim_{x \to a} \frac{f(x)}{g(x)} = \lim_{x \to a} \frac{f'(x)}{g'(x)}.$$

## Mean value theorem

$$\text{If } f(x) \in C([a,b]) \text{ and } f \in D((a,b)),$$
$$\text{then there exists } c \in (a,b) \text{ such that}$$

$$f'(c) = \frac{f(b) - f(a)}{b - a}.$$

![](images/mean-value-theorem-01.png)

f must be continuous on [a,b]:

![](images/mean-value-theorem-02.png)

f must be differentiable on (a,b):

(only requires differentiability on open interval, to ensure the *c* is interior to the endpoints)

![](images/mean-value-theorem-03.png)

Special case (Rolle’s theorem):

$$\text{If } f(a) = f(b), \text{ then there exists } c \in (a,b) \text{ such that } f'(c) = 0.$$

Corollaries:

1. $\text{If } f'(x) = 0 \text{ on an interval, then } f \text{ is constant on that interval.}$
1. $\text{If } f' = g' \text{ on an interval, then } f = g + C \text{ on that interval.}$
1. $\text{If } f \in D((a,b)), \text{ then if } f'(x) \ge 0, \; f \text{ is increasing.}$

Similar for strictly increasing, decreasing etc.

### Cauchy MVT

$$\text{If } f, g \in C([a,b]) \text{ and } f, g \in D((a,b)),$$

$$\text{then there exists some } c \in (a,b) \text{ such that}$$

$$f'(c)\bigl(g(b) - g(a)\bigr) = g'(c)\bigl(f(b) - f(a)\bigr)$$

This is a general form of MVT, with g(x)=x we get the original MVT.

## Concavity

$$\text{A function } f(x) \text{ is concave upward on the interval } I \text{ if and only if}$$

$$\text{for any } a < x < b \text{ in } I, \; \frac{f(x) - f(a)}{x - a} < \frac{f(b) - f(a)}{b - a}.$$

Can be derived from: $f(x) < \frac{f(b) - f(a)}{b - a} (x - a) + f(a)$

Similar for concave downward.

![](images/concavity-01.png)

A point of inflection is where the concavity changes. At an inflection point, $f''(x) = 0$ or $f''(x)$ does not exist.

However, $f''(a) = 0 \not\Longrightarrow a$ is an inflection point.

Counter-example: Consider $f(x) = x^4$. $f''(0) = 0$ but $x = 0$ is not an inflection point.

We need to check the concavity just before and just after the point where $f''=0$ or d.n.e.

### Higher order derivatives and continuity

$$f \in C^n(A) : \; f^{(n)} \text{ exists and is continuous on } A.$$

$$C^n(A) \subset C^{n-1}(A) \subset \cdots \subset C^1(A) \subset C^0(A)$$

### 2nd derivative test

$$\text{If } f(x) \in C^2(I) \text{ and } f'' > 0, \text{ it is concave upward; if } f'' < 0, \text{ it is concave downward.}$$

$$\text{Suppose } f'(a) = 0, \text{ then if } f''(a) > 0, \; a \text{ is a local minimum.}$$

If $f''(a) = 0$, we have no conclusion.
