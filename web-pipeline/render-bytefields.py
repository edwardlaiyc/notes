#!/usr/bin/env python3
r"""Render LaTeX bytefield diagrams to SVG and splice them into a chapter.

Pandoc has no \bytefield support, so bit-field diagrams come out garbled.
This pre-processes a chapter: each \begin{bytefield}...\end{bytefield} is
compiled as a standalone document to a crisp, scalable SVG, and replaced in
a generated copy of the .tex with an \includegraphics reference. Run pandoc
on the .gen.tex instead of the original.

Usage:
    python render-bytefields.py <chapter.tex> <svg-out-dir> <ref-prefix>

    <svg-out-dir>  where the .svg files are written (e.g. ../images/generated)
    <ref-prefix>   path used inside \includegraphics, resolvable by pandoc's
                   --resource-path (e.g. images/generated)

Writes <chapter>.gen.tex and prints its path. Requires pdflatex + pdftocairo.
"""
import re
import subprocess
import sys
import tempfile
from pathlib import Path

# Standalone preamble: bytefield + the master's colours/commands the fields use.
# bytefield's tiny bit-header glyphs slightly overhang their TeX bounding box.
# A 5 pt crop margin keeps their tops intact after PDF-to-SVG conversion.
PREAMBLE = r"""\documentclass[border=5pt]{standalone}
\usepackage{amsmath}
\usepackage{array}
\usepackage{xcolor}
\usepackage{colortbl}
\usepackage{bytefield}
\definecolor{headercyan}{RGB}{204, 255, 255}
\definecolor{headergray}{gray}{0.85}
\newcommand{\gh}{\cellcolor{headergray}}
\begin{document}
%s
\end{document}
"""

BF_RE = re.compile(r"\\begin\{bytefield\}.*?\\end\{bytefield\}", re.S)


def compile_one(block: str, name: str, svg_dir: Path):
    with tempfile.TemporaryDirectory() as td:
        td = Path(td)
        tex = td / f"{name}.tex"
        tex.write_text(PREAMBLE % block, encoding="utf-8")
        subprocess.run(
            ["pdflatex", "-interaction=nonstopmode", "-halt-on-error",
             f"-output-directory={td}", str(tex)],
            capture_output=True, text=True,
        )
        pdf = td / f"{name}.pdf"
        if not pdf.exists():
            print(f"  ! compile FAILED: {name} (left original in place)")
            return None
        svg = svg_dir / f"{name}.svg"
        subprocess.run(["pdftocairo", "-svg", str(pdf), str(svg)], check=True)
        print(f"  {name}.svg")
        return svg.name


def main():
    if len(sys.argv) != 4:
        sys.exit(__doc__)
    tex = Path(sys.argv[1])
    svg_dir = Path(sys.argv[2])
    prefix = sys.argv[3].rstrip("/")
    svg_dir.mkdir(parents=True, exist_ok=True)

    text = tex.read_text(encoding="utf-8")
    base = tex.stem
    blocks = list(BF_RE.finditer(text))
    print(f"{len(blocks)} bytefield diagrams in {tex.name}")

    out, last = [], 0
    for i, m in enumerate(blocks, 1):
        name = compile_one(m.group(0), f"{base}-bf{i}", svg_dir)
        out.append(text[last:m.start()])
        if name:
            out.append(f"\\includegraphics[width=\\textwidth]{{{prefix}/{name}}}")
        else:
            out.append(m.group(0))
        last = m.end()
    out.append(text[last:])

    gen = tex.with_suffix(".gen.tex")
    gen.write_text("".join(out), encoding="utf-8")
    print(f"wrote {gen}")


if __name__ == "__main__":
    main()
