@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    #
    # SC2301 is authored in Markdown, one folder per chapter (N-slug/N.md,
    # figures cropped from the lecture PDFs in N-artifacts/), the same layout
    # as SC2005 and SC2008. The revision cheatsheet has its own folder.
    # build.ps1 detects the .md extension and takes its Markdown path -- no
    # preamble or figure pre-rendering.

    Topics = @(
        @{ Source = '1-foundations\1.md'
           Title  = '1. Foundations: Asymptotic Notation and Insertion Sort' }
        @{ Source = '2-mergesort\2.md'
           Title  = '2. Divide and Conquer: Mergesort' }
        @{ Source = '3-heapsort\3.md'
           Title  = '3. Heaps and Heapsort' }
        @{ Source = '4-quicksort-linear-sorts\4.md'
           Title  = '4. Quicksort, the Limit of Comparison Sorts, and Linear-Time Sorts' }
        @{ Source = '5-graph-traversal\5.md'
           Title  = '5. Graphs: Representations, BFS, DFS and Topological Sort' }
        @{ Source = '6-dijkstra-prim\6.md'
           Title  = "6. Greedy Algorithms: Dijkstra's Shortest Paths and Prim's MST" }
        @{ Source = '7-union-find-kruskal\7.md'
           Title  = "7. Union-Find and Kruskal's Algorithm" }
        @{ Source = '8-recurrences\8.md'
           Title  = '8. Analysis Techniques: Solving Recurrences' }
        @{ Source = '9-amortized-analysis\9.md'
           Title  = '9. Amortized Analysis' }
        @{ Source = '10-dynamic-programming\10.md'
           Title  = '10. Dynamic Programming' }
        @{ Source = '11-string-matching\11.md'
           Title  = '11. String Matching' }
        @{ Source = 'cheatsheet\cheatsheet.md'
           Title  = 'Revision Cheatsheet' }
    )

    # The three flat chapter pages and the flat cheatsheet are replaced by the
    # per-chapter folders above.
    Obsolete = @(
        '1.html',
        '2.html',
        '3.html',
        'cheatsheet.html',
        '1-sorting\1.html',
        '1-sorting\2.html',
        '1-sorting\new-1.html',
        '1-sorting\new-2.html',
        '1-sorting\new-3.html'
    )
}
