---
name: faa-compare
description: >-
  Read-only alignment audit between a FAA Lean file and its Fitch sidecar. Reports
  missing declarations, orphan markdown sections, bad #L anchors, and theorems without
  Fitch. Use when the user says compare, alignment check, sidecar audit, or asks
  whether .md matches .lean.
argument-hint: "<lean-file>"
disable-model-invocation: false
triggers:
  - user
allowed-tools:
  - read
  - grep
  - find_file_by_name
  - exec
permissions:
  allow:
    - Read(**)
    - Exec(grep)
    - Exec(wc)
    - Exec(python3)
---

# FAA compare (Lean ↔ sidecar audit)

**Read-only.** Do not edit Lean or sidecar unless the user explicitly asks to fix findings.

Policy: [`docs/lean-sidecar-policy.md`](../../docs/lean-sidecar-policy.md).
Write path: [`skills/faa-semi-informalize/SKILL.md`](../faa-semi-informalize/SKILL.md).
Anchors: [`skills/faa-maintain/SKILL.md`](../faa-maintain/SKILL.md).

## Workflow

1. **Input:** `FAA/…/Foo.lean`. Expected sidecar: `Foo.md` beside it (missing → **fail**).
2. **Collect** public Lean decls (`abbrev`/`def`/`lemma`/`theorem`/`instance`); skip `private`.
3. **Collect** sidecar `**Def**` / `**Lemma**` / `**Theorem**` sections with `` [`name`](File.lean#Lnn) ``.
4. **Compare:** missing section / orphan section / order mismatch.
5. **Anchors:** optionally `python3 scripts/refresh-sidecar-anchors.py --check` (report only).
6. **Proofs:** non-trivial Lean proofs without Fitch → **missing Fitch**; closed Lean with sidecar still saying `sorry`/`scaffold` → **stale prose**.
7. **Tone (spot-check):** survey / "why this matters" / foreshadowing asides on infrastructure decls → **curriculum blurb** (policy doc § Purpose); suggest trim via **semi-informalize**.
8. **KaTeX (spot-check):** math outside `$…$`/`$$…$$`, custom macros (`\newcommand`, `\DeclareMathOperator`), or non-KaTeX commands → **KaTeX violation**; all formulas in sidecars are KaTeX built-ins only (policy doc § KaTeX).

## Output

Short report: pass/fail, lists of gaps, suggested next skill (`faa-maintain` vs `faa-semi-informalize`). No edits.
