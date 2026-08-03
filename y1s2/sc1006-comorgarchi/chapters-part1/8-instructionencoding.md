# Instruction Encoding and ISA

## The anatomy of Instruction Encoding

### The data processing instruction format

For a CPU to successfully identify and execute each unique assembly instruction, the instruction must be translated (encoded) into a unique binary pattern.

<figure data-latex-placement="h">
<img src="media/images/generated/8-instructionencoding-bf1.svg" loading="lazy" decoding="async" />
<figcaption>General Data Processing Instruction Format</figcaption>
</figure>

- Bits 31-28 (Condition field): The conditions under which the instruction will execute (EQ, NE, AL, etc.). (full list in cheatsheet)

- Bits 27-26 (00): These fixed bits help the processor identify that this specific 32-bit word belongs to the general class of data processing instructions.

- Bit 25 (I): This is the Immediate flag, which dictates how the final 12 bits ("Operand 2") are interpreted. If this bit is 0, Operand 2 contains a register and shift parameters. If this bit is 1, Operand 2 contains an immediate value.

- Bits 24-21 (Operation code): Specifies the exact operation to be performed. It allows for up to 16 distinct instruction combinations. (full list in cheatsheet)

- Bit 20 (S): Indicates whether the instruction should update the Condition Code (CC) flags based on its result.

- Bits 19-16 (Rs1): Specifies the address of the first source register containing the data for the operation.

- Bits 15-12 (Rd): Specifies the address of the destination register where the final computed result will be stored.

- Bits 11-0 (Operand 2): Depending entirely on the I flag (Bit 25), this space either defines a second source register (Rs2) along with shift size and shift type, or it holds an 8-bit immediate value paired with a rotation amount.

### 3 types of instructions

Bit 25 tells us if operand 2 is an immediate value (1) or contains a register and shift paramenters (0).\
Bit 4 tells us if it is immediate shift or register shift.\
Bit 6-5 specifies the shift type (00: LSL, 01: LSR, 10: ASR, 11: ROR/RRX).

<figure data-latex-placement="H">
<img src="media/images/generated/8-instructionencoding-bf2.svg" loading="lazy" decoding="async" />
<figcaption>Data Processing with Immediate Shift<br />
<code>XXXCCS Rd, Rs1, Rs2, {shft #}</code></figcaption>
</figure>

<figure data-latex-placement="H">
<img src="media/images/generated/8-instructionencoding-bf3.svg" loading="lazy" decoding="async" />
<figcaption>Data Processing with Register Shift<br />
<code>XXXCCS Rd, Rs1, Rs2, {shft Rshift}</code></figcaption>
</figure>

<figure data-latex-placement="H">
<img src="media/images/generated/8-instructionencoding-bf4.svg" loading="lazy" decoding="async" />
<figcaption>Data Processing with Immediate Value<br />
<code>XXXCCS Rd, Rs1, #immediate (rotated)</code></figcaption>
</figure>

### Examples - Arithmetic instructions

- Immediate shift `ADD R0, R1, R2, LSL #5`

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf5.svg" loading="lazy" decoding="async" />
  </figure>

- Immediate Shift (No Shift applied): `ADD R0, R1, R2`

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf6.svg" loading="lazy" decoding="async" />
  </figure>

- Register Shift: `SUBS R4, R3, R2, LSR R5`

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf7.svg" loading="lazy" decoding="async" />
  </figure>

- Immediate Value: `RSBEQS R5, R3, #20`

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf8.svg" loading="lazy" decoding="async" />
  </figure>

### Examples - MOV instructions

Note that for MOV instructions, the Rs1 is filled with 0000, because MOV instructions inherently only require a destination register and a second operand.

- MOV Instruction (Immediate Shift structure with Rs1 ignored): `MOV R0, R5`

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf9.svg" loading="lazy" decoding="async" />
  </figure>

- MOV Instruction (Register Shift structure with Rs1 ignored): `MOVNE R1, R3, LSL R2`

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf10.svg" loading="lazy" decoding="async" />
  </figure>

- MOV Instruction (Immediate Value structure with Rs1 ignored): `MOV R1, #0x40000000`

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf11.svg" loading="lazy" decoding="async" />
  </figure>

### Examples - Comparison instructions

- The S bit (Bit 20) is always 1. The entire purpose of a comparison instruction is to update the Condition Code (CC) flags. Therefore, the instruction automatically forces the S bit to 1 so the flags are always updated.

- Rd (Bits 15-12) is 0000: Comparison instructions perform a calculation (like subtraction for CMP) to check the flags, but they throw away the mathematical result. Since there is no result to save, there is no need for a Destination Register (Rd).

<!-- -->

- Comparison Instruction (Register Operand) `XXXCC Rs1, Rs2, {shft #}`

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf12.svg" loading="lazy" decoding="async" />
  </figure>

- Comparison Instruction (Immediate Operand) `XXXCC Rs1, #immediate (rotated)`

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf13.svg" loading="lazy" decoding="async" />
  </figure>

## Branch instructions

<figure data-latex-placement="H">
<img src="media/images/generated/8-instructionencoding-bf14.svg" loading="lazy" decoding="async" />
<figcaption>Branch Instruction Format; <code>B(L)CC Offset</code></figcaption>
</figure>

- Bits 31-28 (Condition): Similarly to data processing instructions, dictates the condition (e.g., EQ, NE) under which the branch will occur.

- Bits 27-25 (101): Hardcoded to 101 to identify it as a branch instruction.

- Bits 24 (Link bit): If L=0, this is a standard branch `B`. If L=1, this is `BL`, so the processor will save return address in LR before jumping.

- Bits 23-0 (Offset): Stores the memory offset, i.e. the distance between the current instruction and the target destination.

  - Although the offset is only 24-bits, it effectively acts as a 26-bit offset.\
    Because ARM instructions are strictly 32 bits (4 bytes) long, they must be stored at word-aligned memory addresses. This means every valid instruction address ends in 00 in binary (e.g., 0, 4, 8, 12...). Since those last two bits are always zero, there is no need to waste instruction space storing them. The assembler calculates the full 26-bit offset and then shifts it to the right by 2 (effectively dividing by 4 and dropping the two zeros) to fit it into the 24-bit space. When the CPU executes the branch, it shifts the value back to the left by 2, restoring the full 26-bit offset.

  - Branch range: Because the instruction essentially uses a 26-bit signed number for the offset, the program can jump forward or backward in memory. This gives a massive branching range of $`\pm32`$ MBytes from the current Program Counter (PC).

### Examples - Branch instructions

Note that for Branch instructions, the 24-bit offset is a signed integer. The assembler calculates this offset based on the distance to the target label. Bits 27-25 are hardcoded to `101` to identify the branch family.

- **Unconditional Branch:** `B label`\
  (Condition AL = `1110`, L = `0`. Example jumping forward in memory)

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf15.svg" loading="lazy" decoding="async" />
  </figure>

- **Branch with Link:** `BL label`\
  (Condition AL = `1110`, L = `1`. Example jumping backward in memory, using two’s complement)

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf16.svg" loading="lazy" decoding="async" />
  </figure>

- **Conditional Branch:** `BEQ label`\
  (Condition EQ = `0000`, L = `0`. Only branches if the Z flag is set)

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf17.svg" loading="lazy" decoding="async" />
  </figure>

## Load/Store instructions

### LDR/STR{B} instruction format

<figure data-latex-placement="H">
<img src="media/images/generated/8-instructionencoding-bf18.svg" loading="lazy" decoding="async" />
<figcaption>Load/Store Single Word/Byte (Register Offset)<br />
<code>LDR/STR{B}CC Rs, [Rd, offset pre or post]!</code></figcaption>
</figure>

<figure data-latex-placement="H">
<img src="media/images/generated/8-instructionencoding-bf19.svg" loading="lazy" decoding="async" />
<figcaption>Load/Store Single Word/Byte (Immediate Offset)<br />
<code>LDR/STR{B}CC Rs, [Rd, offset pre or post]!</code></figcaption>
</figure>

- Bits 31-28: Condition

- Bits 27-25: Unique identifier of LDR/STR. 010: offset is register (possibly shifted), 011: offset is immediate value.

- Bits 24-20 (Control flags):

  1.  Bit 24 (P): Pre/Post. 1 = pre-indexed; 0 = post-indexed.

  2.  Bit 23 (U): Offset direction. 1 = add; 0 = subtract.

  3.  Bit 22 (B): Byte/Word. 1 = accessing single byte; 0 = full 32-bit word.

  4.  Bit 21 (W): Write-back (!). 1 = writeback; 0 = no writeback.

  5.  Bit 20 (L): Load/store. 1 = load into register; 0 = store into memory.

- Bits 19-16 (Base register): Base memory address.

- Bits 15-12 (Destination/Source Register/Rd): The register that will either receive the data (Load) or supply the data (Store).

- Bits 11-0 (Offset): can either be a shifted register or a 12-bit immediate value, depending on the identifier bits.

### Examples - LDR/STR{B} instructions

<figure data-latex-placement="htpb">
<img src="media/images/generated/8-instructionencoding-bf20.svg" loading="lazy" decoding="async" />
<figcaption>Immediate Offset Example:<br />
<code>LDR R0, [R2, #4]</code></figcaption>
</figure>

<figure data-latex-placement="htpb">
<img src="media/images/generated/8-instructionencoding-bf21.svg" loading="lazy" decoding="async" />
<figcaption>Immediate Offset Example (with Byte and Write-back):<br />
<code>STRB R0, [R2, #-4]!</code></figcaption>
</figure>

### LDM/STM instruction format

<figure data-latex-placement="H">
<img src="media/images/generated/8-instructionencoding-bf22.svg" loading="lazy" decoding="async" />
<figcaption>Load/Store Multiple Instructions<br />
<code>LDM/STM{mode}CC Rs{!}, {register list}</code></figcaption>
</figure>

1.  Bits 27-25: Hardcoded to 100 to indicate multiple load/store.

2.  Bits 24-20 (Control flags): P, U, W, L are the same. Bit 22 changed from B to ^.

    1.  Bit 22 (^): "don’t care" bit, used for restoring status registers in privileged modes.

3.  Bits 15-0 (Register List): Instead of an offset, the entire bottom 16 bits are mapped as a boolean list. Each bit corresponds directly to one of the 16 ARM registers (e.g., Bit 0 represents R0, Bit 15 represents R15/PC). If a bit is set to 1, that register is included in the memory transfer.

### Examples - LDM/STM instructions

Note that for stack operations, the Base Register (Rs) is typically the Stack Pointer (`SP` or `R13`, which is `1101` in binary). The register list uses 1 bit per register, where Bit 0 corresponds to `R0` and Bit 15 corresponds to `R15` (`PC`).

- **Push to Full Descending Stack:** `STMFD SP!, {R0, R1, R4}`\
  (Condition AL = `1110`. `STMFD` aliases to `STMDB` \[Decrement Before\], so P=`1`, U=`0`. `^` bit is `0`. Writeback W=`1`. Store L=`0`.)

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf24.svg" loading="lazy" decoding="async" />
  </figure>

- **Pop from Full Descending Stack:** `LDMFD SP!, {R0, R1, R4}`\
  (Condition AL = `1110`. `LDMFD` aliases to `LDMIA` \[Increment After\], so P=`0`, U=`1`. `^` bit is `0`. Writeback W=`1`. Load L=`1`.)

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf25.svg" loading="lazy" decoding="async" />
  </figure>

- **Push to Empty Ascending Stack:** `STMEA SP!, {R2, R3, LR}`\
  (Condition AL = `1110`. `STMEA` aliases to `STMIA` \[Increment After\], so P=`0`, U=`1`. `^` bit is `0`. Writeback W=`1`. Store L=`0`.)

  <figure data-latex-placement="H">
  <img src="media/images/generated/8-instructionencoding-bf26.svg" loading="lazy" decoding="async" />
  </figure>

## Fixed vs Variable Length ISA

- Fixed-length ISA (ARM approach): every single instruction is exactly the same size (32 bits). The operands used in these instructions must be restricted to either registers or fixed immediate values.\
  **Benefit**: The fetch and decode cycle is fast and predictable because the CPU knows how many bits to grab from memory for every instruction. The hardware is easier to design in silicon.

- Variable-length ISA (e.g. Intel 80x86, instructions vary from 1 - 17 bytes long). Such an instruction is built from a mix of mandatory and optional chunks.\
  **Benefit**: It allows for a highly flexible and compact instruction set. Because simple instructions only take up 1 byte instead of wasting 4 bytes, the overall memory footprint of the program (code density) shrinks.\
  **Drawbacks**: Complex instructions require complex hardware. The CPU has to read the first part of the instruction to figure out how long the rest of the instruction is, which forces a much slower, multi-step fetch and decode process.

## Hardware Constraints

Given only 32 bits per instruction, the game is to allocate the optimal number of bits to each feature.

- Register Limits: Operations using registers are vastly faster than memory accesses because they are physically closer to the ALU. However, implementing too many takes up precious space on the silicon die, dramatically increases the routing and multiplexing complexity inside the CPU, and increases the operand size needed during instruction encoding. For a standard data processing instruction (like ADD Rd, Rs1, Rs2), just specifying those three registers eats up 12 bits of the 32-bit budget

- Immediate Value Constraints: Because the instruction needs bits for opcodes, condition codes, and registers, there simply isn’t enough room left to hold a massive 32-bit constant number. This hardware constraint is exactly why ARM uses the clever 8-bit rotated immediate trick we covered earlier—it squeezes a wide range of useful numbers into a tiny 12-bit space.

## Orthogonality

Orthogonality means that different features of the architecture (instructions, registers, and addressing modes) can be combined independently without weird exceptions.\
If an ISA is perfectly orthogonal, any instruction can use any register, and any instruction can use any addressing mode.\
How ARM acheives orthogonality:

1.  Condition Codes: Every single ARM instruction reserves bits 31-28 for the Condition field. You can make any instruction conditional (ADDEQ, MOVEQ, BEQ, LDREQ).

2.  Operand 2: Any instruction that uses Operand 2 can apply a bit-shift. (i.e. don’t need a separate instruction just to do that).

However, perfect orthogonality is nearly impossible in a 32-bit fixed system. Because different operations require fundamentally different information (a Branch needs a massive memory offset, while an ADD needs three registers), the architecture must break its own rules. This is why the CPU relies on the key Identifier bits (27-25) to switch between entirely different decoding layouts.
