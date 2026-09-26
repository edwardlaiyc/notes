::: {.cheatsheet}
::: {.cheatsheet-panel}

## 1. Master Formula Table

| Category | Parameter / Scenario | Master Formula | Units & Critical Invariants |
| :--- | :--- | :--- | :--- |
| **Resilience & Reliability** | Link Operational Relations | $\text{MTBF} = \text{MTTF} + \text{MTTR}$ | $\text{MTTF}$: uptime, $\text{MTTR}$: repair downtime |
| | Availability ($r$) & Unavailability ($b$) | $r = \frac{\text{MTTF}}{\text{MTBF}}, \quad b = \frac{\text{MTTR}}{\text{MTBF}} = 1 - r$ | Steady-state probabilities: $r + b = 1$ |
| | Allowable Annual Downtime | $\text{Downtime} = b \times T_{\text{year}}$ | $T_{\text{year}} = 365 \times 24 \times 3600 = 31{,}536{,}000\text{ s}$ |
| | The "$k$ Nines" Rule | $b = 10^{-k} \iff r = 1 - 10^{-k}$ | 3 nines: $b = 10^{-3}$; 6 nines: $b = 10^{-6}$ ($31.5\text{ s/yr}$); 8 nines: $b = 10^{-8}$ |
| | Max Allowable Failures / Year | $\text{Failures}_{\max} = \lfloor \frac{\text{Allowable Downtime}}{\text{MTTR}} \rfloor$ | E.g., 6 nines & $\text{MTTR}=10\text{s} \implies \lfloor 31.536 / 10 \rfloor = \mathbf{3\text{ failures}}$ |
| | Series Link Reliability Budget | $r_{\text{series}} = (1 - b)^n \ge 1 - 10^{-k} \implies n \approx \frac{10^{-k}}{b}$ | Fails if **any** link breaks; $n \le \frac{\ln(1 - 10^{-k})}{\ln(1 - b)}$ |
| | Parallel Link Redundancy | $b_{\text{parallel}} = p^n \le (1 - r_{\text{target}}) \implies n \ge \frac{\ln(1 - r_{\text{target}})}{\ln(p)}$ | Fails only if **all** $n$ redundant links break simultaneously |
| **Flow & Error Control** | Frame Transmission Delay | $T_f = \frac{L}{R}$ | $L$: frame size in bits ($\text{Bytes} \times 8$), $R$: bitrate in bps |
| | Signal Propagation Delay | $T_p = \frac{D}{V} = D \times \text{delay factor}$ | $D$: distance in m, $V \approx 2 \times 10^8\text{ m/s}$ ($100\text{ m}\mu\text{ s}$ in cable) |
| | Normalized Propagation Delay | $a = \frac{T_p}{T_f} = \frac{D \cdot R}{V \cdot L}$ | $a < 1$: Tx dominates; $a > 1$: Propagation dominates |
| | Base Confirmation Cycle | $T_{\text{cycle}} = T_f + 2T_p = T_f(1 + 2a)$ | Round-trip confirmation time (negligible ACK length) |
| | Stop-and-Wait (S&W) Utilization | $U_{\text{SaW}} = \frac{1 - P}{1 + 2a}$ | Error-free: set frame error probability $P = 0$ |
| | Sliding Window / ARQ Utilization | $U = \begin{cases} 1 - P & W \ge 1 + 2a \\ \dfrac{W(1 - P)}{1 + 2a} & W < 1 + 2a \end{cases}$ | Standard course exam convention: use for both SR and GBN<br>$\text{Throughput} = U \times R$ |
| | Window Size ($W$) Upper Bounds | Flow Control: $W \le 2^k$<br>Go-Back-N ARQ: $W \le 2^k - 1$<br>Selective Reject ARQ: $W \le 2^{k-1}$ | $k$: sequence bits in header<br>GBN: $W_{\text{rx}} = 1$<br>SR: $W_{\text{rx}} = W_{\text{tx}} \implies k = \lceil \log_2 W \rceil + 1$ |
| | Multi-Hop Buffer Equilibrium | $T_{\text{cycle, egress}} \le \frac{T_{\text{cycle, ingress}}}{W_{\text{ingress}}}$ | Service cycle time $\le$ average arrival interval |
| **Medium Access Control** | Pure ALOHA Throughput | $S = G e^{-2G} \implies S_{\max} = \frac{1}{2e} \approx 18.4\%$ | Vulnerable window $= 2T_f$; peak at offered load $G^* = 0.5$ |
| | Slotted ALOHA Throughput | $S = G e^{-G} \implies S_{\max} = \frac{1}{e} \approx 36.8\%$ | Vulnerable window $= 1T_f$; peak at $G^* = 1.0 \implies p^* = 1/n$ |
| | Cascaded ALOHA Path ($X \to Y \to Z$) | $S_{\text{total}} = G e^{-G} \cdot e^{-2G} = G e^{-3G}$ | Peak at $G^* = 1/3 \implies S_{\max} = \frac{1}{3e} \approx 12.3\%$ |
| | CSMA/CD Minimum Frame Size | $T_f \ge 2\tau_{\text{end-to-end}} \implies L_{\min} = 2\tau R \iff R_{\max} = \frac{L_{\min}}{2\tau}$ | Collision detection condition: $2\tau = 2(\sum \tau_{\text{cable}} + \sum \tau_{\text{repeater}})$ |
| | Classic Ethernet Constraints | Min Frame: $64\text{ B}$ (512 bits) $\implies$ Min Payload: $46\text{ B}$ | MAC overhead: $18\text{ B}$ (Preamble & SFD **not** counted!) |
| | Binary Exponential Backoff (BEB) | $K \in \{0, 1, 2, \dots, 2^{\min(i, 10)} - 1\}$ | Slot delay $= K \times 51.2\ \mu\text{s}$; abort after 16 failed attempts |
| | MARP Throughput (Reservation) | Piggybacked: $S = \frac{u}{(u - v) + \frac{v}{S_r}} = \frac{\mu + v}{\mu + \frac{v}{S_r}}$<br>No Data: $S = \frac{u}{u + \frac{v}{S_r}}$ | $u$: total frame bits, $v$: reservation bits, $\mu = u - v$<br>$S_r$: Phase 1 MAC utilization |
| **Delay & Switching** | Uniform Pipelined Packet Delay | $T_{\text{Packet}} = (P + k - 1)\frac{p}{b} + k \cdot d$ | $P$: packets, $p$: packet bits, $k = N_{\text{nodes}} - 1$ hops |
| | Circuit Switching Latency | $T_{\text{Circuit}} = s + \frac{x}{b} + k \cdot d$ | $s$: circuit setup time, $x$: message bits |
| | Switching Crossover Criterion | $T_{\text{Packet}} < T_{\text{Circuit}} \iff (k - 1)\frac{p}{b} < s$ | **Independent** of message size $x$ and prop delay $d$ |
| | Switch Latency Equivalence | $D_{\text{eq}} = T_{\text{switch}} \times V, \quad D_{\text{extra}} = N_{\text{switches}} \times D_{\text{eq}}$ | Negligible if $\frac{D_{\text{extra}}}{D_{\text{total}}} < 5\%$ |

:::

::: {.cheatsheet-sheet}
::: {.cheatsheet-column}
::: {.cheatsheet-panel}

## 2. Tested MCQ Question Patterns & Plug-and-Chug Steps

### Pattern 1: Maximum Serial Links for Given Reliability
* **Trigger:** *"A WAN path consists of $n$ serial links, each with failure probability $p$. Find maximum $n$ to guarantee $k$ nines."*
* **Formula:** $(1 - p)^n \ge 1 - 10^{-k} \implies n \cdot p \le 10^{-k} \implies n \le \frac{10^{-k}}{p}$.
* **Fast Test:** $p = 10^{-4}$, target 3 nines ($1 - 10^{-3}$):
  $$n \le \frac{10^{-3}}{10^{-4}} = \mathbf{10\text{ links}}.$$

---

### Pattern 2: Max Failures per Year from MTTR
* **Trigger:** *"Carrier-grade network (6 nines). MTTR is $T_{\text{repair}}$. Find maximum allowable non-overlapping failures per year."*
* **Execution Steps:**
  1. Total annual downtime budget $= 10^{-6} \times 31{,}536{,}000\text{ s} = 31.536\text{ seconds}$.
  2. Max failures $= \lfloor \frac{31.536}{\text{MTTR}} \rfloor$.
* **Fast Test:** For $\text{MTTR} = 10\text{ s} \implies \lfloor \frac{31.536}{10} \rfloor = \mathbf{3\text{ failures/year}}$.

---

### Pattern 3: Parallel Redundancy Sizing
* **Trigger:** *"Link failure probability is $p$. How many parallel links are needed to achieve availability $\ge r_{\text{target}}$?"*
* **Formula:** $p^n \le (1 - r_{\text{target}})$.
* **Fast Test:** $p = 0.3$, target $\ge 0.99 \implies 0.3^n \le 0.01$:
  * $n=1: 0.3$; $n=2: 0.09$; $n=3: 0.027$; $n=4: 0.0081 \le 0.01 \implies \mathbf{n = 4\text{ links}}$.

---

### Pattern 4: Alternative Parallel Links (S&W vs. Sliding Window)
* **Trigger:** *"Link 1 uses Stop-and-Wait; Link 2 uses Sliding Window. Find min window size $W$ for Link 2 to outperform Link 1."*
* **Execution Steps:**
  1. Compute S&W throughput on Link 1: $\text{Tput}_1 = \frac{L}{T_{f1} + 2T_{p1}}$.
  2. Write sliding window throughput on Link 2: $\text{Tput}_2 = W \times \frac{L}{T_{f2} + 2T_{p2}}$ (assuming $W < 1 + 2a$).
  3. Set $\text{Tput}_2 > \text{Tput}_1$ and solve for $W$:
     $$W > \frac{T_{f2} + 2T_{p2}}{T_{f1} + 2T_{p1}} \implies W = \lceil W \rceil.$$

---

### Pattern 5: Selective Reject Window Size & Header Sequence Bits
* **Trigger:** *"Given $R, L, T_p$, error $P$, find min window $W$ for target throughput and sequence bits $k$."*
* **Execution Steps:**
  1. Compute $T_f = \frac{L\text{ (bytes)} \times 8}{R}$, $a = \frac{T_p}{T_f}$, and target utilization $U = \frac{\text{Target Throughput}}{R}$.
  2. Window size: $W = \lceil \frac{U(1 + 2a)}{1 - P} \rceil$.
  3. Header sequence bits for Selective Reject ($W \le 2^{k-1}$):
     $$k \ge \lceil \log_2 W \rceil + 1.$$
* **Fast Test:** $R = 640\text{ kbps}, L = 400\text{B} = 3200\text{ b} \implies T_f = 5\text{ ms}$. $T_p = 8\text{ ms} \implies a = 1.6$. $P = 0.2$. Target $= 512\text{ kbps} \implies U = 0.8$.
  $$W \ge \frac{0.8(1 + 2(1.6))}{1 - 0.2} = \frac{0.8(4.2)}{0.8} = 4.2 \implies \mathbf{W = 5}.$$
  $$5 \le 2^{k-1} \implies 2^3 < 5 \le 2^4 \implies k - 1 = 3 \implies \mathbf{k = 4\text{ bits}}.$$

---

:::
:::

::: {.cheatsheet-column}
::: {.cheatsheet-panel}

### Pattern 6: HDLC Frame Parsing & Supervisory Control
* **Trigger:** *"Station B receives $I(4, 6)$, then $\text{SREJ}(6)$ or $\text{RNR}(4)$."*
* **Protocol Invariants:**
  * In $I(N_S, N_R)$, $N_S$ is the frame's sequence number; $N_R$ acknowledges all frames up to $N_R - 1$ and requests frame $N_R$.
  * `RR(n)`: Cumulative ACK; acknowledges up to $n-1$, ready to receive $n$.
  * `RNR(n)`: Acknowledges all frames up to $n-1$, but **closes receive window** (tells peer to stop sending).
  * `SREJ(n)`: Out-of-order frame detected; retransmit **only frame $n$**. Subsequent valid frames are buffered.
  * If B sent frames 6 and 7, and A returns $\text{SREJ}(6) \implies$ **Frame 6 was lost, but Frame 7 was received and buffered**.

---

### Pattern 7: CSMA/CD Maximum Bitrate or Cable Length
* **Trigger:** *"Find max transmission rate $R$ or max segment length given $L_{\min}$ and repeaters."*
* **Execution Steps:**
  1. Constraint: $T_f \ge 2\tau_{\text{end-to-end}} \implies L_{\min} = 2\tau R$.
  2. Max Bitrate: $R_{\max} = \frac{L_{\min}}{2\tau_{\text{end-to-end}}}$.
  3. Max Segment Length:
     $$\tau_{\text{end-to-end}} = \frac{L_{\min}}{2R} \implies \tau_{\text{cable}} = \tau_{\text{end-to-end}} - \sum \tau_{\text{repeaters}}.$$
     $$\text{Segment Length} = \frac{\tau_{\text{cable}} \times V}{N_{\text{segments}}}.$$

---

### Pattern 8: Backoff Contention Event Probabilities
* **Trigger:** *"Stations collide on a hub/bus. Find probability that the next event is success or collision."*
* **Core Rule:** An idle slot (where no stations transmit) does **not** count as an event.
* **3 Stations Colliding (Choices $\{0, 1\}$):**
  * Total outcomes $= 2^3 = 8$.
  * Collision outcomes: All pick 0 (1), two pick 0 (3), all pick 1 (1) $\implies 5$ outcomes.
  * $P(\text{Collision next}) = \frac{5}{8} = \mathbf{0.625}; \quad P(\text{Success next}) = \frac{3}{8} = \mathbf{0.375}$.
  * $P(\text{Station A specifically succeeds next}) = \frac{1}{8} = \mathbf{0.125}$.
* **4 Stations Colliding (Choices $\{0, 1\}$):**
  * Total outcomes $= 2^4 = 16$.
  * Success in slot 0 requires exactly 1 station in slot $0 \implies \binom{4}{1} = 4$.
  * $P(\text{Success in slot 0}) = \frac{4}{16} = \mathbf{0.25}$.

---

### Pattern 9: Non-Uniform Packet Pipelining Delay
* **Trigger:** *"Packets of different sizes (e.g., 1000B, 4000B, 2000B) sent over intermediate routers."*
* **Method:** Never use $(P + k - 1)T_x$. Construct a hop-by-hop forwarding timeline:
  * Store-and-Forward: Hop $m$ cannot transmit Packet $i$ until all bits of Packet $i$ have arrived from Hop $m-1$.
  * Interface Contention: Hop $m$ cannot transmit Packet $i$ if it is still transmitting Packet $i-1$.
* **Fast Test:** Sizes 1000B ($4\text{ ms}$), 4000B ($16\text{ ms}$), 2000B ($8\text{ ms}$) at $R = 2\text{ Mbps}$ across 2 intermediate routers ($k = 3$ hops):
  * **Hop 1:** P1: $[0, 4]$, P2: $[4, 20]$, P3: $[20, 28]$.
  * **Hop 2:** P1: $[4, 8]$. P2 arrives at 20 $\implies [20, 36]$. P3 arrives at 28, but Hop 2 is busy until 36 $\implies$ P3: $[36, 44]$.
  * **Hop 3:** P1: $[8, 12]$. P2 arrives at 36 $\implies [36, 52]$. P3 arrives at 44, but Hop 3 is busy until 52 $\implies$ P3: $[52, 60]$.
  * **Total Time:** $\mathbf{60\text{ ms}}$.

---

### Pattern 10: Uniform Packet Pipelining Rate Dimensioning
* **Trigger:** *"Message size $X$, split into $P$ packets with header $H$ over $N$ nodes. Find min data rate $b$ for total delay $\le T$."*
* **Execution Steps:**
  1. Hops $k = N_{\text{nodes}} - 1$.
  2. Packet size $p = \left(\frac{X}{P} + H\right) \times 8\text{ bits}$.
  3. Total transmission intervals $= P + k - 1$.
  4. Link rate: $b \ge \frac{(P + k - 1) \cdot p}{T}$.

---

## 3. High-Yield Conceptual Reference & Trivia

### Historical Inventors / Internet Pioneers Matching
* **TCP/IP:** Vinton Cerf & Robert Kahn
* **Ethernet:** Robert Metcalfe
* **Packet Switching Theory:** Leonard Kleinrock
* **Electronic Mail (Email):** Ray Tomlinson
* **World Wide Web (WWW):** Tim Berners-Lee
* **ALOHA Protocol:** Norman Abramson

### Protocol Behavior Across Normalized Delay ($a$)
* **ALOHA Independence:** ALOHA throughput is flat across varying $a$ because stations transmit blindly without sensing the carrier. Performance depends solely on frame transmission duration ($T_f$).
* **Why Slotted ALOHA Beats CSMA/CD at Large $a$ ($a \to 1$ or $a > 1$):**
  * When $a$ is large, propagation delay ($T_p$) is long compared to transmission delay ($T_f$).
  * Carrier sensing detects outdated channel states, and CSMA/CD's worst-case collision window ($2a$) wastes substantial channel capacity.
  * Slotted ALOHA confines collisions strictly to discrete slot boundaries, maintaining stable performance.
* **CSMA Persistence Comparison:**
  * **1-Persistent:** Senses idle $\to$ transmits immediately ($p=1$). Zero idle delay under light loads; high collision rate under heavy loads.
  * **Non-Persistent:** Senses busy $\to$ random backoff before re-sensing. Greatly reduces collision under heavy load; wastes capacity idling under light load.
  * **$p$-Persistent:** Slotted; transmits with probability $p$. Balances low collisions and reduced idle latency by tuning $p$.

### Sliding Window Buffer Edge Mechanics
* **Sender Window:**
  * Trailing edge (left) advances when **valid ACKs are received**.
  * Leading edge (right) advances when **new frames are transmitted**.
* **Receiver Window:**
  * Trailing edge (left) advances when **in-order frames are received and delivered to upper layer**.
  * Leading edge (right) advances when **ACKs are dispatched**.

---

## 4. Rapid MCQ Elimination Rules

* **Destination MAC Parity (Inspect 2nd Hex Digit from Left):**
  * `X[Even]:XX:XX:XX:XX:XX` (`0, 2, 4, 6, 8, A, C, E`) $\implies$ **Unicast**.
  * `X[Odd]:XX:XX:XX:XX:XX` (`1, 3, 5, 7, 9, B, D, F`) $\implies$ **Multicast**.
  * `FF:FF:FF:FF:FF:FF` $\implies$ **Broadcast**.
  * *Trap check:* A **Source MAC** address is always unicast; its 2nd character can **never** be odd.

* **MAC Throughput Upper Bounds:**
  * Pure ALOHA maximum throughput is $\mathbf{18.4\%}$ ($\frac{1}{2e}$).
  * Slotted ALOHA maximum throughput is $\mathbf{36.8\%}$ ($\frac{1}{e}$).
  * Eliminate any MCQ choice claiming higher throughput for ALOHA.

* **Layer 2 vs. Layer 3 Router Behavior:**
  * Intermediate routers **strip and discard** the incoming Layer 2 header and trailer ($DH/DT$) and build a new Layer 2 frame on every hop.
  * The Layer 3 Network header ($NH$), Transport header ($TH$), and application data **never change** across intermediate hops.

* **Switching Crossover Invariant:**
  * In the condition $(k - 1)\frac{p}{b} < s$, total message length $x$ and propagation delay $d$ cancel out.
  * Altering message size $x$ has **zero effect** on whether packet switching is faster than circuit switching.

* **Collision vs. Broadcast Domains:**
  * **Hub / Repeater (Layer 1):** 1 collision domain, 1 broadcast domain across all ports (splits nothing).
  * **Switch / Bridge (Layer 2):** Each physical port is an isolated collision domain; all ports share 1 broadcast domain.
  * **Router (Layer 3):** Each physical interface represents an isolated collision domain **and** an isolated broadcast domain.

* **Virtual Circuit vs. Circuit Switching:**
  * Virtual circuits **do not** reserve dedicated physical bandwidth (bandwidth is dynamically shared).
  * Virtual circuit control planes **do** require connectionless packet routing capability to forward setup packets.

---

## 5. Exam Trap Radar

* **Hop Count vs. Node Count:**
  * A network path with $N$ nodes has **$k = N - 1$ hops**.
  * In pipelining formulas, use $(P + k - 1)$, **never** $(P + N - 1)$.
* **Byte to Bit Conversions:**
  * Packet sizes and frame lengths are almost always given in **Bytes**, while transmission rates are given in **bps (bits/second)**.
  * Multiply Bytes by $8$ before calculating transmission delay: $T_f = \frac{\text{Bytes} \times 8}{R}$.
* **Preamble Exclusion in Ethernet:**
  * Total minimum frame size is **64 bytes** (512 bits).
  * Preamble (7B) and SFD (1B) are physical-layer synchronization patterns and **do not count** toward the 64-byte frame minimum.
  * MAC overhead is **18 bytes** (6B DA + 6B SA + 2B Type + 4B FCS) $\implies$ Minimum payload is **46 bytes**.
* **ARQ Window Sizing Upper Bounds:**
  * Flow control only: $W \le 2^k$.
  * Go-Back-N ARQ: $W \le 2^k - 1$ (because $W_{\text{rx}} = 1$).
  * Selective Reject ARQ: $W \le 2^{k-1}$ (because $W_{\text{rx}} = W_{\text{tx}}$).
* **MARP Utilization Denominator:**
  * If the reservation frame carries **no data**, denominator is $u + \frac{v}{S_r}$.
  * If the reservation frame **piggybacks** $v$ data bits, remaining data transmission duration is reduced to $u - v$, making the denominator $(u - v) + \frac{v}{S_r}$.

:::
:::
:::
:::
