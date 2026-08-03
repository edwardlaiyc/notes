# SC1006 Computer Organisation & Architecture — notes + web-conversion pipeline

**Scope:** this file adds SC1006-specific instructions to the workspace-wide
`../../CLAUDE.md`. The root file describes conventions shared by every course;
this file owns only this course's source quirks and web pipeline.

## Project context
Personal LaTeX lecture notes (NTU Year 1 Sem 2) being converted to a **fast,
readable, responsive web version** for a personal notes website. Source `.tex`
compiles to PDF normally; this pipeline additionally produces web `.html` (+ a
portable `.md`) from the same source.

**Format decision:** HTML is the *primary* deliverable — it carries the full
design (numbered sections, TOC card, theme toggle, MathML). Markdown is a
*secondary/portable* export (for a future static-site generator); it does NOT
get the HTML navigation panel or auto-numbering. Optimise HTML first.

## Output shape: landing page + chapter-sized reading pages
The web version has a small `index.html` landing page. Both parts use one page
per topic for fast reading; no whole-part combined page is published:

| Page | Built from | Contents |
|------|-----------|----------|
| `index.html` | `index.md` + `course.yml` | Grouped navigation, About, and a separate SC1006 Ecosystem section |
| `chapters-part1/*.html` | one source topic each | Individual Part 1 reading pages |
| `chapters-part2/p2-*.html` | one slice of `part2.tex` each | Individual Part 2 module pages |

**Every reference detail remains published** — nothing is dropped. The General
Reference topic contains the shared tables (byte sizes, memory sizes, number
ranges, condition codes, ASCII) alongside the ARM reference material.

Part 2's source is still the single `cheatsheet2.tex` cheatsheet (→ `part2.tex`
via `assemble-page.py`). For the web it is sliced into eight topic modules by the
shared `split-sections.py` (in `--sections star` spec mode) — one standalone
`.tex` per top-level `\section*` — so Part 2 reads as chapter-sized pages like
Part 1 instead of one long page. The eight modules and the routing of the four
cross-cutting summary tables (three to Memory, one to Data Transfer Mechanisms)
are declared in `site.psd1`'s `split` preprocess step, so nothing is lost. The
`chapters-part2/p2-*.tex` files are generated build artifacts; edit
`cheatsheet2.tex`, not them. The old `chapters-part2/2-memory.tex` draft is not
part of the publishing build.

## Source layout
- `comorg-part1.tex` / `comorg-part2.tex` — PDF master docs (preamble + `\subfile`
  list). The web build does NOT use these except to borrow the preamble.
- `chapters-part1/*.tex` — Part 1 chapters, each a `subfiles` document.
- `chapters-part2/2-memory.tex` — an unused historical draft, excluded from the
  Part 2 publishing build.
- `cheatsheet2.tex` (course root) — standalone `article`, the real Part 2 content.
- `chapters-part1/cheatsheet.tex` — general reference, a `subfiles` doc using
  `comorg-part1.tex` and shared reference fragments from `snippets/`.
- `snippets/*.tex` — shared fragments `\input` by the General Reference. Pandoc
  expands `\input`, keeping the tables modular without a duplicate web page.
- `images/` — all figures (shared). `images/generated/` — SVGs this pipeline creates.

## Pipeline package (shared: `../../web-pipeline/`)

The build package is **shared and topic-independent** at
`uni-notes-y1s2/web-pipeline/` — not a subdirectory of this course. See
`../../web-pipeline/README.md` for the scripts, the `site.psd1` schema, and the
gotchas. This course supplies only three files in its own root:

| File (course root) | Role |
|------|------|
| `course.yml` | Course code/title and the output-page navigation model (pandoc metadata). |
| `site.psd1` | Build manifest: the ordered `Topics` list plus the `Preprocess` steps (bytefields, `assemble` of `cheatsheet2.tex` → `part2.tex`, and the `split` of Part 2 into eight modules with summary-table routing). `publish.ps1` reads this. |
| `index.md` | Overview content below navigation: course introduction and the separate SC1006 Ecosystem section. |
| `assets/style.css` | Generated: a staged copy of the shared stylesheet so this course's output is self-contained. Do not edit — edit `../../web-pipeline/style.css`. |

## Modular topic build (default; run from the course root)
```powershell
..\..\web-pipeline\build.ps1 -Source .\chapters-part1\1-introduction.tex
```

This builds only the selected topic and writes HTML/Markdown beside its source.
It auto-detects a valid `subfiles` master preamble. Use `-Preamble` only for a
broken or non-standard master reference. Multiple `-Source` values are each built
independently.

## Full-site publishing build (separate next step)
```powershell
..\..\web-pipeline\publish.ps1
```

Reads `site.psd1`, runs the preprocessing, builds all 17 topic pages (Prev/Next
and section-number offsets derived from topic order) and the overview. Use
`-SkipPreprocess` for presentation-only rebuilds. It does not publish a combined
page for either part.

## Why each choice (gotchas)
- **Math:** `--mathml` — native browser rendering, zero JS/network, lightest. Not
  MathJax/KaTeX (CDN + JS weight).
- **Images:** external WebP (not `--embed-resources`) so HTML stays small and
  assets cache across the shared `media/` folder. Lazy-loaded + dimension-stamped.
- **Re-running pandoc UNDOES `optimize-images.py`** — `--extract-media` re-emits
  the original PNGs and rewrites refs. Always re-run step 5 after any rebuild.
- **`--resource-path`** is REQUIRED: some chapters reference images by bare name
  (`{stack-heap.png}`) relying on the master's `\graphicspath`. Root-level pages
  must therefore include the relevant chapter and image directories.
- **`multicols` silently destroys the TOC.** Pandoc wraps it in a Div, and TOC
  generation only collects TOP-LEVEL headings — so every heading inside vanishes
  from the TOC, the `toc` variable comes out empty, and `$if(toc)$` then drops the
  whole contents disclosure. Fixed by
  `unwrap-multicols.lua`; single-column reflow is what the web wants anyway.
- **Tables pandoc silently DROPS** (renders as raw `&`-separated text instead):
  - `\multirow` — kills the entire table. `\multicolumn` alone is fine.
  - `\cline` — same.
  - `\\` inside `\shortstack` **within a table cell** — terminates the row early,
    breaking the column count. This was the ASCII table's actual killer.
  The ASCII table in `snippets/ascii-table.tex` was flattened to survive: corner
  cell no longer merged, stacked label on one line. Grep built HTML for
  `class="tabular"` — any hit means a table was dropped.
- **bytefield:** pandoc renders these as garbage (`32`, `& & &`). Pre-render with
  `render-bytefields.py`. `cheatsheet.tex` has 7; `cheatsheet2.tex` has none.
  Commented-out bytefields fail to compile — expected, they stay commented.
- **SVG width:** pandoc drops `width=` on SVG `<img>`; `style.css` forces
  `figure > img[src$=".svg"] { width:100% }` so bit-field diagrams span the column.
- **Sub-figure proportions:** pandoc discards LaTeX subfigure width ratios. CSS
  caps each at `max-width:47%`; stacks below 520px.
- **Theme:** defaults to off-white light for everyone (not system-preference);
  toggle persists in `localStorage`.
- **CSS cache when previewing:** the `<link>` to `style.css` is unversioned, so a
  `?v=` on the HTML URL won't refresh CSS — hard-reload (Ctrl+Shift+R). This WILL
  bite you after editing `style.css`; symptoms look like broken layout.

## Page layout / TOC design
The presentation is modelled on the minimal RLHF Book layout: a centred `42em`
Georgia/Palatino reading column, restrained near-body-size in-content headings
(`h1` `1.7em` down to body size — deliberately small like the reference, not the
oversized 2.5em they started at), quiet figure captions, and a small fixed theme
control. `SC1006` is deliberately prominent in the masthead (`1.35em`, heading
colour) because the course code is the primary label; the masthead uses its own
`.course-code`/`.site-title`/`.page-title` classes, so shrinking the bare
`h1`–`h6` rules never touches it.

Overview uses the grouped global navigation panel as its header-level
navigation, followed by About and a separate Ecosystem section, so the template
receives `hide-page-nav=true`.
Reading pages show the same navigation collapsed. There is no separate per-page
header link row — the navigation panel is the single source of page links. The footer
contains the author credit `Edward Lai` plus monochrome
LinkedIn (`linkedin.com/in/edwardlaiyc`) and GitHub (`github.com/edwardlaiyc`) icon
links. Match the RLHF Book footer composition: a centred row of 40px icons with
20px gaps, followed by the author credit underneath, with no top border. The
credit is set larger than the surrounding footer text (`.site-footer p` at
`1.2rem`, body colour) to match the reference site's `.author` credit. Do not
repeat internal page links or the course title there.

Match the RLHF Book homepage structure, not merely its colours:

1. Course masthead.
2. Expanded grouped navigation (one group per section; each link is a whole page,
   never an in-page anchor) laid out in a responsive multi-column grid. Each group
   is a white card. There is no search field.
3. About content.
4. A separate SC1006 Ecosystem section outside the navigation panel.

The Ecosystem section mirrors the reference site's layout: a vertical stack of
horizontal cards, each with a short label on the left and an icon-only
call-to-action button on the right (`.ecosystem` / `.ecosystem-card` /
`.ecosystem-btn` / `.ecosystem-btn-icon` in `style.css`). It contains two cards:
`.pdf` with the full-colour Google Drive logo, and `.tex, .md` with the GitHub
logo. Both are live `<a href="…" class="ecosystem-btn ecosystem-btn-primary
ecosystem-btn-icon" target="_blank" rel="noopener noreferrer" aria-label="…">`
anchors — Drive points at this course's folder under `Y1S2 Notes`, GitHub at
`github.com/edwardlaiyc/school/tree/main/y1s2/sc1006-comorgarchi`. A button whose
URL is not yet known uses a non-clickable
`<span class="ecosystem-btn ecosystem-btn-pending ecosystem-btn-icon">` with an
`aria-label`/`title` of "link pending" instead; swap it for the anchor form above
in `index.md` and rebuild the index. Do not move the Ecosystem into `course.yml`
or the navigation panel, and never invent URLs.

The content-page TOC (`.page-contents`) is an always-visible list under a
`Contents` label — not a collapsible dropdown. It needs no JavaScript and works
consistently at desktop and phone widths. See `../../web-pipeline/README.md`
for the pipeline contract and the LaTeX→pandoc gotchas.

## Local preview
`file://` is blocked by the browser extension. Serve over localhost from the
course root: `python -m http.server 8765` → `http://127.0.0.1:8765/index.html`

## Status
- **Built:** unified `index.html` navigation hub; nine individual Part 1 topic
  HTML/Markdown pairs, including General Reference; and eight Part 2 module
  HTML/Markdown pairs (`chapters-part2/p2-*`). All local assets resolve and no
  tables are dropped.
- **Modular outputs:** the complete publishing build regenerates every Part 1
  topic directly from its LaTeX source, and re-slices Part 2 into its eight
  module pages from `part2.tex`. `build.ps1` also supports selecting any topic
  (Part 1 chapter or Part 2 module) independently.
- **Cleaned:** obsolete bulk-generated topic outputs, root `cheatsheet2.html|.md`,
  and the old shared chapter-media extraction were removed before the modular
  builder was introduced.
- **Known duplication:** the C data-type range table appears in both
  `2-dataorganisation.html` and General Reference because both source documents
  genuinely contain that material.
- **Modular reference:** General Reference uses the five `snippets/*.tex`
  fragments; editing a shared fact updates the single published reference page.
- **Identifiers:** unused LaTeX labels were removed, leaving no duplicate IDs in
  any published HTML page.
- **Landing/footer:** Overview uses its grouped navigation panel (white cards, no
  search field) instead of a duplicate header link row, then renders About and the independent
  Ecosystem section. Every page ends with the reference-style 40px
  LinkedIn/GitHub icon row and `Edward Lai` credit, with no repeated course title
  or internal links.
- **Verified:** consecutive full-site builds are byte-for-byte reproducible. A
  physical-phone spot check remains optional because the automation harness does
  not provide reliable mobile viewport emulation.
