-- Sidecar: FAA/Isomorphisms.md
/-
Copyright (c) 2026 Formalizing-Abstract-Algebra contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Formalizing-Abstract-Algebra contributors
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.GroupTheory.GroupAction.Basic
import Mathlib.GroupTheory.SpecificGroups.Cyclic

/-!
# Isomorphisms

Judson, *Abstract Algebra: Theory and Applications*, Chapter 9:
isomorphisms, cyclic group classification, Cayley's theorem, and direct products.

## Statements

- Judson 9.1.6 (properties of isomorphisms): `map_one'`, `map_inv'`, `map_zpow'`,
  `orderOf_map`
- Judson 9.1.7–9 (classification of cyclic groups): `exists_mulEquiv_multiplicative_int`,
  `exists_mulEquiv_zmod_of_isCyclic`, `exists_mulEquiv_zmod_of_prime_card`
- Judson 9.1.12 (Cayley): `cayley`
- Judson 9.2.1 / 9.2.5 (direct products): `prod_group`, `orderOf_prod`
- Judson 9.2.9 (`ℤₘ × ℤₙ ≅ ℤ_{mn}` iff coprime): `zmod_prod_addEquiv_zmod`
-/

namespace AATA

variable {G H : Type*} [Group G] [Group H]

section Isomorphisms

/-- **Judson 9.1.6(1).** An isomorphism maps the identity to the identity. -/
theorem map_one' (f : G ≃* H) : f 1 = 1 :=
  map_one f

/-- **Judson 9.1.6(2).** `f (g⁻¹) = (f g)⁻¹`. -/
theorem map_inv' (f : G ≃* H) (g : G) : f g⁻¹ = (f g)⁻¹ :=
  map_inv f g

/-- **Judson 9.1.6(3).** `f (g ^ n) = (f g) ^ n` for `n : ℤ`. -/
theorem map_zpow' (f : G ≃* H) (g : G) (n : ℤ) : f (g ^ n) = f g ^ n :=
  map_zpow f g n

/-- **Judson 9.1.6(5).** Isomorphisms preserve the order of an element. -/
theorem orderOf_map (f : G ≃* H) (g : G) : orderOf (f g) = orderOf g :=
  orderOf_injective f.toMonoidHom f.injective g

/-- **Judson 9.1.7.** Every infinite cyclic group is isomorphic to `ℤ`. -/
theorem exists_mulEquiv_multiplicative_int [IsCyclic G] [Infinite G] :
    Nonempty (G ≃* Multiplicative ℤ) :=
  let ⟨g, hg⟩ := isCyclic_iff_exists_zpowers_eq_top.mp inferInstance
  ⟨(intEquivOfZPowersEqTop g hg).symm⟩

/-- **Judson 9.1.8.** Every cyclic group of order `n` is isomorphic to `ℤₙ`. -/
theorem exists_mulEquiv_zmod_of_isCyclic [IsCyclic G] {n : ℕ} (h : Nat.card G = n) :
    Nonempty (Multiplicative (ZMod n) ≃* G) :=
  ⟨h ▸ zmodCyclicMulEquiv inferInstance⟩

/-- **Judson 9.1.9.** Every group of prime order `p` is isomorphic to `ℤₚ`. -/
theorem exists_mulEquiv_zmod_of_prime_card {p : ℕ} [Fact p.Prime] (h : Nat.card G = p) :
    Nonempty (Multiplicative (ZMod p) ≃* G) :=
  ⟨h ▸ zmodCyclicMulEquiv (isCyclic_of_prime_card h)⟩

/-- **Judson 9.1.12** (Cayley). Every group embeds into its own permutation group. -/
theorem cayley : ∃ φ : G →* Equiv.Perm G, Function.Injective φ :=
  ⟨MulAction.toPermHom G G, fun g h e ↦ by
    have key := DFunLike.congr_fun e 1
    simpa [MulAction.toPermHom, smul_eq_mul] using key⟩

end Isomorphisms

section DirectProducts

/-- **Judson 9.2.1.** The direct product of two groups is a group. -/
abbrev prod_group : Group (G × H) := inferInstance

/-- **Judson 9.2.5.** `orderOf (a, b) = lcm (orderOf a) (orderOf b)`. -/
theorem orderOf_prod (a : G) (b : H) : orderOf (a, b) = Nat.lcm (orderOf a) (orderOf b) :=
  Prod.orderOf_mk

set_option linter.style.haveILetI false in
/-- **Judson 9.2.9.** `ℤₘ × ℤₙ ≅ ℤ_{m * n}` as additive groups iff `gcd m n = 1`. -/
theorem zmod_prod_addEquiv_zmod {m n : ℕ} [NeZero m] [NeZero n] :
    Nonempty (ZMod m × ZMod n ≃+ ZMod (m * n)) ↔ m.Coprime n := by
  constructor
  · rintro ⟨e⟩
    haveI : IsAddCyclic (ZMod m × ZMod n) :=
      isAddCyclic_of_surjective e.symm.toAddMonoidHom e.symm.surjective
    have key := coprime_card_of_isAddCyclic_prod (ZMod m) (ZMod n)
    rwa [Nat.card_zmod, Nat.card_zmod] at key
  · intro h
    exact ⟨(ZMod.chineseRemainder h).toAddEquiv.symm⟩

end DirectProducts

end AATA
