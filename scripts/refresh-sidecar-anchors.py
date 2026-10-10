#!/usr/bin/env python3
"""Refresh #L… line anchors in FAA Fitch sidecars from public Lean declaration lines.

Run from the repo root (where `FAA.lean` lives).

Usage:
  python3 scripts/refresh-sidecar-anchors.py              # all FAA/**/*.lean pairs
  python3 scripts/refresh-sidecar-anchors.py FAA/Foo.lean # one file
  python3 scripts/refresh-sidecar-anchors.py --check      # exit 1 if stale

Matches sidecar links [`declName`](File.lean#Lnn) to the line of the same public
abbrev/def/lemma/theorem/instance in the paired .lean file. Does not edit Fitch
proofs or add missing sections.

Also maintains the reverse pointer: every paired .lean file's first line is
`-- Sidecar: <repo-relative .md path>` (see docs/lean-sidecar-policy.md § Pairing).
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LIB = ROOT / "FAA"

DECL_LINE = re.compile(
    r"^\s*"
    r"(?:(?:private|protected|noncomputable|unsafe)\s+)*"
    r"(?:@\[[^\]]+\]\s+)*"
    r"(abbrev|def|lemma|theorem|instance|structure)\s+"
    r"([A-Za-z0-9_'.]+)"
)

LINK = re.compile(
    r"\[`([^`]+)`\]\(([^)/`]+\.lean)#L(\d+)\)"
)

SIDECAR_LINE = re.compile(r"^--\s*Sidecar:\s*(\S+)\s*$")


def public_decls(lean_path: Path) -> dict[str, int]:
    """Map declaration name -> 1-based line number (public decls only)."""
    decls: dict[str, int] = {}
    for i, line in enumerate(lean_path.read_text(encoding="utf-8").splitlines(), start=1):
        if re.search(r"\bprivate\b", line.split("--", 1)[0]):
            continue
        m = DECL_LINE.match(line)
        if not m:
            continue
        kind, name = m.group(1), m.group(2)
        if kind == "instance" and name in {"def", "theorem"}:
            continue
        decls[name] = i
    return decls


def sidecar_for(lean_path: Path) -> Path:
    return lean_path.with_suffix(".md")


def ensure_sidecar_link(lean_path: Path, *, dry_run: bool = False) -> list[str]:
    """Make the first line of a paired .lean file `-- Sidecar: <repo-relative .md>`."""
    md_path = sidecar_for(lean_path)
    if not md_path.is_file():
        return []
    want = f"-- Sidecar: {md_path.relative_to(ROOT).as_posix()}"
    text = lean_path.read_text(encoding="utf-8")
    lines = text.splitlines(keepends=True)
    m = SIDECAR_LINE.match(lines[0]) if lines else None
    if m is not None and lines[0].rstrip("\n") == want:
        return []
    if m is not None:
        lines[0] = want + "\n"
        action = "fix"
    else:
        lines.insert(0, want + "\n")
        action = "add"
    if not dry_run:
        lean_path.write_text("".join(lines), encoding="utf-8")
    return [f"{lean_path.relative_to(ROOT)}: {action} `{want}`"]


def default_lean_files() -> list[Path]:
    paths = sorted(LIB.rglob("*.lean"))
    root_index = ROOT / "FAA.lean"
    if root_index.is_file():
        paths.insert(0, root_index)
    return paths


def refresh_sidecar(lean_path: Path, *, dry_run: bool = False) -> list[str]:
    md_path = sidecar_for(lean_path)
    if not md_path.is_file():
        print(f"skip {lean_path.relative_to(ROOT)}: no sidecar {md_path.name}")
        return []

    decls = public_decls(lean_path)
    lean_name = lean_path.name
    text = md_path.read_text(encoding="utf-8")
    changes: list[str] = []

    def repl(m: re.Match[str]) -> str:
        decl, linked_file, old_line = m.group(1), m.group(2), int(m.group(3))
        if linked_file != lean_name:
            return m.group(0)
        if decl not in decls:
            return m.group(0)
        new_line = decls[decl]
        if new_line == old_line:
            return m.group(0)
        changes.append(f"  {decl}: L{old_line} → L{new_line}")
        return f"[`{decl}`]({linked_file}#L{new_line})"

    new_text = LINK.sub(repl, text)
    if changes and not dry_run:
        md_path.write_text(new_text, encoding="utf-8")
    prefix = lean_path.relative_to(ROOT)
    if changes:
        return [f"{prefix} ↔ {md_path.name}"] + changes
    return []


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "lean_files",
        nargs="*",
        type=Path,
        help="Lean files under FAA/ (default: all FAA/**/*.lean with a sidecar)",
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="Do not write; exit 1 if any anchors would change",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print changes without writing",
    )
    args = parser.parse_args()

    if args.lean_files:
        lean_paths = [p if p.is_absolute() else ROOT / p for p in args.lean_files]
    else:
        lean_paths = default_lean_files()

    all_changes: list[str] = []
    for lean_path in lean_paths:
        if not lean_path.is_file():
            print(f"error: not found: {lean_path}", file=sys.stderr)
            return 2
        # Insert the back-pointer first so #L anchors below see post-insertion lines.
        all_changes.extend(ensure_sidecar_link(lean_path, dry_run=args.check or args.dry_run))
        all_changes.extend(refresh_sidecar(lean_path, dry_run=args.check or args.dry_run))

    if all_changes:
        print("\n".join(all_changes))
        if args.check:
            print("\nStale sidecar links/anchors found (run without --check to fix).", file=sys.stderr)
            return 1
        if not args.dry_run:
            print("\nUpdated sidecar anchor(s).")
    else:
        print("All sidecar #L anchors up to date.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
