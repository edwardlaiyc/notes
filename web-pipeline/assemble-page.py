#!/usr/bin/env python3
"""Assemble several `subfiles` chapters into ONE standalone .tex for the web build.

Why this exists: the web version is one page per part, but the sources are one
file per chapter (each a `subfiles` document with its own \\documentclass /
\\begin{document} / \\end{document}). Pandoc stops dead at the first
\\end{document}, so the chapters can't simply be \\input. This strips each
chapter down to its body and concatenates them under a single shared preamble.

Usage:
  python assemble-page.py OUT.tex --preamble MASTER.tex FILE1.tex FILE2.tex ...
        [--drop-subsection "Title" ...]

--drop-subsection removes a \\subsection{Title} and everything up to the next
section/subsection. Used to route the general-reference material out of the
Part 1 cheatsheet so it lands on the reference page instead (no duplication).
"""
import argparse
import re
import sys
from pathlib import Path

BEGIN_DOC = re.compile(r'\\begin\{document\}')
END_DOC = re.compile(r'\\end\{document\}')
# a heading that terminates a dropped subsection
NEXT_HEAD = re.compile(r'^\s*\\(section|subsection)\*?\{', re.M)


def body_of(text: str) -> str:
    """Return just the document body (between begin/end document, if present)."""
    m = BEGIN_DOC.search(text)
    if m:
        text = text[m.end():]
    m = END_DOC.search(text)
    if m:
        text = text[:m.start()]
    return text.strip('\n')


def preamble_of(text: str) -> str:
    """Everything before \\begin{document}."""
    m = BEGIN_DOC.search(text)
    return text[:m.start()] if m else text


ENV_BEGIN = re.compile(r'\\begin\{([a-zA-Z*]+)\}')
ENV_END = re.compile(r'\\end\{([a-zA-Z*]+)\}')


def unmatched_begins(chunk: str):
    """Environments opened but not closed inside `chunk`, in order.

    A dropped subsection can span an environment opener that belongs to the NEXT
    subsection (e.g. \\begin{landscape} sits just above \\subsection{Stacks}).
    Removing it blindly orphans the matching \\end and pandoc aborts the file,
    so any such opener has to be put back at the cut point.
    """
    stack = []
    for m in re.finditer(r'\\(begin|end)\{([a-zA-Z*]+)\}', chunk):
        kind, env = m.group(1), m.group(2)
        if kind == 'begin':
            stack.append(env)
        elif stack and stack[-1] == env:
            stack.pop()
    return stack


def drop_subsection(text: str, title: str) -> str:
    """Remove \\subsection{title} through to the next section/subsection."""
    pat = re.compile(r'^\s*\\subsection\*?\{' + re.escape(title) + r'\}',
                     re.M)
    m = pat.search(text)
    if not m:
        print(f"  ! subsection not found, skipping: {title}", file=sys.stderr)
        return text
    nxt = NEXT_HEAD.search(text, m.end())
    end = nxt.start() if nxt else len(text)
    removed = text[m.start():end]
    restore = ''.join(f'\\begin{{{e}}}\n' for e in unmatched_begins(removed))
    if restore:
        print(f"    (restored orphaned opener(s) after dropping {title}: "
              f"{', '.join(unmatched_begins(removed))})")
    return text[:m.start()] + '\n' + restore + text[end:]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('out')
    ap.add_argument('sources', nargs='+')
    ap.add_argument('--preamble', required=True,
                    help='file whose preamble is reused for the combined doc')
    ap.add_argument('--drop-subsection', action='append', default=[])
    ap.add_argument('--title', default=None)
    args = ap.parse_args()

    pre = preamble_of(Path(args.preamble).read_text(encoding='utf-8'))
    if args.title:
        pre = re.sub(r'\\title\{[^}]*\}', r'\\title{' + args.title + '}', pre)

    parts = []
    for src in args.sources:
        p = Path(src)
        if not p.exists():
            sys.exit(f"missing source: {src}")
        body = body_of(p.read_text(encoding='utf-8'))
        for title in args.drop_subsection:
            body = drop_subsection(body, title)
        parts.append(f"% ==== from {p.name} ====\n{body}")
        print(f"  + {p.name} ({len(body.splitlines())} lines)")

    combined = pre + '\\begin{document}\n\n' + '\n\n'.join(parts) + '\n\n\\end{document}\n'
    Path(args.out).write_text(combined, encoding='utf-8')
    print(f"wrote {args.out} ({len(combined.splitlines())} lines)")


if __name__ == '__main__':
    main()
