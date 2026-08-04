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
y1s2/                      one folder per course, plus the semester landing page
└── sc1006-comorgarchi/    a course
    ├── *.tex              LaTeX source
    ├── chapters-part1/    chapters, and the .html / .md built from them
    ├── images/            figures
    └── index.md           course overview
```

Each course folder holds everything for that course: the `.tex` source, the
figures, and the generated `.html` / `.md` pages. Read a topic three ways —
the `.tex` to see how it was written, the `.md` for plain text on GitHub, or
the [published site](https://edwardlaiyc.github.io/notes/) for the nice version.

## Building

The site is pre-built: the `.html` pages are committed and GitHub Pages serves
them as-is, so nothing here needs a build step to read or to publish.

The LaTeX → HTML/Markdown converter that produces them (pandoc + MiKTeX +
Pillow) is kept outside this repo, which holds the notes rather than the
machinery. The `course.yml` and `site.psd1` in each course folder are its
input: branding and navigation, and the ordered topic list.

## Compiled PDFs

PDFs are not tracked here — they are regenerated on every build and would bloat
history. They live in Google Drive, linked from each course's overview page.
