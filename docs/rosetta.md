# Rosetta (terminology & conventions)

**Consult this file before naming** a declaration, docstring, or doc section. When a source uses a different term, record the mismatch in a docstring or sidecar `*Remark:*` — do not silently switch conventions.

This file is self-contained: terminology follows the source text (Judson, *Abstract Algebra: Theory and Applications*) and Mathlib naming. Record settled decisions below; do not import conventions from other projects.

Sidecar policy: [`lean-sidecar-policy.md`](lean-sidecar-policy.md). Per-file Lean↔Math tables in each sidecar header define that file's local math *symbols*; this file records repo-wide naming *decisions* (which term, not which symbol).

## File naming

- One Lean module per book chapter: `FAA/ChNN<Title>.lean` — `NN` is the two-digit
  chapter number, `<Title>` the book's chapter title in CamelCase.
  Examples: `FAA/Ch01Preliminaries.lean`, `FAA/Ch02Integers.lean`, future `FAA/Ch03Groups.lean`.
- Hyphens are illegal in Lean module names: write `Ch01Preliminaries`, not `Ch-01-Preliminaries`.
- The Fitch sidecar takes the same base name: `FAA/ChNN<Title>.md`.
- `FAA/Basic.lean` (the charter) is not a book chapter and keeps its name.

## Preferred terms

| Say | Not | Why |
|-----|-----|-----|
| *(empty — add rows as naming decisions are made)* | | |

## Concept table: source ↔ Mathlib ↔ Lean

*(empty — add once a source text is chosen in `MILESTONES.md`)*
