# Lean sidecar policy (FAA)

**This file is self-contained** — it is the canonical sidecar policy for this repo; no other checkout is needed.

Every public declaration in `FAA/**/*.lean` has a **Fitch companion** `*.md` in the same folder.

Root [`FAA.lean`](../FAA.lean) pairs with [`FAA.md`](../FAA.md).

## Purpose

The sidecar is a **parallel reading surface for the Lean file**, not a note that teaches the subject.

| Owns | Role |
|------|------|
| **Lean** | Correctness; global identifiers (`invertible_iff_bijective`, `classes_partition`, …) |
| **Sidecar** | Human mathematics: what each decl *is*, in local math notation, Lean order, with `#L` links |

- **Lean names are global; math names are local.** Lean identifiers must disambiguate the whole project; a sidecar's math symbols need only read well inside that one file.
- A mathematician **who knows the subject** should be able to **read the sidecar as mathematics without knowing Lean** — then follow the `#L` anchors and the **Lean | Math** table to read the `.lean`. (Not a textbook: the sidecar *states* the math, it does not explain it.)
- The sidecar should **not comment on the file as a curriculum** (no "why this matters", foreshadowing, survey, or motivational prose).
- Design narrative and proof *strategy* belong in Lean docstrings or on the theorem that *uses* a fact — not as asides on infrastructure instances.
- **Mathlib-first.** Abstract algebra is dense in Mathlib. Sidecars state the mathematics of what `FAA` adds; a file that mostly instantiates Mathlib classes may legitimately have thin `*Remark:*` sections.
- **Formalisation artefacts.** Flag definition-versus-predicate bookkeeping in the `.lean` docstring; the sidecar uses `*Remark:*` instead of `*Proof:*` (§ What the sidecar must contain).

Canonical mechanics: [`skills/faa-semi-informalize/SKILL.md`](../skills/faa-semi-informalize/SKILL.md).
Audit (read-only): [`skills/faa-compare/SKILL.md`](../skills/faa-compare/SKILL.md).
Upkeep: [`skills/faa-maintain/SKILL.md`](../skills/faa-maintain/SKILL.md) (anchors **and** [`FAA/INVENTORY.md`](../FAA/INVENTORY.md)).

## Inventory (`FAA/INVENTORY.md`)

Nested **module list** of what is in the tree now (not the roadmap — that is [`MILESTONES.md`](../MILESTONES.md)).

| Rule | |
|------|--|
| Group by subfolder | `Group/`, `Ring/`, … with children indented |
| Bare module name | write `Basic`, not `Basic.lean` / `Basic.md` |
| Link the sidecar only | `[Basic](Group/Basic.md)` — Lean is reached from the sidecar `**Source.**` line |
| No blurbs | no one-line descriptions, no planned-but-absent files |

Maintain updates this whenever a `FAA/**/*.lean` (or its sidecar) is added, removed, or renamed.

**Language:** follow mathematics / algebra / Lean–mathlib terms (see README standing rules). Invent new phrases only for a real mathematical notion or a needed software interface.

## Pairing

| Lean | Sidecar |
|------|---------|
| `FAA/Foo.lean` | `FAA/Foo.md` |
| `FAA/Group/Bar.lean` | `FAA/Group/Bar.md` |
| `FAA.lean` (imports) | `FAA.md` — short index |

Links run both ways: the sidecar's `**Source.**` line points to the `.lean`; every paired `.lean` carries `-- Sidecar: <repo-relative .md path>` as its **first line** (e.g. `-- Sidecar: FAA/Group/Bar.md`; `FAA.lean` → `-- Sidecar: FAA.md`). `refresh-sidecar-anchors.py` inserts and fixes it — do not hand-edit.

Create or refresh the sidecar **in the same run** as any material Lean edit. A changed Lean proof with a stale Fitch block is a bug.

## `#L…` anchors

Sidecar section headers link to Lean with `` [`declName`](File.lean#L42) ``. After `.lean` edits, agents **must** run **faa-maintain** (not only the raw script from memory):

```bash
python3 scripts/refresh-sidecar-anchors.py FAA/Group/Foo.lean
# or all pairs:
python3 scripts/refresh-sidecar-anchors.py
# check-only:
python3 scripts/refresh-sidecar-anchors.py --check
```

Script: [`scripts/refresh-sidecar-anchors.py`](../scripts/refresh-sidecar-anchors.py).

### Script or MCP?

**Keep the anchor refresher as a script.** Do **not** add a dedicated sidecar MCP.

| | Script (now) | Lean LSP MCP |
|--|--------------|--------------|
| Job | Regex-match decl names → rewrite `#Lnn` | Goals, diagnostics, mathlib search |
| Install | In-repo `python3 scripts/…` | Host-level [lean-lsp-mcp](https://github.com/oOo0oOo/lean-lsp-mcp) |

Proof synthesis uses host-level [lean4-skills](https://github.com/cameronfreer/lean4-skills) (`/lean4:*`). Neither is vendored in this repo; both are public install links (see README § Lean LSP and lean4-skills).

## What the sidecar must contain

1. **Coverage** — one section per **public** declaration (`abbrev`, `def`, `lemma`, `theorem`, `instance`), same order as Lean.
2. **File header** — `**Source.**` first, then optional cross-reference lines (`**Book.**`, `**Docs.**`, …), then **`**Content.**`** — one sentence naming what the file is (not curriculum). Then the **Lean | Math** table whenever body names diverge from Lean identifiers (§ Local math names).
3. **Anchors** — `` [`declName`](File.lean#L42) ``; refresh after Lean moves.
4. **Headers** — `**Def**`, `**Lemma**`, or `**Theorem**`; Lean name in the header link.
5. **Body** — state what the decl *is* in math (succinct), never what it is *not* (no "not required to be …", "not the definition", "unlike …" asides). Dictionary table owns Lean↔math renaming; do not re-explain it in every section.
6. **Proofs** — choose the form that matches the *math*, not the Lean line count:
   - **Fitch** — when there is structure to track (nested assumptions, cases, a real chain of steps). One `Have:` per human mathematical step. `>` depth is **assumption scope**: only `Ass:` (or a discharged case/fix) opens a box, one extra `>` per level, and the `Ass:` line itself sits inside the box it opens; `Show:` marks the current goal and does **not** indent. For a multi-component goal (a structure's fields, a conjunction, an iff), `Show:` may enumerate the parts `…, i.e. (i) …, (ii) …, (iii) …` on one line; each discharging step carries the matching tag and sits at the same depth, and a bare `>` line separates the parts.
   - **Short prose `*Proof.*`** — when the content is citing general facts (e.g. "by Lagrange's theorem and the correspondence of cosets, …"). Fitch would add ceremony without readability.
   - **`*Remark:*`** — only when there is no math to sketch: `rfl` / `simp` / pure formalisation artefact / `sorry` stub. Do not use a remark to name the Lean lemma instead of writing the math.
7. **Omit** — `private` helpers unless needed for readers; import-only modules need only an index.
8. **KaTeX** — `$...$` with built-ins only (`\mathsf`, `\mathrm`, `\leq`, `\circ`, …); no custom `.tex` macros. Prefer `\mathsf{Grp}`, `\mathsf{Ring}` for structure names in math. Known-unsupported commands seen so far: `\bigsqcap` (write `{\Large \sqcap}`; `\bigsqcup` *is* supported), `\bulletop` (write `\bullet`), literal Unicode in math (`◇` → `\diamond`).
9. **Line breaks** — no hard wrapping, ever. One physical line per paragraph, statement, remark, and proof sentence; one physical line per Fitch step or numbered item. Never break a line to fit a column limit.
10. **Local math names** — see § Local math names: the table defines them; bodies are written in them.
11. **Not a textbook** — no survey paragraphs, motivational essays, "in this chapter…", curriculum asides, or definitions by negation. State the claim positively; prove or remark; stop. The same applies to `.lean` comments and docstrings (see [`.cursor/rules/lean.mdc`](../.cursor/rules/lean.mdc)).

## Diagrams

Optional, for structured proofs: a `**Diagrams.**` line before the Fitch block linking to a [quiver](https://q.uiver.app) share URL. KaTeX cannot render tikz/quiver code — use the share link, not embedded source.

To generate a link without the editor: the `#q=` fragment is base64 of `[0, vertex_count, …vertices, …edges]`. Vertex = `[x, y, "label"]`. Edge = `[src, tgt, "label", alignment, options]` — slot 4 is the **label alignment** (`0` left, `1` centre/on-arrow, `2` right, `3` over; left/right are read as if the arrow faced up), slot 5 an options delta like `{"curve": 2}`; trailing elements may be omitted. Omit `=` padding.

## Local math names

Lean identifiers are **global** — they must disambiguate the whole project (`invertible_iff_bijective`, `eqv_classes_disjoint_or_eq`). Math names are **local to each sidecar** and chosen for readability ($f$, $G$, $[a]_n$). Each sidecar owns its dictionary.

- **The `| Lean | Math |` table defines the local names.** Required whenever a body uses a name that differs from the Lean identifier — i.e. nearly always. Symbols are per-file: two sidecars may map different symbols to the same declaration.
- **Bodies read as mathematics without Lean.** Statements and proof steps use the local math names — no Lean-verbs-as-math ("`ext`-ified", `choose`), no Lean-names-in-mathsf (`\mathsf{invertibleIffBijective}`). A reader who knows the subject reads the sidecar without opening the `.lean`; the table and `#L` anchors then map math → Lean.
- **Lean identifiers in bodies only as references**: header anchor links, the table, and inline `code` where a specific declaration is the justification (e.g. "injectivity transfers to the composite — `injective_comp`"). The sentence must still read as math if the reference were deleted.
- **Structure field names** (`carrier`, `one`, `mul`) may label steps — they are the reader-facing API of the structure, like named hypotheses.
- **Composition is standard `∘`.** `f \circ g` means apply `g` first, then `f`. For diagrammatic order (Lean `≫` order), write `\cdot`: `f \cdot g` means `f ≫ g`. Never write `f \circ g` to mean `f ≫ g`.
- **Terminology is repo-wide; symbols are local.** What to *call* a notion lives in [`rosetta.md`](rosetta.md); which *letter* denotes it lives in the sidecar's table.

## Agent wiring

| Framework | Loader |
|-----------|--------|
| Any | [`AGENTS.md`](../AGENTS.md) |
| Cursor | [`.cursor/rules/lean.mdc`](../.cursor/rules/lean.mdc), [`.cursor/skills/`](../.cursor/skills/) |
| Claude Code | [`CLAUDE.md`](../CLAUDE.md) |
| Gemini / Antigravity | [`GEMINI.md`](../GEMINI.md), [`.agents/skills/`](../.agents/skills/) |
| Devin | [`.devin/skills/`](../.devin/skills/) |
| GitHub Copilot | [`.github/copilot-instructions.md`](../.github/copilot-instructions.md) |

## Appendix: a worked Fitch block

A multi-part goal (an iff), enumerated `Show:`, two `Ass:` boxes, the parts separated by a bare `>` line.

*Proof.*

> Show: $aH = H \iff a \in H$, i.e. (i) $a \in H \Rightarrow aH = H$, (ii) $aH = H \Rightarrow a \in H$
>
> Show: (i) — $a \in H \Rightarrow aH = H$
> > Ass: $a \in H$
> > Have: $aH \subseteq H$ (closure of $H$)
> > Have: $H \subseteq aH$, since $h = a(a^{-1}h)$ and $a^{-1}h \in H$
> Have: $aH = H$
>
> Show: (ii) — $aH = H \Rightarrow a \in H$
> > Ass: $aH = H$
> > Have: $a = ae \in aH = H$
> Have: $a \in H$
>
> QED
