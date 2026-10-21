@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    #
    # SC2006 is authored in Markdown, one part per folder (N-slug/N.md), the
    # same layout as SC2008. Figures ship as PNG under each part's
    # N-artifacts/ folder; the .puml beside a PNG is its editable source.
    # The PDFs come from build-pdf.ps1, not from this manifest.
    # Titles must stay plain ASCII (see the root CLAUDE.md).

    Topics = @(
        @{ Source = '0-overview\0.md'
           Title  = 'Overview and Exam Structure' }
        @{ Source = '1-introduction\1.md'
           Title  = '1. Software Engineering and the Life Cycle' }
        @{ Source = '2-requirements-elicitation\2.md'
           Title  = '2. Requirements Elicitation' }
        @{ Source = '3-use-case-model\3.md'
           Title  = '3. Use Case Model' }
        @{ Source = '4-srs\4.md'
           Title  = '4. Software Requirements Specification (SRS)' }
        @{ Source = '5-conceptual-model\5.md'
           Title  = '5. Conceptual Model' }
        @{ Source = '6-dynamic-models\6.md'
           Title  = '6. Dynamic Models: State Machine and Activity Diagrams' }
        @{ Source = '7-software-processes\7.md'
           Title  = '7. Software Process Models' }
        @{ Source = '8-agile-scrum\8.md'
           Title  = '8. Agile, Extreme Programming and Scrum' }
        @{ Source = '9-system-design\9.md'
           Title  = '9. System Design and Software Architecture' }
        @{ Source = '10-design-patterns\10.md'
           Title  = '10. Object Design and Design Patterns' }
        @{ Source = '11-mvc\11.md'
           Title  = '11. Model-View-Controller (MVC)' }
        @{ Source = '12-exam-method\12.md'
           Title  = '12. Exam Method, Question by Question' }
    )
}
