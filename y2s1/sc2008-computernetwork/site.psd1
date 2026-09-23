@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    #
    # SC2008 is authored in Markdown, one lecture per folder (N-slug/N.md),
    # same convention as the y2s1 draft pipeline (see ../CLAUDE.md) but wired
    # into the shared site build instead of the standalone pandoc loop.
    # build.ps1 detects the .md extension and takes its Markdown path -- no
    # preamble, no figure pre-rendering. Figures ship as PNG under
    # each lecture's N-artifacts/ folder.

    Topics = @(
        @{ Source = '1-networklayers\1.md'
           Title  = 'Network Layers and Physical Resilience' }
        @{ Source = '2-dll-flow-error-control\2.md'
           Title  = 'Data Link Layer (DLL): Flow & Error Control' }
        @{ Source = '3-dll-mac-lan\3.md'
           Title  = 'Data Link Layer (DLL): Medium Access Control & LANs' }
        @{ Source = '4-network-paradigms\4.md'
           Title  = 'Network Paradigms' }
    )
}
