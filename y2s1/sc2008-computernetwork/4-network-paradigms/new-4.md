# Network Paradigms & Delay Analysis

## 1. Network Switching Paradigms

A switching network routes data between endpoints through intermediate nodes without requiring dedicated point-to-point physical cables between every pair of hosts.

### 1.1 Circuit Switching Networks
* **Core Principle:** A dedicated, end-to-end physical communication channel (circuit) is reserved and locked along intermediate switches prior to data transmission.
* **The Three Operational Phases:**
  1. **Circuit Establishment:** A setup control signal traverses link-by-link to find and lock dedicated transmission resources (e.g., frequency bands, time slots, line bandwidth). If insufficient capacity exists on any link, the call is blocked (busy tone).
  2. **Ordered Data Transfer:** Data streams continuously through the reserved physical circuit. No intermediate queuing delay occurs at switches. Packets require zero addressing or routing overhead headers because the path is hardware-locked.
  3. **Circuit Disconnect:** When communication terminates, a teardown signal releases the locked resources back to the pool.

* **Trunk Line Capacity Calculation:**
  $$\text{Concurrent Connections} = \frac{\text{Trunk Line Bandwidth}}{\text{Bandwidth per Connection}}$$
  * *Worked Example:* Trunk capacity $R_{\text{trunk}} = 10\text{ Gbps} = 10 \times 10^9\text{ bps}$. Voice call requirement $R_{\text{call}} = 64\text{ kbps} = 64 \times 10^3\text{ bps}$:
    $$\text{Concurrent Calls} = \frac{10 \times 10^9\text{ bps}}{64 \times 10^3\text{ bps}} = \frac{10{,}000{,}000}{64} \approx \mathbf{156{,}250\text{ calls}}$$

---

### 1.2 Packet Switching Networks
* **Core Principle:** Long messages are segmented into smaller, bounded discrete blocks called **packets** (typically $\approx 1000\text{ bytes}$).
* **Packet Composition:**
  * **Payload:** Segment of raw user application data.
  * **Header:** Control bytes containing source and destination identifiers, packet sequence numbers, error check codes, and length indicators.
* **Store-and-Forward Invariant:** An intermediate switch or router cannot forward bits immediately as they arrive; it must receive, buffer, and validate the **entire complete packet** into internal memory before transmitting the first bit onto the outgoing link.

---

### 1.3 Datagram vs. Virtual-Circuit Packet Switching

#### A. Datagram Packet Switching (Connectionless)
* **No Path Reservation:** Packets are transmitted into the network independently with zero setup delay.
* **Full Header Overhead:** Every packet carries complete source and destination Layer 3 IP addresses.
* **Dynamic / Independent Routing:** Each intermediate router independently evaluates its routing table per packet based on current link states and local traffic. Consecutive packets belonging to the same message may traverse completely different paths.
* **Out-of-Order Delivery:** Because packets may follow paths with differing propagation delays and queue lengths, packets often arrive out of sequence. The receiving host uses header **sequence numbers** to reassemble the data in correct order.
* **Implementation:** The modern Internet Protocol (IPv4 / IPv6).

#### B. Virtual-Circuit (VC) Packet Switching (Connection-Oriented)
* **Pre-Established Logical Route:** A signaling phase sets up a fixed logical path before data transmission begins. All packets follow this predetermined route sequentially.
* **Virtual Circuit Identifier (VCI):** Packets do not carry full IP addresses. Instead, each packet carries a short local identifier (VCI). Routers maintain internal VC translation tables that map `(Incoming Port, VCI)` to `(Outgoing Port, Next VCI)`.
* **Shared Capacity (No Resource Reservation):** Unlike circuit switching, **no bandwidth or buffer space is exclusively locked**. Transmission links remain dynamically shared across all active network traffic. If a user is silent, other users consume the link bandwidth.
* **Implementation:** Legacy X.25, ATM, Frame Relay.

---

## 2. Paradigms Side-by-Side Comparison

| Operational Metric | Circuit Switching | Datagram Packet Switching | Virtual-Circuit Packet Switching |
| :--- | :--- | :--- | :--- |
| **Path Setup Phase** | Mandatory before transmission | None (immediate transmission) | Mandatory before transmission |
| **Resource Reservation** | Dedicated / Exclusive (bandwidth locked) | None (dynamically shared) | None (dynamically shared) |
| **Path Determination** | Dedicated physical path | Dynamic (packets take varying paths) | Fixed logical path |
| **Packet Sequence** | Strictly in-order arrival | Packets may arrive out of order | Contiguous in-order arrival |
| **Per-Packet Header Overhead** | Zero overhead after connection setup | Full Source & Destination IP addresses | Lightweight local identifier (VCI) |
| **Queuing Delay** | Zero queuing delay at intermediate switches | Variable (depends on link congestion) | Variable (depends on link congestion) |
| **Network Overload Behavior** | Blocks new connection setup requests (busy tone) | Packets queue up; packets dropped on buffer overflow | Packets queue up; packets dropped on buffer overflow |
| **Fault Tolerance** | Entire connection fails if any link breaks | Packets dynamically reroute around failed links | Entire connection fails; VC must be re-established |

> **Context: Real-World Network Applications**
> * **Landline Telephone Network (PSTN):** Circuit switching.
> * **The Global Internet:** Datagram packet switching.
> * **Aviation Avionics (X.25):** Virtual-circuit packet switching.
> * **Cellular Evolution:**
>   * **1G, 2G, 3G:** Voice calls use dedicated circuit switching.
>   * **4G (LTE) & 5G:** Pure packet-switched architecture (All-IP). Voice calls are segmented into prioritized data packets (VoLTE / VoNR).

---

## 3. Network Delay Analysis

### 3.1 The Four Components of Total Packet Delay
Total nodal delay for a packet traversing a hop is the sum of four discrete components:
$$d_{\text{nodal}} = d_{\text{proc}} + d_{\text{queue}} + d_{\text{trans}} + d_{\text{prop}}$$

![Packet switching delay components along a multi-hop link](4-artifacts/delay-components.png)

1. **Processing Delay ($d_{\text{proc}}$):** Time taken by the intermediate router to examine packet headers, verify CRC bit errors, and consult routing tables to determine the outgoing interface (typically microseconds).
2. **Queuing Delay ($d_{\text{queue}}$):** Time the packet waits in router memory buffers waiting for the transmission link to clear. Varies dynamically based on network congestion.
3. **Transmission Delay ($d_{\text{trans}}$):** Time required to emit/push all bits of the packet onto the physical communication medium:
   $$d_{\text{trans}} = \frac{L}{R}$$
   * $L$ = Packet length (bits).
   * $R$ = Transmission rate / link bandwidth (bits per second, bps).
4. **Propagation Delay ($d_{\text{prop}}$):** Time taken by a single physical bit to travel from the transmitter to the receiver across the physical medium:
   $$d_{\text{prop}} = \frac{D}{V}$$
   * $D$ = Physical link distance (meters).
   * $V$ = Signal propagation speed in medium (typically $2 \times 10^8\text{ m/s}$ in fiber/copper, or $3 \times 10^8\text{ m/s}$ in free space).

---

### 3.2 Circuit Switching Delay Model
Once the physical circuit is established, intermediate switches introduce zero store-and-forward buffering. Data flows through switches at the speed of light:
$$T_{\text{total}}^{\text{Circuit}} = T_{\text{setup}} + \frac{\text{Message Size (bits)}}{R} + \sum d_{\text{prop}}$$

* **Worked Example (Transmission Delay):**
  * Message size $= 1000\text{ bits}$, Link bitrate $R = 10\text{ kbps} = 10{,}000\text{ bps}$.
  * Intermediate topology $= 4\text{ nodes}$ ($3\text{ hops}$).
  $$T_{\text{tx}} = \frac{1000\text{ bits}}{10{,}000\text{ bps}} = \mathbf{0.1\text{ s}} = \mathbf{100\text{ ms}}$$
  *(Data is pushed once by the sender; intermediate switches do not re-serialize the bits).*

---

### 3.3 Packet Switching: Pipelining & Store-and-Forward Latency

#### The Hop Invariant
A network path consisting of $N$ nodes contains $H$ hops:
$$H = N - 1$$

#### The Pipelining Principle
Under store-and-forward packet switching:
* Node 1 pushes Packet 1 onto Link 1.
* Once Node 2 receives the entirety of Packet 1, Node 2 transmits Packet 1 onto Link 2.
* Concurrently, Node 1 immediately begins transmitting Packet 2 onto Link 1.
* Intermediate links operate in parallel, pipelining packet delivery across the multi-hop path.

#### General Transmission Delay Formula
For $P$ equal-sized packets traversing $H$ identical hops, where each packet has transmission time $T_{\text{frame}} = \frac{L}{R}$:

$$\text{Total Transmission Delay} = (\text{Time for all } P \text{ packets to clear Node 1}) + (\text{Time for last packet to cross remaining } H - 1 \text{ hops})$$

$$T_{\text{tx}}^{\text{Packet}} = P \cdot T_{\text{frame}} + (H - 1) \cdot T_{\text{frame}} = (P + H - 1) \cdot T_{\text{frame}}$$

* **Worked Example (4 Nodes, 2 Packets):**
  * Topology: $N = 4\text{ nodes} \implies H = 4 - 1 = 3\text{ hops}$.
  * Number of packets: $P = 2$.
  $$T_{\text{tx}} = (2 + 3 - 1) \cdot T_{\text{frame}} = \mathbf{4 \cdot T_{\text{frame}}}$$

---

### 3.4 Packet Sizing Trade-Offs

$$\text{Total Packet Length } L = \text{Data Payload } (D) + \text{Control Header } (H_{\text{hdr}})$$

* **If Packets are Too Large:**
  * Serialization latency at each store-and-forward hop is massive ($T_{\text{frame}}$ is large).
  * Pipelining efficiency drops because downstream links sit idle waiting for earlier nodes to finish buffering large frames.
  * Frame error rates increase; a single corrupted bit requires retransmitting a massive packet.
* **If Packets are Too Small:**
  * Header overhead ratio ($\frac{H_{\text{hdr}}}{L}$) balloons, consuming high fractions of channel bandwidth on non-payload control data.
  * Routers experience processing exhaustion as per-packet interrupt frequency and header lookup volume scale upward.
