# SC1305 Linear Algebra — notes + web-conversion pipeline

**Scope:** this file adds SC1305-specific instructions to the workspace-wide
`../../CLAUDE.md` and the shared pipeline contract in
`../../web-pipeline/README.md`. The root file describes conventions shared by every
course; this file owns only this course's source quirks and web build.

## Source layout
A standard `subfiles` project (see the root CLAUDE.md):
- `linear-algebra.tex` — PDF master (preamble + `\subfile` list). The web build
  borrows its preamble but does not otherwise use it. It is also the preamble
  passed to the TikZ pre-renderer, so standalone crops match the notes' fonts,
  colours, and macros.
- `chapters/*.tex` — the nine chapters, each a `subfiles` document. **Edit these**,
  not the master. Each has one `\section{}` except `0A0Bvectormatrix` (Vectors +
  Matrices) and `2-matrixalgebra` (Inverse + Factorisation), which have two — so
  the running section numbers step 1,2 / 3 / 4,5 / 6 … across the nine pages.
- `images/` — figures. `images/generated/` — SVGs this pipeline creates.
- `cheatsheet.tex`, `cheatsheet2.tex` — dense multi-column exam crib sheets
  (`multicol` + `nicematrix`, no `\section`s). **Intentionally excluded from the
  web build** (PDF only): they do not fit the per-topic reading format and their
  `nicematrix`/`multicol`/`listings` content is pandoc-hostile. Revisit only if a
  web reference page is explicitly wanted.

## Output shape
Landing page + one reading page per chapter, exactly like the other wired-up
courses. `index.html` (from `index.md` + `course.yml`) carries the grouped
navigation, About, and the SC1305 Ecosystem section (two cards, `.pdf` on Google
Drive and `.tex, .md` on GitHub — both **links pending**, same convention as
sc1006; replace the `ecosystem-btn-pending` span with an `<a>` when a URL exists,
never invent one). The nine `chapters/*.html` are the reading pages.

## The one course-specific wrinkle: inline TikZ
Unlike sc1006 (bytefields + PNGs), this course draws figures inline with **TikZ /
pgfplots** — 14 of them in `chapters/0A0Bvectormatrix.tex` (2-D vector diagrams,
one pgfplots 3-D axis, two `tikz-3dplot` scenes). Pandoc drops or garbles these,
so the shared pipeline gained `render-tikz.py`: each `\begin{tikzpicture}…\end{tikzpicture}`
(plus any `\tdplotsetmaincoords{..}{..}` line right before it) is compiled as a
`standalone` crop to SVG and spliced in as `\includegraphics`. It is wired as a
`tikz` preprocess step in `site.psd1` (needs `Preamble = 'linear-algebra.tex'`);
`build.ps1` also auto-renders any chapter containing `\begin{tikzpicture}`. See
the TikZ gotcha in `../../web-pipeline/README.md`. If more chapters gain TikZ
figures later, add their `.tex` to the `tikz` step's `Sources`.

## Build
From the course root:
```powershell
..\..\web-pipeline\build.ps1 -Source .\chapters\3-determinants.tex   # one topic
..\..\web-pipeline\publish.ps1                                        # whole site
```
`publish.ps1` reads `site.psd1`, pre-renders the TikZ figures, then builds the
nine topic pages (prev/next + section offsets from topic order) and the overview.
`-SkipPreprocess` rebuilds presentation only (reusing existing `.gen.tex` / SVGs).

## Local preview
`file://` is blocked by the browser extension. Serve over localhost from the
course root: `python -m http.server 8765` → `http://127.0.0.1:8765/index.html`.
Hard-reload (Ctrl+Shift+R) after editing `style.css` — the `<link>` is unversioned.

## Status
Wired up and verified. `course.yml`, `index.md`, `site.psd1`, and this file
authored; `render-tikz.py` added to the shared pipeline (with a `tikz` preprocess
Kind in `publish.ps1` and auto-render in `build.ps1`). Full `publish.ps1` builds
all nine topic pages + overview; the 14 TikZ/pgfplots figures in ch.1 pre-render
to SVG, running section numbers span 1–11, prev/next nav and MathML (incl. boxed
augmented matrices via `<menclose>`) are correct, and no tables are dropped.
Three source expressions that pandoc could not convert to MathML were fixed in
place: two `\[ … \\ … \]` display blocks in `0A0Bvectormatrix.tex` became
`aligned` environments, and a `\text{\small $p$}` label in `1-systemlineareqns.tex`
(wide-matrix section) became `\scriptstyle p` — pandoc/texmath rejects `\small`
and nested `$…$` inside `\text{}`. Both still typeset identically in the PDF.
