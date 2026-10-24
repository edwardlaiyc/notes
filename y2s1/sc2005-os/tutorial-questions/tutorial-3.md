---
title: "Tutorial 3: CPU Scheduling"
---

This page works through Tutorial 3, which tests Lecture 3 (CPU Scheduling). The questions are copied from the tutorial sheet. The answers follow the **official solutions**. The explanations around them are mine.

**How to use this page.** Try each part first, then open its drawer. Each question ends with a **Recap** drawer. Points marked **Not in the main notes** come from the official solutions (or the tutorial class) and are missing from the lecture chapters. This tutorial has many of them: the queue-order rule, the shared I/O device, and CPU efficiency. The **Extensions** at the end test Lecture 3 ideas that this tutorial skips. Their answers are **unofficial**.

---

## Question 1: True or false

State whether each of the following statements are true or false. Justify your answers.

(a) When a new process is admitted in the system, the short-term scheduler must execute in order to keep the CPU busy.

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**False.** To keep the CPU busy, the short-term scheduler **must** run only when the running process **terminates or blocks** (for example, for I/O). Then the CPU would otherwise be idle.

When a new process is admitted, the scheduler **must** run only if **no other process is running**, that is, the CPU is idle. Otherwise the CPU is already busy. (A preemptive scheduler **may** run at an arrival, but it does not have to.)
:::

</details>

(b) Partitioned multi-processor scheduling suffers from migration overheads due to data in private core-specific caches.

<details class="qa">
<summary><strong>Answer</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**False.** Migration overhead occurs in **global** scheduling: a process runs partly on one core, then continues on another, and the data in the first core's private cache is wasted.

In **partitioned** scheduling, each process stays on one core, so it never migrates. Partitioned scheduling has a different problem: **unbalanced load** on the cores, which depends on how the processes are mapped to cores.
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 1</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* The scheduler **must** run when the running process **blocks or exits**. An arrival forces it only when a core is idle.
* **Global** → migration overhead (cache data lost). **Partitioned** → unbalanced load. Don't swap them.
:::

</details>

---

## Question 2: Gantt charts with I/O

Consider the following set of processes that are using the same I/O device.

| Process | CPU Burst Times | I/O Burst Time | Arrival Time |
|---|---|---|---|
| P1 | 2, 8 | 2 (after first CPU burst) | 0 (order: 1) |
| P2 | 1 | 0 | 0 (order: 2) |
| P3 | 1, 1 | 1 (after first CPU burst) | 2 (order: 1) |
| P4 | 1 | 0 | 2 (order: 2) |
| P5 | 2, 3 | 2 (after first CPU burst) | 4 |

(a) Draw two Gantt charts illustrating the execution of these processes using:

i. Round-Robin (quantum = 2) uni-processor scheduling.

ii. Shortest Remaining Time First (SRTF) global multi-processor scheduling with 2 cores.

(b) What are the turnaround and waiting times of processes for each algorithm?

<details class="qa">
<summary><strong>Two rules you need first</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Not in the main notes.** The lecture examples have no I/O, so they never meet these situations.

**Rule 1: the order of joining the ready queue at the same instant.** Several processes can join the ready queue at the same time $t$. They join in this order:

1. a **new** process (it arrives at $t$),
2. a **preempted** process (its quantum ends at $t$),
3. a process **returning from I/O** (its I/O ends at $t$).

This matters for RR and FCFS, where queue order decides who runs next.

**Rule 2: one I/O device serves one process at a time.** The question says all processes use the **same** I/O device. If a process finishes its CPU burst while the device is busy, it **waits in the device queue** until the device is free. Its I/O starts later than its CPU burst ends.
:::

</details>

<details class="qa">
<summary><strong>Answer to (a) i: Round robin, q = 2, one core</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
![The official RR (q = 2) chart. The CPU row shows P1, P2, P3, P4, P5, P1, P3, P1, P5, P1, P5, P1, ending at 19. The I/O row shows P1 (2–4), P3 (4–5) and P5 (7–9) (Tutorial 3 solutions, slide 6).](tutorial-3-artifacts/q2-rr-gantt.png)

**The trace, event by event.** The queue is written head first.

| Time | Event | Ready queue after the event | Runs |
|---|---|---|---|
| 0 | P1, P2 arrive | P1, P2 | P1 (0–2). Its burst of 2 ends exactly, so it goes to I/O (2–4) |
| 2 | P3, P4 arrive | P2, P3, P4 | P2 (2–3), done |
| 3 | — | P3, P4 | P3 (3–4). Then it needs I/O; the device is free at 4, so I/O 4–5 |
| 4 | **P5 arrives (new)** and **P1 returns from I/O** | P4, **P5, P1** (Rule 1: new before I/O return) | P4 (4–5), done |
| 5 | P3 returns from I/O | P5, P1, P3 | P5 (5–7). Burst ends; I/O 7–9 |
| 7 | — | P1, P3 | P1 (7–9): 2 of its 8 units, 6 left |
| 9 | **P1 preempted** and **P5 returns from I/O** | P3, **P1, P5** (Rule 1: preempted before I/O return) | P3 (9–10), done |
| 10 | — | P1, P5 | P1 (10–12), 4 left |
| 12 | P1 preempted | P5, P1 | P5 (12–14), 1 left |
| 14 | P5 preempted | P1, P5 | P1 (14–16), 2 left |
| 16 | P1 preempted | P5, P1 | P5 (16–17), done |
| 17 | — | P1 | P1 (17–19), done |

Note: a process whose burst ends **before** its quantum ends gives up the CPU at once (P2 at 3, P3 at 4). The next process starts immediately.
:::

</details>

<details class="qa">
<summary><strong>Answer to (a) ii: SRTF, global, two cores</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
![The official global SRTF chart on two cores. Core 1: P1, P4, P1, P3, P1 (ending at 13). Core 2: P2, P3, P5, P5 (ending at 11). I/O: P1 (2–4), P3 (4–5), P5 (6–8) (Tutorial 3 solutions, slide 7).](tutorial-3-artifacts/q2-srtf-global-gantt.png)

In global SRTF, at each moment the processes with the **shortest remaining time of their current CPU burst** run, one on each core. A new or returning process preempts the running process with the **longest** remaining time, if it is shorter.

| Time | Event | Decision |
|---|---|---|
| 0 | P1 (2), P2 (1) arrive | Two cores, two processes: both run. P2 finishes at 1; core 2 is idle 1–2 |
| 2 | P1's burst ends → I/O 2–4. P3 (1), P4 (1) arrive | Both run, 2–3. P4 finishes |
| 3 | P3's first burst ends | **The device is busy with P1 until 4** (Rule 2), so P3 waits in the device queue. P3's I/O runs 4–5 |
| 4 | P1 returns (next burst 8). P5 arrives (2) | Both cores are free, so both run: P1 on core 1, P5 on core 2 |
| 5 | P3 returns (1) | Running: P1 has 7 left, P5 has 1 left. P3 (1) is shorter than P1, so it **preempts P1**. P3 runs 5–6 and finishes |
| 6 | P5's first burst ends → I/O 6–8 | P1 resumes on core 1 and runs 6–13 |
| 8 | P5 returns (3) | Core 2 is free: P5 runs 8–11 |

The SRTF "remaining time" is the remaining time of the **current CPU burst**, not of the whole process. P1 returning at 4 competes with its second burst (8), not with 2 + 8.
:::

</details>

<details class="qa">
<summary><strong>Answer to (b): turnaround and waiting times</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Turnaround time** = completion time − arrival time.

**Waiting time** = turnaround − all CPU bursts − all time spent on I/O. "Time on I/O" includes the time spent **queueing for the I/O device**. So waiting time counts **only the time in the ready queue**.

![The RR turnaround times drawn as arrows from arrival to completion (Tutorial 3 solutions, slide 8).](tutorial-3-artifacts/q2-rr-turnaround.png)

**Round robin (q = 2):**

| Process | Arrival | Completion | Turnaround | CPU + I/O | Waiting |
|---|---|---|---|---|---|
| P1 | 0 | 19 | 19 | 10 + 2 | **7** |
| P2 | 0 | 3 | 3 | 1 + 0 | **2** |
| P3 | 2 | 10 | 8 | 2 + 1 | **5** |
| P4 | 2 | 5 | 3 | 1 + 0 | **2** |
| P5 | 4 | 17 | 13 | 5 + 2 | **6** |

**SRTF (global, 2 cores):**

| Process | Arrival | Completion | Turnaround | CPU + I/O (incl. device queue) | Waiting |
|---|---|---|---|---|---|
| P1 | 0 | 13 | 13 | 10 + 2 | **1** |
| P2 | 0 | 1 | 1 | 1 + 0 | **0** |
| P3 | 2 | 6 | 4 | 2 + (1 queue + 1 I/O) | **0** |
| P4 | 2 | 3 | 1 | 1 + 0 | **0** |
| P5 | 4 | 11 | 7 | 5 + 2 | **0** |

Check P3 under SRTF: $4 - 2 - 1 - 1 = 0$. P3 never sat in the ready queue; its only delay (3–4) was in the device queue, which is not waiting time. P1's 1 unit is the preemption by P3 (5–6).
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 2</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* **Queue order at the same instant:** new process → preempted process → process returning from I/O. *(Not in the main notes.)*
* **One shared I/O device** serves one process at a time; the others wait in the device queue. *(Not in the main notes.)*
* RR: a burst that ends before the quantum frees the CPU at once. A process that blocks for I/O is **not** preempted; it rejoins the queue when its I/O ends.
* SRTF uses the remaining time of the **current CPU burst**. In global SRTF, a newcomer preempts the running process with the **longest** remaining time.
* Turnaround = completion − arrival. **Waiting = turnaround − CPU bursts − I/O time (including device-queue time)** = ready-queue time only.
:::

</details>

---

## Question 3: Reading a schedule backwards

Consider a set of processes P0–P6 with the following arrival times.

| Process | Arrival Time Instant |
|---|---|
| P0, P1, P4, P5, P6 | 0 (order: P0, P1, P4, P5, P6) |
| P2 | 3 |
| P3 | 9 |

A dual-core schedule of these processes is shown in the figure below.

![The dual-core schedule. I/O: P0 (1–3), P4 (4–7), P2 (7–9). Core 1: P0, P4, P2, P0, P4, P2, P3. Core 2: P5 (0–2), P6 (2–6), P1 (6–12) (Tutorial 3, Question 3).](tutorial-3-artifacts/q3-dual-core-schedule.png){width=75%}

(a) What are the CPU and I/O burst lengths for each process (if there are multiple CPU or I/O bursts for a process, then identify all of them)?

(b) Does the schedule represent partitioned or global multiprocessor scheduling? Identify the scheduling algorithm(s) used in the schedule (select from those covered in the lectures). Justify your answer.

<details class="qa">
<summary><strong>Answer to (a)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
Read each process's boxes left to right, alternating CPU and I/O. Written as (CPU, I/O, CPU):

| Process | Bursts | Where to read them |
|---|---|---|
| P0 | (1, 2, 2) | Core 1 0–1, I/O 1–3, core 1 5–7 |
| P1 | (6) | Core 2 6–12 |
| P2 | (1, 2, 1) | Core 1 4–5, I/O 7–9, core 1 9–10 |
| P3 | (2) | Core 1 10–12 |
| P4 | (3, 3, 2) | Core 1 1–4, I/O 4–7, core 1 7–9 |
| P5 | (2) | Core 2 0–2 |
| P6 | (4) | Core 2 2–6 |

Note P2: its CPU burst ends at 5, but its I/O starts only at 7. The single I/O device is busy with P4 until 7, so P2 waits in the device queue. Don't read the gap as part of a burst.
:::

</details>

<details class="qa">
<summary><strong>Answer to (b)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Several answers are possible.** The official solution checks each option and eliminates the ones that contradict the chart. Assume processes that arrive together join the ready queue in **PID order**.

**Option 1: partitioned.** P1, P5 and P6 always run on core 2; the rest always run on core 1. No process moves between cores, so partitioned fits.

* **Core 2** (P1, P5, P6, all at time 0): it ran P5 (2), P6 (4), P1 (6), shortest first. **FCFS and RR are impossible**: both would run P1 first, since P1 is first in PID order. **SJF or SRTF** fit.
* **Core 1** (P0, P4, P2, P3):
    * **FCFS is impossible.** At 4, P4 leaves for I/O. P0 (back from I/O at 3) and P2 (arrived at 3) are both ready; in PID order P0 is first, so FCFS would run P0 at 4. The chart runs P2.
    * **RR is impossible** for the same reason. (RR would also need $q \ge 3$, since P4 ran 3 units without a break.)
    * **SJF and SRTF fit**: at 4, P2's burst (1) is shorter than P0's (2).

**Option 2: global.**

* **FCFS or RR: impossible.** At time 0, P1 is second in the queue, so it should run at once on the second core, in parallel with P0.
* **SRTF: impossible.** At 3, P2 arrives with a burst of 1, while P6 on core 2 has 3 units left. SRTF would preempt P6. The chart doesn't.
* **SJF: possible**, if SJF uses the length of the **current CPU burst**. At time 1, P4's first burst (3) is shorter than P6's (4), so P4 goes first.
:::

</details>

<details class="qa">
<summary><strong>The method: how to identify a scheduler from a chart</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Not in the main notes** as a method; the steps follow the official answer.

1. **Partitioned or global?** If every process stays on one core, partitioned is possible. If any process runs on two cores, it must be global. (A chart with no migration can still be global.)
2. **Find the decision points:** every moment a core becomes free, or a process arrives or returns from I/O.
3. **At each decision point, ask what each algorithm would pick:**
    * FCFS: the head of the queue (arrival order, PID order for ties).
    * RR: the same, plus a forced switch after $q$.
    * SJF: the shortest **current** burst, but only when a core becomes free.
    * SRTF: the same, and also **preempt** when a shorter process arrives.
4. **One contradiction eliminates an algorithm.** Look especially for a preemption that *should* have happened (rules out SRTF) or a short job that ran before an earlier one (rules out FCFS and RR).
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 3</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* Read bursts as alternating CPU / I/O boxes. A gap between a CPU burst and its I/O is **device-queue time**, not a burst.
* **No migration** → partitioned is possible; **any migration** → global.
* FCFS and RR follow queue order; SJF picks the shortest current burst when a core frees; SRTF also preempts.
* SJF and SRTF compare the **current** CPU burst, not the total.
* Eliminate by contradiction at decision points. Questions like this can have several valid answers.
:::

</details>

---

## Question 4: CPU efficiency under round robin

Measurements of a certain system have shown that the average process runs for time $T$ before blocking on I/O. A process switch requires time $S$, which is effectively wasted (overhead). Define what is meant by CPU efficiency. For round robin scheduling with quantum $Q$, give a formula for the CPU efficiency for each of the following cases:

(a) $Q = \infty$
(b) $Q > T$
(c) $S < Q < T$
(d) $Q = S$
(e) $Q = 0$

<details class="qa">
<summary><strong>Answer: the definition</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Not in the main notes.** The lecture says small quanta cause many context switches, but gives no formula.

![One CPU burst of length T (top) is cut into quanta Q, each followed by a switch S; the last piece is at most Q (Tutorial 3 solutions, slide 15).](tutorial-3-artifacts/q4-efficiency-timeline.png){width=80%}

**CPU efficiency** = useful CPU time ÷ total CPU time.

$$\text{efficiency} = \frac{\text{CPU burst}}{\text{CPU burst} + S \times \#\text{switches}} = \frac{T}{T + S \times \#\text{switches}}$$

The pieces of $T$ (the quanta) add up to exactly $T$. The switches $S$ are **neither part of $T$ nor part of $Q$**. Count the **first** context switch too: the switch that starts the process is also overhead.
:::

</details>

<details class="qa">
<summary><strong>Answer: the five cases</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
The burst $T$ is cut into $\lceil T/Q \rceil$ pieces, and each piece costs one switch.

| Case | Number of switches | Efficiency |
|---|---|---|
| (a) $Q = \infty$ | 1 | $\dfrac{T}{T + S}$ |
| (b) $Q > T$ | 1 | $\dfrac{T}{T + S}$ |
| (c) $S < Q < T$ | $\lceil T/Q \rceil$ | $\dfrac{T}{T + S\lceil T/Q \rceil}$ |
| (d) $Q = S$ | $\lceil T/S \rceil$ | $\dfrac{T}{T + S\lceil T/S \rceil} \approx \dfrac{1}{2}$ |
| (e) $Q = 0$ | $\infty$ | $0$ |

* **(a) and (b):** the quantum never expires inside the burst. The process runs its whole burst after one switch, so RR behaves like FCFS.
* **(d):** $S\lceil T/S \rceil \approx T$, so half the time is switching.
* **(e):** the process never makes progress; all the time goes to switching.
:::

</details>

<details class="qa">
<summary><strong>Recap: concepts in Question 4</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* **Efficiency = useful time ÷ total time = $T / (T + S \times \#\text{switches})$.** *(Not in the main notes.)*
* Number of switches = $\lceil T/Q \rceil$ when $Q < T$, and 1 when $Q \ge T$. **Count the first switch.**
* Large $Q$ → one switch → RR acts like FCFS. $Q = S$ → about 50%. $Q \to 0$ → efficiency → 0.
:::

</details>

---

## Extensions

These test Lecture 3 ideas, and the new rules above, that the tutorial does not ask about. The answers are **unofficial**, worked by hand.

1. **The queue-order rule.** RR with $q = 2$ on one core. P3 arrives at 0 with bursts (CPU 1, I/O 2, CPU 1). P1 arrives at 1 with one CPU burst of 5. P2 arrives at 3 with one CPU burst of 1. Draw the chart and give each waiting time.

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* 0–1: P3 runs its first burst, then does I/O 1–3.
* 1–3: P1 runs (2 of 5; 3 left). Its quantum ends at 3.
* **At 3, three processes join at once:** P2 (new), P1 (preempted), P3 (back from I/O). Queue: **P2, P1, P3**.
* 3–4 P2 (done). 4–6 P1 (1 left). 6–7 P3 (done). 7–8 P1 (done).

| Process | Turnaround | CPU + I/O | Waiting |
|---|---|---|---|
| P1 | $8 - 1 = 7$ | 5 + 0 | 2 (3–4 and 6–7) |
| P2 | $4 - 3 = 1$ | 1 + 0 | 0 |
| P3 | $7 - 0 = 7$ | 2 + 2 | 3 (3–6) |
:::

</details>

2. **SRTF on one core.** P1 (arrival 0, burst 8), P2 (1, 4), P3 (2, 9), P4 (3, 5). Draw the chart and find the average waiting time.

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* 0–1 P1. At 1, P2 (4) is shorter than P1's remaining 7, so P2 preempts.
* 1–5 P2 (P3 at 2 and P4 at 3 are longer than P2's remaining time).
* At 5: P1 has 7, P3 has 9, P4 has 5. 5–10 P4, 10–17 P1, 17–26 P3.

Waiting = completion − arrival − burst: P1 $17 - 0 - 8 = 9$, P2 $5 - 1 - 4 = 0$, P3 $26 - 2 - 9 = 15$, P4 $10 - 3 - 5 = 2$. Average $= 26/4 = 6.5$.
:::

</details>

3. **Efficiency with numbers.** $T = 10$ ms, $S = 1$ ms. Find the efficiency for $Q = 4$ ms and for $Q = 20$ ms.

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* $Q = 4$: $\lceil 10/4 \rceil = 3$ switches. Efficiency $= 10 / (10 + 3) \approx 76.9\%$.
* $Q = 20 > T$: 1 switch. Efficiency $= 10 / 11 \approx 90.9\%$.
:::

</details>

4. Three processes arrive at 0 in the order P1 (24), P2 (3), P3 (3). Find the FCFS average waiting time, then the average if they had arrived as P2, P3, P1. What effect does this show?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
* Order P1, P2, P3: waits 0, 24, 27. Average $= 51/3 = 17$.
* Order P2, P3, P1: waits 0, 3, 6. Average $= 9/3 = 3$.

This is the **convoy effect**: short processes stuck behind one long process wait a long time. FCFS is nonpreemptive, so the long job holds the CPU.
:::

</details>

5. In priority scheduling, what problem can a low-priority process face, and what is the standard fix?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
**Starvation:** higher-priority processes keep arriving, so the low-priority process never runs. The fix is **aging**: raise a process's priority the longer it waits, until it eventually runs. (SJF and SRTF can starve long jobs in the same way.)
:::

</details>

6. RR has 5 processes in the ready queue and $q = 20$ ms. What is the longest a process waits before its next turn? What happens to RR when $q$ is larger than every burst?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
At most $(n-1)q = 4 \times 20 = 80$ ms. This bound is why RR gives good **response time**.

When $q$ exceeds every burst, no quantum ever expires, so RR becomes **FCFS**. From that point, a larger $q$ no longer changes the average turnaround time. (Below that point, turnaround has **no simple relation** to $q$.)
:::

</details>

7. A system uses multilevel queue scheduling with fixed priority: foreground (RR) before background (FCFS). What is the risk, and what alternative avoids it?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
The **background queue can starve** while foreground processes keep the CPU busy. The alternative is **time slices** between queues, for example 80% of CPU time to foreground and 20% to background.
:::

</details>

8. Why is finding the best process-to-core assignment hard in partitioned scheduling?

<details class="qa">
<summary><strong>Answer (unofficial)</strong> <span class="qa-caret" aria-hidden="true"></span></summary>

::: qa-answer
The best assignment is an **NP-hard** problem, similar to the knapsack problem. So systems use heuristics, such as **best-fit** when burst lengths are known. A poor assignment leaves one core idle while another is overloaded.
:::

</details>
