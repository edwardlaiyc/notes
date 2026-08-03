# SC2500 Probability & Statistics — notes + web-conversion pipeline

**Scope:** this file adds SC2500-specific instructions to the workspace-wide
`../../CLAUDE.md` and the shared pipeline contract in
`../../web-pipeline/README.md`. The root file describes conventions shared by every
course; this file owns only this course's source quirks and web build.

## Source layout
A standard `subfiles` project (see the root CLAUDE.md):
- `Probability.tex` — PDF master (preamble + `\subfile` list). The web build
  borrows its preamble but does not otherwise use it. It is also the preamble
  passed to the TikZ pre-renderer, so standalone crops match the notes' fonts,
  colours, and macros.
- `chapters/*.tex` — the twelve chapters, each a `subfiles` document. **Edit
  these**, not the master. Each has one `\section{}` except
  `12-samplingoptimise` (Optimisation in ML + Sampling), which has two — so the
  running section numbers step 1…11 then 12,13 across the twelve pages.
- `images/` — figures (raster PNGs + a few pre-existing SVGs).
  `images/generated/` — SVGs this pipeline creates from the ch.3 TikZ.
- `cheatsheet2.tex`, `cheatsheet3.tex`, `test.tex` — exam crib sheets / scratch.
  **Intentionally excluded from the web build** (PDF only): they are not part of
  the per-topic reading sequence.

## Output shape
Landing page + one reading page per chapter, exactly like the other wired-up
courses. `index.html` (from `index.md` + `course.yml`) carries the grouped
navigation, About, and the SC2500 Ecosystem section (two cards, `.pdf` on Google
Drive and `.tex, .md` on GitHub — both live `ecosystem-btn-primary` anchors,
same convention as sc1006/sc1305; a button with no known URL uses the
non-clickable `ecosystem-btn-pending` span instead, and URLs are never invented).
The twelve `chapters/*.html` are the reading pages.

## The one course-specific wrinkle: inline TikZ / pgfplots
Only `chapters/3-randomvariablesanddistributions.tex` draws figures inline: six
of them (two hand-drawn CDF `tikzpicture`s, a PMF stem plot, and three `pgfplots`
axes — PDF/Gaussian). Pandoc drops or garbles these, so the shared
`render-tikz.py` compiles each as a `standalone` crop to SVG and splices in an
`\includegraphics`. It is wired as a `tikz` preprocess step in `site.psd1`
(needs `Preamble = 'Probability.tex'`); `build.ps1` also auto-renders any chapter
containing `\begin{tikzpicture}`. If more chapters gain TikZ figures later, add
their `.tex` to the `tikz` step's `Sources`.

## Build
From the course root:
```powershell
..\..\web-pipeline\build.ps1 -Source .\chapters\5-variance.tex   # one topic
..\..\web-pipeline\publish.ps1                                    # whole site
```
`publish.ps1` reads `site.psd1`, pre-renders the six ch.3 figures, then builds the
twelve topic pages (prev/next + section offsets from topic order) and the
overview. `-SkipPreprocess` rebuilds presentation only (reusing existing SVGs).
Run `publish.ps1` **without** stdout redirection — pandoc's benign texmath
`[WARNING]` lines on stderr make PowerShell 5.1 abort a redirected/piped run
(NativeCommandError); the plain invocation completes.

## Local preview
`file://` is blocked by the browser extension. Serve over localhost from the
course root: `python -m http.server 8765` → `http://127.0.0.1:8765/index.html`.
Hard-reload (Ctrl+Shift+R) after editing `style.css` — the `<link>` is unversioned.

## Status
Wired up and verified. `course.yml`, `index.md`, `site.psd1`, and this file
authored. Full `publish.ps1` builds all twelve topic pages + overview; the six
TikZ/pgfplots figures in ch.3 pre-render to SVG, running section numbers span
1–13, prev/next nav and MathML render, and no tables are dropped.

Two fixes were needed along the way:
- **Shared pipeline** — `render-tikz.py` gained a `DROP_COMMAND_RE` pass. This
  master configures page layout / links with bare `\geometry{...}` and
  `\hypersetup{...}` lines; the pre-renderer already drops the `geometry`/
  `hyperref` *packages* from the standalone crop, which left those config
  commands undefined and every ch.3 crop failed to compile. The new pass strips
  `\geometry{}`, `\hypersetup{}`, and `\captionsetup{}` invocations (brace group
  included, multi-line safe) from the derived standalone preamble. General fix,
  benefits any future course whose master carries such config lines.
- **Source** — one `align*` block in `11-statisticalml.tex` carried a `\notag`
  (a no-op in an unnumbered `align*`) that pandoc/texmath rejected, dropping the
  block to raw TeX. Removed; the PDF is unchanged. The `[WARNING] Could not
  convert TeX math …` lines from ch.6 (`\frac{1}{t}` inside a `longtable` cell)
  and ch.12 (`O\left(\dots\right)`) are emitted on the **Markdown** pass only —
  the HTML pass converts them to correct MathML, so they are benign; leave them.
