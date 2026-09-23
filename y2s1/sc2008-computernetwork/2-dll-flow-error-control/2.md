# Data Link Layer (DLL): Flow & Error Control

## 1. Universal Timing & Channel Parameters

### 1.1 Fundamental Time Metrics
* **Frame Transmission Delay ($T_{\text{frame}}$ or $T_f$):** The time required to inject all bits of a frame onto the physical wire:
  $$T_f = \frac{L}{R}$$
  * $L$: Frame length in bits (convert bytes by multiplying by 8).
  * $R$: Link transmission rate in bits per second (bps).
* **Signal Propagation Delay ($T_{\text{prop}}$ or $T_p$):** The time needed for a single physical bit to travel from sender to receiver across the physical link:
  $$T_p = \frac{D}{V} \quad \text{or} \quad T_p = D \times \text{delay factor}$$
  * $D$: Distance between sender and receiver in meters.
  * $V$: Propagation speed in the medium (typically $2 \times 10^8\text{ m/s}$ in copper/fiber).
* **Total Cycle Time ($T_{\text{cycle}}$):** The complete elapsed time from the start of frame transmission until the acknowledgment (ACK) returns:
  $$T_{\text{cycle}} = T_{\text{frame}} + T_{\text{prop}} + T_{\text{proc}} + T_{\text{ack}} + T_{\text{prop}} + T_{\text{proc}}$$
  * Standard course assumption: Processing delay and ACK transmission time are negligible ($T_{\text{proc}} \approx 0, T_{\text{ack}} \approx 0$).
  * Simplified cycle time:
    $$T_{\text{cycle}} = T_f + 2T_p$$

![Stop-and-Wait Timing](2-artifacts/stop-and-wait.png)

---

### 1.2 Normalized Propagation Delay ($a$)
The parameter $a$ represents the ratio of propagation delay to transmission delay:
$$a = \frac{T_p}{T_f} = \frac{D \cdot R}{V \cdot L}$$

* **Physical Regimes:**
  * **$a < 1$ (Transmission Dominates):** The frame is long or the link is short/slow ($T_f > T_p$). Most of the cycle time is spent actively transmitting data bits.
  * **$a > 1$ (Propagation Dominates):** The link is fast or the distance is long ($T_p > T_f$). After transmitting the frame, the sender spends most of the cycle waiting idly for the round-trip signal propagation.

---

### 1.3 Link Utilization ($U$)
Link utilization is the fraction of total cycle time during which the link actively carries useful data bits:
$$U = \frac{T_{\text{useful}}}{T_{\text{cycle}}}$$

---

## 2. Flow Control (Error-Free Transmission)

Flow control ensures a fast sender does not overwhelm a slow receiver's internal memory buffers with data.

### 2.1 Stop-and-Wait Flow Control
* **Operational Rule:** The sender transmits 1 frame, halts, and waits for an explicit ACK from the receiver before transmitting the next frame.
* **Sequence Numbering:** Uses a 1-bit alternating sequence number ($0$ and $1$).
  * Frame alternate: $F_0, F_1, F_0, F_1, \dots$
  * Meaning of $\text{ACK}_n$: Cumulative; indicates the receiver has successfully received frame $F_{1-n}$ and is expecting frame $F_n$ next.
* **Link Utilization:**
  $$U_{\text{SaW}} = \frac{T_f}{T_f + 2T_p} = \frac{1}{1 + 2a}$$

---

### 2.2 Sliding Window Flow Control
Sliding window allows multiple unacknowledged frames to remain in transit simultaneously, keeping the transmission pipe full.

![Sliding Window N and k](2-artifacts/sliding-window-n-and-k.png)

* **Window Size ($N$ or $W$):** The maximum number of frames the sender can transmit without receiving an ACK.
* **Sequence Number Space ($k$ bits):** Frames are numbered modulo $2^k$, ranging from $0$ to $2^k - 1$.
* **Theoretical Sequence Bound:** To prevent sequence number ambiguity between fresh frames and duplicate retransmissions in error-free flow control:
  $$N \le 2^k$$
* **Window Edge Movement Invariants:**
  * **Sender Window ($W_{\text{tx}}$):** Trailing edge (left) moves forward when frames are **sent**; leading edge (right) moves forward when **ACKs are received**.
  * **Receiver Window ($W_{\text{rx}}$):** Trailing edge (left) moves forward when frames are **received**; leading edge (right) moves forward when **ACKs are sent**.

![Sliding Window](2-artifacts/sliding-window.png)

* **Control Signals:**
  * **Receive Ready ($\text{RR}(n)$ or $\text{ACK}_n$):** Acknowledges all frames up to $n - 1$ and indicates readiness to receive frame $n$.
  * **Receive Not Ready ($\text{RNR}(n)$):** Acknowledges frames up to $n - 1$ but closes the window, temporarily halting sender transmissions until an $\text{RR}$ is sent.
  * **Piggybacking:** Reverse-direction acknowledgments and sequence numbers are carried directly inside outgoing data frame headers.

---

### 2.3 Sliding Window Performance (Error-Free)
Normalizing frame transmission time to $T_f = 1$ (making base cycle duration $1 + 2a$):

* **Case I: Full Pipe ($N \ge 1 + 2a$)**
  * The window is large enough that the sender can transmit continuously until the first ACK arrives at $t = 1 + 2a$.
  * The link experiences zero idle time:
    $$U = 1.0 \quad (100\%)$$

* **Case II: Window Exhaustion ($N < 1 + 2a$)**
  * The sender exhausts its window of $N$ frames at $t = N$ and must sit idle until $t = 1 + 2a$ for the first ACK.
  * Utilization is bounded by the window size:
    $$U = \frac{N}{1 + 2a}$$

![Window Exhaustion](2-artifacts/window-exhaustion.png)

![Link Utilization vs. Normalized Propagation Delay (a)](2-artifacts/link-utilization-vs-a.png)

---

## 3. Error Control: Automatic Repeat Request (ARQ)

When frames are lost or corrupted by bit errors (detected via CRC), ARQ protocols trigger retransmissions to ensure reliable delivery.

### 3.1 Stop-and-Wait ARQ
* **Sender Behavior:** Emits one frame and starts a retransmission timer.
  * If $\text{ACK}$ arrives before timeout: Sends next frame.
  * If timer expires (lost frame or lost ACK) or explicit $\text{NAK}$ is received: Retransmits the same frame.
* **Duplicate Handling:** If an ACK is lost, the sender retransmits the frame. The receiver inspects the alternating sequence number, recognizes the duplicate, discards the payload, and retransmits the ACK to keep both sides synchronized.
* **Utilization with Independent Frame Error Probability $P$:**
  $$U_{\text{SaW}}^{\text{ARQ}} = \frac{1 - P}{1 + 2a}$$

![Stop-and-Wait ARQ](2-artifacts/stop-and-wait-arq.png)

![Stop-and-Wait ARQ Example](2-artifacts/stop-and-wait-arq-example.png)

---

### 3.2 Go-Back-N ARQ (GBN)
* **Mechanics:**
  * **Receiver Window ($W_{\text{rx}} = 1$):** Accepts frames strictly in sequence. It has zero buffer space for out-of-order frames.
  * **Sender Window ($W_{\text{tx}} = N$):** Maintains a buffer of up to $N$ unacknowledged transmitted frames.
  * If frame $n$ is damaged or missing, the receiver sends a Reject ($\text{REJ}(n)$ or $\text{NAK}_n$) and discards all subsequent out-of-order frames.
  * Upon timeout or receipt of $\text{NAK}_n$, the sender rewinds its window back to frame $n$ and retransmits frame $n$ plus every subsequent frame already transmitted.

![Go-Back-N](2-artifacts/go-back-n.png)

* **Maximum Window Derivation ($N \le 2^k - 1$):**
  * Because $W_{\text{rx}} = 1$, the fundamental non-overlap condition requires:
    $$W_{\text{tx}} + W_{\text{rx}} \le 2^k \implies N + 1 \le 2^k \implies N \le 2^k - 1$$
  * **Why $N = 2^k$ Fails (e.g., $k = 3 \implies N = 8$):**
    1. Sender transmits frames $0, 1, 2, 3, 4, 5, 6, 7$.
    2. Receiver accepts all 8 frames, advances its expected sequence number to $0$, and sends $\text{ACK } 0$.
    3. The ACK is lost in transit.
    4. Sender times out and retransmits old frame $0$.
    5. Receiver is expecting new frame $0$; it cannot distinguish the old duplicate frame $0$ from a fresh frame $0$, causing duplicate data insertion.
  * **Why $N = 2^k - 1$ Resolves This (e.g., $k = 3 \implies N = 7$):**
    * If the ACK for frames $0$ through $6$ is lost, the receiver is expecting frame $7$.
    * When the sender times out and retransmits old frame $0$, the receiver sees $0 \ne 7$, identifies it as an out-of-window duplicate, discards it, and resends $\text{ACK } 7$.

![Go-Back-N Max Window Size (N = 8)](2-artifacts/go-back-n-window-size-n8.png)

![Go-Back-N Max Window Size (N = 7)](2-artifacts/go-back-n-window-size-n7.png)

---

### 3.3 Selective Reject ARQ (SR)
* **Mechanics:**
  * **Receiver Window ($W_{\text{rx}} = N$):** Allocates an out-of-order buffer of size $N$.
  * **Sender Window ($W_{\text{tx}} = N$):** Allocates a transmission buffer of size $N$.
  * If frame $n$ is corrupted or lost, the receiver issues a Selective Reject ($\text{SREJ}(n)$).
  * Valid subsequent out-of-order frames falling inside the receive window are accepted and stored in memory.
  * The sender retransmits **only** the single requested frame $n$.
  * Once frame $n$ arrives correctly, the receiver places it in proper sequence and delivers the entire contiguous block to the network layer.

![Selective Reject](2-artifacts/selective-reject.png)

* **Maximum Window Derivation ($N \le 2^{k-1}$):**
  * Because both sender and receiver maintain active sliding windows of size $N$:
    $$W_{\text{tx}} + W_{\text{rx}} \le 2^k \implies 2N \le 2^k \implies N \le 2^{k-1}$$
  * **Why $N > 2^{k-1}$ Fails (e.g., $k = 3 \implies N = 5$):**
    1. Sender transmits frames $0, 1, 2, 3, 4$.
    2. Receiver accepts all 5 frames, advances its receive window to $[5, 6, 7, 0, 1]$, and returns $\text{ACK } 5$.
    3. The ACK is lost in transit.
    4. Sender times out and retransmits old frame $0$.
    5. Because $0$ falls inside the receiver's new window $[5, 6, 7, 0, 1]$, the receiver mistakenly accepts old frame $0$ as fresh data.
  * **Why $N = 2^{k-1}$ Resolves This (e.g., $k = 3 \implies N = 4$):**
    * When frames $0, 1, 2, 3$ are accepted, the receive window shifts forward to $[4, 5, 6, 7]$.
    * When sender times out and retransmits old frame $0$, $0$ is outside $[4, 5, 6, 7]$. The receiver discards it and re-issues $\text{ACK } 4$.

![Selective Reject Max Window Size (N = 5)](2-artifacts/selective-reject-window-size.png)

---

## 4. Master Summary & Exam Formulas

### 4.1 Comparison Matrix

| Protocol Feature | Stop-and-Wait ARQ | Go-Back-N ARQ (GBN) | Selective Reject ARQ (SR) |
| :--- | :--- | :--- | :--- |
| **Sender Window ($W_{\text{tx}}$)** | $1$ | $N \le 2^k - 1$ | $N \le 2^{k-1}$ |
| **Receiver Window ($W_{\text{rx}}$)** | $1$ | $1$ (in-order delivery only) | $N$ (out-of-order buffering) |
| **Retransmission Scope** | Current frame only | Corrupted frame **plus all subsequent frames** | Corrupted frame **only** |
| **Buffer Complexity** | Minimal (1 frame) | Low (Sender buffers $N$, Receiver buffers 1) | High (Sender and Receiver both buffer $N$) |
| **Bandwidth Efficiency** | Low under $a \gg 1$ | Moderate (wasted by redundant retransmissions) | Highest (retransmits only lost packets) |

---

### 4.2 Formula Reference Sheet

* **Stop-and-Wait Flow Control (Error-Free):**
  $$U = \frac{1}{1 + 2a}$$

* **Stop-and-Wait ARQ (Frame Error Probability $P$):**
  $$U_{\text{SaW}}^{\text{ARQ}} = \frac{1 - P}{1 + 2a}$$

* **Sliding Window Flow Control (Error-Free):**
  $$U = \begin{cases} 1 & N \ge 1 + 2a \\ \dfrac{N}{1 + 2a} & N < 1 + 2a \end{cases}$$

* **Selective Reject ARQ (Frame Error Probability $P$):**
  $$U_{\text{SR}} = \begin{cases} 1 - P & N \ge 1 + 2a \\[0.8em] \dfrac{N(1 - P)}{1 + 2a} & N < 1 + 2a \end{cases}$$

* **Course Examination Convention for Go-Back-N:**
  The true GBN utilization formula is mathematically complex. In this course, **use the Selective Reject formula above to calculate Go-Back-N utilization ($U_{\text{GBN}}$)**.

---

## 5. Exam Problem Archetypes

### Archetype 1: Throughput-to-Window Dimensioning
* **Problem:** A 64 kbps leased line connects two offices. The link protocol uses a 3-bit sequence field. Packet size is 80 bytes, one-way propagation delay is 10 ms, and bit errors are negligible. Find the minimum window size required to achieve a throughput of at least 32 kbps.
* **Step 1: Compute transmission delay and parameter $a$:**
  $$L = 80\text{ bytes} \times 8 = 640\text{ bits}$$
  $$T_f = \frac{L}{R} = \frac{640\text{ bits}}{64 \times 10^3\text{ bps}} = 0.01\text{ s} = 10\text{ ms}$$
  $$a = \frac{T_p}{T_f} = \frac{10\text{ ms}}{10\text{ ms}} = 1.0$$
* **Step 2: Find the target link utilization:**
  $$\text{Throughput} = U \times R \implies U_{\text{target}} = \frac{32\text{ kbps}}{64\text{ kbps}} = 0.5$$
* **Step 3: Solve for window size $W$:**
  $$U = \frac{W}{1 + 2a} \ge 0.5 \implies \frac{W}{1 + 2(1.0)} \ge 0.5 \implies \frac{W}{3} \ge 0.5 \implies W \ge 1.5$$
* **Step 4: Apply integer bound and sequence constraint:**
  Round up to the next integer: $W = \mathbf{2}$.
  Check sequence limit: For $k = 3$ bits, maximum window size is $2^3 = 8$. Since $2 \le 8$, $W = 2$ is valid.

---

### Archetype 2: Multi-Hop Buffer Flow Equilibrium
* **Problem:** Node A sends frames to Node C via intermediate Node B.
  * Link A–B: Distance 2000 km, rate 100 kbps, sliding window with $W = 3$, individual ACKs.
  * Link B–C: Distance 500 km, stop-and-wait protocol.
  * Both links: Full duplex, propagation delay $10\ \mu\text{s/km}$, data frames are 1000 bits, ACK frames are negligible, error-free.
  Determine the minimum transmission rate between B and C so Node B's memory buffer does not overflow.
* **Core Principle:** To prevent buffer overflow, Node B's outgoing frame rate to C must be at least as fast as its incoming frame rate from A:
  $$\text{Throughput}_{\text{B-C}} \ge \text{Throughput}_{\text{A-B}} \iff T_{\text{cycle, B-C}} \le \frac{T_{\text{cycle, A-B}}}{W_{\text{A-B}}}$$
* **Step 1: Timing for Link A–B:**
  $$T_{p,\text{AB}} = 2000\text{ km} \times 10\ \mu\text{s/km} = 20{,}000\ \mu\text{s} = 20\text{ ms}$$
  $$T_{f,\text{AB}} = \frac{1000\text{ bits}}{100 \times 10^3\text{ bps}} = 10\text{ ms}$$
  Cycle time for A to send 1 frame and receive its ACK:
  $$T_{\text{cycle, AB}} = T_{f,\text{AB}} + 2T_{p,\text{AB}} = 10 + 2(20) = 50\text{ ms}$$
  Since $W = 3$ frames are sent within this cycle, the incoming rate at B is:
  $$\text{Arrival interval per frame} = \frac{50\text{ ms}}{3} = \frac{50}{3}\text{ ms}$$
* **Step 2: Timing for Link B–C (Stop-and-Wait):**
  $$T_{p,\text{BC}} = 500\text{ km} \times 10\ \mu\text{s/km} = 5{,}000\ \mu\text{s} = 5\text{ ms}$$
  Let $x$ be the frame transmission delay on link B–C ($x = 1000 / R_{\text{BC}}$).
  $$T_{\text{cycle, BC}} = x + 2T_{p,\text{BC}} = x + 2(5) = x + 10\text{ ms}$$
* **Step 3: Solve for transmission rate $R_{\text{BC}}$:**
  Equate the per-frame service time at B to the arrival interval:
  $$x + 10 \le \frac{50}{3} \implies x \le \frac{50}{3} - 10 = \frac{20}{3}\text{ ms} = \frac{0.02}{3}\text{ s}$$
  $$R_{\text{BC}} = \frac{L}{x} \ge \frac{1000\text{ bits}}{\frac{20}{3} \times 10^{-3}\text{ s}} = \mathbf{150\text{ kbps}}$$

---

### Archetype 3: Sequence Bit Sizing for Selective-Reject ARQ
* **Problem:** A 100 kbps link spans 5 km with propagation delay $3\text{ ms/km}$ and frame length 25 bytes. Frame error probability is $P = 0.2$. Reliable delivery uses Selective Reject ARQ.
  1. If window size is $W = 10$, compute link utilization.
  2. Compute the minimum window size to maximize utilization, and the minimum sequence number bits $k$ required in the frame header.
* **Step 1: Compute link delay parameters:**
  $$T_f = \frac{25\text{ bytes} \times 8\text{ bits/byte}}{100 \times 10^3\text{ bps}} = \frac{200}{100{,}000} = 2\text{ ms}$$
  $$T_p = 5\text{ km} \times 3\text{ ms/km} = 15\text{ ms}$$
  $$a = \frac{T_p}{T_f} = \frac{15}{2} = 7.5$$
* **Step 2: Utilization for $W = 10$:**
  $$1 + 2a = 1 + 2(7.5) = 16$$
  Because $W = 10 < 16$, the window is exhausted before the ACK returns:
  $$U = \frac{W(1 - P)}{1 + 2a} = \frac{10(1 - 0.2)}{16} = \frac{8}{16} = \mathbf{0.5} \quad (50\%)$$
* **Step 3: Minimum window size for maximum utilization:**
  Maximum possible utilization is achieved when the transmission pipe is completely filled ($W \ge 1 + 2a$):
  $$W_{\min} = 1 + 2a = 1 + 2(7.5) = \mathbf{16}$$
  $$(U_{\max} = 1 - P = 1 - 0.2 = 0.8 \text{ or } 80\%)$$
* **Step 4: Header sequence bits ($k$):**
  For Selective Reject ARQ, $W \le 2^{k-1}$:
  $$16 \le 2^{k-1} \implies 2^4 \le 2^{k-1} \implies k - 1 \ge 4 \implies k \ge \mathbf{5\text{ bits}}$$

---

### Archetype 4: Bidirectional HDLC Ladder Diagram Tracing
* **Frame Label Invariant:** Information frames are labeled $I(N_S, N_R)$:
  * $N_S$: Sequence number of the data frame being sent.
  * $N_R$: Piggybacked acknowledgment; the sequence number of the next frame expected from the other station (implicitly acknowledging all frames through $N_R - 1$).
* **Ladder Diagram State Rules:**
  1. Forward and backward streams maintain independent send sequence counters.
  2. Every outgoing frame must copy the latest received sequence counter as its $N_R$ value.
  3. When an expected frame is missing, an explicit negative acknowledgment ($\text{SREJ}(n)$) requests frame $n$.
  4. After receiving missing frame $n$, the receiver sends a cumulative $\text{RR}(m)$ confirming reception of frame $n$ and all buffered subsequent frames up to $m - 1$.

* **Worked Trace (3-bit sequence numbering, modulo 8):**
  * Station A sends: $I(4, 3)$, $I(5, 3)$.
  * Station B receives $I(4, 3)$ and sends: $I(3, 5)$.
  * In transit, frame $I(5, 3)$ from A is corrupted/lost.
  * Station A sends: $I(6, 4)$.
  * Station B receives $I(6, 4)$ out of order (expecting 5). B buffers frame 6 and immediately issues:
    $$\text{SREJ}(5)$$
  * Station A sends: $I(7, 4)$.
  * Station A receives $\text{SREJ}(5)$ and retransmits **only** the missing frame:
    $$I(5, 4)$$
  * Station B receives $I(5, 4)$. Because B already buffered frames 6 and 7, B delivers frames 5, 6, and 7 to the higher layer and issues a cumulative ACK:
    $$\text{RR}(0) \quad (\text{since } 7 + 1 = 8 \equiv 0 \pmod 8)$$