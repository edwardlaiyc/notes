# Data Organisation in Memory

## Memory Hierarchy

<figure data-latex-placement="H">
<img width="780" height="174" src="media/images/memory-hierarchy.webp" style="width:80.0%" loading="lazy" decoding="async" />
</figure>

1.  **Registers** Very fast access, but limited numbers within the CPU (2-128 registers). Operates at CPU clock rate.

2.  **Cache memory** Fast access static RAM close to CPU. Typical access time 3-20ns, size up to 512kB.

3.  **Main memory** Dynamic RAM or ROM. Typical access time 30-70nS, size up to 16GB.

4.  **Secondary memory** Not always random access but non-volatile. Maybe be based on magnetic or flash technology. Typical access time 0.03-100mS, size: up to 4TB.

### Main Memory

<figure data-latex-placement="H">
<img width="182" height="258" src="media/images/main-mem.webp" style="width:30.0%" loading="lazy" decoding="async" />
<figcaption>Main memory</figcaption>
</figure>

- Each address location is byte-size (8 bits).

- The memory size (the number of addresses) i.e. $`2^n`$ bytes, is dependent on the number of lines $`n`$ in the address bus.

- Based on Von Neumann’s architecture, the memory stores both code (instructions) and data.

## Number representation

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
| float | 4 | 32 |  |
| double | 8 | 64 |  |
| long double | 12 | 96 |  |

</div>

Note:

- Integers can be signed or unsigned.

- Floating point numbers are always signed.

### Two ways of storing a multi-byte number

<figure data-latex-placement="H">
<img width="1000" height="434" src="media/images/32bit-Endianess.webp" style="width:90.0%" loading="lazy" decoding="async" />
<figcaption>Little vs Big Endian format</figcaption>
</figure>

- Little Endian - LSB at lowest address.

- Big Endian - MSB at lowest address.

## Character Representation

A char requires one byte (8 bits) of memory. The binary data is transformed to some representative characters through some encoding standard.\
Some encoding standards:

- 7-bit ASCII code

- DEC’s Sixbit (6-bit)

- IBM’s EBCDIC (8-bit)

- Unicode (16-bit)

<figure data-latex-placement="H">
<img width="1400" height="955" src="media/images/ascii.webp" style="width:90.0%" loading="lazy" decoding="async" />
<figcaption>7-bit ASCII table</figcaption>
</figure>

Note that lower and upper case characters and digits are contiguous.\

Boolean variables have 2 states:

1.  False = 0

2.  True = non-zero

Most implementations use one byte (8 bits) to store a 1-bit Boolean value (inefficient). Some processors like the 8051 support a small portion of bit-addressable memory.

<figure data-latex-placement="H">
<img width="421" height="437" src="media/images/8051.webp" style="width:40.0%" loading="lazy" decoding="async" />
<figcaption>8051 processor supports bit-addressable memory.</figcaption>
</figure>

## Array, String and Structure Representations

### Arrays

A linear array is a consecutive area in memory storing a homogenous data type.\
Elements are accessed through some offset from the base address.

<figure data-latex-placement="H">
<img width="830" height="323" src="media/images/array-storage.webp" style="width:90.0%" loading="lazy" decoding="async" />
<figcaption>Offset calculated from number of elements and size of the data type.</figcaption>
</figure>

<figure data-latex-placement="H">
<img width="884" height="324" src="media/images/nested-array.webp" style="width:90.0%" loading="lazy" decoding="async" />
<figcaption>Nested arrays</figcaption>
</figure>

### Strings

<figure data-latex-placement="H">
<img width="377" height="99" src="media/images/c-string.webp" style="width:50.0%" loading="lazy" decoding="async" />
<figcaption>Strings are initialised as array of characters.</figcaption>
</figure>

<figure data-latex-placement="H">
<img width="489" height="351" src="media/images/c-vs-pascal-string.webp" style="width:60.0%" loading="lazy" decoding="async" />
<figcaption>C string terminates with null character, Pascal string stores the length of the string at the start of the string.</figcaption>
</figure>

- C strings have no length limit, whereas Pascal strings are limited to number of bytes used to store the length (e.g. 1 byte $`\rightarrow`$ max 255 characters.)

- C strings have no overhead (only one byte for \0) for length metadata, Pascal strings require space to store the length prefix.

- Determining length of C string is O(n), for Pascal string is O(1).

### Structures

<figure data-latex-placement="H">
<img width="743" height="350" src="media/images/struct-representation.webp" style="width:90.0%" loading="lazy" decoding="async" />
<figcaption>Each data type is ordered according to declaration, and allocated their own data size based on their type.</figcaption>
</figure>

## Pointer representation

<figure data-latex-placement="H">
<figure>
<img width="344" height="173" src="media/images/ptr-code.webp" loading="lazy" decoding="async" />
<figcaption>Initialising pointer</figcaption>
</figure>
<figure>
<img width="343" height="197" src="media/images/ptr-visual.webp" loading="lazy" decoding="async" />
<figcaption>Assuming addresses are 16 bits.</figcaption>
</figure>
<figcaption>Size of pointer is fixed regardless of data type.</figcaption>
</figure>

Use `*ptr` to dereference a pointer.

## Data Alignment

<div class="table-wrap">

| **Data Type** | **Size (Byte)** | **Example of allowable start addresses due to alignment** |
|:---|:--:|:---|
| char | 1 | 0x..0000, 0x..0001, 0x..0002 |
| short | 2 | 0x..0000, 0x..0002, 0x..0004 |
| int | 4 | 0x..0000, 0x..0004, 0x..0008 |
| float | 4 | 0x..0000, 0x..0004, 0x..0008 |
| double | 8 | 0x..0000, 0x..0008, 0x..0010 |
| pointer | 8 | 0x..0000, 0x..0008, 0x..0010 |

Multi-byte data should be aligned to addresses that are multiples of their data type size.

</div>

*Assuming* a 64-bit processor that uses 64-bits to represent an address.

<figure data-latex-placement="H">
<img width="529" height="241" src="media/images/intel-pentium-4.webp" style="width:80.0%" loading="lazy" decoding="async" />
<figcaption>Intel Pentium 4</figcaption>
</figure>

- 64-bit data bus $`\rightarrow`$ The CPU fetches 64-bits every memory cycle.

- 33 address pins $`\rightarrow`$ There are $`2^33`$ 8 byte "blocks".

- 8 Bank Enable pins select which 8-bits in that 64-bits block to read from.

- The CPU has a 64-bit data word size.

<figure data-latex-placement="H">
<img width="177" height="329" src="media/images/8-byte-alignment.webp" style="width:30.0%" loading="lazy" decoding="async" />
<figcaption>8-byte data should be aligned to addresses that are multiples of 8.</figcaption>
</figure>

- Since the CPU fetches 8 bytes at a time, any 8-byte data that is not aligned needs two memory cycles to be fetched.

- If a processor has an 8 bit (1 byte) data bus, there won’t be any alignment issues.\
  Multi-byte data takes the same number of cycles to be fetched, regardless of the memory address.

- If a processor has a 16 bit (2 bytes) data bus, then 2, 4 or 8 byte data should be aligned to even addresses.

### Data alignment in structures

<figure data-latex-placement="H">
<figure>
<img width="165" height="198" src="media/images/struct-1.webp" loading="lazy" decoding="async" />
<figcaption>Defining struct in C</figcaption>
</figure>
<figure>
<img width="529" height="339" src="media/images/struct-padding.webp" loading="lazy" decoding="async" />
<figcaption>Padded bytes are added to maintain alignment for each data type.</figcaption>
</figure>
</figure>

<figure data-latex-placement="H">
<figure>
<img width="188" height="156" src="media/images/struct-2.webp" loading="lazy" decoding="async" />
<figcaption>Rearranging order of data objects</figcaption>
</figure>
<figure>
<img width="175" height="272" src="media/images/struct-optimised.webp" loading="lazy" decoding="async" />
<figcaption>New struct takes 8 bytes instead of 12 previously.</figcaption>
</figure>
</figure>
