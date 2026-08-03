# Bayesian Regression

## Recap

### Bayes’ Rule

Bayes’ Rule (assuming $`P(B)>0`$):
``` math
P(A \mid B) = \frac{P(B \mid A)\, P(A)}{P(B)}
```

- The prior $`P(A)`$: Belief about $`A`$ before seeing $`B`$.

- The likelihood $`P(B|A)`$: If A true, how probable is the observed evidence $`B`$.

- The marginal likelihood $`P(B)`$: Total probability of observing $`B`$ across all scenarios. Acts as normalisation constant.

- The posterior $`P(A|B)`$: Updated belief about $`A`$ after seeing $`B`$.

The PDF version:
``` math
f(x \mid y) = \frac{f(y \mid x)\, f(x)}{f(y)}
```
where $`f(y) = \int f(y | x)f(x) \mathrm{d}x`$ is the normalising constant.\
The point is that in Bayesian inference and regression, we will use the form
``` math
\text{posterior} \propto \text{likelihood} \times \text{prior}
```
ignoring the normalisation constant.

### Unnormalised density functions

A PDF is defined as:
``` math
f(x) = \frac{g(x)}{Z}, \quad Z = \int g(x)\, dx
```
$`Z`$ is the normalising constant. If two functions $`g_1`$ and $`g_2`$ differ by only a constant, i.e. $`g_1 \propto g_2`$, then they define the exact same PDF.\
$`Z`$ is often intractable to compute, hence we can just write $`f \propto g`$ and work with the unnormalised form $`g`$.

#### Example

The full PDF of a 1D Gaussian $`\mathcal{N}(\mu, \sigma^2)`$ is
``` math
f(x) = \frac{1}{\sqrt{2\pi\sigma^2}} \exp\!\left(-\frac{(x-\mu)^2}{2\sigma^2}\right)
```
Expanding the square in the exponent:
``` math
f(x) \propto \exp\!\left(-\frac{1}{2\sigma^2}x^2 + \frac{\mu}{\sigma^2}x\right)
```
We dropped terms not involving $`x`$.\
Hence if we observe this quadratic form in the exponent, we know it’s Gaussian.

### Frequentist vs Bayesian

Frequentist approach treats Parameters like $`\mu`$ as fixed, unknown constants, wuth no distributions.\
MLE is frequentist approach. It finds the parameter that makes the observed data most probable.

#### Example

A factory produces products labeled 100g. The actual weight $`X`$ follows a Gaussian distribution with known variance 1, but unknown mean $`\mu`$. Three products are sampled with weights 99g, 110g, 107g. What is the best estimate of $`\mu`$?\
Given variance = 1 and the independent samples, the likelihood is
``` math
p(x_i \mid \mu) = \frac{1}{\sqrt{2\pi}} \exp\left(-\frac{(x_i - \mu)^2}{2}\right)
```
The joint likelihood of all observations is (by independence):
``` math
\mathcal{L}(\mu) = \prod_{i=1}^n p(x_i \mid \mu) = \prod_{i=1}^n \frac{1}{\sqrt{2\pi}} \exp\left(-\frac{(x_i - \mu)^2}{2}\right)
```
Taking the log-likelihood:
``` math
\log \mathcal{L}(\mu) = -\frac{n}{2}\log(2\pi) - \frac{1}{2}\sum_{i=1}^n (x_i - \mu)^2
```
Maximising this is equivalent to minimising $`\sum_{i=1}^n (x_i - \mu)^2`$:
``` math
\frac{d}{d\mu} \sum_{i=1}^n (x_i - \mu)^2 = -2\sum_{i=1}^n (x_i - \mu) = 0
```
``` math
\boxed{\hat{\mu}_n = \frac{1}{n}\sum_{i=1}^n x_i}
```
MLE says that the sample mean is the best estimate for $`\mu`$. However, this approach says nothing about our confidence in this estimate. Also, we cannot incorporate any prior knowledge we may have.\
\
Bayesian approach treats parameters as random variables with its own distribution. We can encode our prior beliefs about $`\mu`$ and then update those beliefs.\
Treating each observation as Gaussian around $`\mu`$, the likelihood is:
``` math
X_i \sim N(\mu, \sigma^2), \quad i = 1, 2, \ldots, n
```
Our prior Gaussian belief about $`\mu`$ before seeing data:
``` math
\mu \sim p(\mu) = N(\mu_0, \sigma_0^2)
```
Here $`\mu_0`$ is our prior best guess for $`\mu`$, and $`\sigma_0^2`$ is our uncertainty about that guess.\
Applying Bayes’ Rule,
``` math
p(\mu \mid x_1, \ldots, x_n) \propto \prod_{i=1}^n p(x_i \mid \mu)\, p(\mu)
```
This is the posterior, i.e. the update belief about $`\mu`$ after $`n`$ observations.\
The posterior is also Gaussian. Its parameters are
``` math
\boxed{\hat{\mu}_n = \frac{\sigma^2 \sigma_0^2}{n\sigma_0^2 + \sigma^2}\left(\frac{\sum_{i=1}^n x_i}{\sigma^2} + \frac{\mu_0}{\sigma_0^2}\right)}
```
``` math
\boxed{\hat{\sigma}_n^2 = \frac{\sigma^2 \sigma_0^2}{n\sigma_0^2 + \sigma^2}}
```
The posterior mean can be rewritten as
``` math
\hat{\mu}_n = \frac{n\sigma_0^2}{n\sigma_0^2 + \sigma^2}\bar{x} + \frac{\sigma^2}{n\sigma_0^2 + \sigma^2}\mu_0
```
where $`\bar{x} = \frac{1}{n}\Sigma x_i`$ is the MLE estimate. Note that this is just the weighted average of the MLE estimate and the prior mean. The weights depend on the relative uncertainty.\
If $`\sigma_0^2`$ is large, there is more weight on $`\bar{x}`$. If $`\sigma^2`$ is large, more weight on $`\mu_0`$. As $`n\to\infty`$, $`\hat{\mu}_n \to \bar{x}`$.\
The posterior variance $`\hat{\sigma}^2_n \to 0`$ as $`n \to \infty`$. Compared to MLE, where $`\hat{\sigma}^2_n = 0`$ always.

### Regression

Recall that Least Squares Method (LSM) finds a linear function of $`x`$ that best predicts $`y`$, given $`n`$ data points, each consisting of input $`x_i \in \mathbb{R}^d`$ and output $`y_i \in \mathbb{R}`$.\
Organising the inputs and outputs:
``` math
\mathbf{y} = (y_1, \ldots, y_n)^\top \in \mathbb{R}^n
```
``` math
\mathbf{X}^\top = (x_1, \ldots, x_n) \in \mathbb{R}^{d \times n}
```
We want a weight vector $`\mathbf{w} \in \mathbb{R}^d`$ such that $`\mathbf{Xw} \approx \mathbf{y}`$.\
LSM finds $`\mathbf{w}`$ by minimising the total squared error:
``` math
\hat{w} = \arg\min_{w \in \mathbb{R}^d} \|\mathbf{y} - \mathbf{X}w\|^2
```
By differentiating and setting to zero, we get
``` math
\boxed{\hat{w} = \hat{\Sigma}^{-1}\mathbf{X}^\top\mathbf{y}}
```
where $`\hat{\Sigma} = \mathbf{X}^T\mathbf{X}`$ and assuming it is invertible. This is the normal equation, the closed-form solution to least squares.\
If we use MLE by supposing the true relationship between $`x`$ and $`y`$ is linear and corrupted by Gaussian noise,
``` math
y = w^{*\top}x + \varepsilon, \quad \varepsilon \sim N(0, \sigma^2 I)
```
where $`w^* \in \mathbb{R}^d`$ is the true unknown weight vector.\
The output $`y`$ is Gaussian:
``` math
P(y \mid w, x) = N(w^\top x, \sigma^2 I)(y)
```
By MLE we will also get
``` math
\hat{w}_{\text{MLE}} = \hat{\Sigma}^{-1}\mathbf{X}^\top\mathbf{y}
```
The implication is that LSM has the same limitation as MLE. It just gives a single estimate without the uncertainty about the prediction. It also doesn’t incorporate prior beliefs. This leads into Bayesian Linear Regression which address these gaps.

## Bayesian Linear Regression

### 1-D case

Applying Bayesian inference to the regression setting. Start with 1-D inputs, $`x_i\in\mathbb{R}`$ and $`w\in\mathbb{R}`$.\
**Likelihood**: Each output is Gaussian around $`wx_i`$:
``` math
y_i \sim p(y_i \mid x_i, w) = N(wx_i, \sigma^2), \quad i = 1, 2, \ldots, n
```
**Prior**: Treat $`w`$ as a random variable with a Gaussian prior:
``` math
w \sim p(w) = N(0, \sigma_0^2)
```
The prior is centered at 0, encoding a belief that weights are small.\
**The posterior**: By Bayes’ Rule,
``` math
p(w \mid \mathbf{y}) \propto p(\mathbf{y} \mid w, \mathbf{X})\, p(w) = \prod_{i=1}^n p(y_i \mid x_i, w)\, p(w)
```
The result is that the posterior is Gaussian with
``` math
\begin{align*}
    \hat{\mu}_n &= \frac{1}{\sigma^2}\left(\frac{1}{\sigma_0^2} + \frac{1}{\sigma^2}\mathbf{X}^\top\mathbf{X}\right)^{-1}\mathbf{X}^\top\mathbf{y}\\
    &= \left(\frac{\sigma^2}{\sigma_0^2}I + \mathbf{X}^\top\mathbf{X}\right)^{-1}\mathbf{X}^\top\mathbf{y}
\end{align*}
```
``` math
\hat{\sigma}_n^2 = \left(\frac{1}{\sigma_0^2} + \frac{1}{\sigma^2}\mathbf{X}^\top\mathbf{X}\right)^{-1}
```
Comparing with ridge regression which solves $`\arg \min_w \|\mathbf{y} - \mathbf{X}w\|^2 + \lambda \|w\|^2`$, giving:
``` math
\hat{w}_{\text{ridge}} = \left(\lambda I + \mathbf{X}^\top\mathbf{X}\right)^{-1}\mathbf{X}^\top\mathbf{y}
```
Note that they are identical with $`\lambda = \frac{\sigma^2}{\sigma^2_0}`$. So the Gaussion prior $`\mathcal{N}(0,\sigma_0^2)`$ is mathematically equivalent to $`L_2`$ regularisation.

- Large $`\sigma^2`$ (noisy data): Large $`\lambda`$, pulls $`w`$ towards 0.

- Small $`\sigma_0^2`$ (strong prior): large $`\lambda`$.

- Large $`n`$, $`\mathbf{X}^T\mathbf{X} = \sum_{i=1}^n x_i x_i^\top`$ dominates, $`\lambda I`$ negligible, prior fades away.

$`\hat{\sigma}^2_n`$ represents the remaining uncertainty about $`w`$ after the observations. It shrinks as $`n`$ increases.\
Also, as $`\sigma_0^2 \to \infty`$ (no prior conviction), $`\frac{\sigma^2}{\sigma_0^2} \to 0`$ and $`\hat{\mu}_n \to \hat{w}_{\text{LSM}}`$. Hence LSM is just a special case of Bayesian regression with an infintely weak prior.

### Derivation

``` math
\begin{align*}
p(w|\mathbf{y}) &\propto p(w)p(\mathbf{y}|\mathbf{X}, w) \\
&\propto \exp\left(-\frac{1}{2\sigma_0^2}w^2 - \frac{1}{2\sigma^2}\sum_{i=1}^n(y_i - wx_i)^2\right) \\
&\propto \exp\left(-\frac{1}{2}S_n w^2 + \frac{1}{\sigma^2}\sum_{i=1}^n x_i y_i w\right), 
\qquad S_n = \frac{1}{\sigma_0^2} + \frac{\sum_{i=1}^n x_i^2}{\sigma^2} \\
&\propto \exp\left(-\frac{1}{2}S_n\left(w - \frac{S_n^{-1}}{\sigma^2}\sum_{i=1}^n x_i y_i\right)^2\right) 
\qquad \text{(completing the square)} \\
&\propto N(\hat{\mu}_n, \hat{\sigma}_n)
\end{align*}
```
$`S_n`$ collects the $`w^2`$ coefficients from both the prior and likelihood:
``` math
S_n = \frac{1}{\sigma_0^2} + \frac{\sum_{i=1}^n x_i^2}{\sigma^2} = \frac{1}{\sigma_0^2} + \frac{\mathbf{X}^\top\mathbf{X}}{\sigma^2}
```
Since a Gaussian has the form $`\exp (-\frac{1}{2\hat{\sigma}_n^2}(w - \hat{\mu}_n)^2)`$, by matching $`S_n = \frac{1}{\hat{\sigma}_n^2}`$ and reading off $`\hat{\mu}_n`$,
``` math
\hat{\mu}_n = \frac{1}{\sigma^2}\left(\frac{1}{\sigma_0^2} + \frac{1}{\sigma^2}\mathbf{X}^\top\mathbf{X}\right)^{-1}\mathbf{X}^\top\mathbf{y} = \left(\frac{\sigma^2}{\sigma_0^2}I + \mathbf{X}^\top\mathbf{X}\right)^{-1}\mathbf{X}^\top\mathbf{y}
```
``` math
\hat{\sigma}_n^2 = S_n^{-1} = \left(\frac{1}{\sigma_0^2} + \frac{1}{\sigma^2}\mathbf{X}^\top\mathbf{X}\right)^{-1}
```

### $`d`$-dimension case

For $`d`$ dimensions, scalars just become vectors and scalars.\
The likelihood and prior become:
``` math
y_i \sim N(w^\top x_i, \sigma^2 I), \quad w \sim N(\mathbf{0}, \sigma_0^2 I)
```
The posterior is a multivariate Gaussian.
``` math
\hat{\mu}_n = \frac{1}{\sigma^2}\left(\frac{1}{\sigma_0^2}I + \frac{1}{\sigma^2}\mathbf{X}^\top\mathbf{X}\right)^{-1}\mathbf{X}^\top\mathbf{y}
```
The variance $`\hat{\sigma}_n^2`$ becomes a covariance matrix $`\hat{\Sigma}_n`$:
``` math
\hat{\Sigma}_n = \left(\frac{1}{\sigma_0^2}I + \frac{1}{\sigma^2}\mathbf{X}^\top\mathbf{X}\right)^{-1}
```
Again, as $`n \to \infty`$, $`\frac{1}{\sigma^2}\mathbf{X}^T \mathbf{X}`$ dominates and $`\hat{\Sigma} \to 0`$. The uncertainty drops with more data.

## Predictive Distribution

So far Bayesian Linear Regression gives the posterior distribution over weights $`p(w | \mathbf{y})`$. But we want to make predictions for new inputs.\
Given a new input $`x`$, we want to know the distribution of its output $`y`$. This is the predictive distribution $`p(y | \mathbf{y}, x)`$ (probability of $`y`$ given all the training data).\
\
Here $`w`$ is a distribution, so every plausible value of $`w`$ gives a different prediction for $`y`$. We need to average over all of them, weighted by how probable each $`w`$ is:
``` math
p(y \mid \mathbf{y}, x) = \int p(y \mid w, x)\, p(w \mid \mathbf{y})\, dw
```
This is also called marginalising out $`w`$.\
Since both $`p(y | w,x) = \mathcal{N}(w^\top x, \sigma^2)`$ and $`p(w | \mathbf{y}) = \mathcal{N}(\hat{\mu}_n, \hat{\Sigma}_n)`$ are Gaussian, the result is Gaussian and can be computed as:
``` math
\boxed{p(y \mid \mathbf{y}, x) = N(\hat{\mu}_n^\top x,\ \sigma^2 + x^\top \hat{\Sigma}_n x)}
```

- Predictive mean $`\hat{\mu}^\top_n x`$: This is simply the posterior mean weights applied to the new input - the same as what LSM would give using $`\hat{w}^\top x`$. The best single prediction is unchanged.

- Predictive variance $`\sigma^2 + x^\top \hat{\Sigma}_n x`$:

  - $`\sigma^2`$ is the irreducible noise. Even if we knew $`w`$ exactly, there is inherent randomness in the data generating process $`y = w^\top x + \epsilon`$.

  - $`x^\top \hat{\Sigma}_n x`$ is the model uncertainty. This reflects our uncertainty about $`w`$ itself, projected onto the new input $`x`$. It depends on where $`x`$ sits relative to the training data. If $`x`$ is far from any training point, $`\hat{\Sigma}_n`$ is large in that direction and this term is large.

### Basis Functions

$`x`$ can be replaced by basis functions $`\phi(x)`$. First transform the raw input:
``` math
x \mapsto \phi(x) = (\phi_1(x), \phi_2(x), \ldots, \phi_k(x))^\top
```
Then the model is still linear in $`\phi(x)`$ but can still capture nonlinear relationships in the original $`x`$.
