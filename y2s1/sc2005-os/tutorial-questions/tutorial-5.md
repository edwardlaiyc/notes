---
title: "Tutorial 5: Process Synchronization II"
---

This page works through Tutorial 5, which tests the second half of Lecture 4 (Process Synchronization): semaphores, how to use them, and how to build them. The questions are copied from the tutorial sheet. The answers follow the **official solutions**. The explanations around them are mine.

**How to use this page.** Try each part first, then open its drawer. Each question ends with a **Recap** drawer. Points marked **Not in the main notes** come from the official solutions and are missing from the lecture chapters. The **Extensions** at the end test Lecture 4 ideas that this tutorial skips. Their answers are **unofficial**.

**Recall:** a semaphore `S` is a shared integer used only through two atomic operations. `Wait(S)` takes one unit, and waits if none is free. `Signal(S)` gives one unit back. In the blocking version, `Wait` subtracts 1 and blocks if the value becomes negative; `Signal` adds 1 and wakes a waiting process if the value is still 0 or less.

---

## Question 1: Apples and oranges

Alice is playing a game that involves pairing apples with oranges. The game produces apples and oranges in separate baskets at random instants. For Alice to get points, she must pair exactly 1 apple with 2 oranges by picking them from the respective baskets. Each basket is protected by a semaphore; A for the apple basket and O for the orange basket. To access a basket, Alice must first acquire the corresponding semaphore.

Complete the code in the below figure to help Alice to play this game. You should only use the operations `Wait(A)`, `Wait(O)`, `Signal(A)` and `Signal(O)` in the boxes provided. You may use any number of these operations (including zero) in each of the boxes. Your solution must be deadlock-free even in the presence of other players who may be executing a different code.

```text
[ Box 1 ]
// Pick 1 apple
[ Box 2 ]
If (atleast 2 oranges in basket) {
    ** Pick 2 oranges and pair with apple. **
    [ Box 3 ]
} else {
    [ Box 4 ]
    ** Drop 1 apple back in basket **
    [ Box 5 ]
}
```

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
```text
Wait(A)                                  // Box 1
// Pick 1 apple
Signal(A); Wait(O)                       // Box 2
If (atleast 2 oranges in basket) {
    ** Pick 2 oranges and pair with apple. **
    Signal(O)                            // Box 3
} else {
    Signal(O); Wait(A)                   // Box 4
    ** Drop 1 apple back in basket **
    Signal(A)                            // Box 5
}
```

1. Acquire A, take an apple, and **release A at once**.
2. Acquire O. If at least 2 oranges are there, take them and release O.
3. If not, **release O first**, then acquire A again, drop the apple back, and release A.

**Why there is no deadlock:** Alice **never holds both semaphores at the same time**. There is no nesting. Each `Wait` happens while she holds nothing.
:::

</details>

<details class="qa">
<summary><strong>Why nesting would deadlock</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
Suppose Alice kept A while she checked the oranges (`Wait(A); … Wait(O)`). Another player might run the opposite order (`Wait(O); … Wait(A)`). Then:

1. Alice takes A.
2. The other player takes O.
3. Alice blocks on O; the other player blocks on A.

Each holds one semaphore and waits for the other: deadlock. This is the same pattern as the lecture's two-semaphore deadlock. The question says other players "may be executing a different code", so you cannot assume they use the same order. **The only safe choice is never to wait while holding.**

The else-branch follows the same rule: Alice must give up O **before** she waits for A again to return the apple.
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 1</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* Hold a semaphore **only for the time you touch its resource**. Release it as soon as you are done.
* **Never call `Wait` while you hold another semaphore** when you can't control the order other processes use. Then "hold and wait" cannot happen, so deadlock cannot happen. *(The rule is implied by the lecture's deadlock example; the tutorial states it.)*
* To put something back, re-acquire its semaphore, after releasing the one you hold.
:::

</details>

---

## Question 2: A shifted semaphore

Consider the following implementations of the system calls `Wait()` and `Signal()`.

```c
Wait (Semaphore S)              Signal (Semaphore S)
{                               {
    S.value--;                      S.value++;
    If (S.value < -1) {             If (S.value <= 0) {
        block();                        wakeup();
    }                               }
}                               }
```

Suppose these system calls are guaranteed to be atomic and a Semaphore `S` in this system is used to protect critical sections as shown below. Assume `S` is initialized to 0. Explain if this solution ensures mutual exclusion and progress with justifications?

```c
// Process Pi:
While (1)
{
    Wait(S);
    Critical-section for Pi
    Signal(S);
    Remainder-section for Pi
}
```

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Mutual exclusion: satisfied.** The first process to run `Wait()` makes the value −1. The block test is `< -1`, so it does not block, and it enters. *(The official slide writes "becomes 1"; from a start of 0, one `Wait` gives −1.)* Any other process now takes the value to −2 or below and blocks. No one else enters until the first process runs `Signal()`. Also, `Wait` and `Signal` always run in pairs, in that order, from a start of 0, so the value **can never be greater than 0**.

**Progress: satisfied.**

* When the value goes from −1 to 0, `Signal()` calls `wakeup()` although **no process is waiting**. This wakeup is unnecessary, but harmless.
* If the value was below −1, processes are blocked, and every `Signal()` wakes one of them.

So no process stays blocked while the semaphore is free (value 0).
:::

</details>

<details class="qa">
<summary><strong>How to analyse a modified semaphore</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Not in the main notes** as a method.

Make a table of what each value **means**, then check the block and wake conditions against it.

| Value | Meaning here | Standard semaphore (start 1) |
|---|---|---|
| 0 | Free | 1 |
| −1 | One process inside, none waiting | 0 |
| −1 − k | One inside, k waiting | −k |

Every value is the standard value **shifted down by 1**, and the block test (`< -1` instead of `< 0`) is shifted by the same amount. So `Wait` behaves exactly like the standard one.

The wake test is **not** shifted (`<= 0` instead of `<= -1`). So `Signal` also fires at −1 → 0, when no one waits. That is the one extra wakeup. It is wasted work, not an error.

**General check:** mutual exclusion fails if two processes can pass `Wait` without blocking. Progress fails if a process can stay blocked while the semaphore is free (a missed wakeup).
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 2</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* Write out what each semaphore value means, and compare it with the standard semaphore.
* A **shifted start value plus an equally shifted block test** gives the same behaviour.
* An **extra** wakeup with an empty list is harmless. A **missing** wakeup breaks progress.
* Paired `Wait`/`Signal` from start value $v$ keep the value at most $v$.
:::

</details>

---

## Question 3: Building a semaphore from TestAndSet

Describe how `Wait(S)` and `Signal(S)` of a semaphore can be implemented using a TestAndSet instruction, given the below semaphore structure definition.

*Hint:* The semaphore value and the process queue `L` are shared variables among different processes when those processes access the semaphore.

```c
typedef struct {
    int value;
    struct process *L;
} semaphore;
```

<details class="qa">
<summary><strong>Step 1: find the critical section</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
Start from the blocking implementation, with `block()` and `wakeup()` written out:

```c
// Wait(S)
S.value--;                          // critical section
if (S.value < 0) {                  // critical section
    add current process to S.L;     // critical section
    put current process to waiting state;   // remainder
}

// Signal(S)
S.value++;                          // critical section
if (S.value <= 0) {                 // critical section
    remove a process P from S.L;    // critical section
    add process P to ready queue;   // remainder
}
```

The shared variables are `S.value` and `S.L`. Every line that reads or changes them is in the critical section. **Not all of `block()` and `wakeup()` is in the critical section**: changing a process's state, and adding it to the ready queue, do not touch `S`.
:::

</details>

<details class="qa">
<summary><strong>Step 2: the implementation</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
Protect the critical section with one shared lock, `boolean lock = false;`, and the standard TestAndSet (which sets the lock to `true`):

```c
wait(S):
    while (TestAndSet(&lock));          // acquire
    S.value = S.value - 1;
    if (S.value < 0) {
        add current process to S.L;
        lock = false;                   // release BEFORE sleeping
        put current process to waiting state;
    }
    else lock = false;                  // release

signal(S):
    while (TestAndSet(&lock));          // acquire
    S.value = S.value + 1;
    if (S.value <= 0) {
        remove a process P from S.L;
        lock = false;                   // release
        add process P to ready queue;
    }
    else lock = false;                  // release
```

**Every path releases the lock exactly once**: inside the `if`, or in the `else`.
:::

</details>

<details class="qa">
<summary><strong>Why release the lock before sleeping</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
If a process went to sleep while it still held `lock`, no other process could get past `while (TestAndSet(&lock))` in `signal`. So no one could ever wake the sleeper: the system would hang. The lock must be released **before** the process is put in the waiting state.

**Why spinning is acceptable here:** a process spins on `lock` only while another process runs the few instructions of the critical section. That wait is very short, shorter than a context switch. The long wait (for the semaphore itself) is a real sleep in `S.L`, which uses no CPU.
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 3</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* `Wait` and `Signal` must be atomic. TestAndSet provides it: the **critical section is only the code that touches `S.value` and `S.L`**.
* Changing a process's state, and the ready queue, are **outside** that critical section.
* **Release the lock before the process sleeps**, or no one can signal it.
* Every path through `wait` and `signal` must release the lock (note the `else` branches).
* Two levels of waiting: a **short spin** on `lock`, and a **long sleep** in `S.L`.
:::

</details>

---

## Extensions

These test Lecture 4 ideas that the tutorial does not ask about. The answers are **unofficial**, worked from the lecture.

1. A blocking semaphore starts at 2. Five processes call `Wait`, then one calls `Signal`. What is the value, and how many processes are blocked?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
Value = start − Waits + Signals $= 2 - 5 + 1 = -2$. A negative value $-k$ means $k$ processes are waiting, so **2 are blocked**. (Five called `Wait`: two passed at once, three blocked, and the `Signal` woke one of them.)
:::

</details>

2. Code B in process Pk must run only after code A in process Pi. Which semaphore do you use, with what start value, and where do the operations go?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
One semaphore `flag` with start value **0**. Pi runs `A; Signal(flag);`. Pk runs `Wait(flag); B;`. If Pk arrives first, it blocks, because the value is 0, until Pi has finished A.
:::

</details>

3. In the bounded-buffer solution, a consumer calls `Wait(mutex)` before `Wait(full)`. What goes wrong when the buffer is empty?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Deadlock.** The consumer takes `mutex`, then blocks on `full` while it still holds `mutex`. A producer then blocks on `mutex`, so it can never add an item and signal `full`. **Rule: wait for the resource first, then the mutex.** The order of the two `Signal`s does not matter, because `Signal` never blocks.
:::

</details>

4. Give the three remedies for deadlock in the dining philosophers, and say which deadlock condition each one removes.

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* **At most four hungry at once** (a counting semaphore `seats = 4`): the circle needs all five, so it cannot close. Removes **circular wait**.
* **Pick up both chopsticks only if both are free** (checked inside a mutex): no one holds one while waiting for the other. Removes **hold and wait**.
* **Asymmetric order** (odd: left then right; even: right then left): neighbours compete for the same first chopstick, so the circle cannot close. Removes **circular wait**.
:::

</details>

5. In the readers-preference readers–writers solution, who can starve, and why does only the first reader call `Wait(wrt)`?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
A **writer** can starve if readers keep arriving, because new readers enter while any reader is inside. Only the **first** reader (`readcount == 1`) calls `Wait(wrt)`: that locks out all writers for the whole group of readers. Only the **last** reader (`readcount == 0`) calls `Signal(wrt)`. `mutex` protects `readcount`, which all readers change.
:::

</details>

6. A blocking semaphore keeps waiting processes in list `L`. Which order of removal from `L` can cause starvation?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Priority order** (a low-priority process can wait forever) and **LIFO** (the process that joined first can wait forever). A **FIFO** queue prevents starvation and gives bounded waiting.
:::

</details>

7. Why must `Wait` decrement `S.value` before it checks it, not after it wakes up?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
If the decrement comes after the wakeup, a third process can slip in between: P0 is woken by a `Signal` (value 1), but before P0 runs, P2 calls `Wait`, sees 1, takes it and enters. Then P0 runs, decrements, and enters too. **Mutual exclusion fails.** Decrementing first reserves the process's place at the moment it calls `Wait`.
:::

</details>
