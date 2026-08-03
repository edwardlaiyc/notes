# Determinants

## 10 Properties of Determinants

For square matrices,

1.  $`|I|=1`$ for any $`n\times n`$ identiy matrix $`I`$.

2.  Determinant changes sign when two rows or two columns are exchanged.
    ``` math
    \begin{vmatrix} a & b \\ c & d \end{vmatrix} = - \begin{vmatrix} c & d \\ a & b \end{vmatrix} = - \begin{vmatrix} b & a \\ d & c \end{vmatrix}
    ```
    For permutation matrix $`P`$ involving $`r`$ row exchanges,
    ``` math
    |P| = 1 \text{ for even } r,\quad |P| = -1 \text{ for odd } r
    ```

3.  The determinant is a linear function of each row separately.\
    Scaling a single row of a matrix by $`t`$,
    ``` math
    \begin{vmatrix} ta & tb \\ c & d \end{vmatrix} = t \begin{vmatrix} a & b \\ c & d \end{vmatrix}
    ```
    Adding a row of one matrix to the corresponding row of another matrix,
    ``` math
    \begin{vmatrix} a+a^{\prime} & b+b^{\prime} \\ c & d \end{vmatrix} = \begin{vmatrix} a & b \\ c & d \end{vmatrix} + \begin{vmatrix} a^{\prime} & b^{\prime} \\ c & d \end{vmatrix}
    ```
    Note that the addition can only be distributed across a single row. The remaining rows in all the matrices involved must be unchanged. As a general rule,
    ``` math
    |A + B| \neq |A| + |B|
    ```

4.  If any 2 rows in matrix $`A`$ are equal, then $`|A|=0`$.
    ``` math
    \begin{vmatrix} a & b \\ a & b \\ c & d\end{vmatrix} = 0
    ```
    *Proof.* Swapping the 2 identical rows in $`A`$, the determinant is $`-|A|`$ (Property 2). However, the matrix $`A`$ did not change, so $`|A| = -|A| \implies |A|=0`$.\
    Note that this applies if two rows are scalar multiples of each other.
    ``` math
    \begin{vmatrix} a & b \\ ta & tb \end{vmatrix} = t \begin{vmatrix} a & b \\ a & b \end{vmatrix} = 0
    ```

5.  Adding/Subtracting a multiple of one row to another row does not change $`|A|`$.
    ``` math
    \begin{vmatrix} a & b \\ c-la & d-lb \end{vmatrix} = \begin{vmatrix} a & b \\ c & d \end{vmatrix}
    ```
    for $`l`$ a scalar.\
    *Proof.*
    ``` math
    \begin{align*}
            \begin{vmatrix} a & b \\ c-la & d-lb \end{vmatrix} &= \begin{vmatrix} a & b \\ c & d \end{vmatrix} + \begin{vmatrix} a & b \\ -la & -lb \end{vmatrix} \\
            &= \begin{vmatrix} a & b \\ c & d \end{vmatrix} - l \begin{vmatrix} a & b \\ a & b \end{vmatrix} \\
            &= \begin{vmatrix} a & b \\ c & d \end{vmatrix} - l(0)
    \end{align*}
    ```
    Note that when performing Gaussian elimination on $`A`$ to get $`U`$ (upper triangular; REF form), we either subtract/add multiples of one row to another (does not affect $`|A|`$), or swap rows (changes sign of $`|A|`$). Hence $`|A| = \pm |U|`$.\
    Note further that performing further elimination to RREF does change $`|A|`$, as we would have to scale rows (to make the pivots = 1).

6.  If matrix $`A`$ has a row of zeroes, $`|A|=0`$.
    ``` math
    \begin{vmatrix} 0 & 0 \\ c & d \end{vmatrix} = 0
    ```
    *Proof.*
    ``` math
    |A| = \begin{vmatrix} 0 & 0 \\ c & d \end{vmatrix} = \begin{vmatrix} 0 + c & 0 + d \\ c & d \end{vmatrix} = \begin{vmatrix} c & d \\ c & d \end{vmatrix} = 0
    ```

7.  If matrix $`A`$ is triangular, its determinant is simply the product of its main diagonal entries.
    ``` math
    |A| = a_{11}a_{22} \dots a_{nn}
    ```
    For purely diagonal matrix, each diagonal element can be factored out row by row until you are left with the identity matrix.
    ``` math
    \begin{vmatrix} a_{11} & 0 & 0 \\ 0 & a_{22} & 0 \\ 0 & 0 & a_{nn} \end{vmatrix} = a_{11} \begin{vmatrix} 1 & 0 & 0 \\ 0 & a_{22} & 0 \\ 0 & 0 & a_{nn} \end{vmatrix} = a_{11}a_{22} \dots a_{nn} \begin{vmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 1 \end{vmatrix}
    ```
    Since $`|I| = 1`$, then we get the result above.\
    For upper triangular matrix $`U`$,
    ``` math
    |U| = \begin{vmatrix} a & b \\ 0 & d \end{vmatrix}
    ```
    The off-diagonal entries can be made 0 by row elimination. For example, applying $`R_1 \leftarrow R_1 - \frac{b}{d}R_2`$ to $`U`$,
    ``` math
    |U| = \begin{vmatrix} a & 0 \\ 0 & d \end{vmatrix} = ad
    ```
    If any diagonal element $`a_{ii} = 0`$, the elimination process will produce an entire row of zeros. Following Property 6, this means the determinant is $`0`$, and the matrix is classified as singular.

8.  $`A`$ is singular $`\iff |A| = 0`$, and $`A`$ is invertible $`\iff |A| \neq 0`$.\
    If $`A`$ is singular, the elimination process produces $`U`$ with a row of zeroes $`\implies |U| = 0 \implies |A| = 0`$.\
    If $`A`$ is invertible, $`U`$ will have non-zero pivots along its entire main diagonal. From Rule 7, the product of these pivots is non-zero, hence $`|A| = \pm |U|`$.\
    For a $`2 \times 2`$ matrix, and $`a \neq 0`$,
    ``` math
    \begin{vmatrix} a & b \\ c & d \end{vmatrix} = \begin{vmatrix} a & b \\ 0 & d - (c/a)b \end{vmatrix} = a \times \left(d - \frac{cb}{a}\right) = ad - bc
    ```

9.  Determinant of product $`|AB| = |A||B|`$.\
    *Proof.* Consider the function $`D(A) = \frac{|AB|}{|B|}`$, if it passes these 3 rules, then $`D(A)`$ is a determinant.

    1.  Identity Matrix - If matrix $`A`$ is the identity matrix $`I`$, $`D(A) = \frac{|IB|}{|B|} = \frac{|B|}{|B|} = 1`$.

    2.  Row exchange - If two rows of $`A`$ are exchanged, those exact same corresponding rows are exchanged in $`AB`$. Since exchanging rows flips the sign of a determinant, so $`|AB|`$ changes sign. Hence $`D(A)`$ changes sign too.

    3.  Linearity - If one row of $`A`$ multiplied by a scalar $`t`$, that same row in $`AB`$ is also multiplied by $`t`$. So $`|AB|`$ and $`D(A)`$ is multiplied by $`t`$. The same linear behavior holds true when adding rows together.

    $`\therefore`$ $`\frac{|AB|}{|B|}`$ has the same properties that define $`|A|`$, and $`\frac{|AB|}{|B|} = |A|`$.\
    If $`B`$ is singular, then the product $`AB`$ is also singular. So $`|AB| = 0`$, and also $`|A||B| = 0`$, hence $`|AB| = |A||B|`$ still holds.

10. $`|A^T| = |A|`$. For a $`2 \times 2`$ matrix,
    ``` math
    \begin{vmatrix} a & b \\ c & d \end{vmatrix} = \begin{vmatrix} a & c \\ b & d \end{vmatrix} = ad - bc
    ```
    Because of this property, all the above properties apply to columns too. For example,

    - Swapping two columns changes sign of determinant.

    - Adding multiple of one column to another does not affect determinant.

    - Column of zeroes means determinant is 0.

## Determinants as Area/Volume

#### Theorem

For a $`2 \times 2`$ matrix $`A`$, abs($`|A|`$) is the area of the parallelogram formed by the columns of $`A`$.\
For a $`3 \times 3`$ matrix $`A`$, abs($`|A|`$) is the volume of the parallelepiped (a 3D slanted box) formed by the columns of $`A`$.\
*Proof.*\
Consider the $`2 \times 2`$ diagonal matrix,
``` math
A = \begin{bmatrix} a & 0 \\ 0 & d \end{bmatrix}
```
$`\begin{bmatrix} a \\ 0 \end{bmatrix}`$ represents a horizontal vector along the x-axis, $`\begin{bmatrix} 0 \\ d \end{bmatrix}`$ along the y-axis. These vectors are perpendicular, so the shape is a perfect rectangle.
``` math
abs \left( \begin{vmatrix} a & 0 \\ 0 & d \end{vmatrix} \right) = abs(ad) = \text{Area of rectangle}
```
To transform any $`2 \times 2`$ matrix $`A = [a_1\quad a_2]`$ into a diagonal matrix without changing the absolute value of the determinant,

1.  **Swapping 2 columns** - Flips the sign of $`|A|`$ but absolute value is unchanged.

2.  **2D Shear, Replacing column $`a_2`$ with $`a_2 + ca_1`$** - Imagine some line $`L`$ passing through the origin and vector $`a_1`$. Vector $`a_2`$ dictates the top of the parallelogram. The line $`a_2 + L`$ passes through $`a_2`$ and is perfectly parallel to $`L`$. If we add $`ca_1`$ to $`a_2`$, the new vector $`a_2 + ca_1`$ simply slides along that top parallel line $`a_2 + L`$. Because the base $`a_1`$ hasn’t changed, and the points $`a_2`$ and $`a_2 + ca_1`$ have the exact same perpendicular distance to $`L`$ (the height is identical), both parallelograms calculate to the exact same base $`\times`$ height. Therefore, their areas are perfectly equal and $`|A|`$ is unchanged.

Similarly, for the $`3\times 3`$ diagonal matrix,
``` math
A = \begin{bmatrix} a & 0 & 0 \\ 0 & b & 0 \\ 0 & 0 & c \end{bmatrix}
```
The volume of the standard rectangular box is just $`abs(|A|) = a \times b \times c`$.\
The same logic applies to transform any $`3 \times 3`$ matrix $`A = [a_1 \quad a_2 \quad a_3]`$.

- **3D Shear** - The volume of a 3D parallelepiped is calculated as the area of its base multiplied by its height. Let the base be the flat 2D plane formed by vectors $`a_1`$ and $`a_3`$, known mathematically as $`\text{Span}\{a_1, a_3\}`$. The height is determined by how far vector $`a_2`$ sticks out from that base plane. The tip of $`a_2`$ lives in a parallel plane defined as $`a_2 + \text{Span}\{a_1, a_3\}`$. If we alter the matrix by replacing $`a_2`$ with $`a_2 + ca_1`$, that new vector just slides around inside that top parallel plane. Since the vector only moves sideways within the parallel plane, any vector $`a_2 + ca_1`$ maintains the exact same perpendicular height as the original $`a_2`$. With the base area identical and the height unchanged, the total volume of the parallelepiped is perfectly preserved when $`\begin{bmatrix} a_1 & a_2 & a_3 \end{bmatrix}`$ is changed to $`\begin{bmatrix} a_1 & a_2 + ca_1 & a_3 \end{bmatrix}`$.

## Linear Transformations

#### Theorem

Let $`T:\mathbb{R}^2\to\mathbb{R}^2`$ be a linear transformation determined by a $`2 \times 2`$ matrix $`A`$. Then for any parallelogram $`S`$, the area of the transformed shape $`T(S) = abs(|A|) \times`$ area of $`S`$.\
**3D space**: For $`T`$ determined by a $`3 \times 3`$ matrix $`A`$, and $`S`$ a parallelepiped in $`\mathbb{R}^3`$, then volume of $`T(S) = abs(|A|) \times`$ volume of $`S`$.\
*Proof.* First, imagine a parallelogram $`S`$ anchored at the origin, formed by two vectors $`b_1`$ and $`b_2`$. We can put these vectors into their own matrix, $`B = \begin{bmatrix} b_1 & b_2 \end{bmatrix}`$. Applying the transformation matrix $`A`$ to this shape, the new transformed shape $`T(S)`$ is defined by the matrix product $`AB`$. The new area is $`abs(|AB|) = abs(|A||B|) = abs(|A|) \times abs(|B|) = abs(|A|) \times \text{area of } S`$.\
Then any arbitrary parallelogram can be written in the form $`\mathbf{p} + S`$, where $`\mathbf{p}`$ is a translation vector.
``` math
\begin{align*}
    \text{area of }T(\mathbf{p} + S) &= \text{area of }(T(\mathbf{p}) + T(S)) \\
    &= \text{area of} T(S) \\
    &= abs(|A|) \times \text{area of }S \\
    &= abs(|A|) \times \text{area of }\mathbf{p} + S
\end{align*}
```
The above proof is similar for $`3 \times 3`$ case.

**Expanding to Arbitrary Shapes**\
For example, stretching a unit circle to an ellipse.\
$`\mathbf{u} = \begin{bmatrix} u_1 \\ u_2 \end{bmatrix}`$, representing the coordinates of the points forming the original unit circle, satisfying the circle equation $`u_1^2 + u_2^2 = 1`$.\
Diagonal matrix $`A`$ represents the transformation that stretches the $`u_1`$ axis by $`a`$ and the $`u_2`$ axis by $`b`$,
``` math
A = \begin{bmatrix} a & 0 \\ 0 & b \end{bmatrix}
```
Multiplying $`\mathbf{x} = A\mathbf{u}`$, then $`x_1 = au_1`$ and $`x_2 = bu_2 \implies`$ $`u_1 = x_1/a`$ and $`u_2 = x_2/b`$. Thus we get the ellipse equation $`\frac{x_1^2}{a^2} + \frac{x_2^2}{b^2} = 1`$.\
As before, with $`D`$ representing the unit circle and $`T`$ the transformation,
``` math
\begin{align*}
    \text{area of ellipse} &= \text{area of }T(D) \\
    &= abs(|A|) \times \text{area of }D \\
    &= ab \times \pi 1^2 \\
    &= \pi ab
\end{align*}
```
