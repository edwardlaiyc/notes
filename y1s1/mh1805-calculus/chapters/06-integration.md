## Riemann sum

$$\int_a^b f(x) \, dx = \lim_{\Delta x \to 0} \sum_{i=1}^{n} f(x_i^*) \, \Delta x_i, \quad \text{where } \Delta x = \max(\Delta x_i), \; i = 1, 2, \ldots, n.$$

$$\text{where } x_i^* \in [a_{i-1}, a_i] \text{ and } a = a_0 < a_1 < \cdots < a_n = b.$$

$$\text{Choosing } n \text{ equally spaced points, we get } \Delta x_i = \frac{b - a}{n} = \Delta x,$$

$$\text{and } \int_a^b f(x) \, dx = \lim_{n \to \infty} \frac{b - a}{n} \sum_{i=1}^{n} f(x_i^*).$$

## Properties

### Continuity implies integrability

$$\text{If } f \text{ is continuous on } [a,b], \text{ then it is integrable on } [a,b].$$

- Reason: Continuous function has unbroken graph, which means we can find the area under it.
- Integrable functions need not be continuous.
- Reason: The area under the graph can continue accumulating even across discontinuous points.

**For non-continuous f, the integral F is continuous. F is differentiability only if f is continuous (area has no sharp turning points).

![](images/differentiability-implies-continuity-01.png)

Heaviside function:

![](images/continuity-implies-integrability-01.png)

### Integrability and boundedness

$$\text{If } f \text{ is integrable on } [a,b], \text{ it is bounded on } [a,b],$$

$$\text{and is continuous on } [a,b] \text{ except at finitely many points.}$$

This means an unbounded function is non-Reimann integrable; and a function with infinitely many discontinuous points is non-integrable.

### Splitting at point c

$$\int_a^b f(x) \, dx + \int_b^c f(x) \, dx = \int_a^c f(x) \, dx.$$

### Comparing area under graphs

$$\text{If } f, g \text{ are both integrable on } [a,b] \text{ and } f(x) \le g(x), \text{ then } \int_a^b f(x) \, dx \le \int_a^b g(x) \, dx.$$

### Triangle inequality

Recap: $|x + y| \le |x| + |y|.$

$$\text{Generalising the triangle inequality, } \left|\sum_{i=1}^{n} x_i\right| \le \sum_{i=1}^{n} |x_i|,$$

$$\text{we have } \left|\int_a^b f(x) \, dx\right| \le \int_a^b |f(x)| \, dx.$$

## Average value of a function

$$f_{\text{avg}} = \frac{1}{b - a} \int_a^b f(x) \, dx$$

## Integral Mean Value Theorem

$$\text{If } f \in C([a,b]), \text{ then there exists } c \in [a,b] \text{ such that } f(c) = f_{\text{avg}}.$$

## Fundamental theorem of calculus

$$\text{If } f \in C([a,b]), \text{ let } F : [a,b] \to \mathbb{R}, \; F(x) = \int_a^x f(t) \, dt.$$

$$\text{Then for all } x \in (a,b), \; F'(x) = f(x), \text{ and } F \in C([a,b]).$$

** if f continuous, F is differentiable. (There are no sharp jumps in the area under the graph).

** if x is inside the integral, pull x out then use product rule.

 

![](images/fundamental-theorem-of-calculus-01.png)

$$\int_a^b f(x) \, dx = [F(x)]_a^b = F(b) - F(a)$$

## Improper integrals

$$\int_a^{+\infty} f(x) \, dx = \lim_{R \to +\infty} \int_a^{R} f(x) \, dx$$

LHS is an improper integral. If the RHS limit exists, the improper integral converges.

## Indefinite integrals

$$\text{The indefinite integral } \int f(x) \, dx \text{ is the collection of all antiderivatives of } f.$$

## Applications

dx represents a small quantity/change of some x, integrating across all dx represents summing all these dx’s up.

### Work done

$$W = \int F(x) \, dx, \quad \text{for force } F \text{ and displacement } x.$$

Summing up all force, F, applied at each small distance, x.

### Force

$$F = \int p \, dA, \quad \text{for pressure } p \text{ and area } A.$$

Summing up all pressure, p, applied at each small area A.

### Mass

$$M = \int dm = \int \rho \, dV = \int \rho A(x) \, dx, \quad \text{for density } \rho \text{ and volume } V.$$

    *Identify slices of A(x) that share the same density.

    A(x) could be πr^2 / 2πr.

**Special shapes**

Cone

$$V = \frac{1}{3} \pi r^2 h$$

![](images/mass-01.png)

For liquid pressure on side of container, may need to consider ds first, where ds is the slant height.

Usually involves using similar triangles / Pythagoras’ Thm to find relationship between r & h, ds & dx, etc.

**

Circle

(x - h)2 + (y - k)2 = r2

(h, k) is the centre of the circle, r is the radius.

![](images/mass-02.png)

Sphere

x2 + y2 + z2 = r2

z represents vertical plane, r represents radius of sphere

Each slice would be a circle.

$$\text{Area} = \frac{4}{3}\pi r^3$$

$$\text{Surface area} = 4 \pi r^2$$

![](images/mass-03.png)

### Centre of mass

$$\bar{x} = \frac{\int x \, dm}{M} = \frac{\int x \rho \, dV}{M}$$

![](images/centre-of-mass-01.png)

## Methods of integration

### Basic results

![](images/master-list-02.png)

### Integration by parts

$$\int f g' \, dx = f g - \int f' g \, dx$$

[derived from product rule].

**choose g that can be integrated, and f that can be differentiated.

[some integration may loop e.g. $\int e^x \sin x \, dx$]

### Change of variables

$$fg = \int f'(g)\, g'\, dx$$

$$\text{Choosing } u = g \text{ and } du = g'\,dx,\ \text{we get } \int f'(u)\,du = f(u) + C$$

1. Inverse trigo substitution

e.g. $\int \sqrt{1 - x^2}\,dx, \int \sqrt{x^2 + 1}\,dx, \int \sqrt{x^2 - 1}\,dx$

    Use formulas: $\sin^2 x + \cos^2 x = 1, \quad \tan^2 x + 1 = \sec^2 x$

1. Trigo polynomials

e.g. $\int \cos^m x \sin^n x\,dx$

Use double angle formulas: $\cos 2x = 2\cos^2 x - 1 = 1 - 2\sin^2 x$

- If both m,n even, just sub directly.
- If either m,n are odd, sub u=cos x or sin x, to get a polynomial in u.
1. Half-angle substitution

$$\text{Let } u = \tan\!\left(\frac{x}{2}\right), \text{then}$$

$$\sin\!\left(\frac{x}{2}\right) = \frac{u}{\sqrt{1+u^{2}}}, \quad \cos\!\left(\frac{x}{2}\right) = \frac{1}{\sqrt{1+u^{2}}}$$

$$\text{and} \sin x = 2\cos\!\left(\frac{x}{2}\right)\sin\!\left(\frac{x}{2}\right) = \frac{2t}{1+t^{2}}, \quad \cos x = 2\cos^{2}\!\left(\frac{x}{2}\right) - 1 = \frac{1 - t^{2}}{1 + t^{2}}$$

$$\text{and } du = \tfrac{1}{2}\sec^2\!\left(\tfrac{x}{2}\right)\,dx = \tfrac{1}{2}\bigl(1 + \tan^2\!\left(\tfrac{x}{2}\right)\bigr)\,dx = \tfrac{1}{2}(1 + u^2)\,dx$$

    Example: $\int \frac{\sin^{3}x + \cos x}{\sin x - \cos x}\,dx$ (lowkey impossible nvm)

1. Partial fractions

$$\int \frac{P(x)}{Q(x)}\,dx$$

$$\text{If }\deg(P)\ge\deg(Q),\ \text{ } \frac{P}{Q}.$$

$$Q(x) = (x-\alpha)\,(x-\alpha)^2 \cdots \bigl((x-\beta)^2 + \delta^2\bigr)\,\bigl((x-\beta)^2 + \delta^2\bigr)^2 \cdots$$

Where each quadratic root has no real root.

$$\text{Then find partial fractions:} \frac{C_1}{x-\alpha} + \frac{C_2}{(x-\alpha)^2} + \cdots + \frac{A_1 x + B_1}{(x-\beta)^2 + \delta^2} + \frac{A_2 x + B_2}{\bigl((x-\beta)^2 + \delta^2\bigr)^2} + \cdots$$

## Fundamental theorem of algebra

$$\text{Polynomial of degree } n \text{ can be factorised into }$$
$$\begin{aligned} Q(x) = A(x - x_1)(x - x_2)\dots(x - x_n), \\ \text{ where each root may be complex.} \end{aligned}$$

If coefficients of the polynomial are real,

$$\text{then complex roots occur only in conjugate pairs } a-bi, a+bi.$$

$$\text{Multiplying gives } (x-a+bi)(x-a-bi) = (x-a)^2 + b^2.$$

### Rational root theorem

$$\text{Let } P(x) = a_n x^n + a_{n-1} x^{n-1} + \dots + a_0 \text{ have integer coefficients.}$$

$$\text{If } \frac{p}{q} \text{ is a rational root (in lowest terms), then}$$

$$p \text{ is a factor of the constant term } a_0.$$

$$q \text{ is a factor of the leading coefficient } a_n.$$

**Integral root theorem – If the leading coefficient = 1, all of its integer roots divide the constant term.
