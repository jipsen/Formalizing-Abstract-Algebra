-- Sidecar: FAA/Cyclic.md
/-
Copyright (c) 2026 Formalizing-Abstract-Algebra contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Formalizing-Abstract-Algebra contributors
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.GroupTheory.SpecificGroups.Cyclic

/-!
# Cyclic Groups

Judson, *Abstract Algebra: Theory and Applications*, Chapter 4:
cyclic subgroups, cyclic groups, and orders of elements.

## Statements

- Judson 4.1.3 (powers form a subgroup): `cyclicSubgroup`, `mem_cyclicSubgroup`
- Judson 4.1.9 (cyclic implies abelian): `commutative_of_isCyclic`
- Judson 4.1.10 (subgroups of cyclic groups): `isCyclic_subgroup`
- Judson 4.1.11–13 (orders): `orderOf_dvd_of_pow_eq_one'`, `orderOf_pow'`
- Judson 4.1.14 (`ℤₙ` cyclic, generators): `zmod_isAddCyclic`,
  `addOrderOf_zmod_eq_iff_coprime`
-/

namespace AATA

variable {G : Type*} [Group G]

/-- **Judson 4.1.3.** The cyclic subgroup `⟨a⟩` of all powers of `a` (`Subgroup.zpowers`). -/
def cyclicSubgroup (a : G) : Subgroup G := Subgroup.zpowers a

/-- **Judson 4.1.3.** `x ∈ ⟨a⟩` if and only if `x = a ^ k` for some `k : ℤ`. -/
theorem mem_cyclicSubgroup {a x : G} : x ∈ cyclicSubgroup a ↔ ∃ k : ℤ, a ^ k = x :=
  Subgroup.mem_zpowers_iff

/-- **Judson 4.1.9.** A cyclic group is abelian. -/
theorem commutative_of_isCyclic [IsCyclic G] (x y : G) : x * y = y * x := by
  obtain ⟨g, hg⟩ := IsCyclic.exists_generator (α := G)
  obtain ⟨m, hm⟩ := Subgroup.mem_zpowers_iff.1 (hg x)
  obtain ⟨n, hn⟩ := Subgroup.mem_zpowers_iff.1 (hg y)
  rw [← hm, ← hn, ← zpow_add, ← zpow_add, add_comm]

/-- **Judson 4.1.10.** Every subgroup of a cyclic group is cyclic. -/
theorem isCyclic_subgroup [IsCyclic G] (H : Subgroup G) : IsCyclic H := inferInstance

/-- **Judson 4.1.11.** If `a ^ n = 1` then `orderOf a` divides `n`. -/
theorem orderOf_dvd_of_pow_eq_one' (a : G) {n : ℕ} (h : a ^ n = 1) : orderOf a ∣ n :=
  orderOf_dvd_of_pow_eq_one h

/-- **Judson 4.1.13.** `orderOf (a ^ k) = orderOf a / gcd (orderOf a) k` for finite `G`. -/
theorem orderOf_pow' (a : G) [Finite G] (k : ℕ) :
    orderOf (a ^ k) = orderOf a / Nat.gcd (orderOf a) k :=
  orderOf_pow a

/-- **Judson 4.1.14.** `ℤₙ` is cyclic under addition. -/
theorem zmod_isAddCyclic (n : ℕ) : IsAddCyclic (ZMod n) := inferInstance

/-- **Judson 4.1.14.** `(k : ℤₙ)` has order `n` (generates `ℤₙ`) iff `gcd k n = 1`. -/
theorem addOrderOf_zmod_eq_iff_coprime {n : ℕ} (hn : n ≠ 0) (k : ℕ) :
    addOrderOf (k : ZMod n) = n ↔ k.Coprime n := by
  rw [ZMod.addOrderOf_coe k hn, Nat.coprime_comm]
  constructor
  · intro h
    have hd : n.gcd k ∣ n := Nat.gcd_dvd_left n k
    have key := Nat.div_mul_cancel hd
    rw [h] at key
    exact Nat.mul_left_cancel (Nat.pos_of_ne_zero hn) (key.trans (mul_one n).symm)
  · intro h
    have h1 : n.gcd k = 1 := h
    rw [h1]
    exact Nat.div_one n

end AATA
