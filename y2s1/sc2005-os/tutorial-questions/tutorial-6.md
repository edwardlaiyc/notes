---
title: "Tutorial 6: Deadlocks"
---

This page works through Tutorial 6, which tests Lecture 5 (Deadlocks). The questions are copied from the tutorial sheet. The answers follow the **official solutions**. The explanations around them are mine.

**How to use this page.** Try each part first, then open its drawer. Each question ends with a **Recap** drawer. Points marked **Not in the main notes** come from the official solutions and are missing from the lecture chapters. The **Extensions** at the end test Lecture 5 ideas that this tutorial skips. Their answers are **unofficial**.

**Recall the Banker's algorithm.** `Need = Max − Allocation`. A state is **safe** if some order of processes (a **safe sequence**) lets each one get its full `Need` from what is free, finish, and return its `Allocation`. To decide on a request: pretend to grant it, then run the safety check. Grant it only if the new state is safe.

---

## Question 1: True or false

Indicate whether the following statements are true or false. Justify your answers.

(a) In the dining-philosopher problem with five philosophers, if we allow at most four of them to be hungry simultaneously, deadlock may still occur.

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**False.** Deadlock cannot occur, because **at least one philosopher can get both chopsticks**.

Why: four hungry philosophers share five chopsticks. Even if each of the four holds one chopstick, one chopstick is still free. It lies next to one of the four, who takes it, eats, and puts both down. The circle of waits needs all five philosophers, and only four take part.
:::

</details>

(b) It is impossible to have a deadlock involving only one single process.

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**True.** The **hold-and-wait** condition can never be satisfied: a process cannot hold a resource and wait for **another process** to release one when there is no other process. (Circular wait also needs at least two processes.)
:::

</details>

(c) If a resource allocation graph contains a cycle, then a deadlock has occurred.

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**False.** It depends on the **number of instances** of each resource type.

* Every resource type in the cycle has **one** instance → a cycle **means** deadlock.
* Some type has **several** instances → a deadlock is **possible, not certain**. A process outside the cycle may hold another instance, finish, and release it, which breaks the cycle.
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 1</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* **At most four hungry philosophers** → one can always get both chopsticks → no deadlock.
* A deadlock needs **at least two processes**: one process alone cannot hold and wait.
* **Cycle + single instances = deadlock. Cycle + multiple instances = maybe.** No cycle = no deadlock.
:::

</details>

---

## Question 2: Banker's algorithm, one resource type

A resource-allocation state is given below. Assume Available = 2.

| | Allocation | Max | Need |
|---|---|---|---|
| PROCESS 1 | 1 | 6 | 5 |
| PROCESS 2 | 1 | 5 | 4 |
| PROCESS 3 | 2 | 4 | 2 |
| PROCESS 4 | 4 | 7 | 3 |

(a) If PROCESS 4 requests for one unit of the resource next, does this lead to a safe state or an unsafe one?

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Unsafe.** Pretend to grant: PROCESS 4's Allocation becomes 5, its Need becomes 2, and Available becomes 1.

| | Allocation | Need |
|---|---|---|
| PROCESS 1 | 1 | 5 |
| PROCESS 2 | 1 | 4 |
| PROCESS 3 | 2 | 2 |
| PROCESS 4 | 5 | 2 |

Available = 1, and **every Need is greater than 1**. No process can finish first, so no safe sequence exists. The state is unsafe, so the OS must make PROCESS 4 wait.
:::

</details>

(b) If PROCESS 3 requests for one unit of the resource next, does this lead to a safe state or an unsafe one?

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Safe.** Pretend to grant: PROCESS 3's Allocation becomes 3, its Need becomes 1, and Available becomes 1.

| Step | Available before | Process | Need ≤ Available? | Available after (+ Allocation) |
|---|---|---|---|---|
| 1 | 1 | PROCESS 3 | 1 ≤ 1 | 1 + 3 = 4 |
| 2 | 4 | PROCESS 2 | 4 ≤ 4 | 4 + 1 = 5 |
| 3 | 5 | PROCESS 1 | 5 ≤ 5 | 5 + 1 = 6 |
| 4 | 6 | PROCESS 4 | 3 ≤ 6 | 6 + 4 = 10 |

The safe sequence is **⟨PROCESS 3, PROCESS 2, PROCESS 1, PROCESS 4⟩**.
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 2</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* To judge a request: **pretend to grant it** (Available −, Allocation +, Need −), **then** run the safety check.
* If no process has Need ≤ Available, the state is unsafe at once.
* A finished process returns its **Allocation**, not its Max or its Need.
* The same request size (1 unit) can be safe from one process and unsafe from another. What matters is whether the requester can then finish and release.
* Unsafe → the OS makes the process wait, even though a deadlock is not certain.
:::

</details>

---

## Question 3: Banker's algorithm with unknowns

Consider the following snapshot of a system's state, with five processes (P0, P1, P2, P3 and P4) and four resource types (A, B, C and D). The current **Allocation**, **Need** and **Available** matrices are as shown in the table below.

| Process | Allocation (A B C D) | Need (A B C D) |
|---|---|---|
| P0 | 2 2 0 0 | 1 4 0 0 |
| P1 | 3 1 0 0 | 0 1 0 0 |
| P2 | 1 1 0 0 | 1 0 0 0 |
| P3 | 0 0 1 1 | 0 0 1 1 |
| P4 | 0 0 1 1 | 0 0 3 2 |

Available (A B C D) = 0 **x** **y** 1

Suppose process P3 generates the resource request (A=0 B=0 C=0 D=1) next. Compute the minimum values for **x** and **y** so that this request from P3 can be granted and the resulting system state is safe. Justify your answer and show the algorithm steps for generating the safe sequence.

<details class="qa">
<summary><strong>Answer: the values</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**x = 2 and y = 2.** The safe sequence is **⟨P1, P2, P3, P0, P4⟩**.

**Key observation:** A and B are used only by P0–P2, and C and D are used only by P3–P4. So the two groups can be solved separately: x decides whether P0–P2 can finish, and y decides whether P3–P4 can finish.

* **Why x = 2:** P1 and P2 can finish with x = 1, but P0 needs x = 2. With x = 1, after P1 and P2 return their B units, B = 1 + 1 + 1 = 3, and P0 needs 4.
* **Why y = 2:** P3 can finish with y = 1, but P4 needs y = 2. With y = 1, after P3 returns its C unit, C = 1 + 1 = 2, and P4 needs 3.
:::

</details>

<details class="qa">
<summary><strong>Answer: the algorithm steps</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Grant P3's request (0 0 0 1)** with x = y = 2. Available was 0 2 2 1:

* Available becomes **0 2 2 0**.
* P3's Need becomes **0 0 1 0**, and its Allocation becomes **0 0 1 2**.

(The request passes both checks first: 0 0 0 1 ≤ P3's Need 0 0 1 1, and ≤ Available 0 2 2 1.)

**Run the safety algorithm:**

| Available (Work) | Process | Need | Allocation returned |
|---|---|---|---|
| 0 2 2 0 | P1 | 0 1 0 0 | 3 1 0 0 |
| 3 3 2 0 | P2 | 1 0 0 0 | 1 1 0 0 |
| 4 4 2 0 | P3 | 0 0 1 0 | 0 0 1 2 |
| 4 4 3 2 | P0 | 1 4 0 0 | 2 2 0 0 |
| 6 6 3 2 | P4 | 0 0 3 2 | 0 0 1 1 |
| 6 6 4 3 | (all done) | | |

Each row: Need ≤ Available, so the process finishes and Available grows by its Allocation. All five finish, so the state is safe.
:::

</details>

<details class="qa">
<summary><strong>The method for unknowns</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Not in the main notes** as a method.

1. **Apply the request first.** The question asks about the state **after** granting it. Here D drops to 0 and P3's Need for D drops to 0.
2. **Split the resources into independent groups** if some processes never use some types. Solve each group alone.
3. **For each unknown, find the bottleneck process:** the one whose Need is reached last. Run the safety check in the best order and see how much of that resource is available when the bottleneck's turn comes.
4. **Set up the inequality** and solve for the smallest value. For B: $x + 1 + 1 \ge 4$ (P1 and P2 each return 1 B before P0 runs), so $x \ge 2$. For C: $y + 1 \ge 3$ (P3 returns 1 C before P4 runs), so $y \ge 2$.
5. **Check that the smaller value fails**, to show the answer is a minimum.
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 3</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* The resource-request steps: **Request ≤ Need**, **Request ≤ Available**, pretend to grant, then run the **safety algorithm**.
* Vector comparison: Need ≤ Work must hold in **every** element.
* For minimum unknowns: split independent groups, find the bottleneck process, write the inequality, and check that one less fails.
:::

</details>

---

## Extensions

These test Lecture 5 ideas that the tutorial does not ask about. The answers are **unofficial**, worked from the lecture.

1. Name the four necessary conditions for deadlock. If all four hold, must a deadlock occur?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Mutual exclusion, hold and wait, no preemption, circular wait.** They are **necessary but not sufficient**: if any one is missing, deadlock cannot occur; if all four hold, deadlock **may** occur, but does not have to.
:::

</details>

2. How does numbering the resources and requesting them in increasing order prevent deadlock? Which condition does it break?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
It breaks **circular wait**. A cycle would need some process to hold a higher-numbered resource while it waits for a lower-numbered one, and the ordering rule forbids that. For the philosophers: the one between chopsticks 4 and 0 picks up 0 first, which breaks the circle.
:::

</details>

3. Using the Question 2 table (Available = 2), PROCESS 1 requests 6 units. What does the resource-request algorithm do? What if PROCESS 1 requests 3 units?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* **6 units:** 6 > Need (5). This is an **error**: the process asked for more than its declared maximum. The safety check never runs.
* **3 units:** 3 ≤ Need (5), but 3 > Available (2). PROCESS 1 must **wait**, because the resources are not free. The safety check does not run either.

The safety check runs only after both tests pass.
:::

</details>

4. A resource-allocation graph has P1 holding R1 and requesting R2, and P2 holding R2 and requesting R1. Is there a deadlock? What if R2 has a second instance held by P3, which requests nothing?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* **One instance each:** the cycle P1 → R2 → P2 → R1 → P1 is a deadlock.
* **R2 has two instances, one held by P3:** the cycle still exists, but P3 requests nothing, so it finishes and releases its R2. P1 gets R2, finishes, and releases R1 for P2. **No deadlock.** This is why a cycle with multiple instances means "maybe".
:::

</details>

5. True or false: an unsafe state is a deadlocked state.

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**False.** Every deadlock state is unsafe, but an unsafe state only means a deadlock is **possible**. A process may release resources before it reaches its maximum, and then no deadlock occurs. Avoidance simply never enters an unsafe state.
:::

</details>

6. What do most operating systems, including UNIX and Windows, actually do about deadlock, and why?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
They **ignore** it: they assume deadlocks never occur. Prevention and avoidance cost time on every request, all the time, while deadlocks are rare.
:::

</details>

7. How do deadlock and starvation differ?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
In a **deadlock**, a set of processes wait for **each other**, and none can ever continue. In **starvation**, one process waits forever while **others keep running**, for example because the scheduler always picks someone else.
:::

</details>
