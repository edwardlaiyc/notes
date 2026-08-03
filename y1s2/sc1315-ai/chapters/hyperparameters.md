# Hyperparameters

## Learning rate $`\alpha`$

Controls how much each new experience overwrites prior estimates.\
Original value: $`\alpha = 0.9`$. The agent heavily trusts new samples, which works here because the environment is deterministic.

## Discount factor $`\gamma`$

Determines how much future rewards are worth relative to immediate ones.\
Original value: $`\gamma = 0.9`$. A reward $`k`$ steps away is worth $`0.9^k`$ of its face value. This ensures the cumulative sum converges and encodes a preference for reaching the goal sooner rather than later.

## Exploration rate $`\epsilon`$ for $`\epsilon`$-greedy action selection

At any given step there’s a $`\epsilon`$% chance the agent takes a random action instead of the best known one.\
This handles the explore-exploit tradeoff — without exploration the agent might never discover the goal at all.

## Episodes

The number of complete run-throughs of the environment the agent gets to learn from.

## Max steps

caps the length of each episode to prevent infinite loops in cases where the agent never reaches a terminal state.
