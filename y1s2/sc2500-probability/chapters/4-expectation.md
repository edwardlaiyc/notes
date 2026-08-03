# Expectation

For a random variable $`X`$, the expectation is
``` math
\text{Discrete: } \mathbb{E}[X]=\sum_xxp_X(x)
```
``` math
\text{Continuous: } \mathbb{E}[X]=\int_{-\infty}^{\infty}xf_X(x)\:\mathrm{d}x
```
where $`p_X(x)`$ is the probability mass function (PMF) and $`f_X(x)`$ is the probability density function (PDF).

The expectation is the weighted average of all possible outcomes, where the weight is the probability of that outcome happening.

For a function $`g:\mathbb{R}\rightarrow\mathbb{R}`$, the expectation of $`g(X)`$ is
``` math
\text{Discrete: } \mathbb{E}[g(X)]=\sum_xg(x)p_X(x)
```
``` math
\text{Continuous: } \mathbb{E}[g(X)]=\int_{-\infty}^{\infty}g(x)f_X(x)\:\mathrm{d}x
```
**Example** $`X`$ is the outcome of a fair coin flip, $`X(H)=1`$, $`X(T)=0`$.\
For a function $`g(X)=(X+2)^2`$, $`g(1)=9`$, $`g(0)=4`$.\
Then $`\mathbb{E}[g(X)]=(9\times0.5) + (4\times0.5)=6.5`$.

**Properties** For a constant $`c`$, we have that

1.  $`\mathbb{E}[c]=c`$\
    $`\because \mathbb{E}[c]=\sum_xc\cdot p_X(x)=c\cdot \sum_xp_X(x)=c \cdot 1=c`$

2.  $`\mathbb{E}[X+c]=\mathbb{E}[X]+c`$\
    $`\because \mathbb{E}[X+c]=\sum_x(x+c)p_X(x)=\sum_x(xp_X(x))+c(p_X(x))=\mathbb{E}[X]+c\cdot 1=\mathbb{E}[X]+c`$

3.  $`\mathbb{E}[cX]=c\mathbb{E}[X]`$\
    $`\because \mathbb{E}[cX]=\sum_x(cx)p_X(x)=c\cdot \sum_xxp_X(x)=c\cdot \mathbb{E}[X]`$

**Multivariate expectation**

For multiple random variables $`X,Y`$ and a function $`g:\mathbb{R}^2\rightarrow\mathbb{R}`$, the expectation is
``` math
\text{Discrete: }\mathbb{E}[g(X, Y)]=\sum_{x, y}g(x, y)p_{X, Y}(x, y)
```
``` math
\text{Continuous: }\mathbb{E}[g(X, Y)] = \int_{-\infty}^{\infty}\int_{-\infty}^{\infty}g(x, y)f_{X, Y}(x, y)\:\mathrm{d}x\:\mathrm{d}y
```

Similarly, for constants $`c_1`$, $`c_2`$,\
``` math
\mathbb{E}[c_1X+c_2Y] = c_1\mathbb{E}[X] + c_2\mathbb{E}[Y]
```
``` math
\begin{align*}
    \because \mathbb{E}[c_1X+c_2Y] &= \sum_x\sum_y(c_1x + c_2y)\cdot p_{X,Y}(x,y) \\
    &= \sum_x\sum_yc_1x\cdot p_{X,Y}(x,y) + \sum_x\sum_yc_2y\cdot p_{X,Y}(x,y) \\
    &= \sum_xc_1x(\sum_yp_{X,y}(x,y)) + \sum_yc_2y(\sum_xp_{X,Y}(x,y)) \\
    &= \sum_xc_1x\cdot p_X(x) + \sum_yc_2y\cdot p_Y(y) \\
    &= c_1\sum_xxp_X(x) + c_2\sum_yyp_Y(y) \\ 
    &= c_1\mathbb{E}[X] + c_2\mathbb{E}[Y]
\end{align*}
```

**Linearity of expectation** For any two random variables $`X`$ and $`Y`$,
``` math
\mathbb{E}[X+Y] = \mathbb{E}[X] + \mathbb{E}[Y]
```
This rule holds true regardless of whether $`X`$ and $`Y`$ are independent or completely dependent. Dependency affects variance, but it never breaks the linearity of expectation.

1.  Independent scenario: flip two fair coins, let $`X=1`$ if Coin 1 = H, let $`Y=1`$ if Coin 2 = H.\
    $`\mathbb{E}[X] = 0.5`$ and $`\mathbb{E}[Y] = 0.5`$.\
    $`\mathbb{E}[X+Y] = (0 \times 0.25) + (1 \times 0.50) + (2 \times 0.25) = 1`$.

2.  Dependent scenario: Flip one fair coin, but count its result twice. Let $`X = 1`$ if the coin is Heads, and let $`Y = X`$.\
    $`\mathbb{E}[X] = 0.5`$ and $`\mathbb{E}[Y] = 0.5`$.\
    $`\mathbb{E}[X+Y] = (0 \times 0.50) + (2 \times 0.50) = 1`$.
