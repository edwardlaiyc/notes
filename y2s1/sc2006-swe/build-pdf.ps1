# Build every SC2006 part to N.tex and N.pdf, following y2s1/CLAUDE.md's
# per-lecture loop: pandoc with the house preamble, \fitdisplay for display
# maths that has no line break of its own, then pdflatex twice so the table of
# contents resolves. Run from anywhere; paths are resolved from this script.
#
#   .\build-pdf.ps1            all parts
#   .\build-pdf.ps1 -Only 8    one part

param([string]$Only = '')

$ErrorActionPreference = 'Stop'
$course   = $PSScriptRoot
$preamble = Join-Path $course '..\..\web-pipeline\preamble-markdown.tex' | Resolve-Path

$parts = Get-ChildItem $course -Directory |
    Where-Object { $_.Name -match '^(\d+)-' } |
    Sort-Object { [int]($_.Name -replace '-.*$', '') }

$failed = @()
foreach ($dir in $parts) {
    $n = $dir.Name -replace '-.*$', ''
    if ($Only -and $n -ne $Only) { continue }
    Push-Location $dir.FullName
    try {
        & pandoc "$n.md" -f markdown -s `
            "--include-in-header=$preamble" `
            --toc --pdf-engine=pdflatex `
            -V documentclass=article -V fontsize=12pt `
            -V geometry:top=2cm,bottom=2cm,left=2cm,right=2cm `
            -V colorlinks=false -V hidelinks=true `
            -t latex -o "$n.tex"
        if ($LASTEXITCODE -ne 0) { throw "pandoc failed" }

        # \[...\] with no \\ and no \begin{...} inside -> \fitdisplay{...}.
        # Equations that break themselves are left alone; shrinking them would
        # squash the whole block to fit its widest row.
        $tex = [IO.File]::ReadAllText("$PWD\$n.tex")
        $tex = [regex]::Replace($tex, '\\\[((?:(?!\\\]).)*?)\\\]', {
            param($m)
            $body = $m.Groups[1].Value
            if ($body -match '\\\\' -or $body -match '\\begin\{') { return $m.Value }
            '\fitdisplay{' + $body + '}'
        }, 'Singleline')
        [IO.File]::WriteAllText("$PWD\$n.tex", $tex, (New-Object Text.UTF8Encoding $false))

        Remove-Item "$n.pdf" -ErrorAction SilentlyContinue
        foreach ($pass in 1, 2) {
            & pdflatex -interaction=nonstopmode -halt-on-error "$n.tex" | Out-Null
            if ($LASTEXITCODE -ne 0) { throw "pdflatex pass $pass failed (see $n.log)" }
        }
        if (-not (Test-Path "$n.pdf")) { throw "no $n.pdf produced" }
        Write-Host "OK   $($dir.Name)\$n.pdf"
    }
    catch {
        Write-Host "FAIL $($dir.Name): $_"
        $failed += $dir.Name
    }
    finally { Pop-Location }
}
if ($failed.Count) { Write-Host "Failed: $($failed -join ', ')"; exit 1 }
