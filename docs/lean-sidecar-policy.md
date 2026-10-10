# Lean sidecar policy (FAA)

**Canonical policy:** [`quantale-enriched-foundations/docs/lean-sidecar-policy.md`](../../quantale-enriched-foundations/docs/lean-sidecar-policy.md) (sister checkout; on GitHub: [alexhkurz/quantale-enriched-foundations](https://github.com/alexhkurz/quantale-enriched-foundations/blob/main/docs/lean-sidecar-policy.md)) — applies to `FAA/**/*.lean` with the deltas below.

Every public `FAA/**/*.lean` has a Fitch companion `*.md`; the sidecar is a parallel reading surface — math names local to each file, Lean names global — not curriculum. What follows is only what differs in this repo.

## FAA deltas

**Pairing.** `FAA/Foo.lean` ↔ `FAA/Foo.md`; `FAA.lean` (imports only) ↔ `FAA.md` (short index). Nested: `FAA/Group/Bar.lean` ↔ `FAA/Group/Bar.md`.

**Skills.** `faa-semi-informalize` writes/refreshes sidecars; `faa-maintain` runs upkeep ([`scripts/refresh-sidecar-anchors.py`](../scripts/refresh-sidecar-anchors.py)) and keeps [`FAA/INVENTORY.md`](../FAA/INVENTORY.md) in date; `faa-compare` audits read-only; `faa-hammer` / `faa-formalize` must run maintain (+ semi-informalize when proofs changed) on touched files. After editing `.lean`, run **faa-maintain**:

```bash
python3 scripts/refresh-sidecar-anchors.py FAA/Foo.lean
```

**Notation.** Per [`docs/rosetta.md`](rosetta.md) once terminology settles; KaTeX-safe only.

**Mathlib-first.** Abstract algebra is dense in Mathlib. Sidecars state the mathematics of what `FAA` adds; a file that mostly instantiates Mathlib classes may legitimately have thin `*Remark:*` sections.

**Formalisation artefacts.** Flag definition-versus-predicate bookkeeping in the `.lean` docstring; the sidecar uses `*Remark:*` instead of `*Proof:*` (canonical policy § What the sidecar must contain).
