@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    # Ethics is a single monolithic article; the split step slices it into one
    # standalone .tex per top-level \section (auto mode — slug derived from the
    # heading, no Modules list needed). See ../../web-pipeline/README.md.

    Preprocess = @(
        @{
            Kind     = 'split'
            Source   = 'ethics-test.tex'
            OutDir   = 'chapters'
            Sections = 'plain'
        }
    )

    Topics = @(
        @{ Source = 'chapters/metaethics.tex';       Title = 'Metaethics';       NumberSections = $true },
        @{ Source = 'chapters/moral-relativism.tex'; Title = 'Moral Relativism'; NumberSections = $true },
        @{ Source = 'chapters/utilitarianism.tex';   Title = 'Utilitarianism';   NumberSections = $true },
        @{ Source = 'chapters/deontology.tex';       Title = 'Deontology';       NumberSections = $true },
        @{ Source = 'chapters/virtue-ethics.tex';    Title = 'Virtue Ethics';    NumberSections = $true },
        # Review section — unnumbered.
        @{ Source = 'chapters/questions.tex';        Title = 'Questions' }
    )

    Index = @{ Source = 'index.md'; Title = 'Overview' }
}
