---
name: latex-notes
description: Build a plain LaTeX article (title, numbered sections, optional TOC) from Markdown notes, ready to compile in your editor. Project-specific to latex-notes.
disable-model-invocation: true
---

# latex-notes

Turn Markdown notes into a clean single-column LaTeX article. Run the `/md-to-latex` skill to convert each note file into a body **fragment**, then assemble those fragments into this skill's template. Stop at the `.tex` — compile it in your editor (LaTeX Workshop builds on save).

## Template

[`TEMPLATE.tex`](TEMPLATE.tex) here: 11pt `article`, Computer Modern, loads `amsmath`/`graphicx`/`hyperref`/`enumitem`, `\maketitle`, and defines the `\mdfigure`/`\mdfigureplain` image macros the engine's fragments call. Placeholders: `<<TITLE>>`, `<<TOC>>`, `<<INPUTS>>`.

## Delta over the engine

| Markdown | This skill | vs. engine default |
|---|---|---|
| first `#` | document `\title` (dropped from the body) | engine maps every `#` to `\section` |

Everything else falls through to `/md-to-latex` unchanged.

## Assemble

Copy `TEMPLATE.tex` to `<basename>.tex` and fill:

- `<<TITLE>>` — the first `#` heading (single file), or a title you give (multi-file).
- `<<TOC>>` — `\tableofcontents` when combining several files; empty for one.
- `<<INPUTS>>` — one `\input{fragment}` per fragment, in reading order.

**Done when** the master `.tex` and its fragments are on disk with every placeholder filled and every `\input` resolved. Open it in your editor to compile the PDF.
