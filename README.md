# notes

University lecture notes — NTU, CS.

Read them at **[edwardlaiyc.github.io/notes](https://edwardlaiyc.github.io/notes/)**.
This branch holds the source they are written from.

## Contents

### Year 1, Semester 1

| Course | Folder |
|---|---|
| SC1005 Digital Logic | [`y1s1/sc1005-digitallogic/`](y1s1/sc1005-digitallogic/) |
| SC1303 Programming with Data Structures & Algorithms | [`y1s1/sc1303-dsa/`](y1s1/sc1303-dsa/) |
| MH1805 Calculus | [`y1s1/mh1805-calculus/`](y1s1/mh1805-calculus/) |
| MH1812 Discrete Mathematics | [`y1s1/mh1812-discretemaths/`](y1s1/mh1812-discretemaths/) |

### Year 1, Semester 2

| Course | Folder |
|---|---|
| SC1006 Computer Organisation & Architecture | [`y1s2/sc1006-comorgarchi/`](y1s2/sc1006-comorgarchi/) |
| SC1008 C & C++ Programming | [`y1s2/sc1008-c++/`](y1s2/sc1008-c++/) |
| SC1302 Ethics | [`y1s2/sc1302-ethics/`](y1s2/sc1302-ethics/) |
| SC1305 Linear Algebra | [`y1s2/sc1305-linearalgebra/`](y1s2/sc1305-linearalgebra/) |
| SC1315 Artificial Intelligence | [`y1s2/sc1315-ai/`](y1s2/sc1315-ai/) |
| SC2500 Probability & Statistics | [`y1s2/sc2500-probability/`](y1s2/sc2500-probability/) |

## Where things live

| | |
|---|---|
| **Source** | this branch — `.tex` for Y1S2, `.md` for Y1S1 |
| **Site** | the [`gh-pages`](../../tree/gh-pages) branch, served at [edwardlaiyc.github.io/notes](https://edwardlaiyc.github.io/notes/) |
| **PDFs** | [Google Drive](https://drive.google.com/drive/folders/1jBakz2SQzfH1xTFvTZ7bBeTaSbovUeek) |

The two semesters are written differently. **Y1S2 is written in LaTeX** — the
`.tex` is the source. **Y1S1 is written in Markdown** — the `.md` *is* the
source. Neither semester's generated HTML is on this branch; it is built from
what is here and lives on `gh-pages`.

## Figures

**Y1S1 is complete.** Its figures sit beside the notes in `chapters/images/`
as WebP — encoded losslessly from the originals, at about a quarter the size —
so a chapter renders in full on GitHub, in any Markdown viewer, and offline
after a clone.

**Y1S2's figures are not here.** `pdflatex` needs the raster originals, which
are 27 MB and would dominate the repository, so `\includegraphics` refers to
files this branch does not carry and **the `.tex` will not compile straight
after a clone.** The prose, the maths and the structure are all present; only
the figures are absent. For a complete rendered copy, use the PDFs in Google
Drive. To rebuild locally, take the web copies from `gh-pages`:

```sh
git checkout gh-pages -- '*/media/*'
```
