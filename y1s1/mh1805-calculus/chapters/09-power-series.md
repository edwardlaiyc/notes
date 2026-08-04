Purpose: Express complicated/abstract expressions into polynomials for easier calculations.

$$\text{Power series: }\sum_{n=0}^{\infty} a_n (x - c)^n = a_0 + a_1(x - c) + a_2(x - c)^2 + \ldots$$

Common examples (Maclaurin expansions):

$$\text{Geometric series: } \frac{1}{1 - x} = \sum_{n=0}^{\infty} x^n = 1 + x + x^2 + x^3 + \ldots, \text{ for } |x| < 1$$

$$\ln(1+x) = \sum_{n=1}^{\infty} (-1)^{n-1}\frac{x^n}{n} = x - \frac{x^2}{2} + \frac{x^3}{3} - \frac{x^4}{4} + \cdots,\quad x \in (-1,1].$$

$$-\ln(1 - x) = \sum_{n=1}^{\infty} \frac{x^n}{n} = x + \frac{x^2}{2} + \frac{x^3}{3} + \frac{x^4}{4} + \dots, \quad x \in [-1, 1).$$

    *can be derived from ln(1 + x).

$$e^x = \sum_{n=0}^{\infty} \frac{x^n}{n!} = 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \ldots,\quad x \in (-\infty, \infty).$$

$$\sin x = \sum_{n=0}^{\infty} (-1)^n \frac{x^{2n+1}}{(2n+1)!} = x - \frac{x^3}{3!} + \frac{x^5}{5!} - \ldots,\quad x \in (-\infty, \infty).$$

$$\cos x = \frac{d}{dx}(\sin x) = \sum_{n=0}^{\infty} (-1)^n \frac{x^{2n}}{(2n)!} = 1 - \frac{x^2}{2!} + \frac{x^4}{4!} - \ldots,\quad x \in (-\infty, \infty).$$

    *can be derived by differentiating sinx.

$$\tan^{-1} x = \sum_{n=0}^{\infty} (-1)^n \frac{x^{2n+1}}{2n+1} = x - \frac{x^3}{3} + \frac{x^5}{5} - \dots, \quad x \in [-1, 1].$$

    *can be derived from geometric series by integrating 1/(1 + x2).

## Convergence

$$\text{For the power series } \sum_{n=0}^{\infty} a_n (x - c)^n:$$

3 scenarios

$$1.\ \text{Only converges at } x = c \ [\text{Series }= a_0 + 0 + 0 + \ldots].$$

$$2.\ \text{Converges for all } x \in \mathbb{R}.$$

$$3.\ \text{Converges when } |x - c| < R \text{ and diverges when } |x - c| > R, \text{ for some } R > 0.$$

### Case3

$$\text{If } \sum_{n=0}^{\infty} a_n (x - c)^n \text{ converges for some } x = x_0 \neq c,$$
$$\text{then } \sum_{n=0}^{\infty} a_n (x - c)^n \text{ converges absolutely for smaller width } |x - c| < |x_0 - c|.$$

$$\text{Radius of convergence is } R,$$

possible intervals of convergence are:

$$(c - R,\, c + R), (c - R,\, c + R], [c - R,\, c + R), [c - R,\, c + R].$$

$$\text{Convergence at endpoints } x = c \pm R \text{ must be determined separately.}$$

## Differentiation, integration

$$\text{If } f \text{ is convergent on } (c - R,\, c + R),$$

$$\text{then } \frac{d}{dx}f(x) = \sum_{n=0}^{\infty} n a_n (x - c)^{n - 1} \text{and } \int f(x)\,dx = \sum_{n=0}^{\infty} \frac{a_n}{n + 1}(x - c)^{n + 1} + C$$

$$\text{both have the same interval of convergence } (c - R,\, c + R).$$

Differentiation and integration does not affect the radius of convergence.

AT ENDPOINTS, differentiation may lose convergence, integration may gain convergence.

## Abel’s Theorem

A power series is continuous on its interval of convergence.

→ we can find the power series of some function by first differentiating/integrating it.

→ If we find that the series converges at the endpoints x=R of its interval of convergence, we can conclude that the function is continuous at x=R too.

### Example (series to function)

We found the series

$$\frac{x^2}{2} - \frac{x^3}{3 \cdot 2} + \frac{x^4}{4 \cdot 3} - \frac{x^5}{5 \cdot 4} + \dots = \sum_{n=2}^{\infty} (-1)^n \frac{x^n}{n(n-1)} = x \ln(1+x) - x + \ln(1+x),$$

$$\text{by integrating } \ln(1 + x) = \sum_{n=1}{\infty} (-1)^{n-1} \frac{x^n}{n}, \text{for } x \in (-1, 1].$$

$$\text{We should check endpoint }x = -1 \text{ for convergence.}$$

The interval of convergence would be $x \in [-1,1]$.

However, the expression is undefined for $x = -1$.

So using Abel's Theorem, by continuity,

$$f(-1) = \lim_{x \to -1^+} f(x) = \lim_{x \to -1} (x \ln(1+x) - x + \ln(1+x)) = \lim_{x \to -1} ((1+x) \ln(1+x) - x).$$

We get $f(-1) = 1$.

Example (function to series)

We show that

$$\ln(1 + x) = \sum_{k = 1}^{\infty} (-1)^{k-1} \frac{x^k}{k}$$

$$\text{by integrating } \frac{1}{1 - x} = \sum_{k=0}^{\infty} x^k, \text{for } x \in (-1, 1)$$

$$\text{Although we may gain convergence at endpoints, } \ln(1 + x) \text{ is undefined for } x = -1.$$

$$\text{So we only need to check for }x = 1.$$

## Determining interval of convergence and sum of series given some series

Tests

- Ratio test
- Root test
- Comparison test / LCT for the endpoints
- Absolute convergence / alternating series test for the endpoints
- Usually if we already found the sum of our series by comparing to a known series, we can use the radius of convergence of the known series, but we need to separately find the convergence at the endpoints.

Sum

- Compare with the known functions
   - Geometric series
   - ln(1 + x) / -ln(1 - x)
   - ex
   - sinx / cosx
- Differentiation / integration (differentiation may lose convergence at endpoints, integration may gain)
- For series with constant term, try abstracting out for x.

E.g. $\sum_{n=1}^{\infty} \frac{n}{5^n}.$
