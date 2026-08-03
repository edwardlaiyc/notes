# school

Personal university notes — NTU, CS.

Notes are written in LaTeX and published as a static site: one readable page per
topic, with native MathML (no JavaScript maths, no CDN), a light/dark theme, and a
reading-progress bar.

## Semesters

| Semester | Courses | Site |
|---|---|---|
| Y1S2 | SC1006 Computer Organisation & Architecture · SC1008 C & C++ Programming · SC1302 Ethics · SC1305 Linear Algebra · SC1315 Artificial Intelligence · SC2500 Probability & Statistics | [`y1s2/index.html`](y1s2/index.html) |

## Layout

```
web-pipeline/   shared LaTeX → HTML/Markdown build (pandoc + MiKTeX + Pillow)
y1s2/           one folder per course, plus the semester landing page
```

Each course folder holds its `.tex` source, its figures, and the generated
`.html` / `.md` pages. Three small files configure the build: `course.yml`
(branding and navigation), `site.psd1` (ordered topic list and preprocessing),
and `index.md` (the course overview page).

## Building

Requires PowerShell, [pandoc](https://pandoc.org), MiKTeX, and Python with Pillow.

```powershell
# one topic
cd y1s2\sc1006-comorgarchi
..\..\web-pipeline\build.ps1 -Source .\chapters-part1\1-introduction.tex

# a whole course
..\..\web-pipeline\publish.ps1

# a semester landing page
cd y1s2
..\web-pipeline\publish-hub.ps1
```

See [`web-pipeline/README.md`](web-pipeline/README.md) for the manifest schema and
the LaTeX→pandoc gotchas.

## Compiled PDFs

PDFs are not tracked here — they are regenerated on every build and would bloat
history. They live in Google Drive, linked from each course's overview page.
