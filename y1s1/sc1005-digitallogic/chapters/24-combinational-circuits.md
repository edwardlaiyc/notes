## 7 segment decoder

Separately determine equation and circuit for each segment, a,b,...,g, depending on hex value input.

![](images/7-segment-decoder-01.png)

## Decoder

One-hot output based on binary input, output width = 2N for N-bit input

![](images/decoder-01.png)

![](images/decoder-02.png)

```
module decoder (input [1:0] in,
            output reg [3:0] out);
  always @ * begin
    case (in)
      2'b00: out = 4'b0001;
      2'b01: out = 4'b0010;
      2'b10: out = 4'b0100;
      2'b11: out = 4'b1000;
      default: out = 4'b0000;
    endcase
  end
endmodule
```

**Implement 5x32 decoder using one 2x4 decoder and four 3x8 decoders.

Input [4:0] X, output [31:0] Y

wire [3:0] enable

2x4decoder(.input(X[4:3)], .output(enable))

3x8decoder(.input(en[0]), .input(X[2:0]), .output(Y[7:0]));

3x8decoder(.input(en[1]), .input(X[2:0]), .output(Y[8:15]));

3x8decoder(.input(en[2]), .input(X[2:0]), .output(Y[16:23]));

3x8decoder(.input(en[3]), .input(X[2:0]), .output(Y[24:31]));

Reason:

Split into 4 cases, based on the first two MSB of X, then enable the corresponding decoder.

![](images/decoder-03.png)

## Multiplexer

The select input (sel) determines which input connects to the output.

N-input mux thus requires log2(N)-bit select input.

![](images/multiplexer-01.png)

![](images/multiplexer-02.png)

![](images/multiplexer-03.png)

Implementation of mux using decoder

![](images/multiplexer-04.png)

```
module mux (input [3:0] in,
              input [1:0] sel,
              output reg mxout);
  always @ * begin
    case (sel)
      2'b00: mxout = in[0];
      2'b01: mxout = in[1];
      2'b10: mxout = in[2];
      2'b11: mxout = in[3];
      default: mxout = in[0];
    endcase
  end
endmodule
```
