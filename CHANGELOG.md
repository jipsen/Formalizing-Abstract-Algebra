# Changelog

**Newest first.** When library-visible work lands (new modules, definitions, theorems, renames), prepend a bullet under `## YYYY-MM-DD` for that day. Bullets link to Lean sources; each module's sidecar is the `.md` next to it. Module list: [`FAA/INVENTORY.md`](FAA/INVENTORY.md); roadmap: [`MILESTONES.md`](MILESTONES.md).

## 2026-10-10

- Initialized the project: Lean 4 / Mathlib skeleton (`FAA`, toolchain `v4.33.1`), agent rules and `faa-*` skills, Fitch-sidecar infrastructure (`scripts/refresh-sidecar-anchors.py`, `docs/lean-sidecar-policy.md`).
- Made agent infrastructure self-contained: `docs/lean-sidecar-policy.md` is now the canonical policy (previously deferred to a sister repo), `docs/rosetta.md` no longer defers externally; all skills/rules resolve inside this repo.
