#!/usr/bin/env python3
r"""Render LaTeX algorithm2e pseudocode to SVG and splice it into a chapter.

Pandoc has no algorithm2e support, so `\begin{algorithm}...\end{algorithm}`
blocks (the `\Fn`/`\While`/`\For`/`\If`/`\tcp` pseudocode of algorithm2e) come
out dropped or as raw `&`-noise. This pre-processes a source file: each algorithm
block is compiled as a standalone document to a crisp, scalable SVG and replaced,
in a generated copy of the .tex, with an `\includegraphics` reference. Run pandoc
(or the section splitter) on the generated file instead of the original. Mirrors
render-tikz.py / render-bytefields.py.

Each algorithm block carries its own `\SetKwFunction` / `\SetKwProg` definitions,
so a standalone compile of the block alone is self-contained; the preamble only
has to load algorithm2e (inherited from the master).

The standalone preamble is derived from the course master preamble (passed via
--preamble) so fonts, colours, and custom macros match the notes exactly.
Packages meaningless or harmful in a standalone crop (geometry, hyperref,
subfiles, caption/subcaption, float) are dropped, along with the config commands
they provide (\geometry, \hypersetup, \captionsetup).

Usage:
    python render-algorithm.py <in.tex> <out.tex> <svg-out-dir> <ref-prefix> --preamble <master.tex>

Requires pdflatex + pdftocairo.
"""
import argparse
import re
import subprocess
import tempfile
from pathlib import Path

# An algorithm2e block. The environment does not nest, so a non-greedy body is
# safe. Any `[H]`/placement option sits just after \begin{algorithm}.
ALGO_RE = re.compile(r"\\begin\{algorithm\}.*?\\end\{algorithm\}", re.S)

# Preamble packages that must not survive into a standalone crop.
DROP_PACKAGE_RE = re.compile(
    r"\\usepackage(\[[^\]]*\])?\{"
    r"(geometry|hyperref|subfiles|subcaption|caption|float)\}"
)

# Config commands provided by the dropped packages: once the package is gone the
# command is undefined and the standalone compile aborts. Strip the whole
# invocation, brace group included, even across several lines.
DROP_COMMAND_RE = re.compile(
    r"\\(geometry|hypersetup|captionsetup)(\[[^\]]*\])?\s*\{[^{}]*\}",
    re.S,
)


def build_preamble(master: Path):
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
    blocks = list(ALGO_RE.finditer(text))
    print(f"{len(blocks)} algorithm blocks in {tex.name}")

    parts, last = [], 0
    for i, m in enumerate(blocks, 1):
        name = compile_one(m.group(0), f"{base}-alg{i}", svg_dir, preamble_tpl)
        parts.append(text[last:m.start()])
        if name:
            # Center the crop the way the algorithm float would have been, and
            # give it a display width so the pseudocode reads at a comfortable
            # size: the standalone crop's intrinsic width is small (~350px) and
            # its text tiny at natural size. algorithm2e's line width is fixed,
            # so every crop shares one intrinsic width and this scales them all
            # by the same factor -> consistent text size across algorithms.
            # pandoc turns width=..\textwidth into a responsive percentage.
            parts.append(
                "\\begin{center}\\includegraphics[width=0.8\\textwidth]{"
                + f"{prefix}/{name}" + "}\\end{center}"
            )
        else:
            parts.append(m.group(0))
        last = m.end()
    parts.append(text[last:])

    out.write_text("".join(parts), encoding="utf-8")
    print(f"wrote {out}")


if __name__ == "__main__":
    main()
