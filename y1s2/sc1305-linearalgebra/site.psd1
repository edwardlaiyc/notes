@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    # Ordered topic list drives prev/next and section-number offsets; preprocess
    # steps run first. See ../../web-pipeline/README.md for the schema.

    Preprocess = @(
        # Vectors & Matrices carries 14 inline TikZ / pgfplots figures pandoc
        # can't parse -> pre-rendered to SVG, reused by the topic build.
        @{
            Kind     = 'tikz'
            Preamble = 'linear-algebra.tex'
            Sources  = @('chapters/0A0Bvectormatrix.tex')
        }
    )

    # Ordered reading sequence; running section numbers derive from order.
    Topics = @(
        @{ Source = 'chapters/0A0Bvectormatrix.tex'; Title = 'Vectors & Matrices';           NumberSections = $true },
        @{ Source = 'chapters/1-systemlineareqns.tex'; Title = 'Systems of Linear Equations'; NumberSections = $true },
        @{ Source = 'chapters/2-matrixalgebra.tex';  Title = 'Matrix Algebra';                NumberSections = $true },
        @{ Source = 'chapters/3-determinants.tex';   Title = 'Determinants';                  NumberSections = $true },
        @{ Source = 'chapters/4-vectorspaces.tex';   Title = 'Vector Spaces';                 NumberSections = $true },
        @{ Source = 'chapters/5-orthogonality.tex';  Title = 'Orthogonality';                 NumberSections = $true },
        @{ Source = 'chapters/6-leastsquares.tex';   Title = 'Least Squares';                 NumberSections = $true },
        @{ Source = 'chapters/7-complexnumbers.tex'; Title = 'Complex Numbers';               NumberSections = $true },
        @{ Source = 'chapters/8-eigen.tex';          Title = 'Eigenvalues & Eigenvectors';    NumberSections = $true }
    )

    Index = @{ Source = 'index.md'; Title = 'Overview' }
}
