-- Sidecar: FAA/Permutations.md
/-
Copyright (c) 2026 Formalizing-Abstract-Algebra contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Formalizing-Abstract-Algebra contributors
-/
import Mathlib.Data.Fintype.Perm
import Mathlib.GroupTheory.Perm.Sign
import Mathlib.GroupTheory.SpecificGroups.Alternating
import Mathlib.GroupTheory.SpecificGroups.Dihedral

/-!
# Permutation Groups

Judson, *Abstract Algebra: Theory and Applications*, Chapter 5:
permutation groups, cycles, the alternating group, and dihedral groups.

## Statements

- Judson 5.1.1 (`|Sₙ|`): `card_perm'`
- Judson 5.1.8–9 (disjoint cycles): `disjoint_commute`,
  `cycleFactorsFinset_prod`, `cycleFactorsFinset_pairwise_disjoint'`
- Judson 5.1.14–17 (sign and `Aₙ`): `sign_mul'`, `sign_swap'`,
  `alternatingGroup_is_sign_ker`, `mem_alternatingGroup'`, `card_alternatingGroup'`
- Judson 5.2.2–3 (dihedral groups): `dihedralGroup_card`, `dihedral_r_mul_r`,
  `dihedral_sr_mul_r`, `dihedral_reflection_conjugate`, `dihedral_orderOf_r_one`
-/

namespace AATA

variable {α : Type*} [DecidableEq α] [Fintype α]

/-- **Judson 5.1.1.** The symmetric group on `n` letters has `n!` elements. -/
theorem card_perm' : Fintype.card (Equiv.Perm α) = Nat.factorial (Fintype.card α) :=
  Fintype.card_perm

omit [DecidableEq α] [Fintype α] in
/-- **Judson 5.1.8.** Disjoint permutations commute. -/
theorem disjoint_commute {f g : Equiv.Perm α} (h : Equiv.Perm.Disjoint f g) : Commute f g :=
  h.commute

/-- **Judson 5.1.9.** Every permutation is the product of its cycle factors. -/
theorem cycleFactorsFinset_prod (f : Equiv.Perm α) :
    f.cycleFactorsFinset.noncommProd id (Equiv.Perm.cycleFactorsFinset_mem_commute f) = f :=
  f.cycleFactorsFinset_noncommProd

/-- **Judson 5.1.9.** The cycle factors of a permutation are pairwise disjoint. -/
theorem cycleFactorsFinset_pairwise_disjoint' (f : Equiv.Perm α) :
    (f.cycleFactorsFinset : Set (Equiv.Perm α)).Pairwise Equiv.Perm.Disjoint :=
  f.cycleFactorsFinset_pairwise_disjoint

/-- **Judson 5.1.14.** The sign map is a group homomorphism. -/
theorem sign_mul' (f g : Equiv.Perm α) :
    Equiv.Perm.sign (f * g) = Equiv.Perm.sign f * Equiv.Perm.sign g :=
  map_mul Equiv.Perm.sign f g

/-- **Judson 5.1.14.** A transposition has sign `-1`. -/
theorem sign_swap' {x y : α} (h : x ≠ y) : Equiv.Perm.sign (Equiv.swap x y) = -1 :=
  Equiv.Perm.sign_swap h

/-- **Judson 5.1.16.** `Aₙ` is the kernel of the sign homomorphism. -/
theorem alternatingGroup_is_sign_ker : alternatingGroup α = Equiv.Perm.sign.ker :=
  alternatingGroup_eq_sign_ker

/-- **Judson 5.1.16.** `f ∈ Aₙ` if and only if `f` is an even permutation. -/
theorem mem_alternatingGroup' (f : Equiv.Perm α) :
    f ∈ alternatingGroup α ↔ Equiv.Perm.sign f = 1 :=
  Equiv.Perm.mem_alternatingGroup

/-- **Judson 5.1.17.** `Aₙ` has `n! / 2` elements for `n ≥ 2`. -/
theorem card_alternatingGroup' [Nontrivial α] :
    Fintype.card (alternatingGroup α) = Nat.factorial (Fintype.card α) / 2 :=
  card_alternatingGroup

/-- **Judson 5.2.2.** The dihedral group `Dₙ` has `2n` elements. -/
theorem dihedralGroup_card (n : ℕ) [NeZero n] :
    Fintype.card (DihedralGroup n) = 2 * n :=
  DihedralGroup.card

/-- **Judson 5.2.3.** Rotations in `Dₙ` multiply by addition of indices modulo `n`. -/
theorem dihedral_r_mul_r (n : ℕ) (i j : ZMod n) :
    DihedralGroup.r i * DihedralGroup.r j = DihedralGroup.r (i + j) :=
  DihedralGroup.r_mul_r i j

/-- **Judson 5.2.3.** `s rᵢ · rⱼ = s r_{i+j}`: a reflection times a rotation is a reflection. -/
theorem dihedral_sr_mul_r (n : ℕ) (i j : ZMod n) :
    DihedralGroup.sr i * DihedralGroup.r j = DihedralGroup.sr (i + j) :=
  DihedralGroup.sr_mul_r i j

/-- **Judson 5.2.3.** Conjugating a rotation by a reflection inverts it: `s r s = r⁻¹`. -/
theorem dihedral_reflection_conjugate (n : ℕ) (i : ZMod n) :
    DihedralGroup.sr 0 * DihedralGroup.r i * DihedralGroup.sr 0 = DihedralGroup.r (-i) := by
  rw [DihedralGroup.sr_mul_r, DihedralGroup.sr_mul_sr, zero_add, zero_sub]

/-- **Judson 5.2.3.** A single-step rotation `r` has order `n` in `Dₙ`. -/
theorem dihedral_orderOf_r_one (n : ℕ) : orderOf (DihedralGroup.r 1 : DihedralGroup n) = n :=
  DihedralGroup.orderOf_r_one

end AATA
