# General Reference

## Size of bytes

1.  1 byte = 8 bits

2.  1KB = $`2^{10}`$ bytes = 1024 bytes

3.  1MB = $`2^{20}`$ bytes = 1,048,576 bytes

4.  1GB = $`2^{30}`$ bytes = 1,073,741,824 bytes

## Memory sizes

- Size at each address = 8 bits

- Size of address (*assumed*) = 16 bits
  ``` math
  \text{Size of pointer}_{\text{bytes}} = 8 \times \left\lceil \frac{\text{Address Bits}}{8} \right\rceil
  ```

- Size of each register in CPU = 32 bits.\
  There are 16 registers in CPU (R0-R12; R13=SP; R14=LP; R15=PC; CSPR)

- Memory capacity in BYTES = $`2^{\text{Number of address pins}}`$

- Number of BITS in one data transfer = number of data pins

## Size of numbers

<div class="table-wrap">

| **Type** | **Bytes** | **Bits** | **Range** |
|---:|:--:|:--:|:---|
| signed char | 1 | 8 | $`-128 \to +127`$ |
| unsigned char | 1 | 8 | $`0 \to +255`$ |
| short int | 2 | 16 | $`-32,768 \to +32,767 \quad (\pm 32\text{KB})`$ |
| unsigned short int | 2 | 16 | $`0 \to +65,535 \quad\qquad (64\text{KB})`$ |
| unsigned int | 4 | 32 | $`0 \to +4,294,967,295 \quad (4\text{GB})`$ |
| int | 4 | 32 | $`-2,147,483,648 \to +2,147,483,647 \ (\pm 2\text{GB})`$ |
| long int | 4 | 32 | $`-2,147,483,648 \to +2,147,483,647 \ (\pm 2\text{GB})`$ |
| long long int | 8 | 64 | $`-(2^{63}) \to (2^{63})-1`$ |
| float | 4 | 32 | $`\pm1.2\times 10^{-38} \to \pm 3.4\times 10^{38} \ (\sim7 \text{ decimals})`$ |
| double | 8 | 64 | $`\pm2.3 \times 10^{-308} \to \pm1.7\times 10^{308} \ (\sim 15-17 \text{ decimals})`$ |
| long double | 12 | 96 | $`\pm3.4\times 10^{-4932} \to \pm1.1\times 10^{4932} \ (\sim 18-19 \text{ decimals})`$ |

</div>

Data types should be aligned to address that is a multiple of the data bus.

Little Endian (LSB at lowest address; assume this) vs Big Endian (MSB at highest address).

## Size of instructions and its components/operands

1.  One instruction: 32 bits / 4 bytes

2.  Condition flags: 4 bits (Bits 28-31)

3.  Opcode: 8 bits (Bits 20-27)

4.  Register: 4 bits (Since there are 16 possible registers in the processor)

5.  Immediate value: 12 bits (4 rotate right bits + 8 bit immediate value.)

## Execution Cycle

Fetch-Decode-Execute $`\implies`$ PC value is 8 bytes ahead of current instruction being executed. For PC-related addressing, must have offset of 8bytes. The max offset is $`\pm 4096`$ bytes or (#0xFC) , $`\because`$ offset field only has 12 bits.

<div class="landscape">

## Instruction Set

<div class="table-wrap">

<table>
<thead>
<tr>
<th colspan="3" style="text-align: left;"><strong>VisUAL ARM Instruction Set</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;"><strong>Summary</strong></td>
<td style="text-align: left;"><strong>Opcode</strong></td>
<td style="text-align: left;"><strong>Syntax</strong></td>
</tr>
<tr>
<td style="text-align: left;">Move</td>
<td style="text-align: left;">MOV</td>
<td style="text-align: left;">MOV{S}{cond} dest, op1 {, SHIFT op #expression}<br />
S=1: NZC, C if shift occurs.</td>
</tr>
<tr>
<td style="text-align: left;">Move Negated</td>
<td style="text-align: left;">MVN</td>
<td style="text-align: left;">MVN{S}{cond} dest, op1 {, SHIFT op #expression}<br />
Inverts op1 bitwise (1’s comp) before moving.<br />
S=1: NZC, C if shift occurs.</td>
</tr>
<tr>
<td style="text-align: left;">LDR Psuedo-Instruction</td>
<td style="text-align: left;">LDR</td>
<td style="text-align: left;">LDR{S}{cond} dest, =expression</td>
</tr>
<tr>
<td style="text-align: left;">Add</td>
<td style="text-align: left;">ADD</td>
<td style="text-align: left;">ADD{S}{cond} dest, op1, op2 {, SHIFT_op #expression}<br />
S=1, updates NZCV.</td>
</tr>
<tr>
<td style="text-align: left;">Add with Carry</td>
<td style="text-align: left;">ADC</td>
<td style="text-align: left;">ADC{S}{cond} dest, op1, op2 {, SHIFT_op #expression}<br />
dest = op1 + op2 + C<br />
S=1, updates NZCV.</td>
</tr>
<tr>
<td style="text-align: left;">Subtract</td>
<td style="text-align: left;">SUB</td>
<td style="text-align: left;">SUB{S}{cond} dest, op1, op2 {, SHIFT_op #expression}<br />
S=1, updates NZCV.</td>
</tr>
<tr>
<td style="text-align: left;">Subtract with Carry</td>
<td style="text-align: left;">SBC</td>
<td style="text-align: left;">SBC{S}{cond} dest, op1, op2 {, SHIFT_op #expression}<br />
dest = op1 - op2 - NOT(C)<br />
S=1, updates NZCV.</td>
</tr>
<tr>
<td style="text-align: left;">Reverse Subtract</td>
<td style="text-align: left;">RSB</td>
<td style="text-align: left;">RSB{S}{cond} dest, op1, op2 {, SHIFT_op #expression}<br />
dest = op1 - op2<br />
S=1, updates NZCV.</td>
</tr>
<tr>
<td style="text-align: left;">Reverse Subtract with Carry</td>
<td style="text-align: left;">RSC</td>
<td style="text-align: left;">RSC{S}{cond} dest, op1, op2 {, SHIFT_op #expression}<br />
dest = op2 - op1 - NOT(C)<br />
S=1, updates NZCV.</td>
</tr>
<tr>
<td style="text-align: left;">Bitwise And</td>
<td style="text-align: left;">AND</td>
<td style="text-align: left;">AND{S}{cond} dest, op1, op2 {, SHIFT_op #expression}<br />
S=1: NZC, C if shift occurs.</td>
</tr>
<tr>
<td style="text-align: left;">Bitwise Exclusive Or</td>
<td style="text-align: left;">EOR</td>
<td style="text-align: left;">EOR{S}{cond} dest, op1, op2 {, SHIFT_op #expression}<br />
S=1: NZC, C if shift occurs.</td>
</tr>
<tr>
<td style="text-align: left;">Bitwise Clear</td>
<td style="text-align: left;">BIC</td>
<td style="text-align: left;">BIC{S}{cond} dest, op1, op2 {, SHIFT_op #expression}<br />
S=1: NZC, C if shift occurs.</td>
</tr>
<tr>
<td style="text-align: left;">Bitwise Or</td>
<td style="text-align: left;">ORR</td>
<td style="text-align: left;">ORR{S}{cond} dest, op1, op2 {, SHIFT_op #expression}<br />
S=1: NZC, C if shift occurs.</td>
</tr>
<tr>
<td style="text-align: left;">Logical Shift Left</td>
<td style="text-align: left;">LSL</td>
<td style="text-align: left;">LSL{S}{cond} dest, op1, op2<br />
S=1: NZC, C gets the last bit shifted out.</td>
</tr>
<tr>
<td style="text-align: left;">Logical Shift Right</td>
<td style="text-align: left;">LSR</td>
<td style="text-align: left;">LSR{S}{cond} dest, op1, op2<br />
S=1: NZC, C gets the last bit shifted out.</td>
</tr>
<tr>
<td style="text-align: left;">Arithmetic Shift Right</td>
<td style="text-align: left;">ASR</td>
<td style="text-align: left;">ASR{S}{cond} dest, op1, op2<br />
MSB unchanged. If S=1, C=LSB.<br />
S=1: NZC, C gets the last bit shifted out.</td>
</tr>
<tr>
<td style="text-align: left;">Rotate Right</td>
<td style="text-align: left;">ROR</td>
<td style="text-align: left;">ROR{S}{cond} dest, op1, op2<br />
LSB into MSB. If S=1, C=LSB.<br />
S=1: NZC, C gets the last bit shifted out.</td>
</tr>
<tr>
<td style="text-align: left;">Rotate Right and Extend</td>
<td style="text-align: left;">RRX</td>
<td style="text-align: left;">RRX{S}{cond} op1, op2<br />
C into MSB. If S=1, C=LSB.<br />
S=1: NZC, C gets the last bit shifted out.</td>
</tr>
<tr>
<td style="text-align: left;">Compare</td>
<td style="text-align: left;">CMP</td>
<td style="text-align: left;">CMP{cond} op1, op2 {, SHIFT_op #expression}<br />
Test (op1 - op2), same as SUBS without modification<br />
Always updates NZCV.</td>
</tr>
<tr>
<td style="text-align: left;">Compare Negated</td>
<td style="text-align: left;">CMN</td>
<td style="text-align: left;">CMN{cond} op1, op2 {, SHIFT_op #expression}<br />
Tests (op1 + op2), same as ADDS w/o modification<br />
Always updates NZCV.</td>
</tr>
<tr>
<td style="text-align: left;">Test Bit(s) Set</td>
<td style="text-align: left;">TST</td>
<td style="text-align: left;">TST{cond} op1, op2 {, SHIFT_op #expression}<br />
Bitwise AND b/w operands<br />
Always updates NZC.</td>
</tr>
<tr>
<td style="text-align: left;">Test Equals</td>
<td style="text-align: left;">TEQ</td>
<td style="text-align: left;">TEQ{cond} op1, op2 {, SHIFT_op #expression}<br />
Bitwise XOR b/w operands<br />
Always updates NZC.</td>
</tr>
<tr>
<td style="text-align: left;">Load Register</td>
<td style="text-align: left;">LDR</td>
<td style="text-align: left;">LDR{B}{cond} dest, [source {, OFFSET}] Offset addressing<br />
LDR{B}{cond} dest, [source, OFFSET]! Pre-indexed addressing<br />
LDR{B}{cond} dest, [source], OFFSET Post-indexed addressing</td>
</tr>
<tr>
<td style="text-align: left;">Store Register</td>
<td style="text-align: left;">STR</td>
<td style="text-align: left;">STR{B}{cond} source, [dest {, OFFSET}] Offset addressing<br />
STR{B}{cond} source, [dest, OFFSET]! Pre-indexed addressing<br />
STR{B}{cond} source, [dest], OFFSET Post-indexed addressing</td>
</tr>
<tr>
<td style="text-align: left;">Load Multiple Registers</td>
<td style="text-align: left;">LDM[dir]</td>
<td style="text-align: left;">LDM[dir]{cond} source, {list of registers}</td>
</tr>
<tr>
<td style="text-align: left;">Store Multiple Registers</td>
<td style="text-align: left;">STM[dir]</td>
<td style="text-align: left;">STM[dir]{cond} dest, {list of registers}</td>
</tr>
<tr>
<td style="text-align: left;">Branch</td>
<td style="text-align: left;">B</td>
<td style="text-align: left;">B{cond} target</td>
</tr>
<tr>
<td style="text-align: left;">Branch with Link</td>
<td style="text-align: left;">BL</td>
<td style="text-align: left;">BL{cond} target</td>
</tr>
<tr>
<td style="text-align: left;">Stop Emulation</td>
<td style="text-align: left;">END</td>
<td style="text-align: left;">END{cond}</td>
</tr>
</tbody>
</table>

</div>

## Memory Access and Clock Cycles per Instruction

<div class="table-wrap">

| **Instruction Type** | **Memory Accesses (Data + Instr)** | **Total Accesses** | **Clock Cycles** |
|:---|:--:|:--:|:--:|
| **Data Processing (Standard)** |  |  |  |
| MOV, ADD, SUB, AND, ORR, etc. | 1 (Instr) + 0 (Data) | 1 | 1 |
| MOVEQ (Conditional Move) | 1 (Instr) + 0 (Data) | 1 | 1 (True or False) |
| Comparisons (CMP, CMN, TST, TEQ) | 1 (Instr) + 0 (Data) | 1 | 1 |
| Data Proc. with Register Shift (e.g. `LSL Rs`) | 1 (Instr) + 0 (Data) | 1 | 1 |
| **Control Flow (Branches modify PC)** |  |  |  |
| B (Unconditional Branch) | 1 (Instr) + 0 (Data) | 1 | 3 (Pipeline Flush) |
| BEQ / BCC (Conditional Branch) | 1 (Instr) + 0 (Data) | 1 | 1 (False) or 3 (True) |
| BL (Branch with Link) | 1 (Instr) + 0 (Data) | 1 | 3 (Pipeline Flush) |
| BX LR (Branch and Exchange) | 1 (Instr) + 0 (Data) | 1 | 3 (Pipeline Flush) |
| MOV PC, LR (Return from Branch) | 1 (Instr) + 0 (Data) | 1 | 3 (Pipeline Flush) |
| Data Proc. writing to PC (e.g. `ADD PC, ...`) | 1 (Instr) + 0 (Data) | 1 | 3 (Pipeline Flush) |
| **Single Data Transfer** |  |  |  |
| LDR / STR (Single Load/Store) | 1 (Instr) + 1 (Data) | 2 | 2 |
| LDREQ / STREQ (Conditional) | 1 (Instr) + 0 or 1 (Data) | 1 or 2 | 1 (False) or 2 (True) |
| **Block Data Transfer (Stack)** |  |  |  |
| LDMFD (Load Multiple, Full Desc.) | 1 (Instr) + N (Data) | $`N+1`$ | $`N+2`$ |
| STMFD (Store Multiple, Full Desc.) | 1 (Instr) + N (Data) | $`N+1`$ | $`N+2`$ |

ARM Memory Accesses vs. Clock Cycles (N = Register List Size)

</div>

</div>

## Condition Codes

<div class="table-wrap">

| **Code** | **Suffix** | **Flags** | **Meaning** |
|:---|:---|:---|:---|
| 0000 | EQ | $`Z = 1`$ | Equal |
| 0001 | NE | $`Z = 0`$ | Not equal |
| 0010 | CS or HS | $`C = 1`$ | Higher or same, unsigned |
| 0011 | CC or LO | $`C = 0`$ | Lower, unsigned |
| 0100 | MI | $`N = 1`$ | Negative |
| 0101 | PL | $`N = 0`$ | Positive or zero |
| 0110 | VS | $`V = 1`$ | Overflow |
| 0111 | VC | $`V = 0`$ | No overflow |
| 1000 | HI | $`C = 1`$ and $`Z = 0`$ | Higher, unsigned |
| 1001 | LS | $`C = 0`$ or $`Z = 1`$ | Lower or same, unsigned |
| 1010 | GE | $`N = V`$ | Greater than or equal, signed |
| 1011 | LT | $`N \neq V`$ | Less than, signed |
| 1100 | GT | $`Z = 0`$ and $`N = V`$ | Greater than, signed |
| 1101 | LE | $`Z = 1`$ and $`N \neq V`$ | Less than or equal, signed |
| 1110 | AL | Can have any value | Always. This is the default when no suffix is specified. |
| 1111 | NV |  | Reserved (unused) |

ARM Bcc Conditions

</div>

SUBS sets C=1 when no borrow (A - B, where A $`>=`$ B); clears C=0 if borrow (A - B, where A $`<`$ B).

Condition to set the flags:

- N: MSB = 1.

- Z: All zero.

- V: MSB of result $`\neq`$ MSB of operands, where MSB of operands are the same.

- C: Bit carried out = 1.

## Instruction Anatomy

### Data processing instructions

<figure data-latex-placement="H">
<img src="media/images/generated/cheatsheet-bf1.svg" loading="lazy" decoding="async" />
<figcaption>Data Processing with Immediate Value<br />
<code>XXXCCS Rd, Rs1, #immediate (rotated)</code></figcaption>
</figure>

<figure data-latex-placement="H">
<img src="media/images/generated/cheatsheet-bf2.svg" loading="lazy" decoding="async" />
<figcaption>Data Processing with Immediate Shift<br />
<code>XXXCCS Rd, Rs1, Rs2, {shft #}</code></figcaption>
</figure>

<figure data-latex-placement="H">
<img src="media/images/generated/cheatsheet-bf3.svg" loading="lazy" decoding="async" />
<figcaption>Data Processing with Register Shift<br />
<code>XXXCCS Rd, Rs1, Rs2, {shft Rshift}</code></figcaption>
</figure>

### Branch instructions

<figure data-latex-placement="H">
<img src="media/images/generated/cheatsheet-bf4.svg" loading="lazy" decoding="async" />
<figcaption>Branch Instruction Format; <code>B(L)CC Offset</code></figcaption>
</figure>

If L=0, then is `B`. If L=1, then is `BL`. Offset is distance between current instruct & target addr. Effectively acts as 26-bit offset. Branch range: $`\pm 32`$ Mbytes.

### Load/store instructions

<figure data-latex-placement="H">
<img src="media/images/generated/cheatsheet-bf5.svg" loading="lazy" decoding="async" />
<figcaption>Load/Store Single Word/Byte (Register Offset)<br />
<code>LDR/STR{B}CC Rs, [Rd, offset pre or post]!</code></figcaption>
</figure>

<figure data-latex-placement="H">
<img src="media/images/generated/cheatsheet-bf6.svg" loading="lazy" decoding="async" />
<figcaption>Load/Store Single Word/Byte (Immediate Offset)<br />
<code>LDR/STR{B}CC Rs, [Rd, offset pre or post]!</code></figcaption>
</figure>

(The maximum offset for register indirect with immediate value is $`\pm 4096= \pm 2^{12}`$ bytes. The sign is determined by U bit.)\
(1/0): P = Pre/post; U = add/subtract; B = byte/32-bit word; W = writeback/no wb; L = load/store;

<figure data-latex-placement="H">
<img src="media/images/generated/cheatsheet-bf7.svg" loading="lazy" decoding="async" />
<figcaption>Load/Store Multiple Instructions<br />
<code>LDM/STM{mode}CC Rs{!}, {register list}</code></figcaption>
</figure>

B becomes "don’t care" bit; register list bit 0 is R0, bit 15 is R15, 1=include that register.

<div class="table-wrap">

| **Bits 27–25** | **Instruction Category** | **Meaning**                        |
|:--------------:|:-------------------------|:-----------------------------------|
|     `000`      | Data Processing          | Register/Shift Operand ($`I=0`$)   |
|     `001`      | Data Processing          | Immediate Operand ($`I=1`$)        |
|     `010`      | Load/Store Single        | Register Offset                    |
|     `011`      | Load/Store Single        | Immediate Offset                   |
|     `100`      | Load/Store Multiple      | Block Data Transfer (`LDM`/`STM`)  |
|     `101`      | Branch                   | Branch/Jump Instruction (`B`/`BL`) |

Summary of Key Instruction Identifiers (Bits 27-25)

</div>

<div class="table-wrap">

| **Code** | **Instruction** | **Code** | **Instruction** |
|:---------|:----------------|:---------|:----------------|
| 0000     | AND             | 1000     | TST             |
| 0001     | EOR             | 1001     | TEQ             |
| 0010     | SUB             | 1010     | CMP             |
| 0011     | RSB             | 1011     | CMN             |
| 0100     | ADD             | 1100     | ORR             |
| 0101     | ADC             | 1101     | MOV             |
| 0110     | SBC             | 1110     | BIC             |
| 0111     | RSC             | 1111     | MVN             |

Instruction Type (Opcode) Field (Bits 24-21)

</div>

<div class="table-wrap">

| **Code** | **Shift type** |
|:---------|:---------------|
| 00       | LSL            |
| 01       | LSR            |
| 10       | ASR            |
| 11       | ROR/RRX        |

Shift Type Encoding (Bits 6 and 5)

</div>

<div class="table-wrap">

| **PU^WL Bits** | **Instruction** |
|:--------------:|:----------------|
|     00011      | LDMFA (Pop)     |
|     01011      | LDMFD (Pop)     |
|     10010      | STMFD (Push)    |
|     11010      | STMFA (Push)    |
|     00010      | STMED (Push)    |
|     01010      | STMEA (Push)    |
|     10011      | LDMEA (Pop)     |
|     11011      | LDMED (Pop)     |

</div>

## Flow control

`IF` statement: reverse the condition to reduce jump instructions.\
Condtional execution: add the condtion codes to the instruction (e.g. MOVEQ). If using multiple of these, ensure the CSPR unchanged.\

Compound AND: If first condition fail, branch out immediately.\
Compound OR: If first cond pass, branch immediately.\

SWITCH with narrow consecutive values, use jump table.\
SWTICH with wide range of values, use forked cascade.\

PRE-test loops (WHILE): Test condition at the start, branch out if fail.\
POST-test loops (DO-WHILE): Test at the end.\

FOR loops are pre-test loops.

## ASCII table

<div class="center">

<div class="table-wrap">

<table>
<thead>
<tr>
<th colspan="5" style="text-align: center;"><strong>Bits: <span class="math inline"><em>b</em><sub>7</sub><em>b</em><sub>6</sub><em>b</em><sub>5</sub>→</span> / <span class="math inline"><em>b</em><sub>4</sub><em>b</em><sub>3</sub><em>b</em><sub>2</sub><em>b</em><sub>1</sub>↓</span></strong></th>
<th style="text-align: center;"><strong>000</strong></th>
<th style="text-align: center;"><strong>001</strong></th>
<th style="text-align: center;"><strong>010</strong></th>
<th style="text-align: center;"><strong>011</strong></th>
<th style="text-align: center;"><strong>100</strong></th>
<th style="text-align: center;"><strong>101</strong></th>
<th style="text-align: center;"><strong>110</strong></th>
<th style="text-align: center;"><strong>111</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="5" style="text-align: center;"></td>
<td style="text-align: center;"><strong>0</strong></td>
<td style="text-align: center;"><strong>1</strong></td>
<td style="text-align: center;"><strong>2</strong></td>
<td style="text-align: center;"><strong>3</strong></td>
<td style="text-align: center;"><strong>4</strong></td>
<td style="text-align: center;"><strong>5</strong></td>
<td style="text-align: center;"><strong>6</strong></td>
<td style="text-align: center;"><strong>7</strong></td>
</tr>
<tr>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;"><strong>0</strong></td>
<td style="text-align: center;">NUL</td>
<td style="text-align: center;">DLE</td>
<td style="text-align: center;">SP</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">@</td>
<td style="text-align: center;">P</td>
<td style="text-align: center;">`</td>
<td style="text-align: center;">p</td>
</tr>
<tr>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;"><strong>1</strong></td>
<td style="text-align: center;">SOH</td>
<td style="text-align: center;">DC1</td>
<td style="text-align: center;">!</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">A</td>
<td style="text-align: center;">Q</td>
<td style="text-align: center;">a</td>
<td style="text-align: center;">q</td>
</tr>
<tr>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;"><strong>2</strong></td>
<td style="text-align: center;">STX</td>
<td style="text-align: center;">DC2</td>
<td style="text-align: center;">"</td>
<td style="text-align: center;">2</td>
<td style="text-align: center;">B</td>
<td style="text-align: center;">R</td>
<td style="text-align: center;">b</td>
<td style="text-align: center;">r</td>
</tr>
<tr>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;"><strong>3</strong></td>
<td style="text-align: center;">ETX</td>
<td style="text-align: center;">DC3</td>
<td style="text-align: center;">#</td>
<td style="text-align: center;">3</td>
<td style="text-align: center;">C</td>
<td style="text-align: center;">S</td>
<td style="text-align: center;">c</td>
<td style="text-align: center;">s</td>
</tr>
<tr>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;"><strong>4</strong></td>
<td style="text-align: center;">EOT</td>
<td style="text-align: center;">DC4</td>
<td style="text-align: center;">$</td>
<td style="text-align: center;">4</td>
<td style="text-align: center;">D</td>
<td style="text-align: center;">T</td>
<td style="text-align: center;">d</td>
<td style="text-align: center;">t</td>
</tr>
<tr>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;"><strong>5</strong></td>
<td style="text-align: center;">ENQ</td>
<td style="text-align: center;">NAK</td>
<td style="text-align: center;">%</td>
<td style="text-align: center;">5</td>
<td style="text-align: center;">E</td>
<td style="text-align: center;">U</td>
<td style="text-align: center;">e</td>
<td style="text-align: center;">u</td>
</tr>
<tr>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;"><strong>6</strong></td>
<td style="text-align: center;">ACK</td>
<td style="text-align: center;">SYN</td>
<td style="text-align: center;">&amp;</td>
<td style="text-align: center;">6</td>
<td style="text-align: center;">F</td>
<td style="text-align: center;">V</td>
<td style="text-align: center;">f</td>
<td style="text-align: center;">v</td>
</tr>
<tr>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;"><strong>7</strong></td>
<td style="text-align: center;">BEL</td>
<td style="text-align: center;">ETB</td>
<td style="text-align: center;">’</td>
<td style="text-align: center;">7</td>
<td style="text-align: center;">G</td>
<td style="text-align: center;">W</td>
<td style="text-align: center;">g</td>
<td style="text-align: center;">w</td>
</tr>
<tr>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;"><strong>8</strong></td>
<td style="text-align: center;">BS</td>
<td style="text-align: center;">CAN</td>
<td style="text-align: center;">(</td>
<td style="text-align: center;">8</td>
<td style="text-align: center;">H</td>
<td style="text-align: center;">X</td>
<td style="text-align: center;">h</td>
<td style="text-align: center;">x</td>
</tr>
<tr>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;"><strong>9</strong></td>
<td style="text-align: center;">HT</td>
<td style="text-align: center;">EM</td>
<td style="text-align: center;">)</td>
<td style="text-align: center;">9</td>
<td style="text-align: center;">I</td>
<td style="text-align: center;">Y</td>
<td style="text-align: center;">i</td>
<td style="text-align: center;">y</td>
</tr>
<tr>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;"><strong>10</strong></td>
<td style="text-align: center;">LF</td>
<td style="text-align: center;">SUB</td>
<td style="text-align: center;">*</td>
<td style="text-align: center;">:</td>
<td style="text-align: center;">J</td>
<td style="text-align: center;">Z</td>
<td style="text-align: center;">j</td>
<td style="text-align: center;">z</td>
</tr>
<tr>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;"><strong>11</strong></td>
<td style="text-align: center;">VT</td>
<td style="text-align: center;">ESC</td>
<td style="text-align: center;">+</td>
<td style="text-align: center;">;</td>
<td style="text-align: center;">K</td>
<td style="text-align: center;">[</td>
<td style="text-align: center;">k</td>
<td style="text-align: center;">{</td>
</tr>
<tr>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;"><strong>12</strong></td>
<td style="text-align: center;">FF</td>
<td style="text-align: center;">FS</td>
<td style="text-align: center;">,</td>
<td style="text-align: center;">&lt;</td>
<td style="text-align: center;">L</td>
<td style="text-align: center;">\</td>
<td style="text-align: center;">l</td>
<td style="text-align: center;">|</td>
</tr>
<tr>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;"><strong>13</strong></td>
<td style="text-align: center;">CR</td>
<td style="text-align: center;">GS</td>
<td style="text-align: center;">-</td>
<td style="text-align: center;">=</td>
<td style="text-align: center;">M</td>
<td style="text-align: center;">]</td>
<td style="text-align: center;">m</td>
<td style="text-align: center;">}</td>
</tr>
<tr>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">0</td>
<td style="text-align: center;"><strong>14</strong></td>
<td style="text-align: center;">SO</td>
<td style="text-align: center;">RS</td>
<td style="text-align: center;">.</td>
<td style="text-align: center;">&gt;</td>
<td style="text-align: center;">N</td>
<td style="text-align: center;">^</td>
<td style="text-align: center;">n</td>
<td style="text-align: center;">~</td>
</tr>
<tr>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;">1</td>
<td style="text-align: center;"><strong>15</strong></td>
<td style="text-align: center;">SI</td>
<td style="text-align: center;">US</td>
<td style="text-align: center;">/</td>
<td style="text-align: center;">?</td>
<td style="text-align: center;">O</td>
<td style="text-align: center;">_</td>
<td style="text-align: center;">o</td>
<td style="text-align: center;">DEL</td>
</tr>
</tbody>
</table>

</div>

</div>

<div class="landscape">

## Stacks

<div class="center">

<div class="minipage">

<div class="table-wrap">

<table>
<thead>
<tr>
<th style="text-align: left;"><strong>Type</strong></th>
<th style="text-align: left;"><strong>Characteristics</strong></th>
<th style="text-align: left;"><strong>Push Action (Store)</strong></th>
<th style="text-align: left;"><strong>Pop Action (Load)</strong></th>
<th style="text-align: left;"><strong>Access Top Item</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;"><strong>FD</strong></td>
<td style="text-align: left;">Full Descending<br />
Grows Down (<span class="math inline">↓</span>)<br />
SP points to: <strong>Data</strong></td>
<td style="text-align: left;"><strong>Pre-Decrement</strong><br />
STR Rn, [SP, #-4]!<br />
PU^WL: 1010</td>
<td style="text-align: left;"><strong>Post-Increment</strong><br />
LDR Rn, [SP], #4<br />
PU^WL: 0111</td>
<td style="text-align: left;"><strong>No Offset</strong><br />
LDR Rn, [SP]</td>
</tr>
<tr>
<td style="text-align: left;"><strong>ED</strong></td>
<td style="text-align: left;">Empty Descending<br />
Grows Down (<span class="math inline">↓</span>)<br />
SP points to: <strong>Empty</strong></td>
<td style="text-align: left;"><strong>Post-Decrement</strong><br />
STR Rn, [SP], #-4<br />
PU^WL: 0010</td>
<td style="text-align: left;"><strong>Pre-Increment</strong><br />
LDR Rn, [SP, #4]!<br />
PU^WL: 1111</td>
<td style="text-align: left;"><strong>Plus 4</strong><br />
LDR Rn, [SP, #4]</td>
</tr>
<tr>
<td style="text-align: left;"><strong>FA</strong></td>
<td style="text-align: left;">Full Ascending<br />
Grows Up (<span class="math inline">↑</span>)<br />
SP points to: <strong>Data</strong></td>
<td style="text-align: left;"><strong>Pre-Increment</strong><br />
STR Rn, [SP, #4]!<br />
PU^WL: 1110</td>
<td style="text-align: left;"><strong>Post-Decrement</strong><br />
LDR Rn, [SP], #-4<br />
PU^WL: 0011</td>
<td style="text-align: left;"><strong>No Offset</strong><br />
LDR Rn, [SP]</td>
</tr>
<tr>
<td style="text-align: left;"><strong>EA</strong></td>
<td style="text-align: left;">Empty Ascending<br />
Grows Up (<span class="math inline">↑</span>)<br />
SP points to: <strong>Empty</strong></td>
<td style="text-align: left;"><strong>Post-Increment</strong><br />
STR Rn, [SP], #4<br />
PU^WL: 0110</td>
<td style="text-align: left;"><strong>Pre-Decrement</strong><br />
LDR Rn, [SP, #-4]!<br />
PU^WL: 1011</td>
<td style="text-align: left;"><strong>Minus 4</strong><br />
LDR Rn, [SP, #-4]</td>
</tr>
</tbody>
</table>

</div>

</div>

</div>

</div>

## Modular Programming

Branch to subroutine (both change LR and PC).

1.  `BL`.

2.  `MOV LR PC; B SUBROUTINE`.

Return to calling program (both only change PC).

1.  `BX LR`.

2.  `MOV PC LR`.

`STMFD SP! {R6-R7, LR}`: R6 at lowest memory, LR at highest memory, i.e. SP pointing at R6.\
`LDMFD SP! {R6-R7, PC}`: PC takes over saved LR content.\
Immediately after executing `BL Sub1` located at 0x300, LR = 0x304.\
Registers:

- R0 – R3: Arguments (Inputs) & Return Values. Volatile / Caller-saved. (Can be safely overwritten).

- R4 – R11: Local Variables. Non-volatile / Callee-saved. (MUST be preserved for transparent subroutines).

- R11: Frame pointer (use negative offset)

- R12 (IP): Intra-procedure scratch register. Volatile. (Can be safely overwritten).

- R13 (SP): Stack Pointer. Points to the top of the system stack. (use positive offset)

- R14 (LR): Link Register. Holds the return address (PC + 4).

- R15 (PC): Program Counter. Holds the address of the currently executing instruction.

When pushing LR or extra registers at the start of a nested subroutine, the SP shifts. To recalculate LDR offsets:\
Formula: New Offset = Old Offset + (Number of Extra Registers Pushed × 4 bytes)\
Example: If a parameter was at \[SP, \#24\] and you add LR to your push list (STMFD SP!, R4-R7, LR), you pushed 1 extra register. New offset = 24 + (1 × 4) = 28.

    LDR R1, [R0], #4
    MOV R2, R0
    STMFD SP!, {R1, R2}
    BL Sub1

Assuming R0=0x100, V1 stored at 0x100, V2 stored at 0x104.\
R1 passed in by value, R2 passed in by reference.\

Each recursive call saves the address of the next instruction using LR. To find number of recursive calls, find the number of repeated addresses saved, that are close to address in PC.
