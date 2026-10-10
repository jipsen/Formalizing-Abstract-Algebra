---
name: faa-formalize
description: >-
  Fill every `sorry` in one FAA Lean file via lean4-skills and Lean LSP MCP,
  looping in file order until each hole is closed or marked blocked. Distinct
  from faa-hammer (one claim, then stop). Use when the user says faa-formalize,
  fill all sorries, all sorries in this file, systematically prove this file,
  or asks to formalize a whole FAA/**/*.lean file.
argument-hint: "<lean-file> [prove|gap]"
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
  - todo_write
permissions:
  allow:
    - Read(**)
    - Write(FAA/**)
    - Write(*.md)
    - Exec(python3)
    - Exec(lake build)
    - Exec(lake env lean)
---

# FAA formalize (all `sorry`s in a file)

Prove **every** remaining `sorry` in one `FAA/**/*.lean` file. Same stack as
[`faa-hammer`](../faa-hammer/SKILL.md); the difference is the loop.

**Language.** Prefer mathematics / algebra / Lean–mathlib wording. Do not
invent informal labels for clusters of lemmas.

**Mathlib-first.** Search before writing tactics *and* before restating: much of
abstract algebra already exists in Mathlib; a hole often closes by `exact`
on an existing lemma.

**External stack (host-installed, not in this repo):**

- [lean4-skills](https://github.com/cameronfreer/lean4-skills) — `/lean4:prove`; `/lean4:autoprove` only with an explicit budget
- [Lean LSP MCP](https://github.com/leanprover-community/lean-lsp-mcp) — `lean_goal`, `lean_diagnostic_messages`, `lean_multi_attempt`, search tools

## Contrast with `faa-hammer`

| | `faa-hammer` | `faa-formalize` |
|--|--------------|-----------------|
| Scope | One named claim | All `sorry` / `admit` in one file |
| Stop | After that claim | Queue exhausted or budget spent |
| Typical prompt | "hammer this lemma" | "fill all sorries in this file" |

If the user names **one lemma** (not a file), use **faa-hammer**. If they name a
file or say "all sorries", use this skill.

## Modes

| Mode | Meaning |
|------|---------|
| `prove` | Attempt every hole; leave blocked ones as `sorry` with an obstruction note |
| `gap` | Inventory only; do not prove |

Default: `prove`.

## Workflow

1. **File.** Require `FAA/**/*.lean`. If unnamed, use the focused Lean file. Lake
   root is the repo root.

2. **Inventory.** List each `sorry` / `admit` in **file order** (decl name +
   line). Grep is enough; if `$LEAN4_SCRIPTS` is set, also run
   `${LEAN4_PYTHON_BIN:-python3} "$LEAN4_SCRIPTS/sorry_analyzer.py" <file> --report-only`.
   Track the queue (todos or an in-chat checklist). **Announce the queue**
   before proving.

3. **Loop** (file order — earlier decls first). For each hole:

   a. Re-check the file. If this hole is already gone (closed as a side-effect),
      mark skipped and continue.
   b. `lean_goal` at the `sorry`.
   c. Search Mathlib before writing tactics (`lean_local_search`, then at most
      one of `lean_leansearch` / `lean_loogle` / `lean_leanfinder` /
      `lean_state_search`).
   d. Try the automation cascade via `lean_multi_attempt` when available:
      `rfl` → `simp` → `ring` → `linarith` → `omega` → `exact?` → `apply?` →
      `grind` → `aesop`. Stop on first success.
   e. If that fails: **one** bounded prove attempt (lean4-skills `/lean4:prove`
      style). `/lean4:autoprove` only if the user set a per-sorry or file budget.
   f. **Do not** change theorem/lemma statements or add axioms. If a proof seems
      to need that, mark blocked and continue.
   g. If still stuck: leave `sorry`, record a one-line obstruction (optional
      `--` comment at the hole). **Continue** — do not stall the file on one hole.

   After each close, re-grep: line numbers shift.

4. **Build.** `lean_diagnostic_messages` on the file → `lake env lean` on the
   file → `lake build` at the end of the run.

5. **Sidecars and inventory (required).** Run [`faa-maintain`](../faa-maintain/SKILL.md)
   (anchors + [`FAA/INVENTORY.md`](../../FAA/INVENTORY.md)). If proofs changed
   materially, run [`faa-semi-informalize`](../faa-semi-informalize/SKILL.md).

6. **Do not** auto-commit.

## Per-sorry budget

Default: one bounded pass (search + automation cascade + one structured proof
attempt). A hole that survives that pass is **blocked**, not retried in this
run, unless the user set a larger budget (`--budget N` cycles per sorry, or
`/lean4:autoprove` with an explicit stop).

## When to stop

- Zero `sorry` / `admit` left in the file, or
- Every remaining hole has been attempted and marked blocked, or
- User-set wall-clock / cycle budget exhausted.

Report even if some holes remain.

## Output

Report, in this order:

1. File and mode.
2. Table: decl, start line, `closed` / `blocked` / `skipped`, obstruction if blocked.
3. `lake` status; remaining `sorry`s (names + lines).
4. Sidecars updated (`faa-maintain` / `faa-semi-informalize`).
5. Suggested next step: remaining hole, another file, or a single-claim
   `faa-hammer`.
