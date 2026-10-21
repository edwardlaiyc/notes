@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    # Ordered topic list drives prev/next and section-number offsets; preprocess
    # steps run first. See ../../web-pipeline/README.md for the schema.

    Preprocess = @(
        # Random Variables & Distributions carries several inline TikZ / pgfplots
        # figures (CDF/PMF/PDF diagrams, Gaussian axes) pandoc can't parse ->
        # pre-rendered to SVG, reused by the topic build.
        @{
            Kind     = 'tikz'
            Preamble = 'Probability.tex'
            Sources  = @('chapters/3-randomvariablesanddistributions.tex')
        }
    )

    # Ordered reading sequence; running section numbers derive from order.
    Topics = @(
        @{ Source = 'chapters/1-intro.tex';                          Title = 'Introduction';                    NumberSections = $true },
        @{ Source = 'chapters/2-conditionalprob.tex';                Title = 'Conditional Probability';         NumberSections = $true },
        @{ Source = 'chapters/3-randomvariablesanddistributions.tex'; Title = 'Random Variables & Distributions'; NumberSections = $true },
        @{ Source = 'chapters/4-expectation.tex';                    Title = 'Expectation';                     NumberSections = $true },
        @{ Source = 'chapters/5-variance.tex';                       Title = 'Variance';                        NumberSections = $true },
        @{ Source = 'chapters/6-concentration.tex';                  Title = 'Concentration Inequalities';      NumberSections = $true },
        @{ Source = 'chapters/7-estimation.tex';                     Title = 'Estimation';                      NumberSections = $true },
        @{ Source = 'chapters/8-estimation2.tex';                    Title = 'Estimation II';                   NumberSections = $true },
        @{ Source = 'chapters/9-linearlogregression.tex';           Title = 'Linear & Logistic Regression';    NumberSections = $true },
        @{ Source = 'chapters/10-bayesianregression.tex';           Title = 'Bayesian Regression';             NumberSections = $true },
        @{ Source = 'chapters/11-statisticalml.tex';                 Title = 'Statistical Machine Learning';    NumberSections = $true },
        @{ Source = 'chapters/12-samplingoptimise.tex';             Title = 'Optimisation & Sampling';         NumberSections = $true }
    )

    Index = @{ Source = 'index.md'; Title = 'Overview' }
}
