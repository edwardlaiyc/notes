[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
Push-Location $here
try {
    # The Markdown remains the source of truth.  The raw multicols markers in
    # it are deliberately ignored by the HTML writer and retained by LaTeX.
    & pandoc cheatsheet.md -f markdown -s `
        --include-in-header=cheatsheet-preamble.tex `
        -V documentclass=extarticle -V fontsize=9pt -V classoption=landscape `
        -t latex -o cheatsheet.tex
    if ($LASTEXITCODE -ne 0) { throw "pandoc failed with exit code $LASTEXITCODE" }

    # Keep the wide formula table on the landscape page, then make the
    # remaining reference material follow SC2301's compact two-column layout.
    # Pandoc's Markdown reader treats a raw LaTeX environment as one opaque
    # block, so this generated-output step is the safe place for the wrapper.
    $tex = Get-Content -Raw -Encoding utf8 cheatsheet.tex
    # The single four-column formula table needs a slightly smaller type size;
    # applying it after conversion avoids leaking raw braces into the HTML.
    $tex = [regex]::Replace($tex, '\\begin\{longtable\}', "{\scriptsize`r`n\begin{longtable}", 1)
    $tex = [regex]::Replace($tex, '\\end\{longtable\}', "\end{longtable}`r`n}", 1)
    $heading = '\\subsection\{2\. Tested MCQ Question Patterns \\& Plug-and-Chug\s+Steps\}'
    if ($tex -notmatch $heading) { throw 'Could not locate the cheatsheet column break.' }
    $tex = [regex]::Replace($tex, $heading, "\begin{multicols}{2}`r`n`$0", 1)
    $tex = $tex -replace '\\end\{document\}', "\end{multicols}`r`n\end{document}"
    Set-Content -LiteralPath cheatsheet.tex -Value $tex -Encoding UTF8 -NoNewline

    & pdflatex -interaction=nonstopmode -halt-on-error cheatsheet.tex
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path cheatsheet.pdf)) {
        throw "first pdflatex pass failed with exit code $LASTEXITCODE"
    }
    & pdflatex -interaction=nonstopmode -halt-on-error cheatsheet.tex
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path cheatsheet.pdf)) {
        throw "second pdflatex pass failed with exit code $LASTEXITCODE"
    }
}
finally {
    Pop-Location
}
