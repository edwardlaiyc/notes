@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    #
    # MH1805 is authored in **Markdown**, not LaTeX: the notes began as a Google
    # Doc and were converted, so the .md files under chapters/ are the source of
    # truth. build.ps1 detects the .md extension and takes its Markdown path --
    # no preamble, no figure pre-rendering, and no Markdown *export* (the source
    # already is that). A .tex is generated separately, only to produce the PDF.
    #
    # chapters/ was cut from the single converted document by
    # ../../web-pipeline/split-markdown.py at heading level 2; re-running the
    # split regenerates every file here, so edit the chapters, not the original.

    Topics = @(
        @{ Source = 'chapters\01-master-list.md'
           Title  = 'Master list' }
        @{ Source = 'chapters\02-sets-logic-functions.md'
           Title  = 'Sets Logic Functions' }
        @{ Source = 'chapters\03-limits.md'
           Title  = 'Limits' }
        @{ Source = 'chapters\04-continuous-functions.md'
           Title  = 'Continuous Functions' }
        @{ Source = 'chapters\05-derivatives.md'
           Title  = 'Derivatives' }
        @{ Source = 'chapters\06-integration.md'
           Title  = 'Integration' }
        @{ Source = 'chapters\07-differential-equations.md'
           Title  = 'Differential Equations' }
        @{ Source = 'chapters\08-series.md'
           Title  = 'Series' }
        @{ Source = 'chapters\09-power-series.md'
           Title  = 'Power Series' }
        @{ Source = 'chapters\10-taylor-series.md'
           Title  = 'Taylor Series' }
    )

    Index = @{ Source = 'index.md'; Title = 'Overview' }
}
