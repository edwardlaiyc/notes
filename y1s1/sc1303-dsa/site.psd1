@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    #
    # SC1303 is authored in **Markdown**, not LaTeX: the notes began as a Google
    # Doc and were converted, so the .md files under chapters/ are the source of
    # truth. build.ps1 detects the .md extension and takes its Markdown path --
    # no preamble, no figure pre-rendering, and no Markdown *export* (the source
    # already is that). A .tex is generated separately, only to produce the PDF.
    #
    # chapters/ was cut from the single converted document by
    # ../../web-pipeline/split-markdown.py at heading level 2; re-running the
    # split regenerates every file here, so edit the chapters, not the original.

    Topics = @(
        @{ Source = 'chapters\01-array.md'
           Title  = 'Array' }
        @{ Source = 'chapters\02-set.md'
           Title  = 'Set' }
        @{ Source = 'chapters\03-ordered-array.md'
           Title  = 'Ordered Array' }
        @{ Source = 'chapters\04-linear-search.md'
           Title  = 'Linear Search' }
        @{ Source = 'chapters\05-binary-search-only-on-sorted-array.md'
           Title  = 'Binary Search (only on Sorted Array)' }
        @{ Source = 'chapters\06-bubble-sort.md'
           Title  = 'Bubble Sort' }
        @{ Source = 'chapters\07-selection-sort.md'
           Title  = 'Selection Sort' }
        @{ Source = 'chapters\08-insertion-sort.md'
           Title  = 'Insertion Sort' }
        @{ Source = 'chapters\09-recursion.md'
           Title  = 'Recursion' }
        @{ Source = 'chapters\10-quicksort.md'
           Title  = 'Quicksort' }
        @{ Source = 'chapters\11-linked-list.md'
           Title  = 'Linked List' }
        @{ Source = 'chapters\12-binary-search-tree.md'
           Title  = 'Binary Search Tree' }
        @{ Source = 'chapters\13-tries.md'
           Title  = 'Tries' }
    )

    Index = @{ Source = 'index.md'; Title = 'Overview' }
}
