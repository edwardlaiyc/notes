[CmdletBinding()]
param(
    # Root that holds the course folders (and the hub's index.md / hub.yml) —
    # i.e. a semester folder such as y1s2. Defaults to the current directory,
    # matching publish.ps1's -CourseRoot convention.
    [string]$HubRoot,

    # Hub content (pandoc markdown). Defaults to index.md in the hub root.
    [string]$Source,

    # Hub pandoc metadata (branding + the subject navigation).
    [string]$Config,

    # Page title — the <h1>, the reading-bar label, and part of <title>.
    [string]$Title = 'Lecture Notes'
)

$ErrorActionPreference = 'Stop'
$pipelineRoot = $PSScriptRoot

if (-not $HubRoot) { $HubRoot = (Get-Location).Path }
$resolvedHubRoot = (Resolve-Path -LiteralPath $HubRoot).Path.TrimEnd('\')

if (-not $Source) { $Source = Join-Path $resolvedHubRoot 'index.md' }
$resolvedSource = (Resolve-Path -LiteralPath $Source).Path

if (-not $Config) { $Config = Join-Path $resolvedHubRoot 'hub.yml' }
$resolvedConfig = (Resolve-Path -LiteralPath $Config).Path

Push-Location $resolvedHubRoot
try {
    # Stage the shared stylesheet + self-hosted fonts, exactly as a course does,
    # so the hub is servable from this root with nothing fetched at page load.
    $assetsDir = Join-Path $resolvedHubRoot 'assets'
    if (-not (Test-Path -LiteralPath $assetsDir)) {
        New-Item -ItemType Directory -Path $assetsDir | Out-Null
    }
    Copy-Item -LiteralPath (Join-Path $pipelineRoot 'style.css') `
        -Destination (Join-Path $assetsDir 'style.css') -Force
    $fontsSrc = Join-Path $pipelineRoot 'assets\fonts'
    if (Test-Path -LiteralPath $fontsSrc) {
        $fontsDest = Join-Path $assetsDir 'fonts'
        if (-not (Test-Path -LiteralPath $fontsDest)) {
            New-Item -ItemType Directory -Path $fontsDest | Out-Null
        }
        Copy-Item -Path (Join-Path $fontsSrc '*') -Destination $fontsDest -Recurse -Force
    }

    # Same shell as every course overview, minus both navigations: the subject
    # cards in the body already route to every course, and the template's site
    # navigation (built for a course's long chapter list) only duplicated them.
    $pandocArgs = @(
        $resolvedSource, '-f', 'markdown', '-s',
        "--template=$pipelineRoot\template.html",
        "--metadata-file=$resolvedConfig",
        '-c', 'assets/style.css',
        '--metadata', "title=$Title",
        '--metadata', 'hide-page-nav=true',
        '-o', 'index.html'
    )
    & pandoc @pandocArgs
    if ($LASTEXITCODE -ne 0) { throw "Hub index build failed with exit code $LASTEXITCODE" }

    Write-Host "Published hub index for $resolvedHubRoot"
}
finally { Pop-Location }
