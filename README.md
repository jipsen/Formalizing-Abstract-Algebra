# Formalizing Abstract Algebra

Lean 4 / Mathlib formalization of abstract algebra (groups, rings, fields, lattices — scope set by the project owners in [`MILESTONES.md`](MILESTONES.md)).

**Source text:** Thomas W. Judson, *Abstract Algebra: Theory and Applications* (edition of August 4, 2026) — the textbook this project formalizes. PDF and `pdftotext` extract live in [`bibliography/`](bibliography/) (`aata-20260811.pdf`, `aata-20260811.txt`).

**Agents:** read [`AGENTS.md`](AGENTS.md) (→ this file's standing rules and links).

**Roadmap:** [`MILESTONES.md`](MILESTONES.md).

**Mathlib pin:** `v4.33.1`.

## Quick start (for collaborators)

1. Install [elan](https://elan.lean-lang.org/) (Lean version manager). The repo's [`lean-toolchain`](lean-toolchain) pins the exact Lean/Mathlib-compatible version; elan installs it automatically.
2. Clone and build:

   ```bash
   git clone https://github.com/jipsen/Formalizing-Abstract-Algebra.git
   cd Formalizing-Abstract-Algebra
   lake exe cache get   # download prebuilt Mathlib cache (fast)
   lake build
   ```

3. Open the folder in VS Code or Cursor with the **Lean 4 extension** — go-to-definition and goal view should work after the build finishes.
4. The textbook source is [`bibliography/aata-20260811.txt`](bibliography/aata-20260811.txt) (plain text for searching/quoting) and `aata-20260811.pdf`. Pick claims from [`MILESTONES.md`](MILESTONES.md).

## Standing rules

- **Community language.** Prefer established terms from mathematics and Lean/mathlib. Invent new phrases only when they name a real mathematical notion or a software interface this repo needs. Settled terminology decisions are recorded in [`docs/rosetta.md`](docs/rosetta.md) — consult it before naming.
- **Search Mathlib before defining.** Abstract algebra is one of Mathlib's densest areas (`Group`, `Ring`, `Field`, `Subgroup`, `Ideal`, `QuotientGroup`, …) — a definition or lemma needed here very likely already exists. Use Lean LSP MCP search (`lean_local_search`, `lean_leansearch`, `lean_loogle`, `lean_leanfinder`) and `lean_goal` / `lean_diagnostic_messages` while editing.
- **Proof filling:** [lean4-skills](https://github.com/cameronfreer/lean4-skills) — `/lean4:draft` → `/lean4:prove` or `/lean4:formalize` on one claim (`faa-hammer`); all `sorry`s in a file (`faa-formalize`); `/lean4:autoprove` only with an explicit budget. Use [Lean LSP MCP](https://github.com/oOo0oOo/lean-lsp-mcp) for live goals and search.
- Every `FAA/**/*.lean` has a Fitch `.md` sidecar; refresh when proofs change ([`docs/lean-sidecar-policy.md`](docs/lean-sidecar-policy.md)).
- **After any `FAA/**/*.lean` edit:** run [`faa-maintain`](skills/faa-maintain/SKILL.md) (refreshes `#L…` via [`scripts/refresh-sidecar-anchors.py`](scripts/refresh-sidecar-anchors.py); keeps [`FAA/INVENTORY.md`](FAA/INVENTORY.md) in date).
- Line width 100 for code. `fun x ↦ ...` for lambdas. **Never auto-commit.**
- **Docstrings / module docs** (`/-- … -/` and `/-! … -/`): do **not** wrap mid-phrase. Prefer **one sentence per physical line**; blank lines between paragraphs are fine. Prefer a long line over a mid-sentence break.
- **`MILESTONES.md` TOC:** flat list of `##` sections only, maintained by hand. Do not run TOC generators.

**Validate:** `lean_diagnostic_messages` on the file → `lake env lean <file>` → `lake build` at checkpoints. Lake root is **this repo**.

## Build

```bash
lake update
lake exe cache get
lake build
```

```text
/faa-hammer <milestone-claim>
/faa-formalize FAA/Foo.lean
/faa-semi-informalize FAA/Foo.lean
/faa-maintain FAA/Foo.lean
/faa-compare FAA/Foo.lean
```

## Skills (multi-framework)

Canonical bodies live under [`skills/`](skills/). Thin wrappers (do not duplicate the body):

| Tool | Also reads |
|------|------------|
| Cursor | [`.cursor/skills/`](.cursor/skills/) |
| Devin | [`.devin/skills/`](.devin/skills/) |
| Claude Code / Codex / Antigravity / others | [`.agents/skills/`](.agents/skills/) + [`AGENTS.md`](AGENTS.md) |

| Skill | Role |
|-------|------|
| [`faa-maintain`](skills/faa-maintain/SKILL.md) | Anchor refresh; create missing sidecars; update [`FAA/INVENTORY.md`](FAA/INVENTORY.md) |
| [`faa-semi-informalize`](skills/faa-semi-informalize/SKILL.md) | Write/refresh Fitch sidecar |
| [`faa-compare`](skills/faa-compare/SKILL.md) | Read-only Lean ↔ sidecar audit |
| [`faa-hammer`](skills/faa-hammer/SKILL.md) | One milestone claim → lean4-skills |
| [`faa-formalize`](skills/faa-formalize/SKILL.md) | All `sorry`s in one `FAA/**/*.lean` file |

### Lean LSP and lean4-skills

Install in the agent host; **not** vendored in this repo (both are public, single-click installs — no sister checkouts needed):

- [Lean LSP MCP](https://github.com/oOo0oOo/lean-lsp-mcp)
- [lean4-skills](https://github.com/cameronfreer/lean4-skills)

#### Verify the agent stack (for coauthors)

After installing, run `lake build` once (the LSP needs built dependencies), then:

| Check | How | Expected |
|-------|-----|----------|
| Lean LSP MCP | Ask the agent to call `lean_diagnostic_messages` on `FAA/Basic.lean`, or check the host's MCP server list for `lean-lsp` | Returns diagnostics (an empty list on a clean file) |
| lean4-skills | Ask the agent to run the **diagnose** workflow — `/lean4:diagnose` where the host registers commands (Claude Code, Codex); in Devin/Cursor ask for the `lean4` *skill* and the `diagnose` workflow by name | Reports each capability — Lean/Lake, Python, scripts path, LSP MCP — and flags what is missing |
| lean4-skills scripts | `echo "$LEAN4_SCRIPTS"` (or `command -v lean4-skills-sorry-analyzer`) in a shell | Prints a path |

Everything works without the MCP — it is just slower (`lake env lean` instead of live diagnostics). Without lean4-skills, the `faa-*` skills in this repo fall back to manual prove workflows.

## Then open

| If you need | Open |
|-------------|------|
| Milestones | [`MILESTONES.md`](MILESTONES.md) |
| Module inventory | [`FAA/INVENTORY.md`](FAA/INVENTORY.md) (format: [`docs/lean-sidecar-policy.md`](docs/lean-sidecar-policy.md) § Inventory) |
| Sidecar policy | [`docs/lean-sidecar-policy.md`](docs/lean-sidecar-policy.md) |
| Terminology / naming | [`docs/rosetta.md`](docs/rosetta.md) |
| Cursor rules | [`.cursor/rules/`](.cursor/rules/) |
