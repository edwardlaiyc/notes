$$\text{If } \lim_{x \to 0} f(x) = 0, \text{ then } \lim_{x \to 0} \left( \frac{\sin(f(x))}{f(x)} \right) = 1.$$

Triangle inequality

$$|x + y| \le |x| + |y|.$$

$$\Big| |x| - |y| \Big| \leq |x - y|$$

For large x, factorial > exponential > polynomial > ln/lg.

$$\begin{aligned} \text{For any } p > 0, \, \varepsilon > 0, \quad \\ \lim_{x \to +\infty} \frac{x!}{x^x} = 0, \quad \\ \lim_{x \to +\infty} \frac{e^{\varepsilon x}}{x!} = 0, \quad \\ \lim_{x \to +\infty} \frac{x^p}{e^{\varepsilon x}} = 0, \quad \\ \text{and} \quad \\ \lim_{x \to +\infty} \frac{(\ln x)^p}{x^{\varepsilon}} = 0. \end{aligned}$$

Trigo

$$\sin (A \pm B) = \sin A \cos B \pm \cos A \sin B$$

$$\cos (A \pm B) = \cos A \cos B \mp \sin A \sin B$$

$$\tan (A \pm B) = \frac{\tan A \pm \tan B}{1 \mp \tan A \tan B}$$

$$\sin 2A = 2 \sin A \cos A$$

$$\cos 2A = 2 \cos^2 A - 1 = 1 - 2 \sin^2 A$$

$$\sin^2 x + \cos^2 x = 1$$

$$\tan^2 x + 1 = \sec^2 x$$

$$(a + b + c)^2 = a^2 + b^2 + c^2 + 2ab + 2ac + 2bc$$

$$e^k = \lim_{n \to \infty}(1 + \frac{k}{n})^n$$

$$\lim_{n \to \infty}\tan^{-1}n = \frac{\pi}{2}$$

Bounded function

- $f: A \to \mathbb{R}: \exists M > 0 \text{ such that } \forall x \in A,\, |f(x)| \le M$
- Periodic function
- $f: A \to \mathbb{R}: \exists T > 0 \text{ such that } \forall x \in A,\, f(x + T) = f(x)$
- $\text{Odd function } f: A \to \mathbb{R}: \forall x \in A,\, f(-x) = -f(x)$
- $\text{Even function } f: A \to \mathbb{R}: \forall x \in A,\, f(-x) = f(x)$

Limit point

$$a \text{ is a limit point of set } A \text{ if }\forall \, \delta > 0, \, \exists \, x \in A \text{ such that } 0 < |x - a| < \delta.$$

Limit of a function

$$\begin{aligned} \lim_{x \to a} f(x) = L \\ \quad \text{if} \quad \forall \, \varepsilon > 0, \, \exists \, \delta > 0 \text{ such that } \\ \forall x \in A, \; 0 < |x - a| < \delta \implies |f(x) - L| < \varepsilon. \end{aligned}$$

$$\lim_{x \to \infty} f(x) = L \text{ if } \forall \, \varepsilon > 0, \, \exists \, N > 0 \text{ such that } \forall x > N, \; |f(x) - L| < \varepsilon.$$

Limit d.n.e

$$\lim_{x \to a} f(x) = \infty \text{ if } \forall \, M > 0, \, \exists \, \delta > 0 \text{ such that }\forall x \in A, \; 0 < |x - a| < \delta \implies f(x) > M.$$

$$\lim_{x \to \infty} f(x) = \infty \text{ if } \forall \, M > 0, \, \exists \, N > 0 \text{ such that } x > N \implies f(x) > M.$$

Squeeze Theorem

$$\text{If } g(x) \le f(x) \le h(x) \text{ for } x \in I \setminus \{a\},\text{ and } \lim_{x \to a} g(x) = \lim_{x \to a} h(x) = L,\text{ then } \lim_{x \to a} f(x) = L.$$

$$\lim_{x \to a} f(x) = L \;\Longleftrightarrow\;\lim_{x \to a} \bigl| f(x) - L \bigr| = 0.$$

Continuity

$$f : A \to \mathbb{R} \text{ is continuous at } a \in A \text{ if } \forall \, \varepsilon > 0, \, \exists \, \delta > 0 \text{ such that }$$

$$\forall x \in A, \; |x - a| < \delta \implies |f(x) - f(a)| < \varepsilon.$$

$$f(x) \text{ is continuous on a set } A \;\Longleftrightarrow\;\forall \, a \in A, \; \lim_{x \to a} f(x) = f(a).$$

Composition

$$\text{If } \lim_{x \to a} g(x) = L \text{ and } f \in C(L),\text{ then } \lim_{x \to a} f(g(x)) = f\!\left( \lim_{x \to a} g(x) \right) = f(L).$$

$$\lim_{x \to \infty} (f)^x = \lim_{x \to \infty} e^{x \ln(f)} = e^{\lim_{x \to \infty} (x \cdot f)}$$

Intermediate Value Theorem

$$\text{If } f(x) \in C([a,b]) \text{ and } f(a) \ne f(b),$$

$$\text{then } \forall \, y \in \bigl( \min(f(a), f(b)), \max(f(a), f(b)) \bigr),$$

$$\exists \, c \in (a,b) \text{ such that } f(c) = y.$$

Min/max Theorem

$$\text{If } f(x) \in C([a,b]),$$

$$\text{then there exist points } x_m, x_M \in [a,b] \text{ such that } f(x_m) \le f(x) \le f(x_M).$$

Functions

- Injective $f : A \to \mathbb{R}, \text{ for } x_1, x_2 \in A, \;x_1 \ne x_2 \implies f(x_1) \ne f(x_2).$
- Inverse
- $\text{If } f : A \to \mathbb{R} \text{ is injective, (and also surjective)}$
- $f^{-1} : f(A) \to \mathbb{R}, \quad f^{-1}(y) = x \;\Longleftrightarrow\; f(x) = y.$

Differentiability

f is differentiable at x=a if this limit exists:

$$f'(a) = \frac{d}{dx} f(x) \bigg|_{x=a} = \lim_{x \to a} \frac{f(x) - f(a)}{x - a} = \lim_{h \to 0} \frac{f(a + h) - f(a)}{h}.$$

$$f'(x) = \frac{d}{dx} f(x) = \lim_{h \to 0} \frac{f(x + h) - f(x)}{h}$$

$$D(a) \subset C(a)$$

$$f \in C^n(A) : \; f^{(n)} \text{ exists and is continuous on } A.$$

$$C^n(A) \subset C^{n-1}(A) \subset \cdots \subset C^1(A) \subset C^0(A)$$

![](images/master-list-01.png)

Minima/maxima

$$x_0 \in A \text{ is a global maximum if } \forall x \in A, \; f(x) \le f(x_0).$$

$$f : A \to \mathbb{R}, \; x_0 \text{ is a local maximum if } \exists \, (a,b) \text{ such that }$$

$$x_0 \in (a,b) \text{ and } f(x) \le f(x_0) \text{ for all } x \in (a,b) \cap A.$$

Mean Value Theorem

$$\text{If } f(x) \in C([a,b]) \text{ and } f \in D((a,b)),$$
$$\text{then there exists } c \in (a,b) \text{ such that}$$

$$f'(c) = \frac{f(b) - f(a)}{b - a}.$$

Rolle’s Theorem

$$\text{If } f(a) = f(b), \text{ then there exists } c \in (a,b) \text{ such that } f'(c) = 0.$$

Cauchy Mean Value Theorem

$$\text{If } f, g \in C([a,b]) \text{ and } f, g \in D((a,b)),$$

$$\text{then there exists some } c \in (a,b) \text{ such that}$$

$$f'(c)\bigl(g(b) - g(a)\bigr) = g'(c)\bigl(f(b) - f(a)\bigr)$$

Concavity

$$\text{A function } f(x) \text{ is concave upward on the interval } I \text{ if and only if}$$

$$\text{for any } a < x < b \text{ in } I, \; \frac{f(x) - f(a)}{x - a} < \frac{f(b) - f(a)}{b - a}.$$

At an inflection point, $f''(x) = 0$ or $f''(x)$ does not exist.

However, $f''(a) = 0 \not\Longrightarrow a$ is an inflection point.

Integration

$$\int_a^b f(x) \, dx = \lim_{\Delta x \to 0} \sum_{i=1}^{n} f(x_i^*) \, \Delta x_i, \quad \text{where } \Delta x = \max(\Delta x_i), \; i = 1, 2, \ldots, n.$$

$$\text{where } x_i^* \in [a_{i-1}, a_i] \text{ and } a = a_0 < a_1 < \cdots < a_n = b.$$

$$\text{Choosing } n \text{ equally spaced points, we get } \Delta x_i = \frac{b - a}{n} = \Delta x,$$

$$\text{and } \int_a^b f(x) \, dx = \lim_{n \to \infty} \frac{b - a}{n} \sum_{i=1}^{n} f(x_i^*).$$

$$\text{If } f \text{ is continuous on } [a,b], \text{ then it is integrable on } [a,b].$$

$$\text{If } f \text{ is integrable on } [a,b], \text{ it is bounded on } [a,b],$$

$$\text{and is continuous on } [a,b] \text{ except at finitely many points.}$$

$$\left|\int_a^b f(x) \, dx\right| \le \int_a^b |f(x)| \, dx.$$

$$f_{\text{avg}} = \frac{1}{b - a} \int_a^b f(x) \, dx$$

Integral MVT

$$\text{If } f \in C([a,b]), \text{ then there exists } c \in [a,b] \text{ such that } f(c) = f_{\text{avg}}.$$

Integration techniques

$$\int_a^{+\infty} f(x) \, dx = \lim_{R \to +\infty} \int_a^{R} f(x) \, dx$$

$$\int f g' \, dx = f g - \int f' g \, dx$$

![](images/master-list-02.png)

Fundamental theorem of calculus

$$\text{If } f \in C([a,b]), \text{ let } F : [a,b] \to \mathbb{R}, \; F(x) = \int_a^x f(t) \, dt.$$

$$\text{Then for all } x \in (a,b), \; F'(x) = f(x), \text{ and } F \in C([a,b]).$$

Integration applications

$$W = \int F(x) \, dx, \quad \text{for force } F \text{ and displacement } x.$$

$$F = \int p \, dA, \quad \text{for pressure } p \text{ and area } A.$$

$$M = \int dm = \int \rho \, dV = \int \rho A(x) \, dx, \quad \text{for density } \rho \text{ and volume } V.$$

$$\bar{x} = \frac{\int x \, dm}{M} = \frac{\int x \rho \, dV}{M}$$

Differential equations

$$p(y)y' = q(x) \;\Longrightarrow\; \text{if } p, q \text{ are continuous, } \int p(y)\,dy = \int q(x)\,dx$$

$$\frac{dy}{dx} + p(x)y = q(x)\text{, Letting } P(x) = \int p(x)\,dx, \text{ multiply by } e^{P(x)}$$

$$\text{Homogeneous linear d.e. with constant coefficients: }a y'' + b y' + c y = 0 \rightarrow a r^2 + b r + c = 0.$$

$$y(x) = C_1 e^{r_1 x} + C_2 e^{r_2 x} \ / \ y(x) = C_1 e^{r_1 x} + C_2 x e^{r_1 x} \ / \ y(x) = e^{\alpha x}\big(C_1\cos(\omega x) + C_2\sin(\omega x)\big).$$

$$\text{Judicious guessing of solution to } y'' + a y' + b y = F(x)$$

- $F(x) = a_0 + a_1x + \cdots + a_nx^n: y_p = A_0 + A_1x + \cdots + A_nx^n.$
- $F(x) = e^{\alpha x}(a_0 + a_1x + \cdots + a_nx^n): y_p = (A_0 + A_1x + \cdots + A_nx^n)e^{\alpha x}.$
- $F(x) = \sin(\omega x) \text{ or } \cos(\omega x): y_p = A\cos(\omega x) + B\sin(\omega x).$

Series

$$\text{With a sequence } \{a_k\}_{k=1}^{\infty},\text{ we can form the } n\text{th partial sum }S_n = \sum_{k=1}^{n} a_k = a_1 + a_2 + \cdots + a_n.$$

$$\text{If } \lim_{n \to \infty} S_n \text{ exists, the series } \sum_{k=1}^{\infty} a_k \text{ converges.}$$

$$\sum_{k=1}^{\infty} (A a_k + B b_k)= A \sum_{k=1}^{\infty} a_k+ B \sum_{k=1}^{\infty} b_k \text{, if both series converge.}$$

Convergence Tests

Limit Test

$$\text{Contrapositive: If } a_n \not\to 0, \text{ then the series } \sum_{n=1}^{\infty} a_n \text{ does not converge.}$$

Integral Test

$$\text{If } f:[1,\infty)\to\mathbb{R} \text{ is continuous, decreasing, and } \lim_{x\to +\infty} f(x)=0,\text{ then}$$

$$\sum_{k=1}^{\infty} f(k) \text{ converges } \Leftrightarrow \ \int_{1}^{+\infty} f(x)\,dx \text{ converges.}$$

P-series

$$\sum_{n=1}^{\infty} \frac{1}{n^p} \text{ converges } \Leftrightarrow \ p > 1.$$

LCT

$$\text{For } a_n \ge 0,\, b_n > 0 \text{ for all } n,\ \text{if } \lim_{n \to \infty} \frac{a_n}{b_n} = L,\ \text{where } L > 0,\ L \in \mathbb{R},$$

$$\text{then } \sum_{n=1}^{\infty} a_n \text{ and } \sum_{n=1}^{\infty} b_n \text{ either both converge or both diverge.}$$

Ratio Test

$$\text{For } a_n > 0 \text{ for large } n, \text{ and } \lim_{n \to \infty} \left| \frac{a_{n+1}}{a_n} \right| = c,$$

$$\text{if } c > 1, \text{ then } \sum a_n \text{ diverges.}$$

$$\text{if } c < 1, \text{ then } \sum a_n \text{ converges.}$$

$$\text{if } c = 1, \text{ gives no information.}$$

Root Test

$$\text{For } a_n \ge 0 \text{ for large } n, \text{ and } \lim_{n \to \infty} \sqrt[n]{a_n} = c,$$

$$\text{if } c > 1, \text{ then } \sum a_n \text{ diverges.}$$

$$\text{if } c < 1, \text{ then } \sum a_n \text{ converges.}$$

$$\text{if } c = 1, \text{ no information can be concluded.}$$

Absolute convergence

$$\text{If } \sum_{n=1}^{\infty} |a_n| \text{ converges, then } \sum_{n=1}^{\infty} a_n \text{ converges absolutely.}$$

$$\text{If } \sum_{n=1}^{\infty} a_n \text{ converges absolutely, then it converges.}$$

Conditional convergence

$$\text{If } \sum_{n=1}^{\infty} a_n \text{ converges, but } \sum_{n=1}^{\infty} |a_n| \text{ does not, then } \sum_{n=1}^{\infty} a_n \text{ converges conditionally.}$$

Leibniz’ Test

$$\text{For an alternating series } \pm \sum_{n=1}^{\infty} (-1)^{n-1} b_n, \text{ where } b_n > 0,$$

$$\text{if } b_1 \ge b_2 \ge b_3 \ge \ldots \ge 0 \text{ and } \lim_{n \to \infty} b_n = 0,$$

$$\text{then } \sum_{n=1}^{\infty} (-1)^{n-1} b_n \text{ converges.}$$

Power Series

$$\text{Power series: }\sum_{n=0}^{\infty} a_n (x - c)^n = a_0 + a_1(x - c) + a_2(x - c)^2 + \ldots$$

$$\text{Geometric series: } \frac{1}{1 - x} = \sum_{n=0}^{\infty} x^n = 1 + x + x^2 + x^3 + \ldots, \text{ for } |x| < 1$$

$$\ln(1+x) = \sum_{n=1}^{\infty} (-1)^{n-1}\frac{x^n}{n} = x - \frac{x^2}{2} + \frac{x^3}{3} - \frac{x^4}{4} + \cdots,\quad x \in (-1,1].$$

$$-\ln(1 - x) = \sum_{n=1}^{\infty} \frac{x^n}{n} = x + \frac{x^2}{2} + \frac{x^3}{3} + \frac{x^4}{4} + \dots, \quad x \in [-1, 1).$$

$$e^x = \sum_{n=0}^{\infty} \frac{x^n}{n!} = 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \ldots,\quad x \in (-\infty, \infty).$$

$$\sin x = \sum_{n=0}^{\infty} (-1)^n \frac{x^{2n+1}}{(2n+1)!} = x - \frac{x^3}{3!} + \frac{x^5}{5!} - \ldots,\quad x \in (-\infty, \infty).$$

$$\cos x = \frac{d}{dx}(\sin x) = \sum_{n=0}^{\infty} (-1)^n \frac{x^{2n}}{(2n)!} = 1 - \frac{x^2}{2!} + \frac{x^4}{4!} - \ldots,\quad x \in (-\infty, \infty).$$

$$\tan^{-1} x = \sum_{n=0}^{\infty} (-1)^n \frac{x^{2n+1}}{2n+1} = x - \frac{x^3}{3} + \frac{x^5}{5} - \dots, \quad x \in [-1, 1].$$

Taylor Series

$$\text{Taylor series: } \sum_{n=0}^{\infty} \frac{f^{(n)}(c)}{n!}(x-c)^n = f(c) + \frac{f'(c)}{1!}(x-c) + \frac{f''(c)}{2!}(x-c)^2 + \ldots$$

$$\text{Maclaurin series: } \sum_{n=0}^{\infty} \frac{f^{(n)}(0)}{n!}x^{n}= f(0) + f'(0)x + \frac{f''(0)}{2!}x^{2} + \frac{f'''(0)}{3!}x^{3} + \ldots$$

Ordo

$$f = \mathcal{O}(g) \text{ as } x \to c, \text{ if } \exists\, D, \delta > 0 \text{ such that } |f| \le D|g|, \ \forall\, x \in (c - \delta,\, c + \delta).$$

$$\text{For } 0 \le m \le n,\ \mathcal{O}(x^m) + \mathcal{O}(x^n) = \mathcal{O}(x^m), \text{ as } x \to 0$$

$$\mathcal{O}(g_1) \cdot \mathcal{O}(g_2) = \mathcal{O}(g_1 g_2) \text{ as } x \to c.$$

$$\frac{\mathcal{O}(g_1)}{g_2} = \mathcal{O}\!\left(\frac{g_1}{g_2}\right) \text{ as } x \to c.$$

Taylor’s Theorem with Lagrange remainder

$$\text{If } f \text{ is } (n+1) \text{ times differentiable on an open interval containing } c \text{ and } x, \text{ then}$$

$$f(x) = P_n(x) + R_n(x) = \sum_{k=0}^{n} \frac{f^{(k)}(c)}{k!}(x - c)^k + \frac{f^{(n+1)}(X)}{(n + 1)!}(x - c)^{n + 1},$$

Taylor’s Theorem, asymptotic version

$$\text{If } f \text{ is } (n+1) \text{ times differentiable on an open interval containing } c$$

$$\text{and } f^{(n+1)} \text{ is continuous at } c,$$

$$\text{then } f(x) = \sum_{k=0}^{n} \frac{f^{(k)}(c)}{k!}(x - c)^k + \mathcal{O}\!\left((x - c)^{n+1}\right), \text{ as } x \to c.$$

$f(x)$ with derivatives of all orders is analytic at $x=c$ if

its Taylor series at $x=c$ converges to $f(x)$ on an open interval containing ${x=c}$.

$$\exists \text{ an open interval } (c-R, c+R) \text{ such that } \forall x \text{ in that interval,}$$

$$f(x) = \sum_{n=0}^{\infty} \frac{f^{(n)}(c)}{n!} (x-c)^n$$
