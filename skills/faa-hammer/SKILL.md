---
name: faa-hammer
description: >-
  Use autoformalization as a Sledgehammer-style tool on one FAA milestone claim
  (groups/rings/fields/lattices or a named lemma in FAA/). Prefer /lean4:draft
  then /lean4:prove. Use when the user says faa-hammer, AF-as-a-hammer, hammer
  this lemma, or asks Lean to check a claim from MILESTONES.md.
argument-hint: "<claim-or-location> [hammer|generalize|gap|scaffold]"
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

# FAA hammer (AF-as-a-hammer)

One **claim** from [`MILESTONES.md`](../../MILESTONES.md) or a named lemma in `FAA/`. Not chapter-scale autoformalization. For every `sorry` in a file, use [`faa-formalize`](../faa-formalize/SKILL.md).

**Language.** Prefer mathematics / algebra / Lean–mathlib wording in decls, docs, and chat. Invent a new phrase only if it names a mathematical object or a software API this repo needs — not a label for "the stuff in this section."

**Mathlib-first.** Abstract algebra is dense in Mathlib (`Group`, `Ring`, `Subgroup`, `Ideal`, `QuotientGroup`, homomorphism bundles, …). A claim needed here very likely already exists — search before stating anything.

**External stack (host-installed, not in this repo):**

- [lean4-skills](https://github.com/cameronfreer/lean4-skills) — `/lean4:draft`, `/lean4:prove`, `/lean4:formalize`
- [Lean LSP MCP](https://github.com/leanprover-community/lean-lsp-mcp) — `lean_goal`, `lean_diagnostic_messages`, search tools

## Modes

| Mode | Meaning |
|------|---------|
| `hammer` | Prove the stated claim in the obvious module |
| `generalize` | Slightly stronger statement if Mathlib-friendly |
| `gap` | Leave `sorry` with a clear docstring / sidecar remark |
| `scaffold` | Declarations only |

Default: `hammer`. **One claim, then stop.**

## Workflow

1. **Locate** the claim (milestone bullet, file, or informal statement). Prefer Mathlib classes/instances over new defs — see README standing rules.
2. **Search** with Lean LSP MCP before defining.
3. **Draft / prove** with lean4-skills on **this claim only**. `/lean4:autoprove` only if the user set a budget.
4. **Build.** From repo root: `lake env lean` on the touched file; `lake build` at checkpoints.
5. **Sidecars and inventory (required).** Run [`faa-maintain`](../faa-maintain/SKILL.md) (anchors + [`FAA/INVENTORY.md`](../../FAA/INVENTORY.md)). If proofs changed materially, run [`faa-semi-informalize`](../faa-semi-informalize/SKILL.md).
6. **Do not** auto-commit.

## When to stop

Claim done or blocked with a clear gap. Report file, decl names, remaining sorries, next suggested claim.
