# Milestones

[`README.md`](README.md). Tree: [`FAA/INVENTORY.md`](FAA/INVENTORY.md).

Mathlib `v4.33.1`. Source text: T. W. Judson, *Abstract Algebra: Theory and Applications* ([`bibliography/aata-20260811.txt`](bibliography/aata-20260811.txt), 23 chapters).

## Phase 0 — setup (done)

Lake/Mathlib pinned, agent skills and rules installed.

## Phase 1 — foundations (AATA Ch 1–2)

Sets, mappings, equivalence relations and partitions (`FAA/Preliminaries.lean`); induction, well-ordering, division algorithm, gcd/Bezout, Euclid's lemma, infinitude of primes, fundamental theorem of arithmetic (`FAA/Integers.lean`). Bootstrap the `docs/rosetta.md` concept table.

Capstones: division algorithm; Bezout; fundamental theorem of arithmetic.

## Phase 2 — group theory core (Ch 3–6, 9–11)

Groups and subgroups (`Group`, `Subgroup`); cyclic groups (`IsCyclic`, `orderOf`); permutation and dihedral groups (`Equiv.Perm`, `Perm.sign`, `DihedralGroup`); cosets and Lagrange's theorem; Fermat/Euler; Cayley; isomorphisms and direct products (`≃*`, `MulEquiv`, `DirectProduct`); normal subgroups and factor groups (`Subgroup.Normal`, `QuotientGroup`); homomorphisms and the isomorphism theorems (`QuotientGroup.quotientKerEquivRange`); simplicity of $A_n$ for $n \geq 5$.

Capstones: Lagrange's theorem; Cayley's theorem; isomorphism theorems; $A_n$ simple ($n \geq 5$).

## Phase 3 — rings (Ch 16–18)

Rings, ideals, ring homomorphisms (`Ring`, `Ideal`, `RingHom`, `Ideal.Quotient`); maximal and prime ideals ($R/I$ field iff $I$ maximal, domain iff prime); polynomial rings and the division algorithm (`Polynomial`, `EuclideanDomain`); irreducibility (Eisenstein, Gauss's lemma); fields of fractions (`FractionRing`); $\mathrm{ED} \Rightarrow \mathrm{PID} \Rightarrow \mathrm{UFD}$.

Capstones: $R/I$ field iff $I$ maximal; Eisenstein's criterion; field of fractions; $\mathrm{ED} \Rightarrow \mathrm{PID} \Rightarrow \mathrm{UFD}$.

## Phase 4 — deeper group theory (Ch 12–15)

Matrix groups and symmetry (`Matrix.GeneralLinearGroup`, `SpecialLinearGroup`, `OrthogonalGroup`); group actions, orbits, stabilizers, class equation (`MulAction`); Burnside's counting theorem; fundamental theorem of finite abelian groups; solvable groups (`IsSolvable`, derived series); the Sylow theorems (`Sylow`).

Capstones: Burnside; fundamental theorem of finite abelian groups; Sylow's theorems.

## Phase 5 — vector spaces and fields (Ch 19–21)

Lattices and Boolean algebras (`Lattice`, `DistribLattice`, `BooleanAlgebra`) — overlap with sister projects noted in the workspace rule; vector spaces (`Module`, `LinearIndependent`, `Basis`, `finrank`); extension fields (`IntermediateField`, `IsAlgebraic`); splitting fields (`SplittingField`); geometric constructions (doubling the cube, trisection — likely genuinely new formalization).

Capstones: dimension theory; existence and uniqueness of splitting fields; impossibility of the classical constructions.

## Phase 6 — finite fields and Galois theory (Ch 22–23)

Structure of finite fields (`GaloisField`, `FiniteField`); existence and uniqueness of $GF(p^n)$; multiplicative group cyclic; field automorphisms (`IsGalois`); the fundamental theorem of Galois theory (`IsGalois.autEquivIntermediateField`); insolvability of the quintic (`Mathlib.FieldTheory.AbelRuffini`, `solvableByRad` — glue may be needed).

Capstones: $GF(p^n)$ exists and is unique; fundamental theorem of Galois theory; quintic insolvability.

## Applications track — optional, higher effort (Ch 7–8, 22.2)

Cryptography: RSA is not a Mathlib protocol — new `FAA` definitions over `ZMod`; correctness from Euler's theorem (Phase 2). Coding theory: Mathlib has Hamming distance but little linear-code theory — new formalization: linear codes as `Submodule`s, generator/parity-check matrices, syndrome decoding; BCH codes stretch goal.

## Workflow (every phase)

Extract claims from `bibliography/aata-20260811.txt`; add `docs/rosetta.md` rows before naming; skeleton `FAA/**/*.lean` with statements (milestone claims may begin as `sorry`); `/faa-hammer` on capstones, `/faa-formalize` for remaining `sorry`s; `/faa-semi-informalize` then `/faa-maintain` (anchors + `FAA/INVENTORY.md`) then `/faa-compare`; validate `lean_diagnostic_messages` → `lake env lean <file>` → `lake build` at phase checkpoints.
