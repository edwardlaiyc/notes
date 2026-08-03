#!/usr/bin/env python3
r"""Split one monolithic LaTeX article into per-topic standalone .tex files.

A subject whose notes live in a single ``article`` (one file, many top-level
``\section`` blocks) reads better on the web as chapter-sized pages. This slices
the document into one standalone .tex per top-level section, each reusing the
document's own preamble, so every slice then builds through the ordinary
``build.ps1`` topic path (nav, TOC, prev/next, media extraction).

Two modes:

* Auto (default) — one module per top-level section, in document order. The slug
  is derived from the heading text and the title is the heading text itself. This
  needs no configuration and suits a plain ``\section`` article (e.g. ethics).

* Spec (``--spec spec.json``) — the caller supplies an explicit, ordered module
  list (slug + clean title, matched positionally to the sections) and optional
  routing of pre-section summary tables into named modules. This reproduces a
  hand-tuned split such as SC1006 Part 2.

``--sections {any,plain,star}`` selects which headings count as top-level:
``\section{...}``, ``\section*{...}``, or either (default ``any``). Each slice
keeps the star-ness of its own heading.

Usage:
  python split-sections.py SRC.tex OUTPUT_DIR [--sections any|plain|star]
                           [--spec spec.json]

spec.json shape:
  {
    "modules": [{"slug": "p2-1-arithmetic", "title": "Computer Arithmetic"}, ...],
    "table_routing": [{"caption": "Volatile Memory Summary", "slug": "p2-5-memory"}, ...]
  }
"""
import argparse
import json
import re
import sys
from pathlib import Path

BEGIN_DOC = re.compile(r'\\begin\{document\}')
END_DOC = re.compile(r'\\end\{document\}')
TABLE = re.compile(r'\\begin\{table\}.*?\\end\{table\}', re.DOTALL)
CAPTION = re.compile(r'\\caption\{([^}]*)\}')

SECTION_PATTERNS = {
    'any':   re.compile(r'\\section(\*)?\{'),
    'plain': re.compile(r'\\section\{'),
    'star':  re.compile(r'\\section\*\{'),
}
# Capture the star flag and the heading text for the section that opens a chunk.
HEAD_RE = re.compile(r'\\section(\*)?\{([^}]*)\}')


def preamble_of(text: str) -> str:
    m = BEGIN_DOC.search(text)
    return text[:m.start()] if m else ''


def body_of(text: str) -> str:
    m = BEGIN_DOC.search(text)
    if m:
        text = text[m.end():]
    m = END_DOC.search(text)
    if m:
        text = text[:m.start()]
    return text


def clean_body(body: str) -> str:
    """Strip document-scaffolding that has no place on a per-topic page."""
    body = body.replace(r'\tableofcontents', '')
    body = body.replace(r'\maketitle', '')
    body = re.sub(r'\\newpage', '', body)
    # A whole-document \begin{multicols}{N} wrapper would orphan a \begin or \end
    # in each slice; unwrapping to single column is what the web wants anyway.
    body = re.sub(r'\\begin\{multicols\}\{\d+\}', '', body)
    body = body.replace(r'\end{multicols}', '')
    # LaTeX-only ToC bookkeeping; pandoc builds its own contents from headings.
    body = re.sub(r'\\phantomsection', '', body)
    body = re.sub(r'\\addcontentsline\{[^}]*\}\{[^}]*\}\{[^}]*\}', '', body)
    return body


def slugify(title: str) -> str:
    slug = re.sub(r'[^a-z0-9]+', '-', title.lower()).strip('-')
    return slug or 'section'


def route_tables(pre_section: str, table_routing):
    """Return {slug: [table_env, ...]} for summary tables above section 1."""
    routed = {}
    for table in TABLE.findall(pre_section):
        caption_match = CAPTION.search(table)
        caption = caption_match.group(1) if caption_match else ''
        slug = next((r['slug'] for r in table_routing if r['caption'] in caption), None)
        if slug is None:
            print(f"  ! unrouted summary table (caption: {caption!r})",
                  file=sys.stderr)
            continue
        routed.setdefault(slug, []).append(table.strip())
        print(f"  routed table {caption!r} -> {slug}")
    return routed


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('src')
    ap.add_argument('out_dir')
    ap.add_argument('--sections', choices=SECTION_PATTERNS.keys(), default='any')
    ap.add_argument('--spec', default=None,
                    help='JSON with explicit modules and optional table_routing')
    args = ap.parse_args()

    src = Path(args.src)
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    spec = {}
    if args.spec:
        # utf-8-sig tolerates the BOM PowerShell's Set-Content -Encoding utf8 writes.
        spec = json.loads(Path(args.spec).read_text(encoding='utf-8-sig'))
    modules = spec.get('modules')
    table_routing = spec.get('table_routing', [])

    text = src.read_text(encoding='utf-8')
    preamble = preamble_of(text)
    body = clean_body(body_of(text))

    section_re = SECTION_PATTERNS[args.sections]
    starts = [m.start() for m in section_re.finditer(body)]
    if not starts:
        sys.exit(f"no top-level sections ({args.sections}) found in {src.name}")

    # Auto mode: one module per section, derived from its own heading text.
    if modules is None:
        modules = []
        for pos in starts:
            head = HEAD_RE.match(body, pos)
            title = head.group(2).strip() if head else 'Section'
            modules.append({'slug': slugify(title), 'title': title})
    elif len(starts) != len(modules):
        sys.exit(f"expected {len(modules)} section blocks, found {len(starts)}")

    pre_section = body[:starts[0]]
    routed = route_tables(pre_section, table_routing) if table_routing else {}

    bounds = starts + [len(body)]
    for i, module in enumerate(modules):
        slug, title = module['slug'], module['title']
        chunk = body[bounds[i]:bounds[i + 1]].strip()
        # Rewrite just this chunk's opening heading to the clean module title,
        # preserving its original star-ness.
        star = '*' if HEAD_RE.match(chunk) and HEAD_RE.match(chunk).group(1) else ''
        chunk = re.sub(r'^\\section\*?\{[^}]*\}',
                       r'\\section' + star + '{' + title + '}',
                       chunk, count=1)

        # Slot routed summary tables directly under the topic heading (not above
        # it) so the page reads heading-first like an ordinary chapter.
        lead_tables = '\n\n'.join(routed.get(slug, []))
        if lead_tables:
            nl = chunk.find('\n')
            head, rest = (chunk, '') if nl == -1 else (chunk[:nl], chunk[nl:])
            chunk = head + '\n\n' + lead_tables + '\n' + rest

        parts = [preamble, r'\begin{document}', '', chunk, '', r'\end{document}', '']
        (out_dir / f'{slug}.tex').write_text('\n'.join(parts), encoding='utf-8')
        extra = f" (+{len(routed.get(slug, []))} summary table(s))" if slug in routed else ''
        print(f"  wrote {slug}.tex  [{title}]{extra}")


if __name__ == '__main__':
    main()
