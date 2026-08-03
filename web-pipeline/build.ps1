[CmdletBinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    [string[]]$Source,

    [string]$CourseRoot,
    [string]$Config,
    [string]$Preamble,
    [string]$Title,
    [switch]$NumberSections,
    [int]$SectionOffset = 0,
    [switch]$SiteNavigation,
    [string]$PreviousHref,
    [string]$PreviousLabel,
    [string]$NextHref,
    [string]$NextLabel,
    [switch]$HtmlOnly,
    [switch]$MarkdownOnly,
    # Pre-rendered figures (bytefields and/or TikZ) live in <name>.gen.tex.
    # -ReuseBytefields consumes an existing one; -NoBytefields skips rendering.
    # Aliases keep the general meaning discoverable (both figure kinds share the
    # single .gen.tex slot).
    [Alias('ReuseGenerated')]
    [switch]$ReuseBytefields,
    [Alias('NoPreRender')]
    [switch]$NoBytefields
)

$ErrorActionPreference = 'Stop'
$pipelineRoot = $PSScriptRoot

# The pipeline is shared and topic-independent, so it can no longer assume it
# lives inside the course. The course root defaults to the current directory
# (run build.ps1 from the course root) but can be set explicitly by publish.ps1.
if (-not $CourseRoot) {
    $CourseRoot = (Get-Location).Path
}
$resolvedCourseRoot = (Resolve-Path -LiteralPath $CourseRoot).Path.TrimEnd('\')

# Per-course pandoc metadata (branding + navigation). Defaults to course.yml in
# the course root; the pipeline no longer ships a course.yml of its own.
if (-not $Config) {
    $Config = Join-Path $resolvedCourseRoot 'course.yml'
}
$resolvedConfig = (Resolve-Path -LiteralPath $Config).Path

if ($HtmlOnly -and $MarkdownOnly) {
    throw 'Choose at most one of -HtmlOnly or -MarkdownOnly.'
}

function Assert-LastExitCode([string]$step) {
    if ($LASTEXITCODE -ne 0) {
        throw "$step failed with exit code $LASTEXITCODE"
    }
}

function Get-RelativeWebPath(
    [string]$fromDirectory,
    [string]$targetPath,
    [switch]$TargetIsDirectory
) {
    $fromFull = [System.IO.Path]::GetFullPath($fromDirectory).TrimEnd('\') + '\'
    $targetFull = [System.IO.Path]::GetFullPath($targetPath)
    if ($TargetIsDirectory) {
        $targetFull = $targetFull.TrimEnd('\') + '\'
    }

    $fromUri = [uri]$fromFull
    $targetUri = [uri]$targetFull
    return [uri]::UnescapeDataString($fromUri.MakeRelativeUri($targetUri).ToString())
}

# Stage the shared stylesheet into the course so each published site is
# self-contained and servable from its own root (the pipeline sits outside it).
function Get-StagedStylesheet {
    $assetsDir = Join-Path $resolvedCourseRoot 'assets'
    if (-not (Test-Path -LiteralPath $assetsDir)) {
        New-Item -ItemType Directory -Path $assetsDir | Out-Null
    }
    $stylesheet = Join-Path $assetsDir 'style.css'
    Copy-Item -LiteralPath (Join-Path $pipelineRoot 'style.css') `
        -Destination $stylesheet -Force
    Copy-StagedFonts $assetsDir
    return $stylesheet
}

# Mirror the self-hosted web fonts next to the staged stylesheet, so the CSS's
# relative url("fonts/...woff2") references resolve in the published site.
function Copy-StagedFonts([string]$assetsDir) {
    $fontsSrc = Join-Path $pipelineRoot 'assets\fonts'
    if (-not (Test-Path -LiteralPath $fontsSrc)) { return }
    $fontsDest = Join-Path $assetsDir 'fonts'
    if (-not (Test-Path -LiteralPath $fontsDest)) {
        New-Item -ItemType Directory -Path $fontsDest | Out-Null
    }
    Copy-Item -Path (Join-Path $fontsSrc '*') -Destination $fontsDest -Recurse -Force
}

function Get-TopicTitle([string]$content, [string]$fallback) {
    $heading = [regex]::Match($content, '\\(?:chapter|section)\*?\{([^{}]+)\}')
    if ($heading.Success) {
        return $heading.Groups[1].Value.Trim()
    }

    $readable = $fallback -replace '^\d+[-_ ]*', '' -replace '[-_]+', ' '
    return (Get-Culture).TextInfo.ToTitleCase($readable)
}

function Resolve-Preamble([string]$content, [string]$sourceDirectory) {
    if ($Preamble) {
        $candidate = if ([System.IO.Path]::IsPathRooted($Preamble)) {
            $Preamble
        }
        else {
            Join-Path $resolvedCourseRoot $Preamble
        }
        return (Resolve-Path -LiteralPath $candidate).Path
    }

    $subfile = [regex]::Match($content, '\\documentclass\[([^\]]+)\]\{subfiles\}')
    if (-not $subfile.Success) {
        return $null
    }

    $candidate = [System.IO.Path]::GetFullPath(
        (Join-Path $sourceDirectory $subfile.Groups[1].Value)
    )
    if (-not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
        throw "The source references a missing subfiles master: $candidate. Supply -Preamble explicitly."
    }
    return $candidate
}

$resolvedSources = foreach ($pattern in $Source) {
    Resolve-Path -Path $pattern | ForEach-Object { $_.Path }
}
$resolvedSources = @($resolvedSources | Sort-Object -Unique)

$stagedStylesheet = Get-StagedStylesheet

foreach ($sourcePath in $resolvedSources) {
    if ([System.IO.Path]::GetExtension($sourcePath) -ne '.tex') {
        throw "Topic source must be a .tex file: $sourcePath"
    }
    if ($sourcePath.EndsWith('.gen.tex', [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Pass the original .tex source, not a generated .gen.tex file: $sourcePath"
    }

    $resolvedSource = [System.IO.Path]::GetFullPath($sourcePath)
    if (-not $resolvedSource.StartsWith(
        $resolvedCourseRoot + [System.IO.Path]::DirectorySeparatorChar,
        [System.StringComparison]::OrdinalIgnoreCase
    )) {
        throw "Source is outside the course root ($resolvedCourseRoot): $resolvedSource"
    }

    $sourceDirectory = Split-Path -Parent $resolvedSource
    $sourceLeaf = Split-Path -Leaf $resolvedSource
    $outputName = [System.IO.Path]::GetFileNameWithoutExtension($resolvedSource)
    $content = Get-Content -Raw -Encoding utf8 -LiteralPath $resolvedSource
    $topicTitle = if ($Title -and $resolvedSources.Count -eq 1) {
        $Title
    }
    else {
        Get-TopicTitle $content $outputName
    }

    # Master preamble (subfiles master, or -Preamble). Needed both for the
    # standalone TikZ crops below and to assemble the page further down.
    $master = Resolve-Preamble $content $sourceDirectory

    # Figures pandoc can't parse (bytefields, TikZ) are pre-rendered to SVG and
    # spliced into a single <name>.gen.tex. When a chapter has both, each renderer
    # chains onto the previous output so no substitution is lost. (algorithm2e is
    # NOT auto-rendered — a course that wants it as an image opts in via the
    # explicit `algorithm` Preprocess step; sc1315 instead ships each algorithm as
    # a Verbatim code block for the web, so its raw algorithm2e must be left for
    # pandoc to drop, not turned into an SVG here.)
    $buildSource = $resolvedSource
    $needsBytefield = $content -match '\\begin\{bytefield\}'
    $needsTikz = $content -match '\\begin\{tikzpicture\}'
    if ($needsBytefield -or $needsTikz) {
        $generatedSource = Join-Path $sourceDirectory "$outputName.gen.tex"
        if ($ReuseBytefields) {
            if (-not (Test-Path -LiteralPath $generatedSource -PathType Leaf)) {
                throw "No reusable pre-rendered source exists for ${sourceLeaf}: $generatedSource"
            }
            $buildSource = $generatedSource
        }
        elseif (-not $NoBytefields) {
            $generatedDir = "$resolvedCourseRoot\images\generated"
            if ($needsBytefield) {
                Push-Location $sourceDirectory
                try {
                    & python "$pipelineRoot\render-bytefields.py" $sourceLeaf `
                        $generatedDir 'images/generated'
                    Assert-LastExitCode "$sourceLeaf bytefield rendering"
                }
                finally {
                    Pop-Location
                }
                $buildSource = $generatedSource
            }
            if ($needsTikz) {
                if (-not $master) {
                    throw "TikZ pre-render needs a master preamble but none was resolved for ${sourceLeaf}. Supply -Preamble."
                }
                $tikzIn = if ($needsBytefield) { $generatedSource } else { $resolvedSource }
                & python "$pipelineRoot\render-tikz.py" $tikzIn $generatedSource `
                    $generatedDir 'images/generated' '--preamble' $master
                Assert-LastExitCode "$sourceLeaf tikz rendering"
                $buildSource = $generatedSource
            }
        }
    }

    $temporarySource = $null
    if ($master) {
        $temporarySource = Join-Path ([System.IO.Path]::GetTempPath()) `
            ("notes-web-{0}.tex" -f [guid]::NewGuid().ToString('N'))
        & python "$pipelineRoot\assemble-page.py" $temporarySource `
            '--preamble' $master '--title' $topicTitle $buildSource
        Assert-LastExitCode "$sourceLeaf preparation"
        $buildSource = $temporarySource
    }

    try {
        $cssPath = Get-RelativeWebPath $sourceDirectory $stagedStylesheet
        $siteRoot = Get-RelativeWebPath $sourceDirectory $resolvedCourseRoot `
            -TargetIsDirectory

        $resourcePath = @(
            '.',
            $resolvedCourseRoot,
            (Join-Path $resolvedCourseRoot 'images'),
            $sourceDirectory,
            (Join-Path $sourceDirectory 'images')
        ) -join ';'

        Push-Location $sourceDirectory
        try {
            if (-not $MarkdownOnly) {
                $htmlArgs = @(
                    $buildSource, '-f', 'latex', '-s', '--mathml', '--toc',
                    "--template=$pipelineRoot\template.html",
                    "--metadata-file=$resolvedConfig",
                    "--lua-filter=$pipelineRoot\unwrap-multicols.lua",
                    "--lua-filter=$pipelineRoot\lazy.lua",
                    "--lua-filter=$pipelineRoot\qa-details.lua",
                    "--lua-filter=$pipelineRoot\toc-hide-unnumbered.lua",
                    '-c', $cssPath,
                    '--metadata', "title=$topicTitle",
                    '--metadata', "site-root=$siteRoot",
                    '--extract-media=media',
                    "--resource-path=$resourcePath",
                    '-o', "$outputName.html"
                )
                if ($NumberSections) {
                    $htmlArgs += '--number-sections'
                    if ($SectionOffset -gt 0) {
                        $htmlArgs += "--number-offset=$SectionOffset"
                    }
                }
                if ($SiteNavigation) {
                    $htmlArgs += @('--metadata', 'show-site-nav=true')
                }
                if ($PreviousHref) {
                    $htmlArgs += @(
                        '--metadata', "previous-href=$PreviousHref",
                        '--metadata', "previous-label=$PreviousLabel"
                    )
                }
                if ($NextHref) {
                    $htmlArgs += @(
                        '--metadata', "next-href=$NextHref",
                        '--metadata', "next-label=$NextLabel"
                    )
                }
                & pandoc @htmlArgs
                Assert-LastExitCode "$sourceLeaf HTML build"
            }

            if (-not $HtmlOnly) {
                $markdownArgs = @(
                    $buildSource, '-f', 'latex', '-t', 'gfm+tex_math_dollars',
                    '--wrap=none',
                    "--lua-filter=$pipelineRoot\unwrap-multicols.lua",
                    "--lua-filter=$pipelineRoot\lazy.lua",
                    '--extract-media=media',
                    "--resource-path=$resourcePath",
                    '-o', "$outputName.md"
                )
                & pandoc @markdownArgs
                Assert-LastExitCode "$sourceLeaf Markdown build"
            }

            $outputs = @()
            if (-not $MarkdownOnly) { $outputs += "$outputName.html" }
            if (-not $HtmlOnly) { $outputs += "$outputName.md" }
            if (Test-Path -LiteralPath 'media') {
                & python "$pipelineRoot\optimize-images.py" 'media' @outputs
                Assert-LastExitCode "$sourceLeaf image optimisation"
            }
        }
        finally {
            Pop-Location
        }

        Write-Host "Built topic: $sourceLeaf -> $($outputs -join ', ')"
    }
    finally {
        if ($temporarySource -and (Test-Path -LiteralPath $temporarySource)) {
            [System.IO.File]::Delete($temporarySource)
        }
    }
}
