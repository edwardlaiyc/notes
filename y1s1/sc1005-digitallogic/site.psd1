@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    #
    # SC1005 is authored in **Markdown**, not LaTeX: the notes began as a Google
    # Doc and were converted, so the .md files under chapters/ are the source of
    # truth. build.ps1 detects the .md extension and takes its Markdown path --
    # no preamble, no figure pre-rendering, and no Markdown *export* (the source
    # already is that). A .tex is generated separately, only to produce the PDF.
    #
    # chapters/ was cut from the single converted document by
    # ../../web-pipeline/split-markdown.py at heading level 3; re-running the
    # split regenerates every file here, so edit the chapters, not the original.

    Topics = @(
        @{ Source = 'chapters\01-basics.md'
           Title  = 'Basics' }
        @{ Source = 'chapters\02-parity-bit.md'
           Title  = 'Parity bit' }
        @{ Source = 'chapters\03-number-conversion.md'
           Title  = 'Number conversion' }
        @{ Source = 'chapters\04-universality-of-nand-nor-gates.md'
           Title  = 'Universality of NAND & NOR gates' }
        @{ Source = 'chapters\05-full-adder.md'
           Title  = 'Full-adder' }
        @{ Source = 'chapters\06-signed-magnitude.md'
           Title  = 'Signed-magnitude' }
        @{ Source = 'chapters\07-1-s-complement.md'
           Title  = '1''s complement' }
        @{ Source = 'chapters\08-2-s-complement.md'
           Title  = '2''s complement' }
        @{ Source = 'chapters\09-combined-circuit-for-addition-and-subtraction.md'
           Title  = 'Combined circuit for addition and subtraction' }
        @{ Source = 'chapters\10-overflow.md'
           Title  = 'Overflow' }
        @{ Source = 'chapters\11-parallel-addition-with-registers.md'
           Title  = 'Parallel addition with registers' }
        @{ Source = 'chapters\12-binary-multiplication.md'
           Title  = 'Binary Multiplication' }
        @{ Source = 'chapters\13-bcd-addition.md'
           Title  = 'BCD addition' }
        @{ Source = 'chapters\14-deriving-boolean-expressions.md'
           Title  = 'Deriving boolean expressions' }
        @{ Source = 'chapters\15-k-map.md'
           Title  = 'K-map' }
        @{ Source = 'chapters\16-cmos-circuit.md'
           Title  = 'CMOS circuit' }
        @{ Source = 'chapters\17-circuit-characteristics-and-parameters.md'
           Title  = 'Circuit characteristics and parameters' }
        @{ Source = 'chapters\18-tristate-outputs.md'
           Title  = 'Tristate outputs' }
        @{ Source = 'chapters\19-open-drain-output.md'
           Title  = 'Open-drain output' }
        @{ Source = 'chapters\20-schmitt-trigger-inverter.md'
           Title  = 'Schmitt-Trigger Inverter' }
        @{ Source = 'chapters\21-pla.md'
           Title  = 'PLA' }
        @{ Source = 'chapters\22-floating-point-numbers.md'
           Title  = 'Floating-point numbers' }
        @{ Source = 'chapters\23-2-types-of-circuits-combinational-vs-sequential.md'
           Title  = '2 TYPES OF CIRCUITS - COMBINATIONAL vs SEQUENTIAL' }
        @{ Source = 'chapters\24-combinational-circuits.md'
           Title  = 'Combinational Circuits' }
        @{ Source = 'chapters\25-sequential-circuits.md'
           Title  = 'Sequential Circuits' }
        @{ Source = 'chapters\26-latches.md'
           Title  = 'Latches' }
        @{ Source = 'chapters\27-flip-flops.md'
           Title  = 'Flip Flops' }
        @{ Source = 'chapters\28-general-verilog.md'
           Title  = 'General Verilog' }
        @{ Source = 'chapters\29-combinational-always-block-always.md'
           Title  = 'Combinational always block [always@*]' }
        @{ Source = 'chapters\30-synchronous-always-block.md'
           Title  = 'Synchronous always block' }
        @{ Source = 'chapters\31-some-sequential-blocks.md'
           Title  = 'Some sequential blocks' }
        @{ Source = 'chapters\32-finite-state-machine.md'
           Title  = 'Finite State Machine' }
    )

    Index = @{ Source = 'index.md'; Title = 'Overview' }
}
