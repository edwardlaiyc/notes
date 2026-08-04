# notes

University lecture notes — NTU, CS.

## Where the notes are

Every course lives in one folder. Pick a course, then open its chapter folder.

| Course | Folder | Topics |
|---|---|---|
| SC1006 Computer Organisation & Architecture | [`y1s2/sc1006-comorgarchi/`](y1s2/sc1006-comorgarchi/) | 17 |
| SC1008 C & C++ Programming | [`y1s2/sc1008-c++/`](y1s2/sc1008-c++/) | 1 |
| SC1302 Ethics | [`y1s2/sc1302-ethics/`](y1s2/sc1302-ethics/) | 6 |
| SC1305 Linear Algebra | [`y1s2/sc1305-linearalgebra/`](y1s2/sc1305-linearalgebra/) | 9 |
| SC1315 Artificial Intelligence | [`y1s2/sc1315-ai/`](y1s2/sc1315-ai/) | 16 |
| SC2500 Probability & Statistics | [`y1s2/sc2500-probability/`](y1s2/sc2500-probability/) | 12 |

Each topic comes in three forms, same filename, different extension:

| | |
|---|---|
| `.md` | reads directly on GitHub — start here |
| `.html` | the formatted page, best on the [site](https://edwardlaiyc.github.io/notes/) |
| `.tex` | the LaTeX source |

## Layout

```
y1s2/
├── index.html              all six courses
└── sc1006-comorgarchi/     a course
    ├── index.md            course overview
    ├── chapters-part1/     the notes: 1-introduction.md / .html / .tex
    ├── chapters-part2/
    └── images/             figures
```

Chapters are in `chapters/` for most courses; SC1006 splits into
`chapters-part1/` and `chapters-part2/`. Files are numbered in reading order.

SC1008 is the exception — its notes are a Colab notebook, linked from
[its overview page](y1s2/sc1008-c++/index.md); only the cheat sheet
(`final-summary`) is in the folder itself.

## PDFs

Not in this repo. Each course's overview page links its PDF on Google Drive.
