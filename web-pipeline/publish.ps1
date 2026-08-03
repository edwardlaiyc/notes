[CmdletBinding()]
param(
    # Course root to publish. Defaults to the current directory.
    [string]$CourseRoot,

    # Per-course build manifest (PowerShell data file). Defaults to site.psd1 in
    # the course root. See README.md for the schema.
    [string]$Manifest,

    # Per-course pandoc metadata (branding + navigation).
    [string]$Config,

    [switch]$SkipPreprocess
)

$ErrorActionPreference = 'Stop'
$pipelineRoot = $PSScriptRoot

if (-not $CourseRoot) { $CourseRoot = (Get-Location).Path }
$resolvedCourseRoot = (Resolve-Path -LiteralPath $CourseRoot).Path.TrimEnd('\')

if (-not $Manifest) { $Manifest = Join-Path $resolvedCourseRoot 'site.psd1' }
$resolvedManifest = (Resolve-Path -LiteralPath $Manifest).Path

if (-not $Config) { $Config = Join-Path $resolvedCourseRoot 'course.yml' }
$resolvedConfig = (Resolve-Path -LiteralPath $Config).Path

function Assert-LastExitCode([string]$step) {
    if ($LASTEXITCODE -ne 0) {
        throw "$step failed with exit code $LASTEXITCODE"
    }
}

# .html href for a topic, from its course-root-relative .tex source path.
function Get-TopicHref([string]$source) {
    ($source -replace '\\', '/') -replace '\.tex$', '.html'
}

$site = Import-PowerShellDataFile -LiteralPath $resolvedManifest
$topics = @($site.Topics)
if (-not $topics) { throw "Manifest has no Topics: $resolvedManifest" }

$indexTitle = if ($site.Index -and $site.Index.Title) { $site.Index.Title } else { 'Overview' }
$indexSource = if ($site.Index -and $site.Index.Source) { $site.Index.Source } else { 'index.md' }
$indexHref = 'index.html'

# Any figure pre-render kind produces a <name>.gen.tex that topic builds reuse.
# (When the source is a monolith split afterwards, the split output topics carry
# no bytefield/tikz/algorithm markers, so build.ps1 skips reuse regardless.)
$hasPrerendered = @($site.Preprocess |
    Where-Object { $_.Kind -eq 'bytefields' -or $_.Kind -eq 'tikz' -or $_.Kind -eq 'algorithm' }).Count -gt 0

Push-Location $resolvedCourseRoot
try {
    # --- Preprocessing (bytefields, tikz, assemble, split) -----------------
    if (-not $SkipPreprocess -and $site.Preprocess) {
        # Clear stale <name>.gen.tex up front so each publish regenerates figures
        # from source. The figure renderers chain onto an existing .gen.tex (so
        # bytefields -> tikz -> algorithm compose within one run); without this
        # reset a .gen.tex left by a previous run would be treated as already
        # processed and never rebuilt, freezing old output when the source or a
        # renderer changes.
        $figureKinds = @('bytefields', 'tikz', 'algorithm')
        foreach ($step in $site.Preprocess | Where-Object { $figureKinds -contains $_.Kind }) {
            foreach ($src in $step.Sources) {
                $gen = [System.IO.Path]::ChangeExtension((Join-Path $resolvedCourseRoot $src), 'gen.tex')
                if (Test-Path -LiteralPath $gen -PathType Leaf) {
                    Remove-Item -LiteralPath $gen -Force
                }
            }
        }
        foreach ($step in $site.Preprocess) {
            switch ($step.Kind) {
                'bytefields' {
                    foreach ($src in $step.Sources) {
                        $dir = Split-Path -Parent $src
                        $leaf = Split-Path -Leaf $src
                        Push-Location $dir
                        try {
                            & python "$pipelineRoot\render-bytefields.py" $leaf `
                                "$resolvedCourseRoot\images\generated" 'images/generated'
                            Assert-LastExitCode "bytefield render: $src"
                        }
                        finally { Pop-Location }
                    }
                }
                'tikz' {
                    if (-not $step.Preamble) {
                        throw "tikz preprocess step requires a Preamble (course master .tex)."
                    }
                    $preamble = Join-Path $resolvedCourseRoot $step.Preamble
                    foreach ($src in $step.Sources) {
                        $full = Join-Path $resolvedCourseRoot $src
                        $gen = [System.IO.Path]::ChangeExtension($full, 'gen.tex')
                        # Chain onto an existing .gen.tex (e.g. bytefields ran first).
                        $tikzIn = if (Test-Path -LiteralPath $gen) { $gen } else { $full }
                        & python "$pipelineRoot\render-tikz.py" $tikzIn $gen `
                            "$resolvedCourseRoot\images\generated" 'images/generated' `
                            '--preamble' $preamble
                        Assert-LastExitCode "tikz render: $src"
                    }
                }
                'algorithm' {
                    if (-not $step.Preamble) {
                        throw "algorithm preprocess step requires a Preamble (course master .tex)."
                    }
                    $preamble = Join-Path $resolvedCourseRoot $step.Preamble
                    foreach ($src in $step.Sources) {
                        $full = Join-Path $resolvedCourseRoot $src
                        $gen = [System.IO.Path]::ChangeExtension($full, 'gen.tex')
                        # Chain onto an existing .gen.tex if an earlier step ran.
                        $algIn = if (Test-Path -LiteralPath $gen) { $gen } else { $full }
                        & python "$pipelineRoot\render-algorithm.py" $algIn $gen `
                            "$resolvedCourseRoot\images\generated" 'images/generated' `
                            '--preamble' $preamble
                        Assert-LastExitCode "algorithm render: $src"
                    }
                }
                'assemble' {
                    $a = @($step.Out, '--preamble', $step.Preamble)
                    if ($step.Title) { $a += @('--title', $step.Title) }
                    $a += $step.Sources
                    & python "$pipelineRoot\assemble-page.py" @a
                    Assert-LastExitCode "assemble: $($step.Out)"
                }
                'split' {
                    $splitArgs = @($step.Source, $step.OutDir)
                    if ($step.Sections) { $splitArgs += @('--sections', $step.Sections) }
                    $specPath = $null
                    if ($step.Modules) {
                        $spec = @{ modules = @($step.Modules | ForEach-Object {
                            @{ slug = $_.Slug; title = $_.Title } }) }
                        if ($step.TableRouting) {
                            $spec.table_routing = @($step.TableRouting | ForEach-Object {
                                @{ caption = $_.Caption; slug = $_.Slug } })
                        }
                        $specPath = Join-Path ([System.IO.Path]::GetTempPath()) `
                            ("split-spec-{0}.json" -f [guid]::NewGuid().ToString('N'))
                        $spec | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $specPath -Encoding utf8
                        $splitArgs += @('--spec', $specPath)
                    }
                    try {
                        & python "$pipelineRoot\split-sections.py" @splitArgs
                        Assert-LastExitCode "split: $($step.Source)"
                    }
                    finally {
                        if ($specPath -and (Test-Path -LiteralPath $specPath)) {
                            Remove-Item -LiteralPath $specPath -Force
                        }
                    }
                }
                default { throw "Unknown preprocess Kind: $($step.Kind)" }
            }
        }
    }

    # --- Topic pages (prev/next + section offsets derived from order) ------
    $sectionOffset = 0
    for ($i = 0; $i -lt $topics.Count; $i++) {
        $topic = $topics[$i]
        $numberSections = [bool]$topic.NumberSections

        $topicArgs = @{
            Source = $topic.Source
            Title = $topic.Title
            CourseRoot = $resolvedCourseRoot
            Config = $resolvedConfig
            SiteNavigation = $true
        }
        if ($numberSections) {
            $topicArgs.NumberSections = $true
            if ($sectionOffset -gt 0) { $topicArgs.SectionOffset = $sectionOffset }
        }
        if ($hasPrerendered) { $topicArgs.ReuseBytefields = $true }

        # Previous: the prior topic, or the Overview for the first.
        if ($i -eq 0) {
            $topicArgs.PreviousHref = $indexHref
            $topicArgs.PreviousLabel = $indexTitle
        }
        else {
            $topicArgs.PreviousHref = Get-TopicHref $topics[$i - 1].Source
            $topicArgs.PreviousLabel = $topics[$i - 1].Title
        }
        # Next: the following topic, if any.
        if ($i -lt $topics.Count - 1) {
            $topicArgs.NextHref = Get-TopicHref $topics[$i + 1].Source
            $topicArgs.NextLabel = $topics[$i + 1].Title
        }

        & "$pipelineRoot\build.ps1" @topicArgs
        Assert-LastExitCode "$($topic.Title) topic build"

        if ($numberSections) {
            $srcText = Get-Content -Raw -Encoding utf8 -LiteralPath (
                Join-Path $resolvedCourseRoot $topic.Source)
            $sectionOffset += ([regex]::Matches($srcText, '\\section\{')).Count
        }
    }

    # --- Course overview (index) -------------------------------------------
    $assetsDir = Join-Path $resolvedCourseRoot 'assets'
    if (-not (Test-Path -LiteralPath $assetsDir)) {
        New-Item -ItemType Directory -Path $assetsDir | Out-Null
    }
    Copy-Item -LiteralPath (Join-Path $pipelineRoot 'style.css') `
        -Destination (Join-Path $assetsDir 'style.css') -Force
    # Self-hosted web fonts, mirrored next to the stylesheet (see build.ps1).
    $fontsSrc = Join-Path $pipelineRoot 'assets\fonts'
    if (Test-Path -LiteralPath $fontsSrc) {
        $fontsDest = Join-Path $assetsDir 'fonts'
        if (-not (Test-Path -LiteralPath $fontsDest)) {
            New-Item -ItemType Directory -Path $fontsDest | Out-Null
        }
        Copy-Item -Path (Join-Path $fontsSrc '*') -Destination $fontsDest -Recurse -Force
    }

    $indexArgs = @(
        $indexSource, '-f', 'markdown', '-s',
        "--template=$pipelineRoot\template.html",
        "--metadata-file=$resolvedConfig",
        '-c', 'assets/style.css',
        '--metadata', "title=$indexTitle",
        '--metadata', 'hide-page-nav=true',
        '--metadata', 'show-site-nav=true',
        '--metadata', 'open-site-nav=true',
        '-o', $indexHref
    )
    & pandoc @indexArgs
    Assert-LastExitCode 'Course index build'

    # --- Remove obsolete outputs -------------------------------------------
    foreach ($obsolete in @($site.Obsolete)) {
        if ($obsolete -and (Test-Path -LiteralPath $obsolete -PathType Leaf)) {
            Remove-Item -LiteralPath $obsolete -Force
        }
    }

    Write-Host "Published $($topics.Count) topic pages + overview for $resolvedCourseRoot"
}
finally {
    Pop-Location
}
