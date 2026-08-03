# SC1315 Artificial Intelligence — notes + web-conversion pipeline

**Scope:** this file adds SC1315-specific instructions to the workspace-wide
`../../CLAUDE.md` and the shared pipeline contract in
`../../web-pipeline/README.md`. The root file describes conventions shared by every
course; this file owns only this course's source quirks and web build.

## Source layout
Two **monolithic `article`s** (not a `subfiles` project), one per assessment:
- `test1.tex` — Test 1: uninformed + informed search and adversarial search /
  game trees. Thirteen top-level `\section`s. Carries eight pseudocode blocks
  (BFS, DFS, DLS, Iterative Deepening, UCS, Greedy, Game-tree backward induction,
  Minimax) authored as `lstlisting`, one `lstlisting` Python code block, three
  raster PNG figures, and two plain `tabular`s.
- `test2.tex` — Test 2: tabular reinforcement learning (Q-learning on a
  gridworld). Three `\section`s, plain prose + math, no figures or algorithms.

Each `.tex` **is** the source of truth (like `sc1302-ethics`, unlike the
`subfiles` courses). The per-section files under `chapters/` are **generated** by
the split step below — do **not** hand-edit them; edit `test1.tex` / `test2.tex`.

## Output shape
Landing page + one reading page per `\section` (16 total), numbered 1–16 across
the two documents. `index.html` (from `index.md` + `course.yml`) carries the
grouped navigation (Search Strategies / Adversarial Search / Reinforcement
Learning), About, and the SC1315 Ecosystem section (two cards, `.pdf` on Google
Drive and `.tex, .md` on GitHub — both live `ecosystem-btn-primary` anchors,
same convention as the other courses; a button with no known URL uses the
non-clickable `ecosystem-btn-pending` span instead, and URLs are never
invented).

## Algorithms: algorithm2e in the PDF, a Verbatim code block on the web
Each of the eight search/game algorithms is written **twice** in `test1.tex`,
back to back:
1. the original `\begin{algorithm}…\end{algorithm}` (algorithm2e) — this is what
   the **PDF** typesets, unchanged from the source notes; and
2. a `\begin{Verbatim}…\end{Verbatim}` block immediately after it, holding the
   same pseudocode as **plain text** — this is what the **web** shows, as a real
   copyable `<pre>` code block (with the shared copy button).

The two are kept from colliding by one preamble line, `\excludecomment{Verbatim}`
(from the `comment` package): **pdflatex skips every `Verbatim` block**, so the
PDF renders only the algorithm2e version; **pandoc conversely** drops each
algorithm2e to an empty `<div class="algorithm">` (hidden by `.algorithm{display:
none}` in the shared `style.css`) and renders the `Verbatim` as a code block.
Because pdflatex never sees the `Verbatim`, its Unicode maths glyphs
(`⟨⟩ ← τ ∈ ≠ ≤ ∞ ∅ ∪ ⊆ ∖ ℕ`, subscripts `s₀ uᵢ uⱼ`) need no inputenc/literate
setup — they just pass through pandoc to the web font.

This is the settled design after several iterations (algorithm2e→SVG image;
plain-text `lstlisting`; native MathML `array` with vertical guide lines — all
rejected: image not copyable, MathML not a code block, guide lines ugly). Web =
copyable monospace code block with 4-space indentation (no vertical guides); PDF
= the original algorithm2e. **Edit both halves** when you change an algorithm
(they are intentionally duplicated so each medium looks right); `test2.tex` has no
algorithms. `render-algorithm.py` / the `algorithm` preprocess Kind still exist as
an unused optional tool (SVG image approach) but nothing wires them now — and
`build.ps1` deliberately does **not** auto-render `\begin{algorithm}` (that would
turn these back into images); the SVG path is opt-in via the explicit Preprocess
step only.

## Build
From the course root:
```powershell
..\..\web-pipeline\publish.ps1                 # whole site (recommended)
```
`publish.ps1` reads `site.psd1`: splits both articles into `chapters/`, then
builds the 16 topic pages (prev/next + section offsets from topic order) and the
overview. Building a single split chapter in isolation with
`build.ps1 -Source .\chapters\<slug>.tex` also works, but re-splitting requires
the full `publish.ps1`.

## Local preview
`file://` is blocked by the browser extension. Serve over localhost from the
course root: `python -m http.server 8765` → `http://127.0.0.1:8765/index.html`.
Hard-reload (Ctrl+Shift+R) after editing `style.css` — the `<link>` is unversioned.

## Status
Wired up and verified. `course.yml`, `index.md`, `site.psd1`, and this file
authored. Full `publish.ps1` builds all 16 topic pages + overview: the eight
algorithms render on the web as copyable `Verbatim` code blocks (with copy
button, empty algorithm2e divs hidden) while `pdflatex test1.tex` still typesets
the original algorithm2e; running section numbers span 1–16, the two comparison
`tabular`s and all MathML render, prev/next nav is correct, and no tables are
dropped.

Known minor fidelity note: pandoc drops the inline `{\color{blue}…}` /
`{\color{red}…}` cell colouring in the "Comparison of searches" `tabular`, so the
strategy names render in the default colour and the "blue = uninformed, red =
informed" legend line no longer maps to colour. The table is fully readable; the
loss is cosmetic and left as-is.
