A differential equation is an equation involving one or more derivatives of an unknown function.

The general solution to a d.e. is the collection of all the particular solutions.

## Initial-value problem

$n^{th}$-order d.e., and $n$ initial conditions $[y(x_0) = y_0, \dots, y^{n-1}(x_0) = y_{n-1}]$.

## Separable 1st-order d.e.

$$p(y)y' = q(x) \;\Longrightarrow\; \text{if } p, q \text{ are continuous, } \int p(y)\,dy = \int q(x)\,dx$$

## Linear d.e.

$$a_0(x)y^{(n)} + a_1(x)y^{(n-1)} + \cdots + a_n(x)y = F(x)$$

$$\text{If } a_1, a_2, \ldots, a_n, F \text{ are continuous on } I, \text{ then for } x_0 \in I,$$

$$\text{the IVP } y^{(n)} + a_1(x)y^{(n-1)} + \cdots + a_{n-1}(x)y' + a_n(x)y = F(x),$$

$$\text{with } y(x_0) = y_0, \; y'(x_0) = y_1, \; \ldots, \; y^{(n-1)}(x_0) = y_{n-1},$$

$$\text{has a unique solution on } I \; (\text{i.e., exactly one solution}).$$

## 1st- order linear d.e.

$$a(x)\frac{dy}{dx} + b(x)y = r(x) \implies \frac{dy}{dx} + p(x)y = q(x),\text{ if } a(x) \neq 0 \text{ on the interval.}$$

$$\text{Then letting } P(x) = \int p(x)\,dx, \text{ multiply by } e^{P(x)}:$$

$$e^{P(x)}\frac{dy}{dx} + p(x)e^{P(x)}y = \frac{d}{dx}\!\left(e^{P(x)}y\right) = q(x)e^{P(x)}.$$

$$\text{Integrating both sides, } e^{P(x)}y = \int q(x) e^{P(x)} \, dx.$$

## 2nd-order linear d.e.

$$a_0(x)y'' + a_1(x)y' + a_2(x)y = F(x)$$

$$\text{If } F(x) = 0, \text{ the differential equation is homogeneous.}$$

$$\text{For }\textbf{homogeneous } \text{linear d.e. } a(x)y'' + b(x)y' + c(x)y = 0$$

$$\text{If } y_1(x), y_2(x) \text{ are two solutions on an interval } I,$$

$$\text{ then any linear combination }y(x) = C_1y_1(x) + C_2y_2(x)\text{ is also a solution on } I.$$

*can be generalised to nth order linear homo equation.

$$\text{Then for a }\textbf{non-homogeneous }\text{linear d.e. } y'' + p(x)y' + q(x)y = f(x),$$

$$\text{the general solution is } y(x) = C_1y_1(x) + C_2y_2(x) + y_p(x) = y_c(x) + y_p(x),$$

$$\text{where } y_1(x) \text{ and } y_2(x) \text{ are linearly independent solutions of the homogeneous equation}$$

$$(\text{i.e., not scalar multiples of each other}),$$

$$\text{and } y_p(x) \text{ is a particular solution to the non-homo eqn.}$$

**Note:**Only sub in the initial conditions after determining both $y_c$ and $y_p$.

### Solving for y_cx

- $\text{For a homogeneous linear d.e. with constant coefficients: }a y'' + b y' + c y = 0,$
- $\text{substitute } y = e^{rx}, \; y' = re^{rx}, \; y'' = r^2 e^{rx},$
- $\text{to obtain the characteristic equation: } a r^2 + b r + c = 0.$
- $\text{Case 1: } r_1, r_2 \text{ are distinct real roots.}$
- $\text{Then the general solution is } y(x) = C_1 e^{r_1 x} + C_2 e^{r_2 x}.$
- $\text{Case 2: } r_1 \text{ is a real double root.}$
- $\text{Then the general solution is } y(x) = C_1 e^{r_1 x} + C_2 x e^{r_1 x}.$
- $\text{Case 3: Two complex conjugate roots } \alpha + i\omega, \; \alpha - i\omega.$

$$\text{Then the general solution is } y(x) = C_1 e^{(\alpha + i\omega)x} + C_2 e^{(\alpha - i\omega)x}.$$

$$\text{We can further derive } y_3 = e^{\alpha x}\cos(\omega x), \quad y_4 = e^{\alpha x}\sin(\omega x),$$

$$\text{giving } y(x) = e^{\alpha x}\big(C_3\cos(\omega x) + C_4\sin(\omega x)\big).$$

### Solving for y_px

$$\text{Judicious guessing of solution to } y'' + a y' + b y = F(x)$$

- Case 0: $y'' + ay' + by = C$, where $C$ is a constant. By observation, $y_p = \frac{C}{b}$.
- $\text{Case 1: } y'' + a y' + b y = a_0 + a_1x + \cdots + a_nx^n$
- $\text{If } b \ne 0, \text{ we can guess } y_p = A_0 + A_1x + \cdots + A_nx^n.$
- $\text{Substitute } y_p, \; y_p', \; y_p'' \text{ into the equation and compare coefficients.}$
- $\text{Case 2: } y'' + a y' + b y = e^{\alpha x}(a_0 + a_1x + \cdots + a_nx^n)$

$$\text{If } e^{\alpha x} \text{ is not a solution to the homogeneous equation, guess } y_p = (A_0 + A_1x + \cdots + A_nx^n)e^{\alpha x}.$$

$$\text{If } e^{\alpha x} \text{ is a solution, but } x e^{\alpha x} \text{ is not, guess } y_p = x(A_0 + A_1x + \cdots + A_nx^n)e^{\alpha x}.$$

$$\text{If both } e^{\alpha x} \text{ and } x e^{\alpha x} \text{ are solutions, guess } y_p = x^2(A_0 + A_1x + \cdots + A_nx^n)e^{\alpha x}.$$

$$\text{Case 3: If } F(x) \text{ is of the form } \sin(\omega x) \text{ or } \cos(\omega x),\text{ guess } y_p = A\cos(\omega x) + B\sin(\omega x).$$

$$\text{Multiply by } x \text{ if it is already a solution to the homogeneous equation.}$$
