# Vector Spaces

## Vector Spaces

A vector space is a nonempty set $`V`$ of vectors, and is closed under vector addition and scalar multiplication. Specifically, these operations must follow these 10 axioms, for all vectors $`\mathbf{u}`$, $`\mathbf{v}`$, $`\mathbf{w}`$ and scalars $`c`$, $`d`$:\
Addition axioms:

1.  $`\mathbf{u}+\mathbf{v}`$, must be in $`V`$.

2.  $`\mathbf{u}+\mathbf{v}=\mathbf{v}+\mathbf{u}`$.

3.  $`(\mathbf{u}+\mathbf{v})+\mathbf{w}=\mathbf{u}+(\mathbf{v}+\mathbf{w})`$.

4.  There is a zero vector $`\mathbf{0}`$ in $`V`$ such that $`\mathbf{u}+\mathbf{0}=\mathbf{u}`$.

5.  For each $`\mathbf{u}`$ in $`V`$, there is a vector $`-\mathbf{u}`$ in $`V`$ such that $`\mathbf{u}+(-\mathbf{u})=\mathbf{0}`$.

Scalar multiplication axioms:

1.  The scalar multiple of $`u`$ by $`c`$, denoted by $`c\mathbf{u}`$, must be in $`V`$.

2.  $`c(\mathbf{u}+\mathbf{v})=c\mathbf{u}+c\mathbf{v}`$.

3.  $`c(\mathbf{u}+\mathbf{v})=c\mathbf{u}+c\mathbf{v}`$.$`(c+d)\mathbf{u}=c\mathbf{u}+d\mathbf{u}`$.

4.  $`c(d\mathbf{u})=(cd)\mathbf{u}`$.

5.  $`1\mathbf{u}=\mathbf{u}`$.

Following from the above axioms,

- $`0\mathbf{u}=\mathbf{0}`$.

- $`c\mathbf{0}=\mathbf{0}`$.

- $`-\mathbf{u}=(-1)\mathbf{u}`$.

An element of a vector space can be thought of as a single "point" or vector in that space.\
**Examples of vector spaces**

- $`\mathbb{R}^{n}`$: The standard space of n-dimensional column vectors.

- Space $`S`$: The space of all doubly infinite sequences of numbers, formatted as $`\{y_{k}\}=(...,y_{-2},y_{-1},y_{0},y_{1},y_{2},...)`$. Here, addition and scalar multiplication are performed term by term.

- $`\mathbb{P}_{n}`$: The set of all polynomials of degree $`n`$ (where $`n\ge0`$). A standard polynomial looks like $`p(t)=a_{0}+a_{1}t+a_{2}t^{2}+\cdot\cdot\cdot+a_{n}t^{n}`$. The zero polynomial acts as the zero vector.

- Functions: The set $`V`$ of all real-valued functions defined on a set $`D`$. Vector addition is defined as $`(f+g)(t) = f(t)+g(t)`$. The zero vector is the function that is identically zero everywhere, i.e., $`f(t)=0`$.

## Subspaces

A subspace is a subset of a vector space that is itself a vector space, i.e. it satisfies the 3 criteria:

1.  A subspace must contain the zero vector of the parent space.

2.  For any two vectors $`\mathbf{u}`$ and $`\mathbf{v}`$ that are in the subspace, $`\mathbf{u}+\mathbf{v}`$ must also be in the subspace.

3.  For any vector $`\mathbf{u}`$ in in the subspace and any scalar $`c`$, $`c\mathbf{u}`$ must also be in the subspace.

Examples of subspaces:

- $`\{\mathbf{0}\}`$: The zero subspace containing only the zero vector.

- Polynomials: The set of polynomials of degree $`n`$ (denoted as $`\mathbb{P}_{n}`$) forms a subspace within the much larger set of all polynomials with real coefficients ($`P`$).

- Geometry: A line or plane $`\mathbb{R}^3`$ passing through the origin is a subspace of $`\mathbb{R}^3`$.\
  Note that $`\mathbb{R}^2`$ is not a subspace of $`\mathbb{R}^3`$, because $`\mathbb{R}^2`$ contains 2-D vectors, while $`\mathbb{R}^3`$ contains 3-D vectors.\
  $`H = \left\{ \begin{bmatrix} s \\ t \\ 0 \end{bmatrix} : s \text{ and } t \text{ are real} \right\}`$ is a subspace of $`\mathbb{R}^3`$.

## Subspace spanned by a set

**Span**: The span of a set of vectors $`\mathbf{v}_{1},\cdot\cdot\cdot,\mathbf{v}_{p}`$, denoted as $`Span\{\mathbf{v}_{1},\cdot\cdot\cdot,\mathbf{v}_{p}\}`$, is the set of all possible vectors that can be created using linear combinations of $`\mathbf{v}_{1},\cdot\cdot\cdot,\mathbf{v}_{p}`$.

#### Theorem

If vectors $`\mathbf{v}_{1},\cdot\cdot\cdot,\mathbf{v}_{p}`$ exist in a vector space $`V`$, then $`Span\{\mathbf{v}_{1},\cdot\cdot\cdot,\mathbf{v}_{p}\}`$ is a valid subspace of $`V`$.\
Terminology:

- $`Span\{\mathbf{v}_{1},\cdot\cdot\cdot,\mathbf{v}_{p}\}`$ is formally called the "subspace spanned by $`\mathbf{v}_{1},\cdot\cdot\cdot,\mathbf{v}_{p}`$".

- For a subspace $`H`$ inside vector space $`V`$, a “spanning set" for $`H`$ is a specific group of vectors $`\mathbf{v}_{1},\cdot\cdot\cdot,\mathbf{v}_{p}`$ located within $`H`$ such that $`H=Span\{\mathbf{v}_{1},\cdot\cdot\cdot,\mathbf{v}_{p}\}`$.

#### Example

Given $`\mathbf{v}_1`$ and $`\mathbf{v}_2`$ in a vector space $`V`$, let $`H = Span\{\mathbf{v}_1, \mathbf{v}_2\}`$. Show that $`H`$ is a subspace of $`V`$.\
Prove the 3 subspace properties hold for $`H`$:

1.  Contains the Zero Vector: Set the scalar weights to zero, i.e. $`0\mathbf{v_1} + 0\mathbf{v_2} = \mathbf{0}`$.

2.  Closed under Vector Addition: Let $`\mathbf{u}`$ and $`\mathbf{w}`$ be any two vectors in $`H`$. By definition, they can be written as linear combinations: $`\mathbf{u} = c_1\mathbf{v}_1 + c_2\mathbf{v}_2`$ and $`\mathbf{w} = d_1\mathbf{v}_1 + d_2\mathbf{v}_2`$. Adding them together gives:
    ``` math
    \mathbf{u} + \mathbf{w} = (c_1 + d_1)\mathbf{v}_1 + (c_2 + d_2)\mathbf{v}_2
    ```

3.  Closed under Scalar Multiplication: Let $`\mathbf{u} = c_1\mathbf{v}_1 + c_2\mathbf{v}_2`$ be in $`H`$, and let $`k`$ be any real scalar. Multiplying $`\mathbf{u}`$ by $`k`$ gives:
    ``` math
    k\mathbf{u} = (kc_1)\mathbf{v}_1 + (kc_2)\mathbf{v}_2
    ```

Hence, $`H`$ qualifies as a subspace.

#### Example

Let $`H`$ be the set of all vectors of the form $`(a-3b, b-a, a, b)`$ where $`a`$ and $`b`$ are real numbers. Show that $`H`$ is a subspace of $`\mathbb{R}^4`$.\
Expressing $`H`$ as linear combinations of $`\mathbf{v_1}`$ and $`\mathbf{v_2}`$,
``` math
H = \begin{bmatrix} a - 3b \\ -a + b \\ a \\ b \end{bmatrix} = a \begin{bmatrix} 1 \\ -1 \\ 1 \\ 0 \end{bmatrix} + b \begin{bmatrix} -3 \\ 1 \\ 0 \\ 1 \end{bmatrix} = a\mathbf{v_1} + b\mathbf{v_2}
```
Since $`\mathbf{v_1}`$, $`\mathbf{v_2}`$ are in $`\mathbb{R}^4`$ and $`H = Span\{\mathbf{v}_1, \mathbf{v}_2\}`$, $`H`$ is a valid subspace of $`\mathbb{R}^4`$.

## Null space of matrix

The null space of an $`m \times n`$ matrix $`A`$ is the set of all vectors $`\mathbf{x}`$ in $`\mathbb{R}^n`$ that satisfy the homogenous equation $`A\mathbf{x}=\mathbf{0}`$.
``` math
\mathbf{N}(A) = \{\mathbf{x}: \mathbf{x} \in \mathbb{R}^n,\: A\mathbf{x} = \mathbf{0}\}
```
The null space consists of all vectors $`\mathbf{x}`$ in $`\mathbb{R}^n`$ that are mapped to the zero vector in $`\mathbb{R}^m`$ by the linear transformation $`\mathbf{x} \mapsto A\mathbf{x}`$.

#### Theorem

The null space of an $`m \times n`$ matrix $`A`$ is a subspace of $`\mathbb{R}^n`$. Equivalently, the set of all solutions to the system of $`m`$ homogeneous linear equations in $`n`$ unknowns is a subspace of $`\mathbb{R}^n`$.\
*Proof.* We show that $`\mathbf{N}(A)`$ satisfies the 3 properties of a subspace.

1.  The zero vector is in $`\mathbf{N}(A)`$.
    ``` math
    A(\mathbf{0})=\mathbf{0}
    ```
    Any matrix multiplied by the zero vector results in the zero vector, so the zero vector is in $`\mathbf{N}(A)`$.

2.  $`\mathbf{N}(A)`$ is closed under vector addition.\
    To show to that if $`\mathbf{u}`$ and $`\mathbf{v}`$ are in $`\mathbf{N}(A)`$, then $`\mathbf{u} + \mathbf{v}`$ is also in $`\mathbf{N}(A)`$. We have
    ``` math
    A\mathbf{u}=\mathbf{0},\quad A\mathbf{v}=\mathbf{0}
    ```
    Using the distributive property of matrix multiplication,
    ``` math
    A(\mathbf{u} + \mathbf{v}) = A\mathbf{u} + A\mathbf{v} = \mathbf{0} + \mathbf{0} = \mathbf{0}
    ```
    Hence $`\mathbf{u} + \mathbf{v} \in \mathbf{N}(A)`$.

3.  $`N(A)`$ is closed under scalar multiplication.\
    To show that if a vector $`u`$ is in $`N(A)`$, then multiplying it by any real scalar $`c`$ results in a vector $`c\mathbf{u}`$ that is also in $`N(A)`$. We have
    ``` math
    A\mathbf{u} = \mathbf{0}
    ```
    Using properties of matrix scalar multiplication,
    ``` math
    A(c\mathbf{u}) = c(A\mathbf{u}) = c(\mathbf{0}) = \mathbf{0}
    ```
    Hence $`c\mathbf{u} \in \mathbf{N}(A)`$.

#### Example

For this matrix $`A`$ and vector $`\mathbf{u}`$,
``` math
A = \begin{bmatrix} 1 & -3 & -2 \\ -5 & 9 & 1 \end{bmatrix}, \quad \mathbf{u} = \begin{bmatrix} 5 \\ 3 \\ -2 \end{bmatrix}
```
``` math
A \mathbf{u} = \begin{bmatrix} 1 & -3 & -2 \\ -5 & 9 & 1 \end{bmatrix} \begin{bmatrix} 5 \\ 3 \\ -2 \end{bmatrix} = \begin{bmatrix} 5 - 9 + 4 \\ -25 + 27 - 2 \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix}
```
So $`\mathbf{u} \in \mathbf{N}(A)`$.

#### Example

Find the null space of $`A = \begin{bmatrix} 1 & 2 \\ 3 & 6 \end{bmatrix}`$.\
Performing row operations on augmented matrix to reach RREF,
``` math
\begin{bmatrix} 1 & 2 & \big| & 0 \\ 3 & 6 & \big| & 0 \end{bmatrix} \implies \begin{bmatrix} 1 & 2 & \big| & 0 \\ 0 & 0 & \big| & 0 \end{bmatrix}
```
``` math
x_1 + 2x_2 = 0 \implies x_1 = -2x_2 \implies \mathbf{x} = \begin{bmatrix} x_1 \\ x_2 \end{bmatrix} = \begin{bmatrix} -2x_2 \\ x_2 \end{bmatrix} = x_2 \begin{bmatrix} -2 \\ 1 \end{bmatrix}
```
So $`\mathbf{N}(A)`$ spans the line defined by all multiples of the vector $`\begin{bmatrix} -2 \\ 1 \end{bmatrix}`$.

#### Example

Find a spanning set for the null space of the $`3 \times 5`$ matrix
``` math
A = \begin{bmatrix} -3 & 6 & -1 & 1 & -7 \\ 1 & -2 & 2 & 3 & -1 \\ 2 & -4 & 5 & 8 & -4 \end{bmatrix}
```
Performing elimination on augmented matrix $`[A \quad 0]`$ to reach RREF, we get
``` math
\begin{bmatrix} 1 & -2 & 0 & -1 & 3 & \big| & 0 \\ 0 & 0 & 1 & 2 & -2 & \big| & 0 \\ 0 & 0 & 0 & 0 & 0 & \big| & 0 \end{bmatrix}
```
Expressing the pivots in terms of free variables,
``` math
x_1 = 2x_2 + x_4 - 3x_5, \quad x_3 = -2x_4 + 2x_5
```
Finally expressing the solution vector as a linear combination where the weights are the free variables,
``` math
\begin{bmatrix} x_1 \\ x_2 \\ x_3 \\ x_4 \\ x_5 \end{bmatrix} = \begin{bmatrix} 2x_2 + x_4 - 3x_5 \\ x_2 \\ -2x_4 + x_5 \\ x_4 \\ x_5 \end{bmatrix} = x_2 \begin{bmatrix} 2 \\ 1 \\ 0 \\ 0 \\ 0 \end{bmatrix} + x_4 \begin{bmatrix} 1 \\ 0 \\ -2 \\ 1 \\ 0 \end{bmatrix} + x_5 \begin{bmatrix} -3 \\ 0 \\ 2 \\ 0 \\ 1 \end{bmatrix} = x_2\mathbf{u} + x_4\mathbf{v} + x_5\mathbf{w}
```
Every linear combination of $`\mathbf{u}`$, $`\mathbf{v}`$, $`\mathbf{w}`$ is an element of $`\mathbf{N}(A)`$. Thus $`\{\mathbf{u}, \mathbf{v}, \mathbf{w}\}`$ form the spanning set for $`\mathbf{N}(A)`$.

## The Column Space of a Matrix

The column space of an $`m \times n`$ matrix $`A`$ is the set of all possible linear combinations of the columns of $`A`$. If $`A = [\mathbf{a}_1 \cdots \mathbf{a}_n]`$, then
``` math
\mathbf{C}(A) = Span\{\mathbf{a}_1, \dots, \mathbf{a}_n\}
```
Alternatively, it can be defined as the set of all vectors $`\mathbf{b}`$ that can be produced by multiplying $`A`$ with some vector $`\mathbf{x}`$ in $`\mathbb{R}^n`$: $`\mathbf{C}(A) = \{\mathbf{b} : \mathbf{b} = A\mathbf{x} \text{ for some } \mathbf{x} \text{ in } \mathbb{R}^n\}`$.

#### Theorem

The column space of an $`m \times n`$ matrix $`A`$ is a valid subspace of $`\mathbb{R}^m`$.\
*Proof.* Each of $`\mathbf{a}_1, \dots, \mathbf{a}_n`$ has $`m`$ entries, so they are vectors in $`\mathbb{R}^m`$. By earlier theorem, $`\mathbf{C}(A)`$ is the span of some vectors in $`\mathbb{R}^m`$, so $`\mathbf{C}(A)`$ is a subspace of $`\mathbb{R}^m`$.

**Connection to consistency** Considering the equation $`A\mathbf{x}=\mathbf{b}`$, if it has a solution, it means that $`\mathbf{b}`$ can be expressed as linear combination of columns of $`A`$, with the entries of $`\mathbf{x}`$ as the weights.

- A system $`A\mathbf{x} = \mathbf{b}`$ is consistent if and only if the target vector $`\mathbf{b}`$ exists within the column space $`\mathbf{C}(A)`$. If $`\mathbf{b}`$ lies outside the span of the columns of $`A`$, no combination of those columns can reach it, meaning no solution $`\mathbf{x}`$ exists, and the system is inconsistent.

- If the columns of $`A`$ span the entirety of $`\mathbb{R}^m`$ (meaning $`\mathbf{C}(A) = \mathbb{R}^m`$), then every conceivable vector $`\mathbf{b}`$ is reachable. In this case, $`A\mathbf{x} = \mathbf{b}`$ has a solution for every possible $`\mathbf{b}`$ in $`\mathbb{R}^m`$.

For a $`m \times n`$ matrix $`A`$,

<div class="table-wrap">

| **Feature** | **Null Space $`\mathbf{N}(A)`$** | **Column Space $`\mathbf{C}(A)`$** |
|:---|:---|:---|
| **Space** | $`\mathbf{N}(A)`$ is a subspace of $`\mathbb{R}^n`$. | $`\mathbf{C}(A)`$ is a subspace of $`\mathbb{R}^m`$. |
| **Definition Style** | $`\mathbf{N}(A)`$ is implicitly defined; that is, you are given only a condition ($`A\mathbf{x}=\mathbf{0}`$) that vectors in $`\mathbf{N}(A)`$ must satisfy. | $`\mathbf{C}(A)`$ is explicitly defined; that is, you are told how to build vectors in $`\mathbf{C}(A)`$. |
| **Finding Vectors** | It takes time to find vectors in $`\mathbf{N}(A)`$. Row operations on $`[A \quad \mathbf{0}]`$ are required. | It is easy to find vectors in $`\mathbf{C}(A)`$. The columns of $`A`$ are displayed; others are formed from them. |
| **Relation to Matrix $`A`$** | There is no obvious relation between $`\mathbf{N}(A)`$ and the entries in $`A`$. | There is an obvious relation between $`\mathbf{C}(A)`$ and the entries in $`A`$, since each column of $`A`$ is in $`\mathbf{C}(A)`$. |
| **Checking a Specific Vector $`v`$** | A typical vector $`\mathbf{v}`$ in $`\mathbf{N}(A)`$ has the property that $`A\mathbf{v}=0`$. Given a specific vector $`\mathbf{v}`$, it is easy to tell if $`\mathbf{v}`$ is in $`\mathbf{N}(A)`$. Just compute $`A\mathbf{v}`$. | A typical vector $`\mathbf{v}`$ in $`\mathbf{C}(A)`$ has the property that the equation $`A\mathbf{x}=\mathbf{v}`$ is consistent. Given a specific vector $`\mathbf{v}`$, it may take time to tell if $`\mathbf{v}`$ is in $`\mathbf{C}(A)`$. Row operations on $`[A \quad \mathbf{v}]`$ are required. |
| **Mapping Conditions** | $`\mathbf{N}(A) = \{\mathbf{0}\}`$ if and only if the equation $`A\mathbf{x}=\mathbf{0}`$ has only the trivial solution. This happens if and only if the linear transformation $`\mathbf{x} \mapsto A\mathbf{x}`$ is one-to-one. | $`\mathbf{C}(A) = \mathbb{R}^m`$ if and only if the equation $`A\mathbf{x}=\mathbf{b}`$ has a solution for every $`\mathbf{b}`$ in $`\mathbb{R}^m`$. This happens if and only if the linear transformation $`\mathbf{x} \mapsto A\mathbf{x}`$ maps $`\mathbb{R}^n`$ onto $`\mathbb{R}^m`$. |

Comparison: Null Space vs. Column Space {#tab:nul_vs_col}

</div>

#### Example

``` math
A = \begin{bmatrix} 2 & 4 & -2 & 1 \\ -2 & -5 & 7 & 3 \\ 3 & 7 & -8 & 6 \end{bmatrix}
```

1.  If the column space of A is a subspace of $`\mathbb{R}^k`$, what is $`k`$?

    - $`k = 3`$. Because $`A`$ has 3 rows, each column vector contains exactly 3 entries. Therefore, the columns are vectors in $`\mathbb{R}^3`$, making $`C(A)`$ a subspace of $`\mathbb{R}^3`$.

2.  If the null space of A is a subspace of $`\mathbb{R}^k`$, what is $`k`$?

    - $`k = 4`$. The null space $`N(A)`$ consists of all vectors $`\mathbf{x}`$ such that $`A\mathbf{x} = \mathbf{0}`$. Because $`A`$ has 4 columns, the vector $`x`$ must have 4 entries for the matrix multiplication to be defined. Therefore, $`\mathbf{x}`$ is a vector in $`\mathbb{R}^4`$, making $`N(A)`$ a subspace of $`\mathbb{R}^4`$.

3.  Find a nonzero vector in $`C(A)`$ and a nonzero vector in $`N(A)`$.

    1.  Select any column directly from matrix A. Choosing the first column gives the vector $`\begin{bmatrix} 2 \\ -2 \\ 3 \end{bmatrix}`$.

    2.  We must find a vector $`\mathbf{x}`$ that satisfies $`A\mathbf{x} = \mathbf{0}`$. We set up the augmented matrix $`[A \quad 0]`$ and perform row reduction:
        ``` math
        \begin{bmatrix} 2 & 4 & -2 & 1 & 0 \\ -2 & -5 & 7 & 3 & 0 \\ 3 & 7 & -8 & 6 & 0 \end{bmatrix} \sim \begin{bmatrix} 1 & 2 & -1 & 0.5 & 0 \\ 0 & -1 & 5 & 4 & 0 \\ 0 & 0 & 0 & 8.5 & 0 \end{bmatrix}
        ```
        We get $`x_4 = 0`$, $`x_2 = 5x_3`$, $`x_1 = -9x_3`$. Hence $`\mathbf{x} = \begin{bmatrix} -9 \\ 5 \\ 1 \\ 0 \end{bmatrix}`$ is a valid nonzero vector in $`N(A)`$.

4.  Given $`\mathbf{u} = \begin{bmatrix} 3 \\ -2 \\ -1 \\ 0 \end{bmatrix}`$ and $`\mathbf{v} = \begin{bmatrix} 3 \\ -1 \\ 3 \end{bmatrix}`$,

    1.  Determine if $`\mathbf{u}`$ is in $`\mathbf{N}(A)`$. Could $`\mathbf{u}`$ be in $`\mathbf{C}(A)`$?\
        ``` math
        A\mathbf{u} = \begin{bmatrix} 2 & 4 & -2 & 1 \\ -2 & -5 & 7 & 3 \\ 3 & 7 & -8 & 6 \end{bmatrix} \begin{bmatrix} 3 \\ -2 \\ -1 \\ 0 \end{bmatrix} = \begin{bmatrix} 6 - 8 + 2 + 0 \\ -6 + 10 - 7 + 0 \\ 9 - 14 + 8 + 0 \end{bmatrix} = \begin{bmatrix} 0 \\ -3 \\ 3 \end{bmatrix}
        ```
        Since $`A\mathbf{u} \neq 0`$, the vector $`\mathbf{u}`$ is not in $`\mathbf{N}(A)`$.\
        The vector $`\mathbf{u}`$ has 4 entries ($`\mathbb{R}^4`$), but $`\mathbf{C}(A)`$ is strictly a subspace of $`\mathbb{R}^3`$, so $`\mathbf{u}`$ cannot be in $`\mathbf{C}(A)`$.

    2.  Determine if $`\mathbf{v}`$ is in $`\mathbf{C}(A)`$. Could $`\mathbf{v}`$ be in $`\mathbf{N}(A)`$?\
        Set up the augmented matrix $`[A \quad \mathbf{v}]`$ and row reduce it:
        ``` math
        \begin{bmatrix} 2 & 4 & -2 & 1 & 3 \\ -2 & -5 & 7 & 3 & -1 \\ 3 & 7 & -8 & 6 & 3 \end{bmatrix} \sim \dots \sim \begin{bmatrix} 1 & 2 & -1 & 0.5 & 1.5 \\ 0 & -1 & 5 & 4 & 2 \\ 0 & 0 & 0 & 8.5 & 0.5 \end{bmatrix}
        ```
        The system is consistent, so $`\mathbf{v}`$ is in $`\mathbf{C}(A)`$.\
        The vector $`\mathbf{v}`$ has 3 entries ($`\mathbb{R}^3`$), but $`\mathbf{N}(A)`$ is strictly a subspace of $`\mathbb{R}^4`$, so $`\mathbf{v}`$ cannot be in $`\mathbf{N}(A)`$.

## Kernel and Range of a Linear Transformation

**Defining a Linear Transformation** A linear transformation $`T`$ from a vector space $`V`$ to a vector space $`W`$ is a rule that assigns every vector $`\mathbf{x}`$ in $`V`$ to a unique vector $`T(\mathbf{x})`$ in $`W`$. It must sastify:

1.  Addition: $`T(\mathbf{u}+\mathbf{v}) = T(\mathbf{u}) + T(\mathbf{v})`$ for all vectors $`\mathbf{u}`$ and $`\mathbf{v}`$ in $`V`$.

2.  Scalar Multiplication: $`T(c\mathbf{u}) = cT(\mathbf{u})`$ for all vectors $`\mathbf{u}`$ in $`V`$ and all scalars $`c`$.

The **kernel** (or null space) of $`T`$ is the set of all $`\mathbf{u}`$ in $`V`$ such that $`T(\mathbf{u}) = \mathbf{0}`$ (zero vector in $`W`$).\
The **range** of $`T`$ is the set of vectors in $`W`$ of the form $`T(\mathbf{x})`$ for some $`\mathbf{x}`$ in $`V`$.\
Defining linear transformation as matrix multiplication of the form $`T(\mathbf{x}) = A\mathbf{x}`$, the kernel is the null space $`\mathbf{N}(A)`$ and the range is the column space $`\mathbf{C}(A)`$.

## Bases

#### Recall Linear Independence

An indexed set of vectors $`\{\mathbf{v}_{1},...,\mathbf{v}_{p}\}`$ in a vector space $`V`$ is considered linearly independent if the vector equation $`x_{1}\mathbf{v}_{1}+x_{2}\mathbf{v}_{2}+\cdot\cdot\cdot+x_{p}\mathbf{v}_{p}=\mathbf{0}`$ has only the trivial solution.\
Conversely, the set is linearly dependent if there are specific weights $`c_{1},...,c_{p}`$ (where not all of them are zero) that make the equation $`c_{1}\mathbf{v}_{1}+c_{2}\mathbf{v}_{2}+\cdot\cdot\cdot+c_{p}\mathbf{v}_{p}=\mathbf{0}`$ true.\
Some quick checks for independence:

- A set with only a single vector $`\mathbf{v}`$ is linearly independent if and only if $`\mathbf{v}\ne\mathbf{0}`$.

- A set containing exactly two vectors is linearly dependent if and only if one vector is a scalar multiple of the other.

- Any set that contains the zero vector is automatically linearly dependent.

#### Theorem

An indexed set $`\{\mathbf{v}_{1},\ldots,\mathbf{v}_{p}\}`$ consisting of two or more vectors (where $`\mathbf{v}_{1}\ne\mathbf{0}`$) is linearly dependent if and only if some vector $`\mathbf{v}_{j}`$ in the set is a linear combination of the vectors that precede it ($`\mathbf{v}_{1},\ldots,\mathbf{v}_{j-1}`$).

#### Basis

A basis is a set of vectors that acts as a foundational coordinate system for a vector space, and is the smallest spanning set for some space.\
Let $`H`$ be a subspace of a vector space $`V`$. An indexed set of vectors $`\mathcal{B}=\{\mathbf{b}_{1},\ldots,\mathbf{b}_{p}\}`$ in $`V`$ is defined as a basis for $`H`$ if it satisfies two strict conditions:

1.  **Linear Independence**: The set $`\mathcal{B}`$ must be linearly independent. (There are no redundant vectors.)

2.  **Spanning**: The subspace that is spanned by $`\mathcal{B}`$ must exactly coincide with $`H`$, meaning $`H=Span\{\mathbf{b}_{1},...,\mathbf{b}_{p}\}`$.

Every vector space is a subspace of itself, so the basis of $`V`$ is simply a linearly independent set that completely spans $`V`$.\
Some common bases:

- **Invertible Matrices**: For an invertible matrix $`A=[\begin{matrix}\mathbf{a}_{1}&\cdot\cdot\cdot&\mathbf{a}_{n}\end{matrix}]`$, its columns automatically form a basis for $`\mathbb{R}^{n}`$. (Invertible $`\implies`$ pivot in every row and column $`\implies`$ columns are linearly independent and span $`\mathbb{R}^{n}`$.)

- The columns of the $`n\times n`$ identity matrix $`I_{n}`$ form the most fundamental basis for $`\mathbb{R}^{n}`$.

- **The Standard Basis for** $`\mathbb{P}_{n}`$: For the vector space of polynomials of degree $`n`$, the standard basis is the set $`S=\{1,t,t^{2},...,t^{n}\}`$.\
  *Proof.* Verify the 2 conditions for a basis:

  1.  Spanning: By definition, every polynomial in the space $`\mathbb{P}_{n}`$ takes the form $`p(t) = c_{0}(1) + c_{1}(t) + c_{2}(t^{2}) + \dots + c_{n}(t^{n})`$. Because every polynomial can explicitly be written as a linear combination of the vectors in $`S`$, the set $`S`$ spans $`\mathbb{P}_{n}`$.

  2.  Linear Independence: Set the linear combination equal to the zero polynomial: $`c_{0}(1) + c_{1}(t) + c_{2}(t^{2}) + \dots + c_{n}(t^{n}) = 0`$ for all $`t`$. The fundamental theorem of algebra tells us that a non-zero polynomial of degree $`n`$ can have at most $`n`$ roots. The only way this polynomial equation can equal zero for infinite values of $`t`$ is if every single coefficient is exactly zero ($`c_{0} = c_{1} = \dots = c_{n} = 0`$). Since only the trivial solution exists, $`S`$ is linearly independent.

#### Example

Let $`\mathbf{v}_{1}=\left[\begin{matrix}3\\ 0\\ -6\end{matrix}\right]`$, $`\mathbf{v}_{2}=\left[\begin{matrix}-4\\ 1\\ 7\end{matrix}\right]`$, and $`\mathbf{v}_{3}=\left[\begin{matrix}-2\\ 1\\ 5\end{matrix}\right]`$. Determine if $`\{\mathbf{v}_{1},\mathbf{v}_{2},\mathbf{v}_{3}\}`$ is a basis for $`\mathbb{R}^{3}`$.
``` math
A = \begin{bmatrix} 3 & -4 & -2 \\ 0 & 1 & 1 \\ -6 & 7 & 5 \end{bmatrix} \implies \begin{bmatrix} 3 & -4 & -2 \\ 0 & 1 & 1 \\ 0 & 0 & 2 \end{bmatrix}
```
There are 3 pivots, hence the columns are linearly independent, and span $`\mathbb{R}^3`$, so the set is a basis for $`\mathbb{R}^3`$.

## Spanning Set Theorem

A set of vectors may span a subspace, but it may contain redundant vectors. How do we trim a spanning set into only the necessary vectors?

#### Theorem

The Spanning Set Theorem Let $`S=\{\mathbf{v}_{1},\ldots,\mathbf{v}_{p}\}`$ be a set of vectors in a vector space $`V`$, and let $`H=Span\{\mathbf{v}_{1},...,\mathbf{v}_{p}\}`$.

1.  **Removing redundant vectors**: If one vector $`\mathbf{v}_k`$ in $`S`$ is a linear combination of the others, then removing $`v_{k}`$ still yields a spanning set for $`H`$.

2.  **Extracting the basis**: If $`H\ne\{\mathbf{0}\}`$, some subset of $`S`$ will form a basis for $`H`$.

**Note** There are infinitely many different possible bases for a vector space. But, every possible basis for some vector space will always have the same number of vectors. For example, In $`\mathbb{R}^2`$, every valid basis must contain exactly 2 vectors. In $`\mathbb{R}^3`$, every valid basis must contain exactly 3 vectors. If a subspace $`H`$ has a basis of 4 vectors, then every other basis you can possibly find for $`H`$ will also have exactly 4 vectors.

#### Example

Let $`\mathbf{v}_{1}=\begin{bmatrix}0\\ 2\\ -1\end{bmatrix}`$, $`\mathbf{v}_{2}=\begin{bmatrix}2\\ 2\\ 0\end{bmatrix}`$ and $`\mathbf{v}_{3}=\begin{bmatrix}6\\ 16\\ -5\end{bmatrix}`$, and let $`H=Span\{\mathbf{v}_{1},\mathbf{v}_{2},\mathbf{v}_{3}\}`$. Note that $`\mathbf{v}_{3}=5\mathbf{v}_{1}+3\mathbf{v}_{2}`$.

1.  $`Span\{\textbf{v}_{1},\textbf{v}_{2},\textbf{v}_{3}\}=Span\{\textbf{v}_{1},\textbf{v}_{2}\}`$.\
    For any vector $`\mathbf{x}`$ in $`H`$,
    ``` math
    \textbf{x} = c_{1}\textbf{v}_{1} + c_{2}\textbf{v}_{2} + c_{3}\textbf{v}_{3} = c_{1}\textbf{v}_{1} + c_{2}\textbf{v}_{2} + c_{3}(5\textbf{v}_{1} + 3\textbf{v}_{2}) = (c_{1} + 5c_{3})\textbf{v}_{1} + (c_{2} + 3c_{3})\textbf{v}_{2}
    ```

2.  Find a basis for the subspace $`H`$.\
    We know that $`\{\mathbf{v}_1,\mathbf{v}_2\}`$ spans $`H`$. Checking for linear indpendence, there is no scalar $`c`$ such that $`c\begin{bmatrix}0\\ 2\\ -1\end{bmatrix} = \begin{bmatrix}2\\ 2\\ 0\end{bmatrix}`$. Hence $`\{\mathbf{v}_1,\mathbf{v}_2\}`$ forms a basis for $`H`$.

Note that $`H`$ is a two-dimensional subspace, in a 3-dimensional parent vector space.

## Bases for $`\mathbf{N}(A)`$ and $`\mathbf{C}(A)`$

#### Finding a basis for the null space $`\mathbf{N}(A)`$

We want the exact set of vectors that describe every possible solution to the homogeneous equation $`A\textbf{x} = \textbf{0}`$.

1.  Set up the augmented matrix $`[A \quad \textbf{0}]`$.

2.  Row reduce to RREF to identify the pivots and free variables.

3.  Express basic variables in terms of free variables.

4.  Express the generic solution vector $`\mathbf{x}`$ in Parametric Vector Form, and the vectors attached to the free variables form the basis for $`\mathbf{N}(A)`$.

#### Example

Imagine after row reducing $`A\textbf{x} = \textbf{0}`$, we get the equations: $`x_1 = 2x_2 - 5x_4`$ and $`x_3 = 3x_4`$. Here, $`x_2`$ and $`x_4`$ are free variables.
``` math
\textbf{x} = \begin{bmatrix} x_1 \\ x_2 \\ x_3 \\ x_4 \end{bmatrix} = \begin{bmatrix} 2x_2 - 5x_4 \\ x_2 \\ 3x_4 \\ x_4 \end{bmatrix} = x_2 \begin{bmatrix} 2 \\ 1 \\ 0 \\ 0 \end{bmatrix} + x_4 \begin{bmatrix} -5 \\ 0 \\ 3 \\ 1 \end{bmatrix} = x_2\textbf{u} + x_4\textbf{v}
```
Note the 1s and 0s in the second and fourth position of $`\mathbf{u}`$ and $`\mathbf{v}`$, guaranteeing they are independent.\
$`\{\mathbf{u}, \mathbf{v}\}`$ is independent and spans the solution space, so they form the basis for $`\mathbf{N}(A)`$.

#### Finding a basis for the column space $`\mathbf{C}(A)`$

$`\mathbf{C}(A)`$ is the span of all the columns of matrix $`A`$, so they are definitely a spanning set. But all the columns may not form a basis, because some columns may be linearly dependent (redundant).

1.  Row reduce the original matrix $`A`$ to REF or RREF.

2.  Identify the pivot columns.

3.  Extract the corresponding columns from the ORIGINAL matrix to get the basis for $`A`$. (Row operations alter the column space.)

Row operations alter the columns themselves and hence the column space, so we must take the columns from original matrix as the basis. However, row operations preserve the relationships between the columns. Non-pivot columns are linear combinations of the original pivot columns. By the Spanning Set Theorem, we can ignore the non-pivot columns. The original pivot columns are linearly indepedent and span the space, forming the basis for $`\mathbf{C}(A)`$.

#### Example

Find the basis for the column space for
``` math
A = \begin{bmatrix} 1 & 3 & 3 & 2 \\ 2 & 6 & 9 & 5 \\ -1 & -3 & 3 & 0 \end{bmatrix}
```
Row reducing to echelon form matrix $`B`$,
``` math
B = \begin{bmatrix} 1 & 3 & 3 & 2 \\ 0 & 0 & 3 & 1 \\ 0 & 0 & 0 & 0 \end{bmatrix}
```
The pivots are located in Column 1 and Column 3. Note that Column 2 is just 3 times Column 1, and Column 4 is a combination of Columns 1 and 3. Extracting pivot columns from $`A`$,
``` math
\textbf{a}_{1} = \begin{bmatrix} 1 \\ 2 \\ -1 \end{bmatrix}, \quad \textbf{a}_{3} = \begin{bmatrix} 3 \\ 9 \\ 3 \end{bmatrix}
```
The basis for $`C(A)`$ is the set $`\{\textbf{a}_{1}, \textbf{a}_{3}\}`$. Note that the basis is a 2-dimensional subspace of $`\mathbb{R}^3`$.

## Coordinate Systems

Let $`\mathcal{B} = \{\mathbf{b}_{1}, \dots, \mathbf{b}_{n}\}`$ be a basis for a vector space $`V`$. Because a basis spans the space and is linearly independent, for each vector $`\mathbf{x}`$ in $`V`$, there exists a unique set of scalars $`c_{1}, \dots, c_{n}`$ such that:
``` math
\mathbf{x} = c_{1}\mathbf{b}_{1} + \dots + c_{n}\mathbf{b}_{n}
```
These weights $`c_{1}, \dots, c_{n}`$ are the coordinates of $`\mathbf{x}`$ relative to the basis $`\mathcal{B}`$ (or the $`\mathcal{B}`$-coordinates of $`\mathbf{x}`$).\
When we stack these weights into a column vector, it is called the coordinate vector of $`\mathbf{x}`$ relative to $`\mathcal{B}`$, denoted as $`[\mathbf{x}]_{\mathcal{B}}`$.
``` math
[\mathbf{x}]_{\mathcal{B}} = \begin{bmatrix} c_{1} \\ \vdots \\ c_{n} \end{bmatrix}
```
If we place the basis vectors into the columns of a matrix, we get $`P_{\mathcal{B}} = \begin{bmatrix} \mathbf{b}_{1} & \cdots & \mathbf{b}_{n} \end{bmatrix}`$. This matrix changes the $`\mathcal{B}`$-coordinates of a vector $`\mathbf{x}`$ into the standard coordinates of $`\mathbf{x}`$, by this equation:
``` math
\mathbf{x} = P_{\mathcal{B}}[\mathbf{x}]_{\mathcal{B}}
```
Because the columns of $`P_{\mathcal{B}}`$ form a basis for $`\mathbb{R}^{n}`$, they are linearly independent, which means $`P_{\mathcal{B}}`$ is an invertible matrix. Hence we also have
``` math
P_{\mathcal{B}}^{-1}x = [x]_{\mathcal{B}}
```
The mapping $`x \mapsto [x]_{\mathcal{B}}`$ is a one-to-one linear transformation from $`V`$ onto $`\mathbb{R}^n`$.\
Since this mapping preserves vector addition and scalar multiplication,
``` math
[c_{1}\mathbf{u}_{1} + \dots + c_{p}\mathbf{u}_{p}]_{\mathcal{B}} = c_{1}[\mathbf{u}_{1}]_{\mathcal{B}} + \dots + c_{p}[\mathbf{u}_{p}]_{\mathcal{B}}
```
i.e. the $`\mathcal{B}`$-coordinate vector of a linear combination of vectors is the exact same linear combination of their coordinate vectors.

#### Example

Given a basis $`\mathcal{B} = \{b_1, b_2\}`$ for $`\mathbb{R}^2`$, where $`b_1 = \begin{bmatrix} 1 \\ 0 \end{bmatrix}`$ and $`b_2 = \begin{bmatrix} 1 \\ 2 \end{bmatrix}`$.\
A vector $`\mathbf{x}`$ has the coordinate vector $`[\mathbf{x}]_{\mathcal{B}} = \begin{bmatrix} -2 \\ 3 \end{bmatrix}`$. Find the standard vector $`\mathbf{x}`$.
``` math
x = -2\begin{bmatrix} 1 \\ 0 \end{bmatrix} + 3\begin{bmatrix} 1 \\ 2 \end{bmatrix} = \begin{bmatrix} -2 \\ 0 \end{bmatrix} + \begin{bmatrix} 3 \\ 6 \end{bmatrix} = \begin{bmatrix} 1 \\ 6 \end{bmatrix}
```

#### Example

Given a basis $`\mathcal{B} = \{\mathbf{b}_1, \mathbf{b}_2\}`$, $`\mathbf{b}_1 = \begin{bmatrix} 2 \\ 1 \end{bmatrix}`$, $`\mathbf{b}_2 = \begin{bmatrix} -1 \\ 1 \end{bmatrix}`$.\
We have a vector $`\mathbf{x}`$ with standard vector coordinates $`\begin{bmatrix} 4 \\ 5 \end{bmatrix}`$.\
Find the coordinate vector $`[\mathbf{x}]_{\mathcal{B}}`$ of $`\mathbf{x}`$ relative to the basis $`\mathcal{B}`$, i.e. find $`c_1`$ and $`c_2`$ such that $`c_1\mathbf{b}_1 + c_2\mathbf{b}_2 = \mathbf{x}`$.
``` math
\begin{bmatrix} 2 & -1 \\ 1 & 1 \end{bmatrix}\begin{bmatrix} c_1 \\ c_2 \end{bmatrix} = \begin{bmatrix} 4 \\ 5 \end{bmatrix}
```
Solving, we get $`[x]_{\mathcal{B}} = \begin{bmatrix} 3 \\ 2 \end{bmatrix}`$.

## Dimension of a Vector Space

For a vector space $`V`$ spanned by a basis, the dimension of $`V`$ (or $`\dim V`$), is simply the number of vectors in that basis.\
$`\dim \{\mathbf{0}\} = 0`$, because there are no linearly independent vectors to form a basis.\
$`\dim \mathbb{R}^{n} = n`$, because the standard basis for $`\mathbb{R}^{n}`$ consists of the columns of the $`n \times n`$ identity matrix ($`e_{1}, e_{2}, \dots, e_{n}`$).\
$`\dim \mathbb{P}_{n} = n + 1`$, because the standard basis is $`\{1, t, \ldots, t^n\}`$.\
In $`\mathbb{R}^3`$, a 0-D space is a point, a 1-D space is a line, a 2-D space is a plane, and a 3-D space is the entire $`\mathbb{R}^3`$.

#### Example

Find the dimension of the subspace $`H = \left\{ \begin{bmatrix} a - 3b + 6c \\ 5a + 4d \\ b - 2c - d \\ 5d \end{bmatrix} : a, b, c, d \text{ in } \mathbb{R} \right\}`$.
``` math
\begin{bmatrix} a - 3b + 6c \\ 5a + 4d \\ b - 2c - d \\ 5d \end{bmatrix} = a \begin{bmatrix} 1 \\ 5 \\ 0 \\ 0 \end{bmatrix} + b \begin{bmatrix} -3 \\ 0 \\ 1 \\ 0 \end{bmatrix} + c \begin{bmatrix} 6 \\ 0 \\ -2 \\ 0 \end{bmatrix} + d \begin{bmatrix} 0 \\ 4 \\ -1 \\ 5 \end{bmatrix}
```
We can see that $`\mathbf{v}_3 = -2\mathbf{v}_2`$, hence the basis is $`\{\mathbf{v}_{1}, \mathbf{v}_{2}, \mathbf{v}_{4}\}`$. Therefore, $`\dim H = 3`$.

## Dimensions of $`\mathbf{C}(A)`$ and $`\mathbf{N}(A)`$

The column space of $`A`$ is the span of all its columns. To find a basis for $`\mathbf{C}(A)`$, we row reduce $`A`$ to find the pivot columns, and $`\dim \mathbf{C}(A) =`$ the number of pivot columns in $`A`$.\
The null space of $`A`$ is the set of all vectors $`\mathbf{x}`$ that satisfy the homogeneous equation $`Ax = 0`$. To find a basis for $`\mathbf{N}(A)`$, we row reduce $`A`$, express the basic variables in terms of the free variables, and express the solution in parametric vector form:
``` math
x = x_{2}\mathbf{v}_{1} + \mathbf{x}_{4}\mathbf{v}_{2} + \dots
```
Notice that every free variable in the system produces exactly one basis vector ($`\mathbf{v}_{1}, \mathbf{v}_{2}`$, etc.) in the parametric vector form. Therefore, $`\dim \mathbf{N}(A) =`$ to the number of free variables in the equation $`A\mathbf{x} = \mathbf{0}`$.

#### Example

Find the dimension of $`\mathbf{C}(A)`$ and $`\mathbf{N}(A)`$ for
``` math
A = \begin{bmatrix} -3 & 6 & -1 & 1 & -7 \\ 1 & -2 & 2 & 3 & -1 \\ 2 & -4 & 5 & 8 & -4 \end{bmatrix}
```
The echelon form of the augmented matrix $`[A \quad \mathbf{0}]`$ is
``` math
\begin{bmatrix} 1 & -2 & 2 & 3 & -1 & 0 \\ 0 & 0 & 1 & 2 & -2 & 0 \\ 0 & 0 & 0 & 0 & 0 & 0 \end{bmatrix}
```
There are 3 free variables, so $`\dim \mathbf{N}(A) = 3`$ and there are 2 pivot columns, so $`\dim \mathbf{C}(A) = 2`$.

## Row Space

The row space of a matrix $`A`$ is the set of all linear combinations of the rows (or row vectors) of $`A`$.\
The row space is formally $`\mathbf{C}(A^T)`$, since the rows of a matrix $`A`$ are simply the columns of its transpose, $`A^T`$.\
For an $`m \times n`$ matrix, each row vector contains exactly $`n`$ entries. Consequently, the row space $`C(A^T)`$ is a subspace living in $`\mathbb{R}^n`$. (Contrast this with the column space, $`C(A)`$, which lives in $`\mathbb{R}^m`$).

#### Theorem

If two matrices $`A`$ and $`B`$ are row equivalent (can be transformed into the other using EROs), then their row spaces are identical.\
Row operations alter the row vectors, but they do not change the span of those rows. Therefore, if we reduce a matrix $`A`$ to an echelon form matrix $`B`$, the non-zero rows of $`B`$ form a basis for the row space of $`A`$ (and also $`B`$).

#### Example

Find bases for the row space, column space, and null space of matrix $`A`$:
``` math
A = \begin{bmatrix} -2 & -5 & 8 & 0 & -17 \\ 1 & 3 & -5 & 1 & 5 \\ 3 & 11 & -19 & 7 & 1 \\ 1 & 7 & -13 & 5 & -3 \end{bmatrix}
```
First, reduce $`A`$ to echelon form matrix $`B`$:
``` math
A \sim B = \begin{bmatrix} 1 & 3 & -5 & 1 & 5 \\ 0 & 1 & -2 & 2 & -7 \\ 0 & 0 & 0 & -4 & 20 \\ 0 & 0 & 0 & 0 & 0 \end{bmatrix}
```

1.  Basis for $`\mathbf{C}(A^T) = \{(1, 3, -5, 1, 5),\: (0, 1, -2, 2, -7),\: (0, 0, 0, -4, 20)\}`$\
    Note that we use the rows of $`B`$, not $`A`$.

2.  Basis for $`\mathbf{C}(A) = \left\{ \begin{bmatrix} -2 \\ 1 \\ 3 \\ 1 \end{bmatrix},\: \begin{bmatrix} -5 \\ 3 \\ 11 \\ 7 \end{bmatrix},\: \begin{bmatrix} 0 \\ 1 \\ 7 \\ 5 \end{bmatrix} \right\}`$\
    Note that we identify the pivot columns using $`B`$, but use the columns of $`A`$ as the basis, since EROs do change the column space.

We reduce $`B`$ further to RREF matrix $`C`$:
``` math
B \sim C = \begin{bmatrix} 1 & 0 & 1 & 0 & 1 \\ 0 & 1 & -2 & 0 & 3 \\ 0 & 0 & 0 & 1 & -5 \\ 0 & 0 & 0 & 0 & 0 \end{bmatrix}
```
We extract the equations and express the basic variables in terms of the free variables $`\mathbf{x}_3`$ and $`\mathbf{x}_5`$, then decompose the general solution into parametric vector form.\
Hence basis for $`\mathbf{N}(A) = \left\{ \begin{bmatrix} -1 \\ 2 \\ 1 \\ 0 \\ 0 \end{bmatrix}, \begin{bmatrix} -1 \\ -3 \\ 0 \\ 5 \\ 1 \end{bmatrix} \right\}`$

## Rank

The rank of matrix $`A`$ is the dimension of $`\mathbf{C}(A)`$.\
Recall that the equation $`Ax = \mathbf{b}`$ is only consistent when $`\mathbf{b}`$ is in the column space of $`A`$. Therefore, the rank of $`A`$ represents the exact dimension of the set of all vectors $`\mathbf{b}`$ that make the system consistent.\
**Implication**: If you have an $`n \times n`$ matrix $`A`$ with a rank of $`p`$, the transformation $`\mathbf{x} \mapsto A\mathbf{x}`$ takes vectors from an $`n`$-dimensional space and maps them into a $`p`$-dimensional space.

For an $`m \times n`$ matrix $`A`$, $`\dim \mathbf{C}(A) = \dim \mathbf{C}(A^T)`$. A matrix has the exact same number of linearly independent rows as it does linearly independent columns. (because they are both defined by the number of pivots.)

#### Example

Considering this matrix $`A`$ and row reducing it to REF form:
``` math
A = \begin{bmatrix} -2 & -5 & 8 & 0 & -17 \\ 1 & 3 & -5 & 1 & 5 \\ 3 & 11 & -19 & 7 & 1 \\ 1 & 7 & -13 & 5 & -3 \end{bmatrix} \sim B = \begin{bmatrix} 1 & 3 & -5 & 1 & 5 \\ 0 & 1 & -2 & 2 & -7 \\ 0 & 0 & 0 & -4 & 20 \\ 0 & 0 & 0 & 0 & 0 \end{bmatrix}
```
The rank of $`A`$ is 3 since there are 3 pivot columns. The basis for the row space of $`A`$ is formed by the rows in $`B`$ that contain those exact same pivots.

#### Theorem

The Rank Theorem: If matrix $`A`$ has $`n`$ columns, then
``` math
\text{rank of } A + \dim \mathbf{N}(A) = n
```
(Because rank of $`A`$ is $`\dim \mathbf{C}(A)`$, i.e. the number of pivot columns, and $`\dim \mathbf{N}(A)`$ is the number of free variables, i.e. the number of non-pivot columns.)\
This links the solutions of $`A\mathbf{x}=\mathbf{0}`$, i.e. $`\mathbf{N}(A)`$, to the vectors $`\mathbf{b}`$ that make $`A\mathbf{x}=\mathbf{b}`$ consistent, i.e. $`\mathbf{C}(A)`$.

#### Example

There is a homogeneous system of 40 equations in 42 variables. Someone has found two linearly independent solutions that span $`N(A)`$. Can we be certain that an associated nonhomogeneous system (with the same coefficients) will definitely have a solution?\
We have a $`40 \times 42`$ matrix $`A`$. The two solutions form a basis for $`\mathbf{N}(A)`$, so $`\dim \mathbf{N}(A) = 2`$.\
By the Rank Theorem, the rank of $`A`$ or $`\dim \mathbf{C}(A) = 42 - 2 = 40`$.\
The column space is a subspace of $`\mathbb{R}^{40}`$ (vectors with 40 rows). Since we know its dimension is 40, we know that $`\mathbf{C}(A)`$ spans the entirety of $`\mathbb{R}^{40}`$. Hence, every possible vector $`\mathbf{b} \in \mathbb{R}^{40}`$ is in $`\mathbf{C}(A)`$ and every non-homogeneous equation $`A\mathbf{x} = \mathbf{b}`$ is guaranteed to have a solution.

#### Expanding the Invertible Matrix Theorem

For an $`n \times n`$ matrix $`A`$, the following statements are logically equivalent to the statement "$`A`$ is invertible":

1.  The columns of $`A`$ form a basis for $`\mathbb{R}^{n}`$.

2.  $`\mathbf{C}(A) = \mathbb{R}^{n}`$.

3.  $`\dim \mathbf{C}(A) = n`$.

4.  Rank of $`A = n`$.

5.  $`\mathbf{N}(A) = \{\mathbf{0}\}`$.

6.  $`\dim \mathbf{N}(A) = 0`$.

## Change of bases

Earlier, we saw how to translate a vector’s coordinates between a custom basis ($`\mathcal{B}`$) and the standard basis ($`\mathcal{E}`$) using the matrix $`P_{\mathcal{B}}`$.\
We can bypass the standard basis entirely if we want translate coordinates in some basis $`\mathcal{B}`$ to another basis $`\mathcal{C}`$. (i.e. we are looking at the same point in space, but changing how the grid lines are drawn.)\
We can build a change of coordinates matrix from $`\mathcal{B}`$ to $`\mathcal{C}`$, i.e. $`P_{\mathcal{C}\leftarrow\mathcal{B}}`$.\
**How to build it**: We need to know how to express the $`\mathcal{B}`$ basis vectors ($`\mathbf{b}_1, \dots, \mathbf{b}_n`$) in terms of $`\mathcal{C}`$-coordinates. Then,\
``` math
P_{\mathcal{C}\leftarrow\mathcal{B}} = \begin{bmatrix} [\mathbf{b}_1]_{\mathcal{C}} & [\mathbf{b}_2]_{\mathcal{C}} & \dots & [\mathbf{b}_n]_{\mathcal{C}} \end{bmatrix}
```
With this matrix, we can translate any vector $`\mathbf{x}`$ by matrix multiplication:
``` math
[\mathbf{x}]_{\mathcal{C}} = P_{\mathcal{C}\leftarrow\mathcal{B}} \cdot [\mathbf{x}]_{\mathcal{B}}
```

#### Example

We have a vector space with two different bases, $`\mathcal{B} = \{b_1, b_2\}`$ and $`\mathcal{C} = \{c_1, c_2\}`$, and are given a vector $`\mathbf{x}`$ whose coordinates in the $`\mathcal{B}`$ system are $`[x]_{\mathcal{B}} = \begin{bmatrix} 3 \\ 1 \end{bmatrix}`$.\
Also, $`[\mathbf{b}_1]_{\mathcal{C}} = \begin{bmatrix} 4 \\ 1 \end{bmatrix}`$ and $`[\mathbf{b}_2]_{\mathcal{C}} = \begin{bmatrix} -6 \\ 1 \end{bmatrix}`$. Find $`[\mathbf{x}]_{\mathcal{C}}`$.\
Building the change of coordinates of matrix,
``` math
P_{\mathcal{C}\leftarrow\mathcal{B}} = \begin{bmatrix} 4 & -6 \\ 1 & 1 \end{bmatrix}
```
Performing matrix multiplication,
``` math
[x]_{\mathcal{C}} = \begin{bmatrix} 4 & -6 \\ 1 & 1 \end{bmatrix} \begin{bmatrix} 3 \\ 1 \end{bmatrix} = \begin{bmatrix} 6 \\ 4 \end{bmatrix}
```
Alternatively, we know that $`[\mathbf{x}]_{\mathcal{B}} = \begin{bmatrix} 3 \\ 1 \end{bmatrix} \implies \mathbf{x} = 3\mathbf{b}_1 + 1\mathbf{b}_2`$.\
Applying the $`\mathcal{C}`$-coordinate mapping to the whole equation,
``` math
\begin{align*}
    [\mathbf{x}]_{\mathcal{C}} &= [3\mathbf{b}_1 + \mathbf{b}_2]_{\mathcal{C}} \\
    &= 3[\mathbf{b}_1]_{\mathcal{C}} + [\mathbf{b}_2]_{\mathcal{C}} \\
\end{align*}
```

**Invertibility of $`P`$**: Because both $`\mathcal{B}`$ and $`\mathcal{C}`$ are valid bases, their vectors are linearly independent. This means that the change of coordinates matrix $`P_{\mathcal{C}\leftarrow\mathcal{B}}`$ is always invertible.
``` math
P_{\mathcal{B}\leftarrow\mathcal{C}} = (P_{\mathcal{C}\leftarrow\mathcal{B}})^{-1}
```

**Alternative to calculating $`P`$**: If we are not directly given the $`\mathcal{C}`$-coordinates of the $`\mathcal{B}`$ basis vectors (like $`[b_1]_{\mathcal{C}}`$), then we need both bases expressed in a common coordinate system (likely the standard $`\mathbb{R}^n`$ vectors).\
We set up an augmented matrix with the target basis $`\mathcal{C}`$ and the starting basis $`\mathcal{C}`$:
``` math
\left[ \begin{array}{c|c} \mathcal{C} & \mathcal{B} \end{array} \right]
```
Then perform row reduction until we get $`I`$ on the left:
``` math
\left[ \begin{array}{c|c} I & P_{\mathcal{C}\leftarrow\mathcal{B}} \end{array} \right]
```

#### Example

We have\

- $`\mathcal{B} = \{b_1, b_2\}`$ where $`b_1 = \begin{bmatrix} 2 \\ 5 \end{bmatrix}`$ and $`b_2 = \begin{bmatrix} 1 \\ 4 \end{bmatrix}`$

- $`\mathcal{C} = \{c_1, c_2\}`$ where $`c_1 = \begin{bmatrix} 1 \\ 2 \end{bmatrix}`$ and $`c_2 = \begin{bmatrix} 1 \\ 3 \end{bmatrix}`$

Set up the augmented matrix:
``` math
\left[ \begin{array}{cc|cc} 1 & 1 & 2 & 1 \\ 2 & 3 & 5 & 4 \end{array} \right] \sim \left[ \begin{array}{cc|cc} 1 & 0 & 1 & -1 \\ 0 & 1 & 1 & 2 \end{array} \right]
```
Hence
``` math
P_{\mathcal{C}\leftarrow\mathcal{B}} = \begin{bmatrix} 1 & -1 \\ 1 & 2 \end{bmatrix}
```
