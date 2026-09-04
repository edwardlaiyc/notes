*[exponent][significand], where * is the sign bit, and S x RE, for significand S, radix R (binary:2, decimal:10, etc), exponent E.

![](images/floating-point-numbers-01.webp)

| Total bit size | Exponent bit size |
|---|---|
| 8 | 4 |
| 16 | 5 |
| 32 | 8 |

- Bias formula: 2k-1 - 1, for k exponent bits.
- After getting the exponent value, add bias before putting into exponent.
- Purpose: represent negative exponents.

From fixed point to floating point:

![](images/floating-point-numbers-02.webp)

For the same number of bits, floating-point can represent more values.

![](images/floating-point-numbers-03.webp)

**Advantage of floating-point:

- Given the same number of bits, floating-point can represent a wider range of values than fixed-point.
- Fixed-point multiplication may cause loss of significant bits

![](images/floating-point-numbers-04.webp)

**Disadvantage of floating-point:

- More complex.
- Less precise for larger numbers, because of the larger step size

![](images/floating-point-numbers-05.webp)
