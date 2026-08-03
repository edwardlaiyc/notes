# Computer Arithmetic

Carry = 1 if ’1’ bit gets carried out of MSB. Indicates error in unsigned no. system.\
V = 1 if

- **A+B**, MSB(A) = MSB(B) $`\neq`$ MSB(Result)

- **A-B**, MSB(A) $`\neq`$ MSB(B) and MSB(Result) $`\neq`$ MSB(A)

**Sign extension**: copy MSB to all the higher bits.\
**Multi-precision arithmetic**: add the lower 32-bit words, then ADC the upper 32-bit words.\
**Range of 2’s comp** = $`-2^{N-1}`$ to $`2^{N-1}-1`$\
**Fixed point**

- Precision = value of LSB (smallest fractional value)

- $`2^3\,2^2\,2^1\,2^0\,.\,2^{-1}\,2^{-2}\,2^{-3}\,2^{-4}`$, precision is $`2^{-4}`$.

- Precision is fixed and uniform throughout the range.

- For a fixed number of bits, allocating more bits for the integer part (increase range) will reduce the precision.

**Floating point**

- 32-bit: 1 (Sign), 8 (exponent, $`E`$), 23 (fraction, $`F`$), bias = 127

- 64-bit: 1 (Sign), 11 (exponent, $`E`$), 52 (fraction, $`F`$), bias = 1023

- Format: $`(-1)^S \times (1.F)_2 \times 2^{E - \text{Bias}}`$

- E.g. 1 00001100 010100....0 $`\equiv`$ $`-1.3125\times 2^{-115}`$

- Normalised mode

  - Maintain a non-zero digit (1) before the radix point.

  - Exponent range: 0000 0001 to 1111 1110

  - Smallest magnitude: X 0000 0001 0000....0 $`\equiv`$ $`1 \times 2^{-126}`$

  - Largest magnitude: X 1111 1110 1111 ....1 $`\equiv`$ $`\approx 2 \times 2^{127} = 2^{128}`$

  - Underflow: numbers between $`-2^{126}`$ to $`2^{126}`$, i.e. values close to zero that cannot be represented.

**Fixed vs floating pt (32-bit)**

- Max range (fixed) = $`2^{32}`$ (no fractional part)

- Max range (floating) = $`2*2^{128}`$ ($`-2^{128}`$ to $`\sim 2^{128}`$)

- Max precision (fixed) = $`2^{-32}`$ (no integer part)

- Max precision (floating, near to 0) = less than $`2^{-126}`$

- Floating point has higher range and better precision at small numbers, but very coarse precision at the 2 ends of the range. Floating point provides uniform precision across entire range.

**More stuff**

- Arithmetic between numbers with huge diff in magnitude: add/subtract numbers of similar smaller magnitude first, to allow their magnitude to be closer to the bigger magnitudes.

- To preserve precision AMAP, do division last, as division truncates LSB and loses bits.
