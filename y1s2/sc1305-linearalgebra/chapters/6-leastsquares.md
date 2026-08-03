# Least squares

## Consistency in a system of equations

For an $`M \times N`$ matrix $`A`$:

- Under-determined $`M < N`$: There are free variables $`\implies`$ infinite solutions.

- Perfectly-determines $`M=N`$: Unique solution.

- Over-determined $`M > N`$: Prone to inconsistency. Real-world data collection tends to result in over-determined system.

The equation $`Ax=b`$ fundamentally asks if $`b`$ can be constructed as a linear combination of the columns of $`A`$.\
If $`b`$ lives in the column space of $`A`$, then the system is consistent. Otherwise, it is inconsistent.\
Testing if $`b`$ lies in the column space of $`A`$:

- If rank($`A`$) \< rank($`A|b`$), $`b`$ introduces a new dimension, so the system is inconsistent.

- If rank($`A`$) = rank($`A|b`$), the system is consistent.

In real-world data collection, systems are usually over-determined, so $`b`$ doesn’t lie in the column space. The goal is to find the point in the column space that is closest to $`b`$. This best approximation is found using orthogonality from $`b`$ to the column space.

## The Least Squares Problem

Given that $`b`$ does not lie in the column space, we can define an error vector between our prediction $`Ax`$ and $`b`$:
``` math
e = b - Ax
```
We want to make the error vector as short as possible. We want to find a set of weight $`\hat{x}`$ such that
``` math
\|b - A\hat{x}\| \leq \|b - Ax\|
```
Since
``` math
||e|| = \sqrt{e_1^2 + e_2^2 + \dots + e_m^2}
```
we can minimise the squared distance, $`||e||^2`$:
``` math
||e||^2 = e_1^2 + e_2^2 + \dots + e_m^2
```
The method is called Least Squares because we are finding the solution that provides the least possible sum of the squared errors.

## Best Approximation Theorem

#### Theorem

If $`W`$ is a finite-dimensional subspace of an inner product space $`V`$, and if $`\mathbf{b}`$ is a vector in $`V`$, then $`\text{proj}_{W} \mathbf{b}`$ is the best approximation to $`\mathbf{b}`$ from W in the sense that
``` math
||\mathbf{b}-proj_{W}\mathbf{b}||<||\mathbf{b}-\mathbf{w}||
```
for every vector $`\mathbf{w}`$ in W that is different from $`\text{proj}_W \mathbf{b}`$.

## The Normal Equation

We want the error vector to be orthgonal to the entire column space of $`A`$, so
``` math
\begin{align*}
    A^T \mathbf{e} &= \mathbf{0}\\
    A^T (\mathbf{b} - A\mathbf{\hat{x}}) &= \mathbf{0}\\
    A^TA\mathbf{\hat{x}} &= A^T\mathbf{b} \quad [\text{The normal equation}]
\end{align*}
```
Finding a unique solution:

#### Theorem

Let A be an $`m\times n`$ matrix. The following statements are logically equivalent:

1.  The equation $`A\mathbf{x}=\mathbf{b}`$ has a unique least-squares solution for each $`\mathbf{b}`$ in $`\mathbb{R}^{m}`$.

2.  The columns of $`A`$ are linearly independent.

3.  The matrix $`A^{T}A`$ is invertible.

When these statements are true, the least-squares solution $`\mathbf{\hat{x}}`$ is given by $`\mathbf{\hat{x}}=(A^{T}A)^{-1}A^{T}\mathbf{b}`$.

## Projection Matrix

We want a projection matrix $`P`$ that takes any vector $`\mathbf{b}`$ and outputs the closest point in our column space, i.e. $`\mathbf{\hat{b}}`$ $`= P`$$`\mathbf{b}`$.\
First, the projection of $`\mathbf{u}`$ onto a 1-D line defined by $`\mathbf{v}`$:
``` math
Proj_{\mathbf{v}}\mathbf{u} = \mathbf{v}\left(\frac{\mathbf{u}^T\mathbf{v}}{||\mathbf{v}||^2}\right) = \mathbf{v}\left(\frac{\mathbf{u}^T\mathbf{v}}{\mathbf{v}^T\mathbf{v}}\right) = \left(\frac{\mathbf{v}\mathbf{v}^T}{\mathbf{v}^T\mathbf{v}}\right)\mathbf{u} = P\mathbf{u}
```
Therefore, the projection matrix $`P = \frac{\mathbf{v}\mathbf{v}^T}{\mathbf{v}^T\mathbf{v}}`$.\
From the normal equation,
``` math
\begin{align*}
    \mathbf{\hat{x}} &= (A^TA)^{-1}A^T\mathbf{b}\\
    \mathbf{p} = A\mathbf{\hat{x}} = A(A^TA)^{-1}A^T\mathbf{b}
\end{align*}
```
Therefore, $`P = A(A^TA)^{-1}A^T`$.\
Two properties of projection matrix:

1.  $`P^T = P`$. $`P`$ is symmetric, guaranteeing that the error vector is orthogonal to the column space.

2.  $`P^2 = P`$. $`P`$ represents the projection onto the column space. Applying it repeatedly has the same effect of applying it just once.

## QR Factorisation

using the Normal Equation method, computing $`A^T A`$ and finding its inverse can be computationally expensive.\
QR factorisation is faster. Factorising $`A=QR`$,

- $`Q`$ has orthonormal columns. $`Q^T Q = I`$.

- $`R`$ is upper-triangular matrix.

Substituting $`A=QR`$,
``` math
\begin{align*}
    A\mathbf{x} &= \mathbf{b} \\
    QR\mathbf{x} &= \mathbf{b} \\
    R\mathbf{x} &= Q^T \mathbf{b}
\end{align*}
```
Since $`R`$ is a simple upper-triangular staircase, we can just solve using back-substitution.

## Application to linear models

When plotting experimental data on a graph, the points are scattered.\
We want to draw a straight line through them defined as $`y = \beta_0 + \beta_1x`$, where $`\beta_0`$ is the y-intercept and $`\beta_1`$ is the gradient.\
For any given data point ($`x_j, y_j`$), the line will predict a specific height $`\mathbf{\hat{y}}_j`$.\
The vertical gap is the residual, $`\epsilon_j`$:
``` math
\epsilon_j = y_j - (\beta_0 + \beta_1x_j)
```
The goal is to find the specific parameters ($`\beta_0`$ and $`\beta_1`$) that make the total sum of all these squared residuals as small as mathematically possible.\
\
First, translate the equation $`A\mathbf{x}=\mathbf{b}`$ into $`X\mathbf{\beta} = \mathbf{y}`$.

- $`\mathbf{y}`$: Vector containing all the actual $`y`$-coordinates from the data. (The unreachable target).

- $`\mathbf{\beta}`$: Vector containing the unknown weights: $`\begin{bmatrix} \beta_0 \\ \beta_1 \end{bmatrix}`$.

- Design matrix $`X`$: First column contains 1s to multiply with $`\beta_0`$ which is a constant. The second column of $`X`$ is filled with your actual $`x`$-coordinates. These act as the multipliers for your slope $`\beta_1`$.

Adding the errors $`\epsilon`$, the full equation is:
``` math
\mathbf{y} = X\mathbf{\beta} + \mathbf{\epsilon}
```
**Example** We have 4 data points $`(2, 1), (5, 2), (7, 3), (8, 3)`$.\
We set up $`\mathbf{y}`$ = $`\begin{bmatrix} 1 \\ 2 \\ 3 \\ 3 \end{bmatrix}`$ and $`X`$ = $`\begin{bmatrix} 1 & 2 \\ 1 & 5 \\ 1 & 7 \\ 1 & 8 \end{bmatrix}`$. Using the normal equation that minimises $`\epsilon`$: $`X^TX`$$`\mathbf{\beta}`$ = $`X^T`$$`\mathbf{y}`$.\
We have $`X^TX = \begin{bmatrix} 4 & 22 \\ 22 & 142 \end{bmatrix}`$ and $`X^T`$$`\mathbf{y}`$ $`= \begin{bmatrix} 9 \\ 57 \end{bmatrix}`$, so solving we get $`\mathbf{\beta}`$ = $`\begin{bmatrix} 2/7 \\ 5/14 \end{bmatrix}`$.\
The best-fit line is $`y = \frac{2}{7} + \frac{5}{14}x`$.\
\
Least squares can fit a curve $`y = \beta_0 + \beta_1x + \beta_2x^2`$. The linear model is linear wrt to the parameters $`\beta`$ not the data $`x`$.\
Simply add a third column to $`X`$ containing the $`x`$-coordinates squared (for $`\beta_2`$), then solve the Normal equation $`X^TX`$$`\mathbf{\beta}`$ = $`X^T`$$`\mathbf{y}`$.
