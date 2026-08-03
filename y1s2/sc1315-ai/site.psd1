@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    # SC1315 is two monolithic articles (test1 = search & games, test2 =
    # reinforcement learning). The eight search/game algorithms are authored as
    # plain-text pseudocode in `lstlisting` blocks (pandoc renders these as code
    # blocks directly), so no figure pre-render is needed — both articles just
    # split into one .tex per \section. See ../../web-pipeline/README.md.

    Preprocess = @(
        @{ Kind = 'split'; Source = 'test1.tex'; OutDir = 'chapters'; Sections = 'plain' }
        @{ Kind = 'split'; Source = 'test2.tex'; OutDir = 'chapters'; Sections = 'plain' }
    )

    # Ordered reading sequence; running section numbers derive from order.
    Topics = @(
        @{ Source = 'chapters/problem-formulation.tex';           Title = 'Problem Formulation';            NumberSections = $true },
        @{ Source = 'chapters/state-transition-graph.tex';        Title = 'State Transition Graph';         NumberSections = $true },
        @{ Source = 'chapters/breadth-first-search.tex';          Title = 'Breadth First Search';           NumberSections = $true },
        @{ Source = 'chapters/depth-first-search.tex';            Title = 'Depth First Search';             NumberSections = $true },
        @{ Source = 'chapters/depth-limited-search.tex';          Title = 'Depth Limited Search';           NumberSections = $true },
        @{ Source = 'chapters/iterative-deepening.tex';           Title = 'Iterative Deepening';            NumberSections = $true },
        @{ Source = 'chapters/bi-directional-search.tex';         Title = 'Bi-directional Search';          NumberSections = $true },
        @{ Source = 'chapters/uniform-cost-search.tex';           Title = 'Uniform Cost Search';            NumberSections = $true },
        @{ Source = 'chapters/greedy-search.tex';                 Title = 'Greedy Search';                  NumberSections = $true },
        @{ Source = 'chapters/a-search.tex';                      Title = 'A* Search';                      NumberSections = $true },
        @{ Source = 'chapters/comparison-of-searches.tex';        Title = 'Comparison of Searches';         NumberSections = $true },
        @{ Source = 'chapters/game-trees-backward-induction.tex'; Title = 'Game Trees & Backward Induction'; NumberSections = $true },
        @{ Source = 'chapters/minimax-search.tex';                Title = 'Minimax Search';                 NumberSections = $true },
        @{ Source = 'chapters/gridworld-py.tex';                  Title = 'gridworld.py';                   NumberSections = $true },
        @{ Source = 'chapters/q-function.tex';                    Title = 'Q-function';                     NumberSections = $true },
        @{ Source = 'chapters/hyperparameters.tex';               Title = 'Hyperparameters';                NumberSections = $true }
    )

    Index = @{ Source = 'index.md'; Title = 'Overview' }
}
