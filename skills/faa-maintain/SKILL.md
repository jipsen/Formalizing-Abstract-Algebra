---
name: faa-maintain
description: >-
  Run scripted repo maintenance after Lean or sidecar work: ensure a Fitch sidecar
  exists for each touched .lean file, invoke faa-semi-informalize when one is
  missing, refresh #L anchors, keep FAA/INVENTORY.md in date, and spot-check sidecar
  prose for stale 'scaffold' / 'sorry' / 'TODO' language. Use when the user says
  maintain, upkeep, refresh anchors, sync sidecars, update inventory, or after
  modifying FAA/**/*.lean. Distinct from faa-compare (read-only audit) and
  faa-semi-informalize (full Fitch rewrite).
argument-hint: "[<lean-file>|all] [--check]"
disable-model-invocation: false
triggers:
  - user
allowed-tools:
  - read
  - write
  - edit
  - grep
  - find_file_by_name
  - exec
  - skill
permissions:
  allow:
    - Read(**)
    - Write(FAA/**)
    - Write(*.md)
    - Exec(python3)
    - Exec(lake build)
    - Exec(lake env lean)
---

# FAA maintain (Lean ↔ sidecar and inventory upkeep)

**Mechanical fixes** that keep Lean, Fitch sidecars, and [`FAA/INVENTORY.md`](../../FAA/INVENTORY.md)
aligned. Creates missing sidecars by calling **faa-semi-informalize**. Does **not** rewrite an
existing sidecar's Fitch unless missing — use **faa-semi-informalize** for full rewrites. Does
**not** audit only — use **faa-compare**.

Policy: [`docs/lean-sidecar-policy.md`](../../docs/lean-sidecar-policy.md).

## When to run

| Trigger | Action |
|---------|--------|
| You modified any `FAA/**/*.lean` | **Required** before reporting done (sidecars + inventory) |
| User says maintain / sync sidecars / refresh anchors / update inventory | Run on named file or all |
| User says `--check` only | Report stale anchors and inventory gaps; do not write |

## Workflow

1. **Scope.** Input: `FAA/Group/Foo.lean`, or `all` (every `FAA/**/*.lean` touched this session).

2. **Missing sidecar.** If `Foo.md` is absent next to `Foo.lean`, run **faa-semi-informalize** on that file first.

3. **Refresh `#L…` anchors.** From repo root (the same script also maintains the `-- Sidecar: <path>` first line of each paired `.lean` — policy § Pairing; never hand-edit it):

   ```bash
   python3 scripts/refresh-sidecar-anchors.py FAA/Group/Foo.lean
   # or all:
   python3 scripts/refresh-sidecar-anchors.py
   # check-only:
   python3 scripts/refresh-sidecar-anchors.py --check
   ```

4. **Declaration coverage.** The anchor script only refreshes *existing* `[`decl`](File.lean#L…)` links — it does **not** detect declarations missing from the sidecar. For each touched `.lean`, check that every public decl (`theorem`/`def`/`abbrev`/`structure`/`class`/`instance`) has a `**Section**` entry (and a table row where the sidecar keeps one). Add missing entries in semi-informalize style; delegate wholesale coverage to **faa-semi-informalize**.

5. **Stale-prose spot-check.** Grep the paired sidecar(s) for `scaffold`, `sorry`, `TODO` in Fitch/remark text that no longer matches Lean (e.g. Lean closed a `sorry` but sidecar still says stub). Also flag prose that defines by negation ("is not required", "not the definition", "unlike …" asides) in sidecars and Lean docstrings. Report hits; do not silently rewrite — point to **semi-informalize**.

6. **Inventory.** Keep [`FAA/INVENTORY.md`](../../FAA/INVENTORY.md) a **nested module list** by subfolder. Each entry is the bare module name linked to its **sidecar** (`[Basic](…/Basic.md)`); Lean is reached from the sidecar `**Source.**` line. No blurbs, no `.lean` links. Update when this run created, deleted, or renamed a `FAA/**/*.lean` (or its sidecar). On `all` or `--check`, verify every `FAA/**/*.lean` has a listed sidecar (plus [`FAA.md`](../../FAA.md)). Do **not** catalogue planned-but-absent files (roadmap lives in [`MILESTONES.md`](../../MILESTONES.md)). `--check`: report missing/stale lines; do not write.

7. **Build sanity (when in doubt).** If a touched `.lean` was never compiled this session, `lake env lean <file>` (or `lake build` before signing off) — sidecar prose assumes the Lean it describes still elaborates.

8. **Do not** `git commit` unless the user asked.

## When to stop

Anchors refreshed and every public decl covered (or `--check` clean); inventory matches the tree. Report what changed and any compare/semi-informalize follow-ups.
