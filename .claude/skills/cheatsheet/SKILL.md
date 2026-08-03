---
name: cheatsheet
description: Convert Markdown notes into a dense landscape four-column LaTeX cheatsheet (blue section bars, boxed blocks), ready to compile in your editor. Project-specific to latex-notes.
disable-model-invocation: true
---

# cheatsheet

Build a dense **landscape four-column** reference card from Markdown. Run the `/md-to-latex` skill to convert each note file into a body **fragment**, then assemble those fragments into this skill's template. Stop at the `.tex` — compile it in your editor. Everything `/md-to-latex` already handles (math, code, bold/italic, lists, escaping, images) is unchanged; only this template and the deltas below differ.

## Profile

- **Template:** [`TEMPLATE.tex`](TEMPLATE.tex) in this folder, *not* the engine's default. It is a landscape A4, four-column `multicol` body (8pt `extarticle`, tiny margins), with filled blue section bars (white bold text spanning the column), bold run-in subsections, and boxed blocks — no title, no TOC, no page numbers. Its only placeholder is `<<INPUTS>>` — there is no `<<TITLE>>` or `<<TOC>>` to fill.
- **Combining:** every fragment is `\input` inside the one `multicols{4}` block, so multiple note files flow into a single balanced card. There is no combined-vs-single title logic here — a cheatsheet never has a title page.

## Deltas — override the engine's default mapping

Headings use the engine's default mapping (`#`→`\section`, `##`→`\subsection`); the template *styles* them — `\section` as a filled blue bar, `\subsection` as a bold run-in — so those aren't deltas. The real overrides:

| Markdown | Cheatsheet LaTeX | vs. engine default |
|---|---|---|
| `###`+ heading | `\textbf{…}` run-in, then the text | engine keeps `###`→`\subsubsection`; a cheatsheet stays shallow |
| `> text` (blockquote) | `\begin{mdbox}…\end{mdbox}` — boxed theorem block | engine has no blockquote rule |
| `---` (horizontal rule) | `\columnbreak` | engine has no rule; here it balances the four columns by hand |

Apply these in place of the matching engine rule; every other construct falls through to `/md-to-latex` unchanged.
