# Network Layers and Physical Resilience

## 1. Network Architecture & Layering Mechanics

### 1.1 Modularity & The Layering Principle
* **Decomposition:** Complex networks are decomposed into a vertical stack of functional layers to enforce separation of concerns.
* **Service Abstraction:** Layer $n$ provides services to upper layer $n+1$ via a Service Access Point (SAP), while hiding internal implementation details.
* **Modularity:** Changes to protocols or implementations within one layer do not affect other layers, as long as the interfaces remain unchanged.

---

### 1.2 Protocols, Services, and Interfaces
* **Protocols (Horizontal Communication):**
  * Formal rules and conventions governing communication between peering entities across different machines.
  * Defines message syntax (format), transmission order, and actions taken upon message transmission and receipt.
  * Horizontal peer communication is a logical abstraction; physical data flows down the sending stack, traverses the physical link, and ascends the receiving stack.
* **Services & Service Access Points (SAP):**
  * Conceptual interface where Layer $n$ offers services to Layer $n+1$.
  * An $(n)\text{-SAP}$ is named after the underlying service provider (Layer $n$).

---

### 1.3 Data Units & Encapsulation Lifecycle
* **Service Data Unit (SDU):** Raw data payload passed across an $(n)\text{-SAP}$ from Layer $n+1$ down to Layer $n$.
* **Protocol Data Unit (PDU):** The complete packet constructed at Layer $n$, containing control headers, payload, and optional trailers:
  $$\text{PDU}_n = \text{Header}_n + \text{SDU}_n \ (+ \text{Trailer}_n)$$
* **Layer Boundary Invariant:**
  $$\text{PDU}_n = \text{SDU}_{n-1}$$
  The complete PDU at Layer $n$ becomes the SDU payload handed down to Layer $n-1$.
* **Encapsulation (Sender):** Moving down the stack, each layer wraps the payload with its specific control header.
* **Decapsulation (Receiver):** Moving up the stack, each layer reads, processes, and strips off its corresponding header before passing the data upward.

![Services, SAPs, SDUs and PDUs between adjacent layers](1-artifacts/sap-sdu-pdu.png){width=62%}

---

### 1.4 Intermediate Node Forwarding vs. End Hosts
* **End Hosts:** Run the full vertical protocol stack (Layers 1–7 in OSI, or Layers 1–5 in TCP/IP).
* **Intermediate Nodes (Routers / Switches):**
  * Forwarding devices operate strictly up to **Layer 3 (Network Layer)**.
  * **Hop-by-Hop L2 Stripping:** At each router hop, the physical bits are assembled into a Layer 2 frame. The router strips and discards the Layer 2 header and trailer, inspects the Layer 3 destination address to determine the outgoing link, and encapsulates the packet into a brand new Layer 2 frame with fresh MAC addresses.
  * The Layer 3 Network Header ($NH$) and all higher-layer headers remain intact end-to-end.

![OSI encapsulation and per-hop forwarding](1-artifacts/osi-encapsulation-per-hop.png)

---

## 2. Architectural Reference Models

### 2.1 OSI 7-Layer vs. TCP/IP 5-Layer Mapping

![OSI layer functions](1-artifacts/osi-layer-functions.png)

![OSI and TCP/IP layer mapping](1-artifacts/osi-vs-tcpip-mapping.png)

| Layer # | OSI Model | TCP/IP Model | PDU Name | Domain / Implementation | Core Functions & Examples |
| :---: | :--- | :--- | :---: | :---: | :--- |
| **7** | Application | **Application** (Layers 5–7 combined) | Message / Data | User Space (Software) | User-facing network processes: HTTP, SMTP, DNS, FTP |
| **6** | Presentation | | | | Syntax, formatting, encryption/decryption, data compression |
| **5** | Session | | | | Dialogue control, session establishment, checkpointing |
| **4** | Transport | **Transport** | Segment | OS Kernel (Software) | End-to-end process delivery, port multiplexing, reliability: TCP, UDP |
| **3** | Network | **Network (Internet)** | Packet / Datagram | OS Kernel (Software) | Logical addressing, routing across subnets: IPv4, IPv6, ICMP |
| **2** | Data Link | **Data Link (Network Access)** | Frame | Network Adapter / Firmware | Hop-to-hop framing, physical MAC addressing, flow/error control: Ethernet, Wi-Fi |
| **1** | Physical | **Physical** | Bit | Hardware / Medium | Transmission of raw unstructured bit streams over physical media |

---

## 3. Network Reliability & Availability Parameters

### 3.1 Operational Parameters
* **Mean Time to Failure (MTTF):** Expected operational uptime of a system or link before a failure occurs.
* **Mean Time to Repair (MTTR):** Expected downtime required to repair and restore the failed link to operational status.
* **Mean Time Between Failures (MTBF):** Total elapsed cycle time between consecutive failures:
  $$\text{MTBF} = \text{MTTF} + \text{MTTR}$$

---

### 3.2 Link Availability & Failure Probabilities
For any individual link $i$:
* **Link Availability ($r_i$):** Steady-state probability that link $i$ is functional:
  $$r_i = \frac{\text{MTTF}}{\text{MTBF}} = \frac{\text{MTTF}}{\text{MTTF} + \text{MTTR}}$$
* **Link Failure Probability / Unavailability ($b_i$):** Steady-state probability that link $i$ is dysfunctional:
  $$b_i = \frac{\text{MTTR}}{\text{MTBF}} = \frac{\text{MTTR}}{\text{MTTF} + \text{MTTR}}$$
* **Complementary Invariant:**
  $$r_i + b_i = 1 \iff r_i = 1 - b_i$$

#### Availability Reference Table ("The Nines")

| Availability % | Downtime per year | Downtime per month | Downtime per week |
| :--- | :--- | :--- | :--- |
| **90% ("one nine")** | 36.5 days | 72 hours | 16.8 hours |
| **99% ("two nines")** | 3.65 days | 7.20 hours | 1.68 hours |
| **99.9% ("three nines")** | 8.76 hours | 43.8 minutes | 10.1 minutes |
| **99.95%** | 4.38 hours | 21.56 minutes | 5.04 minutes |
| **99.99% ("four nines")** | 52.56 minutes | 4.32 minutes | 1.01 minutes |
| **99.999% ("five nines")** | 5.26 minutes | 25.9 seconds | 6.05 seconds |
| **99.9999% ("six nines")** | 31.5 seconds | 2.59 seconds | 0.605 seconds |
| **99.99999% ("seven nines")** | 3.15 seconds | 0.259 seconds | 0.0605 seconds |

---

## 4. Network Topological Resilience Calculations

### 4.1 Fundamental Assumption
Link failure probabilities are assumed to be **statistically independent** of one another:
$$P(A \cap B) = P(A) \times P(B)$$

---

### 4.2 Series Topology
A series connection survives **only if all links function simultaneously**.

![Series graph](1-artifacts/resilience-series.png){width=55%}

* **Availability:**
  $$r_{\text{series}} = \prod_{i=1}^{n} r_i = r_1 \times r_2 \times \cdots \times r_n$$
* **Failure Probability:**
  $$b_{\text{series}} = 1 - r_{\text{series}} = 1 - \prod_{i=1}^{n} (1 - b_i)$$
* **Calculation (assuming $b_i = 0.05 \implies r_i = 0.95$ for 2 links):**
  $$r_{\text{series}} = 0.95 \times 0.95 = 0.9025$$
  $$b_{\text{series}} = 1 - 0.9025 = 0.0975 \quad (9.75\%)$$

---

### 4.3 Parallel Topology
A parallel set of paths fails **only if all independent links break simultaneously**.

![Parallel graph](1-artifacts/resilience-parallel.png){width=55%}

* **Failure Probability:**
  $$b_{\text{parallel}} = \prod_{i=1}^{n} b_i = b_1 \times b_2 \times \cdots \times b_n$$
* **Availability:**
  $$r_{\text{parallel}} = 1 - b_{\text{parallel}} = 1 - \prod_{i=1}^{n} b_i$$
* **Calculation (assuming $b_i = 0.05$ for 2 links):**
  $$b_{\text{parallel}} = 0.05 \times 0.05 = 0.0025 \quad (0.25\%)$$
  $$r_{\text{parallel}} = 1 - 0.0025 = 0.9975 \quad (99.75\%)$$

---

### 4.4 Hybrid Networks: Path-Based Reduction Framework
To compute end-to-end disconnection probability across series-parallel graphs:
1. Identify all independent parallel transmission paths between source and destination.
2. For each path consisting of series sub-links, compute its availability $r_{\text{path}}$ by multiplying the individual link availabilities.
3. Compute the failure probability of each path:
   $$b_{\text{path}} = 1 - r_{\text{path}}$$
4. Compute total network disconnection probability by multiplying the path failure probabilities together.

![Hybrid graph](1-artifacts/resilience-hybrid.png){width=55%}

* **Worked Example (Path Reduction):**
  * Given link failure probability $b_i = 0.05 \implies r_i = 0.95$ for all links.
  * **Path 1 ($\text{SG} \to \text{HW} \to \text{AU}$ in series):**
    $$r_{\text{SG-HW-AU}} = r_{\text{SG-HW}} \times r_{\text{HW-AU}} = (1 - 0.05) \times (1 - 0.05) = 0.9025$$
    $$b_{\text{SG-HW-AU}} = 1 - 0.9025 = 0.0975$$
  * **Path 2 ($\text{SG} \to \text{AU}$ direct link):**
    $$b_{\text{SG-AU}} = 0.05$$
  * **Network Disconnection Probability (Both paths broken simultaneously):**
    $$P(\text{Disconnected}) = b_{\text{SG-HW-AU}} \times b_{\text{SG-AU}} = 0.0975 \times 0.05 = \mathbf{0.004875} \quad (0.4875\%)$$
  * **Total Network Availability:**
    $$r_{\text{total}} = 1 - P(\text{Disconnected}) = 1 - 0.004875 = \mathbf{0.995125} \quad (99.5125\%)$$
