---
title: "Tutorial 4: Process Synchronization I"
---

This page works through Tutorial 4, which tests the first half of Lecture 4 (Process Synchronization): the critical-section problem, user-level solutions and TestAndSet. The questions are copied from the tutorial sheet. The answers follow the **official solutions**. The explanations around them are mine.

**How to use this page.** Try each part first, then open its drawer. Each question ends with a **Recap** drawer. Points marked **Not in the main notes** come from the official solutions and are missing from the lecture chapters. The **Extensions** at the end test Lecture 4 ideas that this tutorial skips. Their answers are **unofficial**.

**Recall the three requirements** for a solution to the critical-section problem:

1. **Mutual exclusion:** at most one process is in its critical section at a time.
2. **Progress:** if the critical section is free and some processes want to enter, one of them must be able to enter. The choice cannot be postponed forever.
3. **Bounded waiting:** after a process asks to enter, the other processes can enter before it only a limited number of times.

---

## Question 1: A broken user-level solution

Consider the following user-level solution to the critical section problem, where `flag` and `turn` are shared variables initialized to `false` and `0`, respectively.

```c
// Process P0                      // Process P1
while (1) {                        while (1) {
    flag = true;                       turn = 0;
    while (turn == 1);                 while (flag and turn == 0);
    critical-section                   critical-section
    turn = 1;                          flag = false;
    remainder-section                  remainder-section
}                                  }
```

Determine which of the three requirements in part (a) are not satisfied with justifications. *(The three requirements are the ones recalled above.)*

<details class="qa">
<summary><strong>Mutual exclusion</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Not satisfied.** One order of instructions puts both processes inside:

1. P1: `turn = 0;`
2. P1: `while (flag and turn == 0);` → `flag` is still `false`, so P1 passes.
3. P1: enters its critical section.
4. Context switch from P1 to P0.
5. P0: `flag = true;`
6. P0: `while (turn == 1);` → `turn` is 0, so P0 passes.
7. P0: enters its critical section.

**P0 and P1 are both in the critical section.** The flaw: P1 checks `flag` before P0 has set it, and P0 checks only `turn`, which P1 has set to 0.
:::

</details>

<details class="qa">
<summary><strong>Progress</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Not satisfied.**

1. P0 runs its loop once. At the exit, it sets `turn = 1`.
2. P0 comes back: `flag = true;`
3. P0: `while (turn == 1);` → **loops forever**, if P1 stays in its remainder section.

Only P1 sets `turn` back to 0, and only when P1 itself wants to enter. So the critical section is free, P0 wants it, and P0 still cannot enter. Progress fails for P0.
:::

</details>

<details class="qa">
<summary><strong>Bounded waiting</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Satisfied.** Check each waiting position:

1. **P0 waits at `while (turn == 1);`.** P0 enters the moment P1 runs the first statement of its loop (`turn = 0`). So after P0 asks, P1 can enter its critical section **0 times** before P0.
2. **P1 waits at `while (flag and turn == 0);`.** P1 enters the moment P0 runs `turn = 1` after its critical section. So after P1 asks, P0 can enter **at most 1 time** before P1.

Both bounds are finite, so bounded waiting holds.

**Answer: mutual exclusion and progress are not satisfied; bounded waiting is.**
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 1</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* To show a requirement **fails**, give **one** instruction order (with context switches) that breaks it.
* To show bounded waiting **holds**, take each place a process can wait, and count how many times the other process can enter before the waiter is released. A finite count for every place = bounded.
* **Progress fails** when a free critical section can stay closed because the *other* process, sitting in its remainder section, holds the only key (here, `turn`).
* A solution can fail mutual exclusion and progress yet satisfy bounded waiting. The three requirements are independent.
:::

</details>

---

## Question 2: True or false

Indicate whether the following statements are true or false. Justify your answers.

a) Mutual exclusion can be achieved by disabling interrupts during the critical section.

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**True** (official answer). With interrupts disabled, no context switch can occur, so no other process, not even the OS, runs during the critical section.

**The limit, from the lecture:** this works only on **one CPU**. On a multiprocessor, the other CPUs keep running and can enter the critical section. Also, disabling interrupts is a **privileged** instruction, so a user program cannot do it. If a variant says "on a multiprocessor", the answer is **False**.
:::

</details>

b) If a solution to a critical section problem satisfies progress, then it also satisfies bounded waiting.

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**False.** A solution that **always favours P0** over P1 can satisfy progress without bounded waiting. The official counter-example, with `flag` initialized to `false` and `timeout` a large value:

```c
// Process P0                      // Process P1
while (flag);                      while (flag) { wait(timeout); }
flag = true;                       flag = true;
critical section;                  critical section;
flag = false;                      flag = false;
```

* **Progress holds:** when the critical section is free (`flag` is `false`), a waiting process can enter.
* **Bounded waiting fails for P1:** P1 sleeps for a long `timeout` between checks. P0 checks all the time, so it can enter again and again while P1 sleeps. There is no bound on how often P0 gets in first.
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 2</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* Disabling interrupts gives mutual exclusion **on one CPU only**, and only kernel code can do it.
* **Progress does not imply bounded waiting.** The counter-example pattern: a solution that always favours one process.
:::

</details>

---

## Question 3: A wrong TestAndSet

Consider the following implementation of `TestAndSet()`.

```c
boolean TestAndSet (boolean *target) {
    boolean rv = *target;
    *target = false;
    return rv;
}
```

Consider the following hardware-level solution to the critical section problem, where the code for a process Pi (i = 0 or 1) is shown. `lock` is a Boolean variable. The initial value of `lock = True`.

```c
// Process Pi:
while (1) {
    while (TestAndSet(&lock) == false);
    critical-section
    lock = false;
    remainder-section
}
```

Does this solution satisfy the properties of mutual exclusion and progress? Justify your answers.

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
First, notice what is different from the lecture version: this `TestAndSet` sets the target to **`false`**, and the lock starts at **`True`**. So here **`true` means free** and **`false` means taken**.

* The first process calls `TestAndSet`: it returns `true` (free) and sets `lock = false` (taken). The loop condition `== false` is false, so the process enters.

**Mutual exclusion: satisfied.** While one process is inside, `lock` is `false`. The other process's `TestAndSet` returns `false`, so it keeps looping. It cannot enter.

**Progress: not satisfied.** The exit section sets `lock = false`, which here means **still taken**. After P0 (or P1) leaves its critical section, the lock never becomes `true` again. The critical section is free, but the other process waits forever. (The correct exit would be `lock = true`.)
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 3</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* Before you judge a lock, work out **which value means free**. Here the meanings are flipped from the lecture.
* The **exit section must reset the lock to its free value**. If it doesn't, the lock stays closed: mutual exclusion holds, but progress fails.
* `TestAndSet` works because the read and the write are **one atomic step**, so two processes can never both see "free".
:::

</details>

---

## Extensions

These test Lecture 4 ideas that the tutorial does not ask about. The answers are **unofficial**, worked from the lecture.

1. `counter = 5`. A producer runs `counter++` and a consumer runs `counter--` at the same time, each as three instructions (read, change, write). What final values are possible?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**4, 5 or 6.**

* 5: one finishes before the other reads (the correct result).
* 6: both read 5; the consumer writes 4 first, then the producer writes 6.
* 4: both read 5; the producer writes 6 first, then the consumer writes 4.

This is a **race condition**: the result depends on the order in which the instructions interleave.
:::

</details>

2. Algorithm 1 uses only `turn` (`while (turn != i);` … `turn = k;`). Which requirement fails, and why?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Progress fails.** Suppose `turn = 0` and P0 stays in a long remainder section. P1 wants to enter and the critical section is free, but P1 must wait for P0 to hand over the turn, which may never happen. Mutual exclusion and bounded waiting hold. The weakness: `turn` alone does not know whether the other process **wants** to enter.
:::

</details>

3. Algorithm 2 uses only flags (`flag[i] = true; while (flag[k]);`). Give an order of instructions that breaks progress.

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
1. P0 sets `flag[0] = true`.
2. Context switch to P1.
3. P1 sets `flag[1] = true`.

Now each process waits for the other's flag to drop, forever, and neither is inside. Progress fails.
:::

</details>

4. In Peterson's solution (`flag[i] = true; turn = k; while (flag[k] && turn == k);`), both processes are in the entry section at once. Which one enters?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
The one that did **not** write `turn` last. Each process gives the turn away; the last write wins and hands the turn to the other process. So exactly one process enters, and Peterson's solution satisfies all three requirements (for two processes).
:::

</details>

5. With the correct TestAndSet lock (sets `true`, lock starts `false`), which requirement fails, and in what situation?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Bounded waiting fails.** Under round robin, if P0 is always inside its critical section when its quantum ends, P1 spins uselessly for its whole quantum. Then P0 runs again, leaves, loops, and takes the lock again before P1 gets another chance. This can repeat forever. Mutual exclusion and progress hold.
:::

</details>

6. When is busy waiting (spinning) better than blocking?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
When critical sections are **short**. A spinning process wastes CPU cycles, but blocking needs a context switch, which is also overhead. If the wait is shorter than a context switch, spinning wins. With long critical sections, blocking wins.
:::

</details>
