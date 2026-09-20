## Definition

$$\text{With a sequence } \{a_k\}_{k=1}^{\infty},\text{ we can form the } n\text{th partial sum }S_n = \sum_{k=1}^{n} a_k = a_1 + a_2 + \cdots + a_n.$$
$$\text{If } \lim_{n \to \infty} S_n \text{ exists, the series } \sum_{k=1}^{\infty} a_k \text{ converges.}$$

*Series is the sum of the terms of the sequence.

## Sum Law for Series

$$\sum_{k=1}^{\infty} (A a_k + B b_k)= A \sum_{k=1}^{\infty} a_k+ B \sum_{k=1}^{\infty} b_k \text{, if both series converge.}$$

If one diverges and one converges, the sum of them diverges.

If both diverge, no conclusion.

## Series of positive terms

$$\text{If } \{a_k\}_{k=1}^{\infty} \text{ is an increasing sequence, then }\lim_{k \to \infty} a_k \text{ exists } \Longleftrightarrow \{a_k\} \text{ is bounded.}$$

$$\text{If } f:[a,\infty) \to \mathbb{R} \text{ is continuous and increasing, then }\lim_{x \to +\infty} f(x) \text{ exists } \Longleftrightarrow f \text{ is bounded.}$$

$$\text{For } S_n = \sum_{k=1}^{\infty} a_k, \text{ and } a_k \ge 0 \text{ for } k=1,2,3,\ldots, \text{ then}$$

$$\sum_{k=1}^{\infty} a_k \text{ converges } \Leftrightarrow \ (S_n)_{n=1}^{\infty} \text{ is a bounded sequence.}$$

## Tests

### Limit Test

$$\text{If the series } \sum_{n=1}^{\infty} a_n \text{ converges, then } \lim_{n \to \infty} a_n = 0.$$

$$\text{Contrapositive: If } a_n \not\to 0, \text{ then the series } \sum_{n=1}^{\infty} a_n \text{ does not converge.}$$

### Integral test

$$\text{If } f:[1,\infty)\to\mathbb{R} \text{ is continuous, decreasing, and } \lim_{x\to +\infty} f(x)=0,\text{ then}$$

$$\sum_{k=1}^{\infty} f(k) \text{ converges } \Leftrightarrow \ \int_{1}^{+\infty} f(x)\,dx \text{ converges.}$$

### P-series

$$\sum_{n=1}^{\infty} \frac{1}{n^p} \text{ converges } \Leftrightarrow \ p > 1.$$

$$\text{Harmonic series } \sum_{n=1}^{\infty} \frac{1}{n} \text{ diverges.}$$

## For series with positive terms

### General comparison test

$$\text{If } 0 \le a_n \le C b_n, \text{ for some constant } C > 0 \text{ and any positive integers } n,\text{ then}$$

$$\text{if } \sum b_n \text{ converges, then } \sum a_n \text{ must also converge.}$$

$$\text{if } \sum a_n \text{ diverges, then } \sum b_n \text{ must also diverge.}$$

**terms must be non-negative

### Limit Comparison Test

$$\text{For } a_n \ge 0,\, b_n > 0 \text{ for all } n,\ \text{if } \lim_{n \to \infty} \frac{a_n}{b_n} = L,\ \text{where } L > 0,\ L \in \mathbb{R},$$

$$\text{then } \sum_{n=1}^{\infty} a_n \text{ and } \sum_{n=1}^{\infty} b_n \text{ either both converge or both diverge.}$$

### Ratio Test

$$\text{For } a_n > 0 \text{ for large } n, \text{ and } \lim_{n \to \infty} \left| \frac{a_{n+1}}{a_n} \right| = c,$$

$$\text{if } c > 1, \text{ then } \sum a_n \text{ diverges.}$$

$$\text{if } c < 1, \text{ then } \sum a_n \text{ converges.}$$

$$\text{if } c = 1, \text{ gives no information.}$$

### Root Test

$$\text{For } a_n \ge 0 \text{ for large } n, \text{ and } \lim_{n \to \infty} \sqrt[n]{a_n} = c,$$

$$\text{if } c > 1, \text{ then } \sum a_n \text{ diverges.}$$

$$\text{if } c < 1, \text{ then } \sum a_n \text{ converges.}$$

$$\text{if } c = 1, \text{ no information can be concluded.}$$

## For Series with both positive and negative terms

### Absolute convergence

$$\text{If } \sum_{n=1}^{\infty} |a_n| \text{ converges, then } \sum_{n=1}^{\infty} a_n \text{ converges absolutely.}$$

$$\text{If } \sum_{n=1}^{\infty} a_n \text{ converges absolutely, then it converges.}$$

**If the series converges absolutely, then any series obtained from it by rearranging its elements also converges to the same sum.

### Conditional convergence

$$\text{If } \sum_{n=1}^{\infty} a_n \text{ converges, but } \sum_{n=1}^{\infty} |a_n| \text{ does not, then } \sum_{n=1}^{\infty} a_n \text{ converges conditionally.}$$

Riemann’s Theorem

If a series converges conditionally, then we can rearrange its elements to make the sum any other number or even diverge.

*Reason*: The individual terms are small (the series converges), but the positive terms diverge and the negative terms diverge. Given any sum S, we can add positive terms to just exceed S, then subtract negative terms to just dip below S. Repeat forever and the sum settles to S as the terms get smaller.

Example (alternating harmonic series):

$$\sum_{n=1}^{\infty} \frac{(-1)^{n-1}}{n} = 1 - \frac{1}{2} + \frac{1}{3} - \frac{1}{4} + \frac{1}{5} - \cdots = \ln 2$$

Consider the rearrangement:

$$\text{Sum} = 1 - \frac{1}{2} - \frac{1}{4} + \frac{1}{3} - \frac{1}{6} - \frac{1}{8} + \frac{1}{5} - \frac{1}{10} - \frac{1}{12} + \cdots$$

$$= \left(1 - \frac{1}{2}\right) - \frac{1}{4} + \left(\frac{1}{3} - \frac{1}{6}\right) - \frac{1}{8} + \left(\frac{1}{5} - \frac{1}{10}\right) - \frac{1}{12} + \cdots$$

$$= \frac{1}{2} - \frac{1}{4} + \frac{1}{6} - \frac{1}{8} + \frac{1}{10} - \frac{1}{12} + \cdots$$

$$= \frac{1}{2} \left( 1 - \frac{1}{2} + \frac{1}{3} - \frac{1}{4} + \frac{1}{5} - \frac{1}{6} + \cdots \right)$$

$$= \frac{1}{2} \ln 2$$

### Leibniz’ Test for alternating series

$$\text{For an alternating series } \pm \sum_{n=1}^{\infty} (-1)^{n-1} b_n, \text{ where } b_n > 0,$$

$$\text{if } b_1 \ge b_2 \ge b_3 \ge \ldots \ge 0 \text{ and } \lim_{n \to \infty} b_n = 0,$$

$$\text{then } \sum_{n=1}^{\infty} (-1)^{n-1} b_n \text{ converges.}$$

$$\text{Alternating harmonic series }\sum_{n=1}^{\infty} \frac{(-1)^{n-1}}{n} \text{ converges conditionally}$$
