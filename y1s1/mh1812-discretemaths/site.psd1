@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    #
    # MH1812 is authored in **Markdown**, not LaTeX: the notes began as a Google
    # Doc and were converted, so the .md files under chapters/ are the source of
    # truth. build.ps1 detects the .md extension and takes its Markdown path --
    # no preamble, no figure pre-rendering, and no Markdown *export* (the source
    # already is that). A .tex is generated separately, only to produce the PDF.
    #
    # chapters/ was cut from the single converted document by
    # ../../web-pipeline/split-markdown.py at heading level 2; re-running the
    # split regenerates every file here, so edit the chapters, not the original.

    Topics = @(
        @{ Source = 'chapters\01-elementary-number-theory.md'
           Title  = 'Elementary Number Theory' }
        @{ Source = 'chapters\02-propositional-logic.md'
           Title  = 'Propositional Logic' }
        @{ Source = 'chapters\03-predicate-logic.md'
           Title  = 'Predicate Logic' }
        @{ Source = 'chapters\04-proof-techniques.md'
           Title  = 'Proof Techniques' }
        @{ Source = 'chapters\05-combinatorics.md'
           Title  = 'Combinatorics' }
        @{ Source = 'chapters\06-recurrence-relations.md'
           Title  = 'Recurrence Relations' }
        @{ Source = 'chapters\07-set-theory.md'
           Title  = 'Set Theory' }
        @{ Source = 'chapters\08-relations.md'
           Title  = 'Relations' }
        @{ Source = 'chapters\09-functions.md'
           Title  = 'Functions' }
        @{ Source = 'chapters\10-graph-theory.md'
           Title  = 'Graph Theory' }
    )

    Index = @{ Source = 'index.md'; Title = 'Overview' }
}
