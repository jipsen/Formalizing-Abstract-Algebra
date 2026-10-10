# Log

## 2026-10-10 — Phase 1 scaffolding (AATA Ch 1–2)

- Wrote autoformalization outline into `MILESTONES.md` (Phases 0–6 + applications track), Judson as source text.
- Created `FAA/Preliminaries.lean` (Judson 1.2.3–1.2.26): compiles clean via `lake env lean`.
- Created `FAA/Integers.lean` (Judson 2.1.1–2.2.7): first compile showed 4 errors — shadowed `hk` binder in `induction_principle`, unknown `Int.ediv_add_emod`, cascading `rintro` failure, and `~` (`List.Perm`) notation not parsing; fixes in progress.
- Added `faa-log` skill (canonical `skills/faa-log/SKILL.md` + thin wrappers in `.devin/`, `.cursor/`, `.agents/`).
- Fixed `Integers.lean`: `ediv_add_emod` → `mul_ediv_add_emod` (core rename), `l ~ l'` → `List.Perm` (scoped notation), renamed shadowed binder, `_n` for linter, restructured uniqueness step via `have key`. Both files now compile clean.
- Wrote Fitch sidecars `FAA/Preliminaries.md`, `FAA/Integers.md`; updated `FAA.lean` imports, `FAA.md` index, `FAA/INVENTORY.md`, `docs/rosetta.md` concept table (AATA ↔ Mathlib ↔ Lean rows).
- Ran `refresh-sidecar-anchors.py` (anchors current); trimmed docstrings >100 chars flagged by `longLine` linter. `lake build` clean, no warnings.
- KaTeX mandate added to skills: `faa-semi-informalize` (write path), `faa-maintain` (§4 coverage entries), `faa-compare` (§8 audit spot-check).
- KaTeX pass on sidecars: replaced non-built-ins `\gcdA`/`\gcdB` with `Int.gcdA`/`Int.gcdB` code refs, `a\%b` → `a \bmod b`, `\operatorname{sInf}` → `\inf`; `ED ⇒ PID ⇒ UFD` → `$\mathrm{ED} \Rightarrow \mathrm{PID} \Rightarrow \mathrm{UFD}$` in `MILESTONES.md`. `Preliminaries.md` was already clean.

## 2026-10-10 — Phase 2: group theory core (AATA Ch 3–6, 9–11)

- Created seven chapter-aligned modules: `FAA/Groups.lean` (Ch 3), `FAA/Cyclic.lean` (Ch 4), `FAA/Permutations.lean` (Ch 5), `FAA/Cosets.lean` (Ch 6), `FAA/Isomorphisms.lean` (Ch 9), `FAA/NormalSubgroups.lean` (Ch 10), `FAA/Homomorphisms.lean` (Ch 11). All Mathlib-first: capstones are `lagrange`, `euler`, `fermat`, `cayley`, `zmod_prod_addEquiv_zmod`, `alternatingGroup_five_simple`, `third_isomorphism`.
- Fixes along the way: `zpow_mul'` argument order (it gives `a^(n·m) = (a^m)^n`); `conj_mem'` is the `g⁻¹ng` accessor while the `Normal` field is `gng⁻¹`; `orderOf_pow` needs `[Finite G]`; `coprime_card_of_isAddCyclic_prod` takes `M N` explicitly + `Finite`; `ZMod.pow_card` (not bare `pow_card`); coset lemmas `leftCoset_eq_iff`/`normal_iff_eq_cosets` are root-namespace under `open scoped Pointwise`; `n!` notation unavailable — used `Nat.factorial`; `MonoidHom.comap_bot` (not `Subgroup.`); class-valued decls moved to `abbrev` for the reducibility linter.
- Wrote seven KaTeX-friendly Fitch sidecars; refreshed anchors; updated `FAA.lean`, `FAA.md`, `FAA/INVENTORY.md`, `docs/rosetta.md`.
