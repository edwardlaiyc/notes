#!/usr/bin/env python3
r"""Render LaTeX TikZ / pgfplots pictures to SVG and splice them into a chapter.

Pandoc has no TikZ support, so `tikzpicture` (and `pgfplots` axes, which live
inside a tikzpicture) come out as garbage or vanish. This pre-processes a
chapter: each `\begin{tikzpicture}...\end{tikzpicture}` block is compiled as a
standalone document to a crisp, scalable SVG and replaced, in a generated copy
of the .tex, with an `\includegraphics` reference. Run pandoc on the generated
file instead of the original. Mirrors render-bytefields.py.

A `\tdplotsetmaincoords{..}{..}` line immediately preceding a picture (tikz-3dplot
sets the 3-D view that way) is captured together with the picture, otherwise the
standalone compile of a `tdplot_main_coords` picture fails.

The standalone preamble is derived from the course master preamble (passed via
--preamble) so fonts, colours, and custom macros in node labels match the notes
exactly. Packages that are meaningless or harmful in a standalone crop
(geometry, hyperref, subfiles, caption/subcaption, float) are dropped.

Usage:
    python render-tikz.py <in.tex> <out.tex> <svg-out-dir> <ref-prefix> --preamble <master.tex>

    <in.tex>       source chapter (or an already-generated .gen.tex to chain on)
    <out.tex>      where the spliced copy is written
    <svg-out-dir>  where the .svg files are written (e.g. ../images/generated)
    <ref-prefix>   path used inside \includegraphics, resolvable by pandoc's
                   --resource-path (e.g. images/generated)

Requires pdflatex + pdftocairo.
"""
import argparse
import re
import subprocess
import tempfile
from pathlib import Path

# A tikzpicture, optionally preceded by its tikz-3dplot view setup. tikzpicture
# does not nest, so a non-greedy body is safe.
TIKZ_RE = re.compile(
    r"(?:\\tdplotsetmaincoords\{[^}]*\}\{[^}]*\}\s*)?"
    r"\\begin\{tikzpicture\}.*?\\end\{tikzpicture\}",
    re.S,
)

# Preamble packages/commands that must not survive into a standalone crop.
DROP_PACKAGE_RE = re.compile(
    r"\\usepackage(\[[^\]]*\])?\{"
    r"(geometry|hyperref|subfiles|subcaption|caption|float)\}"
)

# Config commands provided by the dropped packages: once the package is gone the
# command is undefined and the standalone compile aborts (e.g. a master that sets
# page layout with \geometry{...} or link colours with \hypersetup{...}). Strip
# the whole invocation, brace group included, even when it spans several lines.
DROP_COMMAND_RE = re.compile(
    r"\\(geometry|hypersetup|captionsetup)(\[[^\]]*\])?\s*\{[^{}]*\}",
    re.S,
)


def build_preamble(master: Path) -> str:
    r"""Standalone preamble mirroring the master's, minus doc-layout packages."""
    text = master.read_text(encoding="utf-8")
    body = text.split(r"\begin{document}", 1)[0]
    lines = []
    for line in body.splitlines():
        stripped = line.strip()
        if stripped.startswith(r"\documentclass"):
            continue  # replaced by the standalone class below
        if DROP_PACKAGE_RE.search(stripped):
            continue
        lines.append(line)
    preamble = "\n".join(lines)
    preamble = DROP_COMMAND_RE.sub("", preamble)
    # Returned as (prefix, suffix); the picture block is concatenated between
    # them. Not %-formatted: the master preamble contains literal % comments.
    return (
        "\\documentclass[border=2pt]{standalone}\n" + preamble
        + "\n\\begin{document}\n",
        "\n\\end{document}\n",
    )


def compile_one(block: str, name: str, svg_dir: Path, preamble_tpl):
    prefix, suffix = preamble_tpl
    with tempfile.TemporaryDirectory() as td:
        td = Path(td)
        tex = td / f"{name}.tex"
        tex.write_text(prefix + block + suffix, encoding="utf-8")
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
    ap = argparse.ArgumentParser()
    ap.add_argument("infile")
    ap.add_argument("outfile")
    ap.add_argument("svg_dir")
    ap.add_argument("prefix")
    ap.add_argument("--preamble", required=True)
    args = ap.parse_args()

    tex = Path(args.infile)
    out = Path(args.outfile)
    svg_dir = Path(args.svg_dir)
    prefix = args.prefix.rstrip("/")
    svg_dir.mkdir(parents=True, exist_ok=True)

    preamble_tpl = build_preamble(Path(args.preamble))
    text = tex.read_text(encoding="utf-8")
    base = tex.stem.replace(".gen", "")
    blocks = list(TIKZ_RE.finditer(text))
    print(f"{len(blocks)} tikz pictures in {tex.name}")

    parts, last = [], 0
    for i, m in enumerate(blocks, 1):
        name = compile_one(m.group(0), f"{base}-tikz{i}", svg_dir, preamble_tpl)
        parts.append(text[last:m.start()])
        if name:
            parts.append(f"\\includegraphics{{{prefix}/{name}}}")
        else:
            parts.append(m.group(0))
        last = m.end()
    parts.append(text[last:])

    out.write_text("".join(parts), encoding="utf-8")
    print(f"wrote {out}")


if __name__ == "__main__":
    main()
