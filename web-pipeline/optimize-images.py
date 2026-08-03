#!/usr/bin/env python3
"""Convert extracted raster images to resized WebP, stamp intrinsic
width/height on every <img>, and rewrite references.

Usage:
    python optimize-images.py <media-dir> <output-file> [<output-file> ...]

- Converts every .png/.jpg/.jpeg under <media-dir> to .webp (quality 85),
  downscaling anything wider than MAX_WIDTH, then deletes the original.
- Records final pixel dimensions of every raster image (webp).
- In each output file: rewrites raster refs to .webp AND adds
  width="W" height="H" to <img> tags that lack a width attribute, so the
  browser reserves space and lazy-loaded images don't cause layout shift.
- SVGs are left untouched (already scalable).
"""
import re
import sys
from pathlib import Path
from PIL import Image

MAX_WIDTH = 1400   # plenty for a ~700px column at 2x retina
QUALITY = 85
EXTS = (".png", ".jpg", ".jpeg")

IMG_RE = re.compile(r"<img\b[^>]*>", re.I)
SRC_RE = re.compile(r'src="([^"]+)"', re.I)
HAS_W = re.compile(r"\swidth=", re.I)   # an actual width ATTRIBUTE (not style:width)


def scan_and_convert(media_dir: Path):
    """Convert rasters to webp; return (bytes_saved, {relpath: (w, h)})."""
    saved = 0
    dims = {}
    for p in sorted(media_dir.rglob("*")):
        suf = p.suffix.lower()
        if suf in EXTS:
            before = p.stat().st_size
            im = Image.open(p)
            if im.mode in ("P", "LA"):
                im = im.convert("RGBA")
            if im.width > MAX_WIDTH:
                h = round(im.height * MAX_WIDTH / im.width)
                im = im.resize((MAX_WIDTH, h), Image.LANCZOS)
            webp = p.with_suffix(".webp")
            im.save(webp, "WEBP", quality=QUALITY, method=6)
            after = webp.stat().st_size
            p.unlink()
            saved += before - after
            dims[webp.relative_to(media_dir).as_posix()] = im.size
            print(f"  {p.name:32s} {before//1024:5d}K -> {after//1024:4d}K")
        elif suf == ".webp":
            with Image.open(p) as im:
                dims[p.relative_to(media_dir).as_posix()] = im.size
    return saved, dims


def rewrite(f: Path, media_name: str, dims: dict):
    text = f.read_text(encoding="utf-8")
    for ext in EXTS:                       # point refs at the webp files
        text = text.replace(ext + '"', '.webp"').replace(ext + ")", ".webp)")

    def add_dims(m):
        tag = m.group(0)
        if HAS_W.search(tag):
            return tag
        s = SRC_RE.search(tag)
        if not s:
            return tag
        key = s.group(1).split(media_name + "/", 1)[-1]
        wh = dims.get(key)
        if not wh:
            return tag
        return tag.replace("<img", f'<img width="{wh[0]}" height="{wh[1]}"', 1)

    text = IMG_RE.sub(add_dims, text)
    f.write_text(text, encoding="utf-8")
    print(f"  rewrote refs + dims in {f.name}")


if __name__ == "__main__":
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    media = Path(sys.argv[1])
    total, dims = scan_and_convert(media)
    for out in sys.argv[2:]:
        rewrite(Path(out), media.name, dims)
    print(f"Saved {total//1024}K total.")
