# Q-function

``` math
Q(s, a) \leftarrow Q(s, a) + \alpha [ r + \gamma \max_{a'} Q(s', a') - Q(s, a) ]
```
Q-learning is off-policy (learns about a different policy than the one it uses to choose actions during training).

- The behaviour policy is $`\epsilon`$-greedy, so $`\epsilon`$% of the time it takes a random action. This is a deliberately suboptimal, exploratory policy.

- The target policy is full greedy (`np.max`) and takes the best possible action from $`s'`$ regardless if the action to get there is random.

The Q values converge to the optimal Q values - the values corresponding to always acting greedily - even though the agent spent training acting suboptimally due to exploration.
