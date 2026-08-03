# Instruction Set

<figure data-latex-placement="H">
<img width="614" height="155" src="media/images/3-types-instructs.webp" style="width:90.0%" loading="lazy" decoding="async" />
<figcaption>The 3 types of instructions.</figcaption>
</figure>

## Data Transfer Instructions

Instructions that move data between registers and/or memory.

### Register Data Transfer

- MOV instruction utilises register direct or immediate addressing.

  <figure data-latex-placement="H">
  <img width="508" height="78" src="media/images/mov-movs.webp" style="width:70.0%" loading="lazy" decoding="async" />
  <figcaption>MOV/MOVS instruction.</figcaption>
  </figure>

- MVN instruction inverts the source operand bitwise by moving into the destination register.

  <figure data-latex-placement="H">
  <img width="545" height="125" src="media/images/movn.webp" style="width:70.0%" loading="lazy" decoding="async" />
  <figcaption>MVN instruction.</figcaption>
  </figure>

### Memory Data Transfer

- LDR accesses memory at effective address using indirect register addressing modes.

  <figure data-latex-placement="H">
  <img width="748" height="83" src="media/images/ldr-instructs.webp" style="width:90.0%" loading="lazy" decoding="async" />
  <figcaption>LDR/LDRB instruction.</figcaption>
  </figure>

- STR copies data to effective address using indirect register addressing modes.

  <figure data-latex-placement="H">
  <img width="749" height="82" src="media/images/str-instructs.webp" style="width:90.0%" loading="lazy" decoding="async" />
  <figcaption>STR/STRB instruction.</figcaption>
  </figure>

## Data Processing Instructions

### Arithmetic Instructions

Supports register direct and immediate addressing (for rightmost operand only).

- ADD/ADDS

  <figure data-latex-placement="H">
  <img width="302" height="119" src="media/images/adds-instruct.webp" style="width:40.0%" loading="lazy" decoding="async" />
  <figcaption>Rightmost operand can be immediate value or register.</figcaption>
  </figure>

  <figure data-latex-placement="H">
  <figure>
  <img width="362" height="197" src="media/images/twos-comp-of.webp" loading="lazy" decoding="async" />
  <figcaption>V=1: overflow when adding <strong>signed</strong> numbers.</figcaption>
  </figure>
  <figure>
  <img width="363" height="202" src="media/images/unsigned-of.webp" loading="lazy" decoding="async" />
  <figcaption>C=1: overflow when adding <strong>unsigned</strong> numbers.</figcaption>
  </figure>
  <figcaption>ADDS affects all the flags NZVC.</figcaption>
  </figure>

- SUB/SUBS/RSB/RSBS

  <figure data-latex-placement="H">
  <img width="433" height="114" src="media/images/subs-instruct.webp" style="width:50.0%" loading="lazy" decoding="async" />
  <figcaption>SUB is not commutative; rightmost operand can be immediate value or register.</figcaption>
  </figure>

  <figure data-latex-placement="H">
  <img width="363" height="41" src="media/images/rsbs-instruct.webp" style="width:50.0%" loading="lazy" decoding="async" />
  <figcaption>RSB reverses the subtraction order.</figcaption>
  </figure>

  <figure data-latex-placement="H">
  <figure>
  <img width="275" height="128" src="media/images/minuend-subtrahend.webp" loading="lazy" decoding="async" />
  </figure>
  <figure>
  <img width="413" height="115" src="media/images/sub-cflag.webp" loading="lazy" decoding="async" />
  </figure>
  <figcaption>SUBS affecting C flag.</figcaption>
  </figure>

  <figure data-latex-placement="H">
  <figure>
  <img width="1141" height="999" src="media/images/sub-c-1.webp" loading="lazy" decoding="async" />
  <figcaption>C=1 if minuend <span class="math inline">&gt;</span> subtrahend</figcaption>
  </figure>
  <figure>
  <img width="1325" height="999" src="media/images/sub-c-0.webp" loading="lazy" decoding="async" />
  <figcaption>C=0 if minuend <span class="math inline">&lt;</span> subtrahend.</figcaption>
  </figure>
  </figure>

  <figure data-latex-placement="H">
  <img width="290" height="50" src="media/images/sub-vflag.webp" style="width:50.0%" loading="lazy" decoding="async" />
  <figcaption>V=1 when the result is out of the signed 32-bit range.</figcaption>
  </figure>

- ADC/SBC/RSC \[with S suffix to influence NZVC\]

  <figure data-latex-placement="H">
  <img width="641" height="155" src="media/images/adc-sbc-rsc.webp" style="width:80.0%" loading="lazy" decoding="async" />
  <figcaption>Uses value of C flag at that point.</figcaption>
  </figure>

### Logical instructions

Boolean operators; S suffix influences N/Z flags.

- MVN/MVNS

  <figure data-latex-placement="H">
  <img width="570" height="104" src="media/images/mvns-instruct.webp" style="width:80.0%" loading="lazy" decoding="async" />
  <figcaption>MVN takes two operands, performs bitwise inversion.</figcaption>
  </figure>

- AND/ANDS

  <figure data-latex-placement="H">
  <img width="530" height="75" src="media/images/and-instruct.webp" style="width:80.0%" loading="lazy" decoding="async" />
  <figcaption>AND can be used to clear bits to 0.</figcaption>
  </figure>

- ORR/ORRS

  <figure data-latex-placement="H">
  <img width="538" height="67" src="media/images/orr-instruct.webp" style="width:80.0%" loading="lazy" decoding="async" />
  <figcaption>ORR can be used to set bits to 1.</figcaption>
  </figure>

- EOR/EORS

  <figure data-latex-placement="H">
  <img width="525" height="70" src="media/images/eor-instruct.webp" style="width:80.0%" loading="lazy" decoding="async" />
  <figcaption>EOR used to complement bits.</figcaption>
  </figure>

- Logical shift left (LSL) & Logical Shift Right (LSR)

  <figure data-latex-placement="H">
  <img width="553" height="70" src="media/images/lsl-lsr.webp" style="width:80.0%" loading="lazy" decoding="async" />
  <figcaption>Multiply (shift left) or divide (shift right) by factor of <span class="math inline">2<sup><em>N</em></sup></span>, for N bits shifted.</figcaption>
  </figure>

  LSL: For signed/unsigned multiply, ’0’s are shifted into the LSB of the register from the right.\
  LSR: For unsigned divide, ’0’s are shifted into the MSB of the register from the left.\
  ’S’ suffix will influence C flag.

  <figure data-latex-placement="H">
  <img width="751" height="153" src="media/images/lsl-lsr-instructs.webp" style="width:90.0%" loading="lazy" decoding="async" />
  <figcaption>Shift operation is applied to the rightmost operand, number of bits to be shifted can be specified as immediate value or within a register.</figcaption>
  </figure>

- Arithmetic shift right (ASR)

  <figure data-latex-placement="H">
  <img width="223" height="64" src="media/images/asr.webp" style="width:40.0%" loading="lazy" decoding="async" />
  </figure>

  ASR: For signed divide, the sign bit is shifted into the MSB from the left.\
  ’S’ suffix will influence C flag.

- Rotate right (ROR) or Rotate Right Extended (RRX)

  <figure data-latex-placement="H">
  <figure>
  <img width="303" height="89" src="media/images/ror.webp" loading="lazy" decoding="async" />
  <figcaption>Bits shifted out are returned in at leftmost end, and also placed in C flag.</figcaption>
  </figure>
  <figure>
  <img width="298" height="83" src="media/images/rrx.webp" loading="lazy" decoding="async" />
  <figcaption>C flag is shifted into the register at the leftmost end, while the bit shifted out replaces the C flag.</figcaption>
  </figure>
  </figure>

  <figure data-latex-placement="H">
  <img width="751" height="42" src="media/images/ror-instruct.webp" style="width:90.0%" loading="lazy" decoding="async" />
  <figcaption>Rotate operation is applied to the rightmost operand.</figcaption>
  </figure>

## Program Control Instructions

To disrupt the program’s normal sequential flow, the contents of the Program Counter (PC) is modifed, either directly or by using Branch instruction.

If a branch is executed based on some condition(s), it is a Conditional Branch or Branch on Conditional Code (Bcc).

If the condition in the conditional code (cc) is true, a displacement is added to the PC. Note that the PC value is 8 bytes ahead of the current Bcc being executed.

The displacement range is $`\pm32`$MB.

<figure data-latex-placement="H">
<img width="749" height="533" src="media/images/bcc-table.webp" style="width:90.0%" loading="lazy" decoding="async" />
<figcaption>The 15 conditional codes. Each code will be prefixed with ’B’ in the code.</figcaption>
</figure>

Signed vs unsigned values

- For testing signed values, use **GT, LT, GE, LE**.

- For testing unsigned values, use **HI, LO, HS, LS**.

Example of using different condition codes for the same function.

<figure data-latex-placement="H">
<img width="535" height="248" src="media/images/bne-loop.webp" style="width:70.0%" loading="lazy" decoding="async" />
<figcaption>BNE tests for Z=0</figcaption>
</figure>

<figure data-latex-placement="H">
<img width="532" height="253" src="media/images/bpl-loop.webp" style="width:70.0%" loading="lazy" decoding="async" />
<figcaption>BPL test for N=0</figcaption>
</figure>

- CMP instruction subtracts source operand from destination register and sets the CC flags (does not ’S’ suffix).

  <figure data-latex-placement="H">
  <figure>
  <img width="267" height="130" src="media/images/subs-vs-cmp.webp" loading="lazy" decoding="async" />
  <figcaption>R1 is modified here.</figcaption>
  </figure>
  <figure>
  <img width="221" height="124" src="media/images/cmp.webp" loading="lazy" decoding="async" />
  <figcaption>R1 unchanged. CMP tests (R1 - R2).</figcaption>
  </figure>
  </figure>

- CMN (Compare negative)

  <figure data-latex-placement="H">
  <img width="520" height="36" src="media/images/cmn.webp" style="width:70.0%" loading="lazy" decoding="async" />
  <figcaption>Tests for (R0 + R1). Essentially ADDS without modifying the destination register.</figcaption>
  </figure>

- TST (Test bits)

  <figure data-latex-placement="H">
  <img width="529" height="36" src="media/images/tst.webp" style="width:70.0%" loading="lazy" decoding="async" />
  <figcaption>Performs bitwise AND between the two operands, without modifying the destination register.</figcaption>
  </figure>

- TEQ (Test equivalence)

  <figure data-latex-placement="H">
  <img width="528" height="36" src="media/images/teq.webp" style="width:70.0%" loading="lazy" decoding="async" />
  <figcaption>Performs bitwise XOR between the two operands, without modifying the destination register.</figcaption>
  </figure>
