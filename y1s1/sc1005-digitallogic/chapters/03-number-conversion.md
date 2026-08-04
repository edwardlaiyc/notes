![](images/number-conversion-01.png)

** For 2n-digit fixed-point decimal value, with n-digit integer part and n-digit fractional part, what is the minimum number of bits needed to represent in unsigned fixed-point binary?

- Integer part: for k bits and n digits, we need 2k - 1 >= 10n - 1.
- Fractional part: for f bits and n digits, we need 2-f <= 10-n. (Step size of binary value <= step size of decimal value)
- Binary: base-2
- Octal: base-8
- Hexadecimal: base-16

BCD

Gray code: only one bit changes at at time, for one cycle it is less error prone compared to straight coded binary. When more bits change at once, it can cause brief mismatches leading to wrong intermediate states, breaking the cycle.

![](images/number-conversion-02.png)

ASCII code: 7-bit code. N-digit decimal number requires 7N-bits in ASCII.

Converting ASCII to hex:

![](images/number-conversion-03.png)
