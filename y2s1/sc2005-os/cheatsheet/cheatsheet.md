---
title: "Exam Cheatsheet"
---

This was written entirely with AI.

## 1. The Final Quizzes
The final assessment has two online quizzes in the CCDS labs, in the Respondus Lockdown browser. Both cover the lectures of weeks 1–12 and their tutorials.

| Quiz | Format | Weight | What it tests |
|---|---|---|---|
| **Concept quiz** | 15 multiple-choice questions | 15% | Definitions, comparisons, true/false reasoning |
| **Algorithm quiz** | 6 short-answer questions | 30% | Calculations and traces: schedules, semaphores, Banker's, address translation, page replacement |

This page covers Lectures 1–8. The lectures on file systems and I/O are not released yet.

**How to use this page.** Section 2 lists the traps for the concept quiz, lecture by lecture. Sections 3–9 give a step-by-step method for each type of calculation. Section 10 collects the formulas. The lecture pages explain why each method works.

## 2. Concept-Quiz Traps
Each line is a statement that sounds right but is wrong, or a pair that people mix up.

### 2.1 Overview (Lecture 1)
* A **system call always causes a trap**. An interrupt comes from a device; a trap comes from the running program (an error or a request).
* **All I/O instructions are privileged.** So all I/O goes through the OS.
* **Kernel mode is not root.** Kernel/user is a hardware mode. Root is a user account. A root program still runs in user mode.
* Mode bit: **monitor (kernel) = 0, user = 1**. An interrupt or trap switches the hardware to monitor mode.
* Base/limit: the legal range is **[base, base + limit − 1]**. An access to `base + limit − 1` is legal; `base + limit` traps.
* **DMA still causes interrupts**: one for each block, not one for each byte.
* Interrupt-driven I/O with a fast device causes **many** interrupts, which costs CPU time.
* Windows and Linux on PCs are **time-sharing**, not real-time.
* **Multiprogramming works on one core.** Multiprocessing needs several cores. Multiprogramming is still useful on a multi-core CPU.
* A simple batch system can run on a multiprocessor. The two ideas are independent.

### 2.2 Processes and threads (Lecture 2)
* A process that waits for the CPU is **ready**, not waiting. "Waiting" means waiting for an event or I/O.
* A process leaving **waiting** goes to **ready**, never directly to running.
* When a hardware interrupt arrives, the running process goes to **ready** so the ISR can run.
* `wait()` is called by the **parent** to wait for a child. A child does not use it to get instructions.
* **Message passing uses more memory** than shared memory, because messages are copied through the kernel.
* The **data** region has a fixed size; the **stack** grows and shrinks. Data holds globals; the stack holds locals.
* Threads share **code, data, heap and open files**. Each thread has its own **registers, program counter and stack**.
* Context switches run in **kernel mode**, because PCBs are in kernel memory. A context switch is pure overhead.
* **Many-to-one:** one blocking call blocks all threads. **One-to-one:** too many kernel threads. **Many-to-many:** mapping is hard. There is no one-to-many model.

### 2.3 Scheduling (Lecture 3)
* The scheduler **must** run only when the running process **blocks** (transition 1) or **exits** (transition 5). A new arrival forces it only if a core is idle.
* **Preemptive** means the scheduler can take the CPU away at any time (transitions 2, 3, 4, or any time), not only "at a timer interrupt".
* **SJF/SRTF minimizes average waiting time.** FCFS has the convoy effect. RR has the best response time but usually higher average waiting time.
* RR with **q larger than every burst = FCFS**. A tiny q means many context switches.
* Average turnaround time has **no simple relation** to q, until q exceeds the longest burst.
* **Starvation** affects priority scheduling (and SJF). **Aging** fixes it.
* **Migration overhead** (cache data moving between cores) is a problem of **global** scheduling, not partitioned. Partitioned scheduling has **unequal loads**.
* Increasing RR's quantum, or keeping enough processes in memory (long-/medium-term schedulers), can raise CPU utilization.

### 2.4 Synchronization (Lecture 4)
* **Progress does not imply bounded waiting.** A solution can always favour one process.
* Disabling interrupts gives mutual exclusion **only on one CPU**.
* Busy waiting is **better** when critical sections are short: no context switch.
* A TestAndSet lock gives mutual exclusion and progress, **not bounded waiting**.
* Blocking semaphore: `S.value = −k` means **k processes are waiting** in list L.
* `Wait` and `Signal` must be **atomic**, even in the blocking version. A switch between `S.value--` and the check can break progress or mutual exclusion.
* A semaphore that starts at **0** forces an order (B after A). A mutex starts at **1**.
* In the bounded buffer, waiting for `mutex` **before** `empty`/`full` causes **deadlock**. The order of the Signals does not matter.
* A FIFO semaphore queue prevents starvation; priority or LIFO queues can cause it.
* A process that "cuts the queue" into a free critical section does **not** violate progress (someone still enters). It may violate bounded waiting.

### 2.5 Deadlocks (Lecture 5)
* The four conditions are **necessary, not sufficient**.
* **A cycle does not always mean deadlock.** With single-instance resources it does; with multi-instance resources it only might.
* **No cycle means no deadlock.**
* A deadlock needs **at least two processes** (hold-and-wait needs another process to hold what you wait for).
* **Safe → no deadlock. Unsafe → deadlock possible, not certain.**
* A state is safe if **at least one** safe sequence exists. Other unsafe sequences do not matter.
* In the dining philosophers, **at most four hungry philosophers → no deadlock**.
* **Mutual exclusion usually cannot be broken** (a chopstick cannot be shared).
* **Most OSes, including UNIX and Windows, ignore deadlock.**
* Banker's: a request > Need is an **error**; a request > Available means **wait**; an unsafe result also means **wait**.

### 2.6 Real-time OS and virtualization (Lectures 6a and 6b)
* **Real-time ≠ fast.** Real-time means predictable in the worst case.
* A single process is **⟨R, C, D⟩**; a periodic one is **⟨T, C, D⟩**. The first number changes meaning.
* **RM** = fixed priority, **shorter period** first. **EDF** = dynamic priority, **earlier absolute deadline** first. EDF uses the instance deadline R + D, not D.
* RM is **simpler and predictable under overload**; EDF is **more powerful but unpredictable under overload**.
* **Type 1:** the VMM is the host OS (Xen, vSphere). **Type 2:** the VMM extends a host OS (KVM on Linux), and normal apps run beside VMs.
* **Full virtualization:** unmodified guest. **Para-virtualization:** modified guest with a special API; more efficient.
* The **guest OS** gives its applications an interface to the (virtual) hardware. Managing a guest OS and **its** applications is the guest OS's job, not the hypervisor's.
* Multiplexing = one P, many V. Aggregation = many P, one V. Emulation = one P looks like a different V.

### 2.7 Memory (Lectures 7 and 8)
* **Compaction needs execution-time binding** (relocatable addresses).
* With **load-time binding**, the loader turns relocatable addresses into absolute ones.
* **Worst-fit leaves the largest** leftover hole; **best-fit the smallest**.
* **Paging has internal fragmentation** (last page), **no external**. **Segmentation has external, no internal.** Fixed partitions: internal. Dynamic partitions: external.
* A TLB does **not always** reduce access time: a low hit ratio can make it worse.
* An **inverted page table** must be **searched**: it is ordered by frame, but looked up by page.
* Segments of one process do **not** have to be contiguous.
* The **dirty bit** = written; the **reference bit** = used. Only dirty pages are written back on replacement.
* **FIFO has Belady's anomaly**; OPT and LRU do not.
* **Thrashing**: low CPU utilization with **high** multiprogramming. Adding processes makes it worse.
* **Fixed allocation requires local replacement.** Variable allocation can be local **or** global.

## 3. Scheduling Questions

### 3.1 Method for a one-core Gantt chart
1. Write a table: process, arrival time, burst(s), priority. Keep a list of the **ready queue** in order.
2. Start at time 0. At each **event** (an arrival, a finish, a quantum end, an I/O completion), update the ready queue and decide who runs.
3. For a preemptive algorithm, check at **every arrival** whether the new process should preempt the running one.
4. Draw the boxes, with times under each boundary.
5. Read off finish times, then compute turnaround, waiting and response for each process.

**Conventions to state if the question does not give them:**

* **Ties:** use the arrival order (or the order the question gives, for example "order: 1, 2").
* **RR, two processes join the queue at the same time:** state your order. In the tutorial solutions, a newly arriving process goes into the queue before a process that returns from I/O at the same instant. The preempted process goes to the **end** of the queue after anything that arrived during its quantum.
* **Context-switch time:** zero, unless given.
* A process in an **I/O burst** is not in the ready queue. When its I/O ends, it rejoins the ready queue.

### 3.2 Rules of each algorithm

| Algorithm | When to choose | Whom to choose |
|---|---|---|
| FCFS | When the core is free | Earliest arrival |
| SJF | When the core is free | Shortest **next burst** (no preemption) |
| SRTF | When the core is free **and** at every arrival | Shortest **remaining** time; a new shorter process preempts |
| Priority (preemptive) | When the core is free **and** at every arrival | Smallest priority number (if smaller = higher) |
| Priority (nonpreemptive) | When the core is free | Smallest priority number |
| RR | When the core is free **and** at each quantum end | Head of the ready queue |

### 3.3 Times

$$\text{turnaround} = \text{finish} - \text{arrival}$$
$$\text{waiting} = \text{turnaround} - (\text{all CPU bursts}) - (\text{all I/O bursts})$$
$$\text{response} = \text{first start} - \text{arrival}$$

With one CPU burst and no I/O: waiting = turnaround − burst.

### 3.4 Many cores
* **Partitioned:** draw one one-core chart for each core, with only the processes assigned to it.
* **Global:** at each event, give the free cores to the best ready processes. With preemption (for example SRTF), a new process preempts the running process that is **worst** by the rule (for SRTF: the longest remaining time), and only if the new one is better.

**CPU utilization on c cores:**

$$\text{utilization} = \frac{\text{sum of busy time over all cores}}{\text{total time} \times c}$$

### 3.5 RR efficiency with switch overhead
Let each burst be T, the quantum Q, and the switch time S. Count **one switch to start the burst**, and one at each quantum end.

$$\text{number of switches} = \left\lceil T / Q \right\rceil \qquad \text{efficiency} = \frac{T}{T + S \times \lceil T/Q \rceil}$$

| Case | Switches | Efficiency |
|---|---|---|
| Q = ∞, or Q > T | 1 | T / (T + S) |
| S < Q < T | ⌈T/Q⌉ | T / (T + S⌈T/Q⌉) |
| Q = S | ⌈T/S⌉ | about 1/2 |
| Q → 0 | ∞ | → 0 |

### 3.6 Identify the algorithm from a chart
* A process runs **before** an earlier-arriving one → not FCFS (and not RR from the start).
* A longer process runs while a shorter one waits → not SJF/SRTF at that moment.
* A running process is **not** preempted by a shorter arrival → not SRTF.
* Pieces of equal length that rotate → RR; the piece length gives q.
* Each core runs a fixed group of processes → partitioned; processes appear on several cores → global.

## 4. Critical-Section and Semaphore Questions

### 4.1 Check the three requirements of a solution
1. **Mutual exclusion fails** if you can find **one interleaving** where two processes are inside together. Try a context switch right after each shared-variable write.
2. **Progress fails** if you can find a state where the critical section is free, someone wants to enter, and **no one can** (both spin forever, or one waits for a process that is in its remainder section).
3. **Bounded waiting fails** if one process can enter **again and again** while another waits.

Write the counterexample as a numbered list: process, statement, variable values.

### 4.2 Track a semaphore's value
For a blocking semaphore:

$$\text{value} = \text{start} - (\text{number of Waits}) + (\text{number of Signals})$$

* value > 0: that many processes can still pass `Wait`.
* value < 0: that many processes are blocked in L.
* If h processes hold S (they passed `Wait` and have not signalled) and w processes are blocked: value = start − h − w.
* **Minimum during a sequence:** put all the Waits first. **Maximum:** put all the Signals first. Check that the order is possible (a process cannot Signal a semaphore before it holds it, if the code says so).
* A mutex shared by N processes: maximum 1, minimum 1 − N (one inside, N − 1 blocked).

### 4.3 Design with semaphores
1. List shared **variables** → one binary semaphore (start 1) around each critical section.
2. List each kind of **resource** → one counting semaphore; start = number of units at the start.
3. Take a unit: `Wait`. Give back or create a unit: `Signal`.
4. Must B wait for A? Semaphore starting at 0: `Signal` after A, `Wait` before B.
5. **Order the Waits:** resources first, mutex last. Never block on a resource while holding a mutex.
6. **Never hold two semaphores** if you can avoid it. If you must, take them in the same global order everywhere (to prevent deadlock).
7. Check every path, including the "else" path, releases everything it took.

## 5. Deadlock Questions

### 5.1 Read a resource-allocation graph
1. Find a process whose requests can all be met by **free** instances.
2. Let it finish and free all its instances.
3. Repeat. If all processes finish → no deadlock (write the order). If some cannot → those processes are deadlocked.

### 5.2 Banker's safety algorithm
1. Compute **Need = Max − Allocation** for every process.
2. Work = Available.
3. Find an unfinished process with **Need ≤ Work** (every element). Add its Allocation to Work. Mark it finished.
4. Repeat. All finished → safe, and the order is a safe sequence. Stuck → unsafe.

Check: at the end, Work = the total instances of each type.

### 5.3 Banker's request
1. Request ≤ Need? If not, **error**.
2. Request ≤ Available? If not, **wait**.
3. Pretend: Available −= Request, Allocation += Request, Need −= Request.
4. Run the safety algorithm. Safe → **grant**. Unsafe → **wait** and restore.

### 5.4 "Find the minimum x so the state is safe"
1. Write Available with the unknown x.
2. Find which processes can finish **without** the unknown resource. Let them finish first; add their Allocation.
3. For each remaining process, the unknown type must cover its Need after the others have returned theirs. Take the **largest** such requirement over the order you choose.
4. Choose the order that makes x smallest, and show the full safe sequence with that x.

## 6. Real-Time Scheduling Questions

### 6.1 Build an RM or EDF schedule
1. List each instance: release time R and absolute deadline R + D. For a periodic process ⟨T, C, D⟩, releases are at 0, T, 2T, ….
2. Draw the schedule up to the **least common multiple of the periods** (when all start at 0, the pattern then repeats), or as far as the question asks.
3. **RM:** fixed priorities; shorter T first. **EDF:** at each moment, the released, unfinished instance with the earliest absolute deadline.
4. At every release, check for preemption.
5. Check each instance: did it get C units before its deadline? If any did not, the set is **not schedulable** under that algorithm.
6. With **ties** (equal priority or equal deadline), each choice gives a different valid schedule. If asked for "all possible schedules", branch at each tie.

## 7. Memory-Organization Questions

### 7.1 Hole allocation (first-, best-, worst-fit)
1. List the holes in address order: start address and size. (A hole's end = start + size − 1.)
2. For each request in order, choose the hole by the rule. Allocate from the **start** of the hole; the hole shrinks.
3. If no hole fits and compaction is allowed: move partitions toward low addresses (as the question says) until a hole is big enough. Count the total memory moved if asked.

### 7.2 Address formats

* Page size $2^n$ → offset = **n bits**.
* Logical address of m bits → page number = **m − n bits**; entries in a normal page table = $2^{m-n}$.
* Physical memory of $2^k$ bytes → physical address = **k bits**; frame number = **k − n bits**; frames = $2^{k-n}$.
* **Inverted page table entries = number of frames** = physical memory ÷ page size.
* Page-table size = entries × entry size.

### 7.3 Number of page-table levels
1. Entries in one page of page table = page size ÷ entry size = $2^e$. So each level index has **e bits**.
2. Page-number bits = m − n.
3. Levels = ⌈(m − n) ÷ e⌉. The outermost level may have fewer bits.
4. Write the address as p1 | p2 | … | d, with the bit counts.

### 7.4 Translate a paged address
1. Write the logical address in binary (or split by dividing by the page size).
2. Page number p = the high bits; offset d = the low n bits.
3. Look up p → frame f. If the entry is invalid → no physical address (page fault).
4. Physical address = f followed by d = f × page size + d.

### 7.5 Translate a segment address
1. ⟨s, d⟩ (if given one binary number, the high bits are s and the low bits are d, with d's width = log2 of the **maximum segment size**).
2. Look up s → base, limit.
3. If d ≥ limit → **trap** (addressing error).
4. Physical address = base + d.

### 7.6 TLB effective access time
ε = TLB lookup time, μ = memory access time, α = hit ratio:

$$\text{EAT} = (\mu + \varepsilon)\alpha + (2\mu + \varepsilon)(1 - \alpha) = (2 - \alpha)\mu + \varepsilon$$

* Without a TLB: EAT = 2μ.
* Minimum α for the TLB to help: solve (2 − α)μ + ε ≤ 2μ, which gives α ≥ ε / μ.
* If the question says the TLB lookup takes zero time, set ε = 0.

## 8. Virtual-Memory Questions

### 8.1 Demand-paging EAT

$$\text{EAT} = (1 - p) \times \text{memory access} + p \times \text{page-fault time}$$

To find the largest p for a target EAT, solve for p. Convert all times to the same unit (ms vs ns).

### 8.2 Page-replacement tables
1. Draw a table: one column for each reference, one row for each frame, and a row for faults.
2. Fill the frames in order while free frames exist (each first reference is a fault).
3. On a hit, copy the column and mark nothing (but update recency for LRU, or set R = 1 for clock).
4. On a fault with full frames, pick the victim by the rule:
    * **FIFO:** the page **loaded** earliest. Keep a queue of load order. A hit does **not** change the queue.
    * **OPT:** look **ahead**; the page whose next use is furthest away, or never used again.
    * **LRU:** look **back**; the page whose last use is furthest in the past.
    * **Clock:** start at the hand. R = 1 → clear to 0, advance. R = 0 → replace here, advance one. New pages start with R = 0 (as in the lecture's example). A hit sets R = 1 and does not move the hand.
5. Count the faults.

**Given a table of load time, last-access time and R bit:**

* FIFO → smallest **load** time.
* LRU → smallest **last-access** time.
* Second chance → go through pages in **load** order; skip (and clear) pages with R = 1; replace the first with R = 0.

### 8.3 Bounds on page faults
A reference string of length L with N different pages, M frames, starting empty:

* **Lower bound = N** (each page's first reference faults).
* **Upper bound = L** when N > M (every reference can fault). When N ≤ M, the count is exactly N.
* The same bounds hold for FIFO and LRU.

### 8.4 Working set
* The working set at time t = the set of **different** pages in the last Δ references up to t.
* WSS = the number of pages in that set.
* If Σ WSS > total frames → thrashing; suspend a process.

### 8.5 Locality of a loop
For an array stored row by row: the loop that walks along rows (row index outside, column index inside) touches consecutive memory → fewer pages → fewer faults. Walking down columns touches a new row (often a new page) each time.

## 9. Short Answers: What a Good Answer Contains
* **True/false with justification:** state the rule, then apply it to the case. One counterexample is enough to show "false".
* **Name the mechanism:** for example "TLB miss → two memory accesses", "valid–invalid bit is i → page fault".
* **State your assumptions** when the question is silent (tie-breaking, context-switch time, initial values).
* **Show the table** (Gantt chart, Banker's Work column, page-replacement grid). Marks often go to the steps.

## 10. Formula Sheet

| Quantity | Formula |
|---|---|
| Legal address (base/limit, absolute) | base ≤ addr < base + limit |
| Legal address (execution-time binding) | addr < limit; physical = addr + base |
| Turnaround time | finish − arrival |
| Waiting time | turnaround − CPU bursts − I/O bursts |
| Response time | first run − arrival |
| CPU utilization (c cores) | busy time ÷ (total time × c) |
| RR maximum wait for a turn | (n − 1) × q |
| RR efficiency | T ÷ (T + S × ⌈T/Q⌉) |
| Blocking semaphore value | start − Waits + Signals; negative = number waiting |
| Banker's Need | Max − Allocation |
| Page number / offset bits | (m − n) / n, for $2^m$ address space and $2^n$ page size |
| Page-table entries | $2^{m-n}$ |
| Inverted page-table entries | number of frames |
| Paged physical address | frame × page size + offset |
| Segment physical address | base + d (if d < limit) |
| TLB EAT | (2 − α)μ + ε |
| Demand-paging EAT | (1 − p) × memory time + p × fault time |
| Working-set demand | D = Σ WSS_i; thrashing if D > m |
| RAID 0 / 1 / 5 usable size | N × n / N (n = 2) / N × (n − 1) |
