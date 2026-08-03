# SC1008 C & C++ Programming — notes + web-conversion

**Scope:** this file adds SC1008-specific instructions to the workspace-wide
`../../CLAUDE.md`. The shared web pipeline is documented in
`../../web-pipeline/README.md`.

## This is a link-out course — read this first

Unlike every other course here, **the real notes for SC1008 are not in this
repo.** They were written and run in a **Google Colab notebook** stored on Google
Drive. That notebook is deliberately **not** converted into the site; the
overview page simply links out to it.

So this course has only one piece of LaTeX source:

| File | Role |
|------|------|
| `final-summary.tex` | A standalone `article` cheat sheet — "C++ Library Functions & Core Concepts". 6 top-level `\section`s, ~23 `\subsection`s, all code in `lstlisting`. **This is the source of truth**; edit it directly. |
| `final-summary.pdf` | pdflatex output. |

There is no `chapters/` folder, no `images/`, and no `subfiles` structure.

## Web version — two pages

| Page | Built from | Contents |
|------|-----------|----------|
| `index.html` | `index.md` + `course.yml` | Overview: a one-line About and the SC1008 Ecosystem cards |
| `final-summary.html` | `final-summary.tex` | The whole cheat sheet as **one** page, sections numbered 1–6 |

`final-summary.tex` is listed **directly** as a topic in `site.psd1` with **no
`split` preprocess step** — at 450 lines it reads fine as a single page, and
slicing a cheat sheet into six fragments would hurt more than help. If it ever
grows, add a `split` step (`Sections = 'plain'`, auto mode) per the pipeline
README.

**No preprocessing is needed at all.** The code is entirely `lstlisting`, which
pandoc converts natively into `<pre>` blocks (and which therefore pick up the
shared copy-button). There are no bytefields, no TikZ/pgfplots, and no
`algorithm2e`, so none of the SVG pre-renderers apply.

## Ecosystem links — the point of this course's overview

The overview page is essentially just these two cards — with the About section
trimmed to a single line, they *are* the content.

| Card | Destination | Holds |
|------|-------------|-------|
| `.ipynb, .pdf` | Google Drive | The Colab notebook (the real notes) and the PDF |
| `.tex, .md` | GitHub | The cheat sheet source and its portable Markdown export |

Cards are titled by **file type only, with no `<p>` subtitle** — the house style
across all six courses. Don't add descriptive subtitles here; the earlier draft
had them and they were removed to match.

SC1008 was the **first** course to use the live `ecosystem-btn-primary` style;
every course now uses it, and `ecosystem-btn-pending` is reserved for a button
whose URL is not yet known. The live form is an `<a class="ecosystem-btn
ecosystem-btn-primary ecosystem-btn-icon" href="…">`, matching the CSS comment in
`../../web-pipeline/style.css` ("Active state once a real URL replaces the pending
span with an `<a>`").

**Keep the `aria-label`s.** Since the visible text is now just a file extension,
each button's `aria-label` ("Full notes — Colab notebook on Google Drive",
"Source .tex and .md on GitHub") is the only thing telling a screen-reader user
where the link goes.

**Not a bug:** the built `index.html` shows each button wrapped in a `<p>`
(`<p><a class="ecosystem-btn"…`). That is pandoc wrapping a lone raw-HTML inline
element in a paragraph, and every other course's `index.html` does the same with
its `<span>`. Don't "fix" it.

**Gotcha:** external URLs must live in `index.md`, **not** in `course.yml`'s
`navigation-groups`. The template prefixes every nav `href` with `$site-root$`
(`template.html:85`), which would mangle an absolute URL into
`../https://…`. Navigation stays internal-only.

Because of that, `course.yml` carries the link-out explanation inside the **Notes**
navigation group instead — as a second bullet under the cheat sheet, reading "Full
notes in the notebook below". It carries **no `href`**, so the shared template
renders it as plain `<li class="navigation-text">` text rather than a link (SC1008
is the only user of that template branch; see `../../web-pipeline/README.md`). Don't
give it an href — it names the ecosystem card below, it isn't a page. It is the
only place on the site that explains *why* the full notes are absent (the About
section no longer says so), and it replaced an earlier `note:` paragraph on the
same group — the template still supports `note:`, nothing uses it now.

## Build

Whole site (overview + the cheat sheet page):
```powershell
..\..\web-pipeline\publish.ps1
```
Just the cheat sheet:
```powershell
..\..\web-pipeline\build.ps1 -Source .\final-summary.tex
```

## Local preview
Serve from the course root so `assets/style.css` and page links resolve:
```powershell
python -m http.server 8765   # → http://127.0.0.1:8765/index.html
```

## Status
- **Built:** `index.html` + `final-summary.html`/`.md`. Sections numbered 1–6,
  22 code blocks, TOC and navigation present, no dropped tables
  (`class="tabular"` count is 0).
- **Ecosystem links are live.** `index.md` points `.ipynb, .pdf` at this
  course's Google Drive folder and `.tex, .md` at
  `github.com/edwardlaiyc/school/tree/main/y1s2/sc1008-c%2B%2B` (the `+` signs
  must stay percent-encoded).
