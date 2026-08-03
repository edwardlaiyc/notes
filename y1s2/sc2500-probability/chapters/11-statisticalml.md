# Statistical Machine Learning

## Classification Problem

Classification problem asks: Given an input, which category does it belong to?\
In supervised learning context, we are given training data of pairs of input and the corresponding labels.
``` math
D = \{(x_1, y_1), (x_2, y_2), \ldots, (x_n, y_n)\}
```
The computer learns from these pairs and produces a hypothesis function $`h`$, where
``` math
h : x \mapsto \hat{y}
```
The label set $`\mathcal{Y}`$ is finite. In comparison, regression problems’ outputs are continuous.\
There are two flavours of classification:

1.  Binary classfication: there are exactly two possible labels. Implication is that we only need to model the probability of one class. Loss function is logistic loss.

2.  Multiclass classification: there are more than two labels. Implication is that we need to output a probability for each of the $`K`$ classes, and they must all sum to 1 using tools like the softmax function. Loss function is cross-entropy loss.

## Binary classification - Logistic Regression

Logistic Regression is for binary classification.\
Recall the sigmoid function that converts any real number into a probability:
``` math
\sigma(z) = \frac{1}{1 + \exp(-z)}
```
When $`z`$ is positive and large, $`\sigma(z)\approx 1`$, when $`z`$ negative and large, $`\sigma(z)\approx 0`$, when $`z=0, \sigma(z)=0.5`$.\
In effect, it acts as a squashing function.\
The probabilistic model is (where $`w`$ are the weights/parameters and $`h_w(x)`$ is the linear scoring function),
``` math
p(y = +1|x, w) = \sigma(h_w(x)), \quad p(y = -1|x, w) = 1 - \sigma(h_w(x))
```
Decision boundary: the set of points where $`h_w(x)=0`$ is the hyperplane separating the two classes. Points on one side are classified +1, the other side -1.\
The unified expression, for $`y\in \{+1, -1\}`$, is
``` math
p(y|x,w) = \frac{1}{1 + \exp(-y\cdot h_w(x))}
```
Using MLE (by taking argmax of sum of log-probabilities), the MLE becomes:
``` math
\hat{w} = \arg\min_{w \in \mathbb{R}^d} \frac{1}{n} \sum_{i=1}^{n} \log(1 + \exp(-y_i \cdot h_w(x_i)))
```
And the logistic loss is:
``` math
l(y', y) = \log(1 + \exp(-y \cdot y'))
```
Intuition: $`y\cdot y'`$ captures whether the prediction is correct. If $`y\cdot y'`$ is positive, the prediction and true label agree $`\implies`$ the loss is small. Otherwise $`y\cdot y'`$ is large and negative $`\implies`$ the loss is large.\
Once $`w`$ is learned, predictions are made by:
``` math
\hat{y} = \begin{cases}
    +1 & \text{if } h_w(x) \ge 0 \\
    -1 & \text{if } h_w(w) < 0
\end{cases}
```

## Multiclass classification - Softmax, Cross-entropy loss

Here we need to output a probability for each of the $`K`$ classes.\
The hypothesis function outputs a vector of $`K`$ scores:
``` math
h_w(x) = (h_{w,1}(x), \ldots, h_{w,K}(x))^\top : \mathcal{X} \to \mathbb{R}^K
```
Each $`h_{w,k}`$ is the raw score, or logit, for class $`k`$.\
Given these scores, the predicted class is just the one with the highest score:
``` math
\hat{y} = \arg\max_{y \in \mathcal{Y}} h_{w,y}(x)
```
That is for prediction. But for learning $`w`$, we need to convert the scores to probabilities (to use MLE).\
The softmax function converts the score vector into a valid probability distribution.\
For a vector $`\mathbf{v} = (v_1,\ldots,v_K)`$,
``` math
q_{v,k} = \frac{\exp(v_k)}{\sum_{j=1}^{K} \exp(v_j)}
```
i.e. $`q_{v,1}`$ corresponds to $`v_1`$.\
Softmax preserves the ranking of scores, but squashes everything to make the sum = 1.\
We can then write a probabilistic model. Assume the true structure on $`y \in \{1,\ldots,K\}`$ given $`x`$ is:
``` math
p(y \mid x, w) = \frac{\exp(h_{w,y}(x))}{\sum_{k=1}^{K} \exp(h_{w,k}(x))}
```
Note that this just softmax applied $`h_w(x)`$, evaluated at position $`y`$, the true class.\
Then apply MLE to find the $`w`$ that makes the training data most probable.\
The log-likelihood for a single data point ($`x, y`$) is:
``` math
\log p(y \mid x, w) = \frac{\exp(h_{w,y}(x))}{\sum_{k=1}^K \exp(h_{w,k}(x))} = h_{w,y}(x) - \log \sum_{k=1}^{K} \exp(h_{w,k}(x))
```
Maximising this over all training data is equivalent to minimising its negative, i.e.
``` math
\min_w \frac{1}{n} \sum_{i=1}^{n} \underbrace{\left\{ -h_{w,y_i}(x_i) + \log \sum_{k=1}^{K} \exp(h_{w,k}(x_i)) \right\}}_{= \ell(h_w(x_i),\ y_i)}
```
This is the cross-entropy loss.\
Intuition:

- $`-h_{w,y_i}(x_i)`$ pushes the score of the true class to be as large as possible.

- $`\log \Sigma \exp(h_{w,k}(x_i))`$ grows whenever any score class gets large, acting as a penalty.

- So the loss is minimized when the true class score is large relative to all other scores.

Context on the rough training flow:\
With $`w`$ a set of $`K`$ weight vectors that parameterise the hypothesis function. Initially random, $`w`$ is learned by repeating this loop:

1.  Feed each training example $`x_i`$ through $`h_w`$ to get $`K`$ raw scores.

2.  Apply softmax to convert scores into probabilities.

3.  Since we know the true label $`y_i`$, compute the cross-entropy loss. How wrong was the model about the true class?

4.  Average the losses across all $`n`$ examples ($`\mathcal{L}_n(w)`$).

5.  Compute the gradient $`\nabla_w \mathcal{L}_n(w)`$.

6.  Update $`w`$ in the opposite direction: $`w \leftarrow w - \eta\nabla_w \mathcal(L)_n w`$.

### Expected loss, KL Divergence

So far we are minimising the empirical loss (the avg loss over the training data).\
But we care about how the model performs over all possible inputs, not just the ones we trained on.\
The expected loss is the average loss over the true data distribution:
``` math
\mathcal{L}(w) = \mathbb{E}_{(X,Y)}[\ell(h_w(X), Y)]
```
We get
``` math
\begin{align*}
\mathcal{L}(w) &= \mathbb{E}_{(X,Y)}[\ell (h_w (X), Y)]\\
&= \underbrace{\int_{\mathcal{X}} \sum_{y=1}^{K} 
\mathbb{P}[Y=y \mid X=x] \log \frac{\mathbb{P}[Y=y \mid X=x]}{p(y \mid x,w)} 
\mathbb{P}[X=x] \, dx}_{\text{KL-divergence}} \\
&\quad - \underbrace{\int_{\mathcal{X}} \sum_{y=1}^{K} \mathbb{P}[Y=y \mid X=x] 
\log \mathbb{P}[Y=y \mid X=x] \mathbb{P}[X=x] \, dx}_{\text{entropy of true distribution}}
\end{align*}
```
The second term does not depend on $`w`$ at all.\
Therefore minimising the expected cross-entropy loss is equivalent to minimising just the KL divergence term. This means finding the $`w`$ that makes the model’s predicted distribution $`p(y|x,w)`$ as close as possible to the true distribution $`P[Y=y|X=X]`$.\
\
Recall that KL divergence measures the degree of discrepancy between two probability distributions $`p`$ and $`q`$:
``` math
D_{\text{KL}}(p \| q) = \sum_{k=1}^{K} p_k \log \frac{p_k}{q_k}
```
So minimising cross entropy is just minimising:
``` math
D_{\text{KL}}(\mathbb{P}[Y|X] \| p(\cdot | X, w))
```
where $`p(\cdot | X, w)`$ is the full probability distribution over all possible classes $`y`$, given input $`X`$ and parameters $`w`$.\
So we are comparing the true distribution $`P[Y|X]`$ vs the model’s predicted distribution $`p(\cdot | X, w)`$.

## Loss functions

A loss function $`l(y', y)`$ measures the error between a prediction $`y' = h_w(x)`$ and the true label $`y`$. Training a model means finding the $`w`$ that minimizes the total loss over training data. Different problems require different loss functions.\
A recap:\
**Regression problems**: the output is a continuous value.\
Squared loss:
``` math
l(y', y) = 0.5(y - y')^2
```
Penalizes large errors heavily due to the square. Sensitive to outliers.\
\
$`\epsilon`$-sensitive loss:
``` math
l(y', y) = \max\{|y - y'| - \epsilon, 0\}
```
Ignores errors smaller than $`\epsilon`$ - useful when small errors are acceptable.\
**Binary classification lossses** Used when $`y\in\{+1, -1\}`$.\
Logistic loss:
``` math
l(y', y) = \log(1 + \exp(-yy'))
```
The product $`yy'`$ captures correctness - positive means correct, negative means wrong.\
Hinge loss:
``` math
l(y', y) = \max\{1 - yy', 0\}
```
Used in Support Vector Machines (SVMs). Zero loss when the prediction is correct and confident ($`yy' \geq 1`$). Doesn’t care about how confident correct predictions are beyond a margin.\
Exponential loss:
``` math
l(y', y) = \exp(-yy')
```
Used in boosting algorithms. Penalizes wrong predictions extremely aggressively - more sensitive to outliers than logistic loss.\
\
All binary classfication losses depend on the product $`yy'`$. When $`yy'`$ is large and positive, it is a correct, confident prediction and the loss should be small.\
Exponential loss grows fastest, logistic loss grows moderately, hinge loss is zero for sufficiently correct predictions, and linear otherwise.\
**Multiclass Classification Loss**\
Cross-entropy loss:
``` math
\ell(h_w(x), y) = -h_{w,y}(x) + \log \sum_{k=1}^{K} \exp(h_{w,k}(x))
```
Minimizing this is equivalent to minimizing KL divergence from the true distribution.

## Supervised learning framework

The goal of supervised learning is to find a hypothesis function $`h_w`$ that performs well on new, unseen data.

### Expected loss minimisation

The ideal objective is to minimise the expected loss:
``` math
\min_w \{\mathcal{L}(w) = \mathbb{E}_{(X,Y)}[l(h_w(X), Y)]\}
```
This means averaging over all possible inputs, weighted by how likely each input is to occur in the real world.\
However, we don’t have every possible input, but only a finite training dataset. So we cannot compute $`\mathcal{L}(w)`$ directly.\

### Empirical loss minimisation

Instead, we approximate $`\mathcal{L}(w)`$ using the empirical loss over training data $`D = \{(x_i, y_i)\}^{n}_{i=1}`$:
``` math
\min_w \{\mathcal{L}_n(w) = \frac{1}{n} \sum_{i=1}^{n} l(h_w(x_i), y_i)\}
```
This is just the average loss over the $`n`$ training examples. As $`n`$ grows, $`\mathcal{L}_n(w)`$ becomes a better approximation of $`\mathcal{L}(w)`$. But minimising the empirical loss does not guarantee minimizing the expected loss, because the training data is just a sample of the real world. If optimise too hard for that specific sample, the model learns the training data rather than the underlying true pattern. Hence overfitting: the empirical loss is very low but the expected loss remains high.

### Overfitting

Overfitting occurs when the gap between empirical loss and expected loss is large. The model performs well on training data but poorly on new unseen data:
``` math
\left| \mathbb{E}_{(X,Y)}[l(\hat{h}(X), Y)] - \frac{1}{n}\sum_{i=1}^{n} l(\hat{h}(x_i), y_i) \right|
```
where $`\hat{h}`$ is the hypothesis function learned from training data $`D`$.\
It happens when the model is too complex and has enough flexibility to memorise the training data rather than learn the underlying pattern.\
Also, with more data, the empirical loss becomes a better approximation of the expected loss, reducting the gap. Overfitting is most dangerous when data is scarce relative to model complexity.\
We can prevent it with appropriate modelling (choose model whose complexity matches the true structure of the problem) and regularisation (penalise model complexity during training, prevent $`w`$ from growing too large).

### The Model

We want to find the best $`h_w`$, but there are infinite functions. So we restrict the search to a model, i.e. a specific family of functions parameterised by $`w`$:
``` math
\mathcal{H} = \{h_w : \mathcal{X} \to \mathcal{Y} \mid w \in \Omega \subset \mathbb{R}^p\}
```
We decide a shape for the function output first, then training just finds the best version of that shape.\
Example - we choose a linear function for the model: $`h_w(x) = w^\top x + b`$. Then we restrict the search to only straight lines. Even if the true relationship is curved, the model will never capture it. This is bias.\
On the other hand, if we choose a complex model like deep neural network, it can represent almost any function, but it has so many parameters that it can memorise the training data. This is variance.

## Regularisation

Overfitting happens when the model is too complex. Regularisation is one way to fix this by penalising complexity directly in the training objective.\
``` math
\min_w \mathcal{L}_{n,\lambda}(w) = \frac{1}{n} \sum_{i=1}^{n} l(h_w(x_i), y_i) + \frac{\lambda}{2} \|w\|_2^2
```
By adding the regularisation term, it pushes $`w`$ to stay small.\
$`\lambda`$ is the regularisation coefficient.

- $`\lambda`$ too large: regularisation dominates and model may be too simple. May cause underfitting.

- $`\lambda`$ too small: empirical loss dominates and model may get too complex. May cause overfitting.

Hence choosing the right $`\lambda`$ is a hyperparameter tuning problem.\
Common regularisation terms:\
**L2 Regularisation (Ridge)**:
``` math
\|w\|_2^2 = \sum_{j=1}^{p} w_j^2
```
Penalizes large weights by squaring them. Shrinks all weights uniformly toward zero but never exactly to zero. Good when all features are expected to contribute something.\
**L1 Regularisation (Lasso):**
``` math
\|w\|_1 = \sum_{j=1}^{p} |w_j|
```
Penalizes weights by their absolute value. Tends to push weights to exactly zero — effectively removing irrelevant features from the model. Good when you expect only a few features to matter (sparsity).\
**Elastic Net:**
``` math
\alpha \|w\|_1 + \frac{1-\alpha}{2} \|w\|_2^2, \quad \alpha \in (0,1)
```
A combination of L1 and L2. $`\alpha`$ controls the mix between the two. Useful when you want some sparsity (L1) but also stable shrinkage (L2).

## Bias-variance tradeoff

Model complexity is defined as the diversity of functions contained in the model class $`\mathcal{H}`$. A model $`G`$ is more complex than $`\mathcal{H}`$ if $`\mathcal{H} \subset G`$.\
For example, a polynomial model is more complex than a linear model because every linear function is a polynomial, but not every polynomial is linear.\
**Bias** measures how wrong the model is on average due to its simplifying assumptions.
``` math
\text{High complexity} \rightarrow \text{Low bias}
```
**Variance** measures how much your learned model changes depending on the training data.
``` math
\text{High complexity} \rightarrow \text{High variance}
```
Complex model has more parameters, more sensitive to the specific training data.\
The expected loss can be decomposed into bias and variance:
``` math
\mathcal{L}(w) \approx \text{Bias}^2 + \text{Variance}
```
We want the optimal complexity where the total expected loss is minimized.

## Model selection

We know there is an optimal model complexity. To find it, we need to choose the model class to use, the number of parameters, the value of $`\lambda`$ for regularisation etc.\
These are hyperparameters, i.e. settings that control the learning process itself, not learned from training.\
We need a way to estimate the expected loss without using the test data.\

### Holdout Method

Split data into 2 parts:
``` math
D = D_{\text{train}} \cup D_{\text{validation}}
```

1.  Train the model on $`D_{\text{train}}`$.

2.  Evaluate the average loss on $`D_{\text{val}}`$ (validation data).

3.  Use the validation loss as an estimate of the expected loss.

4.  Choose the hyperparameters that give the lowest validation data.

Since the model never sees $`D_{\text{val}}`$ during training, the validation loss is an unbiased estimate of how well the model generalises.\
However, if the process is repeated many times trying different hyperparameters, the model starts to indirectly overfit to the validation data too. So the final evaluation must always be done on a completely separate test set that is never touched during model selection.
``` math
D = D_{\text{train}} \cup D_{\text{val}} \cup D_{\text{test}}
```
Holdout method is also high variance: the validation estimate depends heavily on which specific examples ended up in $`D_{\text{val}}`$.

### Cross-validation ($`k`$-fold CV)

Instead of one fixed split, rotate through $`k`$ different splits:

1.  Divide data into $`k`$ equal subsets.

2.  For each subset $`i=1,\ldots,k`$:

    - Use subset $`i`$ as validation data.

    - Train on all other $`k-1`$ subsets.

    - Record validation loss on subset $`i`$.

3.  Average the $`k`$ validation losses to give a CV score.
    ``` math
    \text{CV score} = \frac{1}{k} \sum_{i=1}^{k} \text{validation loss on fold } i
    ```

Every example is used for both training and validation, just never at the same time. This makes CV more data-efficient and less sensitive to how the data is split than the holdout method.\
Computing the CV score for each candidate value of the hyperparameter, we choose the value that gives the lowest CV score.\
**Leave-one-out CV (LOOCV)**\
A special case where $`k=n`$. Each fold contains exactly one example as validation data, trained on all remaining $`n-1`$ examples.\
Advantage — uses almost all data for training each time, very low bias in the estimate.\
Disadvantage — computationally expensive, requires n separate training runs.\
LOOCV is useful when data is very scarce and you cannot afford to leave much out for validation.\
