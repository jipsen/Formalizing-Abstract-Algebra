---
name: faa-semi-informalize
description: >-
  Write or refresh the Fitch-style semi-informal companion of a FAA Lean file.
  One .md sidecar per .lean file. Use when the user says semi-informalize,
  informalize, Fitch companion, or after Lean proofs in FAA/ change.
argument-hint: "<lean-file-or-decl>"
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
permissions:
  allow:
    - Read(**)
    - Write(FAA/**)
    - Write(*.md)
    - Exec(python3)
---

# FAA semi-informalize

Turn a Lean file into a **parallel reading surface** (human math + Fitch), and keep it in date when Lean changes.

**Purpose (read first):** [`docs/lean-sidecar-policy.md`](../../docs/lean-sidecar-policy.md) § Purpose — read the file as mathematics; do not comment on it as a curriculum.

Use community language (math / algebra / Lean) in section titles and prose; do not invent informal labels for clusters of lemmas.

Policy: [`docs/lean-sidecar-policy.md`](../../docs/lean-sidecar-policy.md).
Audit: [`skills/faa-compare/SKILL.md`](../faa-compare/SKILL.md).
Upkeep after edits: [`skills/faa-maintain/SKILL.md`](../faa-maintain/SKILL.md).

## Pairing

| Lean | Sidecar |
|------|---------|
| `FAA/Group/Foo.lean` | `FAA/Group/Foo.md` |
| `FAA.lean` | `FAA.md` (short index) |

If you create or materially edit a Lean file, update the sidecar **in the same run**.

## Workflow

1. **Read** the `.lean` file (and `lean_file_outline` / diagnostics via Lean LSP MCP if available).
2. **Write or refresh** the paired `.md`:
   - One `**Def**` / `**Lemma**` / `**Theorem**` section per public decl, **same order** as Lean.
   - Header links: `` [`name`](File.lean#Lnn) `` (anchors refreshed by **faa-maintain**). Lean name in the header; math in the body.
   - State the claim; then pick proof form by *math* (policy doc § Proofs): Fitch if there is structure; short prose if citing general facts; `*Remark:*` only if there is nothing to sketch.
   - All mathematical formulas are written in KaTeX (`$…$` inline, `$$…$$` display) — KaTeX built-ins only (`\mathsf{Grp}`, `\operatorname*{…}`, …), no custom macros; unsupported commands get the policy's workaround table (`docs/lean-sidecar-policy.md` § KaTeX). No hard wrapping — one physical line per paragraph and per Fitch step.
   - After `**Source.**` (and any `**Book.**` / `**Docs.**` lines), a `**Content.**` sentence naming what the file is; then the **Lean | Math** table whenever names diverge — it defines the local math names the body is written in (policy doc § Local math names).
   - Not a textbook / not curriculum commentary. State what each decl *is* — never what it is *not* (no "not required to be …", "not the definition", "unlike …" asides).
   - Mathlib-first: a file that mostly instantiates Mathlib classes may legitimately have thin `*Remark:*` sections — record what the file adds, not what Mathlib already says.
3. **Run** [`faa-maintain`](../faa-maintain/SKILL.md) on the file (anchor refresh).
4. **Do not** auto-commit.

## Grain

**Fitch:** one `Have:` per mathematical step a human would write — not one per Lean tactic beat.

**Short prose:** when the proof is "by such-and-such general fact(s)" (cite a prior theorem or a Mathlib instance).

## When to stop

Sidecar covers all public decls; anchors refreshed; KaTeX-safe. Report path + what changed.
