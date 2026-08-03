@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    #
    # SC1008 is deliberately minimal. The full course notes were written in a
    # Google Colab notebook and are NOT converted here — the overview page just
    # links out to Drive/GitHub. The only LaTeX source in this course is
    # `final-summary.tex`, a standalone `article` cheat sheet.
    #
    # No Preprocess step: `final-summary.tex` is short (6 top-level sections) and
    # reads fine as ONE page, so it is listed directly as a topic rather than
    # being sliced by a `split` step. Its code is all `lstlisting`, which pandoc
    # converts natively — no bytefields, TikZ, or algorithm2e to pre-render.

    Topics = @(
        @{ Source = 'final-summary.tex'
           Title  = 'C++ Library Functions & Core Concepts'
           NumberSections = $true }
    )

    Index = @{ Source = 'index.md'; Title = 'Overview' }
}
