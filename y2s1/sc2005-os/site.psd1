@{
    # Build manifest for the shared web pipeline (../../web-pipeline/publish.ps1).
    #
    # SC2005 is authored in Markdown. Lectures are one folder each (N-slug/N.md,
    # figures in N-artifacts/), the same layout as SC2008. The tutorial question
    # pages (tutorial-questions/tutorial-N.md, figures in tutorial-N-artifacts/)
    # replaced the old exam cheatsheet. 1-overview/1.tex was the older LaTeX
    # lecture 1; it was replaced by 1.md.
    #
    # The lab guides live under labs/. Labs 1-2 are flat .md files that use the
    # course-root images/ folder (build.ps1 puts it on the resource path); labs
    # 3-4 each have their own folder with an images/ folder beside the .md.

    Topics = @(
        @{ Source = '1-overview\1.md'
           Title  = '1. Overview of Operating Systems' }
        @{ Source = '2-processes-threads\2.md'
           Title  = '2. Processes and Threads' }
        @{ Source = '3-cpu-scheduling\3.md'
           Title  = '3. CPU Scheduling' }
        @{ Source = '4-synchronization\4.md'
           Title  = '4. Process Synchronization' }
        @{ Source = '5-deadlocks\5.md'
           Title  = '5. Deadlocks' }
        @{ Source = '6a-rtos\6a.md'
           Title  = '6a. Real-Time Operating Systems' }
        @{ Source = '6b-virtualization\6b.md'
           Title  = '6b. Virtualization' }
        @{ Source = '7-memory-organization\7.md'
           Title  = '7. Memory Organization' }
        @{ Source = '8-virtual-memory\8.md'
           Title  = '8. Virtual Memory' }
        @{ Source = '9-file-systems\9.md'
           Title  = '9. File Systems' }
        @{ Source = 'tutorial-questions\tutorial-1.md'
           Title  = 'Tutorial 1: Overview of Operating Systems' }
        @{ Source = 'tutorial-questions\tutorial-2.md'
           Title  = 'Tutorial 2: Processes and Threads' }
        @{ Source = 'tutorial-questions\tutorial-3.md'
           Title  = 'Tutorial 3: CPU Scheduling' }
        @{ Source = 'tutorial-questions\tutorial-4.md'
           Title  = 'Tutorial 4: Process Synchronization I' }
        @{ Source = 'tutorial-questions\tutorial-5.md'
           Title  = 'Tutorial 5: Process Synchronization II' }
        @{ Source = 'tutorial-questions\tutorial-6.md'
           Title  = 'Tutorial 6: Deadlocks' }
        @{ Source = 'labs\lab-1.md'
           Title  = 'Lab 1 Guide' }
        @{ Source = 'labs\lab-2.md'
           Title  = 'Lab 2 Guide' }
        @{ Source = 'labs\lab-3\lab-3.md'
           Title  = 'Lab 3 Guide' }
        @{ Source = 'labs\lab-4\lab-4.md'
           Title  = 'Lab 4 Guide' }
    )
}
