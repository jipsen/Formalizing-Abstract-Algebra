# Milestones

[`README.md`](README.md). Tree: [`FAA/INVENTORY.md`](FAA/INVENTORY.md).

Mathlib `v4.33.1`. Source text / syllabus: Thomas W. Judson, *Abstract Algebra: Theory and Applications* (ed. 2026-08-04) — [`bibliography/aata-20260811.pdf`](bibliography/aata-20260811.pdf) / `aata-20260811.txt`. The book numbers results `Thm ch.sec.item` (e.g. `Theorem 6.2.2`, Lagrange).

## Conventions

- One `FAA/<Topic>.lean` module per chapter (or per section cluster when a chapter is large); topic names follow [`docs/rosetta.md`](docs/rosetta.md).
- Every milestone claim carries a book anchor in a comment: `-- aata Thm 6.2.2` (or `-- aata §6.2` for unnumbered statements). The Fitch sidecar mirrors the anchor.
- Mathlib-first: a claim proved by reduction to Mathlib API counts as formalized; the milestone is the anchored statement compiling sorry-free with standard axioms.
- A chapter milestone is **done** when its landmark claims below are proved, key definitions/examples needed to state them exist, the sidecar is in sync, and `faa-maintain` has run (anchors + `FAA/INVENTORY.md`).
- Out of scope: reading questions, Sage/sage-cell content, programming exercises. End-of-chapter exercises are stretch items, added per chapter on demand.

## Phase 0 — setup

Lake/Mathlib pinned, agent skills and rules installed, `FAA/Basic.lean` charter file. *(done)*

## Phase 1 — Preliminaries and the integers (aata ch 1–2)

Foundation + pipeline shakedown on material Mathlib covers completely.

- **Ch 1 Preliminaries.** Sets and functions (injective/surjective/bijective), equivalence relations ↔ partitions, congruence mod *n* (`Int.ModEq`). Landmark: the equivalence-class/partition correspondence (§1.2). *(done — [`FAA/Preliminaries.lean`](FAA/Preliminaries.md))*
- **Ch 2 The Integers.** Well-ordering and induction, division algorithm, gcd and the Euclidean algorithm, prime numbers, Euclid's lemma, **Fundamental Theorem of Arithmetic** (`Thm 2.2.7`; Mathlib `UniqueFactorizationMonoid`/`Nat.factorization`). Stretch: Chinese remainder theorem from the exercises.

## Phase 2 — Groups: first properties (aata ch 3–6)

The core of every later phase.

- **Ch 3 Groups.** Group axioms and examples (`ZMod n`, `U(n)` = `(ZMod n)ˣ`, symmetries of the triangle), cancellation, subgroup criteria (one-step / two-step / finite), powers of an element. Mathlib `Group`, `Subgroup`.
- **Ch 4 Cyclic Groups.** Cyclic subgroups, `orderOf`, **every subgroup of a cyclic group is cyclic**, generators of `ZMod n` (count = φ(n)), roots of unity in ℂ. Mathlib `IsCyclic`, `orderOf`, `Nat.totient`.
- **Ch 5 Permutation Groups.** `Equiv.Perm`/`Equiv.Perm.sign`, cycle decomposition, transpositions, parity, alternating group `alternatingGroup`, dihedral groups `DihedralGroup`. Landmarks: `sign` is a homomorphism to {±1}; |A_n| = n!/2.
- **Ch 6 Cosets and Lagrange's Theorem.** Cosets, index, **Lagrange's theorem** (`Thm 6.2.2`), corollaries: order of an element divides |G|, groups of prime order are cyclic, **Fermat's little theorem** and **Euler's theorem** as corollaries.

## Phase 3 — Group theory: homomorphisms and structure (aata ch 9–15)

Book order is 9, 10, 11, 12, 13, 14, 15; dependencies allow 14–15 to follow 11.

- **Ch 9 Isomorphisms.** Isomorphism properties (order/abelian/cyclic preserved), **Cayley's theorem** — every group embeds in `Equiv.Perm G` — direct products `G × H`.
- **Ch 10 Normal Subgroups and Factor Groups.** Normality criteria (`Subgroup.Normal`), quotient groups `G ⧸ N`, **simplicity of A_n for n ≥ 5** (heavy lift — stage it; §10.2 is the proof via 3-cycles).
- **Ch 11 Homomorphisms.** Kernels and images, **first, second, third isomorphism theorems** (`Thm 11.2.1`, `11.2.3`, `11.2.5`; Mathlib `QuotientGroup.*`/`Submodule.quotientInf*` analogues).
- **Ch 12 Matrix Groups and Symmetry.** `Matrix.GeneralLinearGroup`, `Matrix.SpecialLinearGroup`, `Matrix.orthogonalGroup`, symmetry groups of solids. Light coverage: definitions plus selected results, e.g. O(n) structure.
- **Ch 13 The Structure of Groups.** **Fundamental theorem of finite abelian groups** (`Thm 13.1.4`) and of finitely generated abelian groups (`Thm 13.1.10`, via Mathlib's PID structure theorem), solvable groups `IsSolvable`, commutator/derived series, `S_n` not solvable for n ≥ 5 (link to A_n simplicity).
- **Ch 14 Group Actions.** `MulAction`, orbits and stabilizers, **orbit–stabilizer theorem**, the class equation, **Burnside's counting theorem** (§14.3).
- **Ch 15 The Sylow Theorems.** **Sylow I/II/III** (existence, conjugacy, counting mod p) via Mathlib `Sylow`; applications: groups of order pq, p², and non-simplicity results from §15.2.

## Phase 4 — Rings and polynomials (aata ch 16–18)

- **Ch 16 Rings.** Ring axioms, integral domains and fields, characteristic, ring homomorphisms, ideals and quotient rings, **prime and maximal ideals** (`Ideal.IsPrime`, `Ideal.IsMaximal`; maximal ⇒ prime; `R ⧸ I` field iff `I` maximal in a commutative ring with 1).
- **Ch 17 Polynomials.** `Polynomial R`, division algorithm, factor theorem/root theorem, irreducible polynomials, **Eisenstein's criterion**, irreducibility over ℚ vs ℤ (Gauss-lemma direction).
- **Ch 18 Integral Domains.** Fields of fractions (`IsFractionRing`), PIDs and UFDs, Euclidean domains, **ED ⇒ PID ⇒ UFD** (`Thm 18.2.14`, `Cor 18.2.15`).

## Phase 5 — Lattices and Boolean algebras (aata ch 19)

Independent of ch 16–18; can be scheduled any time after Phase 4.

- **Ch 19 Lattices and Boolean Algebras.** Lattices as posets vs algebras (`Lattice`, `DistribLattice`), Boolean algebras (`BooleanAlgebra`), atoms, **finite Boolean algebras ≅ powersets** (representation theorem), §19.3 electrical circuits as an optional application.

## Phase 6 — Vector spaces and fields (aata ch 20–22)

- **Ch 20 Vector Spaces.** `Module`/`Basis`/`FiniteDimensional`: subspaces, linear independence, bases, dimension. Mostly API-mapping; thin chapter.
- **Ch 21 Fields.** Extension fields, algebraic vs transcendental elements, minimal polynomial `minpoly`, tower law [E:F] = [E:K][K:F], **existence and uniqueness of splitting fields** (`IsSplittingField`), §21.3 geometric constructions — doubling the cube / trisecting the angle as stretch goals.
- **Ch 22 Finite Fields.** **Existence and uniqueness of GF(p^n)** (`GaloisField`/`FiniteField`), multiplicative group of a finite field is cyclic, §22.2 polynomial codes (optional, links back to ch 8).

## Phase 7 — Galois theory (aata ch 23) — capstone

- **Ch 23 Galois Theory.** `Aut(E/F)` / Galois groups (`IsGalois`, `IsGalois.fixedField`), the correspondence between intermediate fields and subgroups, **Fundamental Theorem of Galois Theory** (`IsGalois.intermediateFieldEquivSubgroup`), applications: solvability by radicals and **insolvability of the general quintic** (Mathlib `AbelRuffini`).

## Track A — applications (parallel, optional)

Depends only on Phase 2; can run alongside any phase. Both chapters need genuine new definitions rather than Mathlib instantiation.

- **Ch 7 Introduction to Cryptography.** Private-key ciphers, **RSA correctness** from Euler's theorem (§7.2), message verification.
- **Ch 8 Algebraic Coding Theory.** Hamming distance/weight, error detection/correction bounds, linear codes, generator and parity-check matrices, syndrome/coset decoding, the Hamming (7,4) code.

## Open decisions

- Exercise policy: which end-of-chapter exercises to curate per chapter (the back matter has solutions — good `faa-hammer` targets).
- `FAA/<Topic>` naming per chapter — settle in [`docs/rosetta.md`](docs/rosetta.md) when Phase 1 lands.
- Depth for ch 12 (matrix groups/symmetry) and §19.3, §22.2 (applied sections).
- Whether Phase 1–2 files re-export Mathlib statements verbatim where the book matches Mathlib exactly, or restate in the book's language (recommended: book's language, proof = `mathlib lemma`).
