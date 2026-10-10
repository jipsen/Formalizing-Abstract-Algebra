-- Sidecar: FAA/Cosets.md
/-
Copyright (c) 2026 Formalizing-Abstract-Algebra contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Formalizing-Abstract-Algebra contributors
-/
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Data.Nat.Totient
import Mathlib.GroupTheory.Coset.Basic
import Mathlib.GroupTheory.Coset.Card
import Mathlib.GroupTheory.Index
import Mathlib.GroupTheory.Perm.Cycle.Type

/-!
# Cosets and Lagrange's Theorem

Judson, *Abstract Algebra: Theory and Applications*, Chapter 6:
cosets, Lagrange's theorem, and its corollaries (Euler, Fermat).

## Statements

- Judson 6.1.4 (cosets partition the group): `leftCoset_eq_or_disjoint`
- Judson 6.1.8 / 6.2.2 (Lagrange): `index_mul_card'`, `lagrange`
- Judson 6.2.3–4 (orders, prime order): `orderOf_dvd_card`, `isCyclic_of_prime_card'`,
  `orderOf_eq_card_of_prime_card`
- Judson 6.2.8 (conjugation preserves cycle type): `isConj_iff_cycleType_eq'`
- Judson 6.3.1–3 (Euler and Fermat): `card_units_eq_totient`, `euler`, `fermat`
-/

open scoped Pointwise

namespace AATA

variable {G : Type*} [Group G]

/-- **Judson 6.1.4.** Two left cosets are equal or disjoint. -/
theorem leftCoset_eq_or_disjoint (H : Subgroup G) (x y : G) :
    x • (H : Set G) = y • (H : Set G) ∨
      Disjoint (x • (H : Set G)) (y • (H : Set G)) := by
  rw [or_iff_not_imp_right, Set.not_disjoint_iff]
  rintro ⟨z, hz₁, hz₂⟩
  obtain ⟨h₁, hh₁, rfl⟩ := Set.mem_smul_set.mp hz₁
  obtain ⟨h₂, hh₂, hz₂⟩ := Set.mem_smul_set.mp hz₂
  simp only [smul_eq_mul] at hz₂
  rw [leftCoset_eq_iff]
  have key : x⁻¹ * y = h₁ * h₂⁻¹ := by
    calc x⁻¹ * y = x⁻¹ * (y * h₂ * h₂⁻¹) := by rw [mul_inv_cancel_right]
      _ = x⁻¹ * (x * h₁ * h₂⁻¹) := by rw [hz₂]
      _ = h₁ * h₂⁻¹ := by rw [mul_assoc, inv_mul_cancel_left]
  rw [key]
  exact H.mul_mem hh₁ (H.inv_mem hh₂)

/-- **Judson 6.1.8 / 6.2.2** (Lagrange, index form). `|G| = [G : H] · |H|`. -/
theorem index_mul_card' (H : Subgroup G) : H.index * Nat.card H = Nat.card G :=
  H.index_mul_card

/-- **Judson 6.2.2** (Lagrange). The order of a subgroup divides the order of the group. -/
theorem lagrange (H : Subgroup G) : Nat.card H ∣ Nat.card G :=
  H.card_subgroup_dvd_card

/-- **Judson 6.2.3.** The order of an element divides the order of the group. -/
theorem orderOf_dvd_card (g : G) : orderOf g ∣ Nat.card G :=
  orderOf_dvd_natCard g

/-- **Judson 6.2.4.** A group of prime order is cyclic. -/
theorem isCyclic_of_prime_card' {p : ℕ} [Fact p.Prime] (h : Nat.card G = p) : IsCyclic G :=
  isCyclic_of_prime_card h

/-- **Judson 6.2.4.** Every nonidentity element of a prime-order group has order `|G|`. -/
theorem orderOf_eq_card_of_prime_card {p : ℕ} [Fact p.Prime] (h : Nat.card G = p) {g : G}
    (hg : g ≠ 1) : orderOf g = Nat.card G := by
  have hd := orderOf_dvd_natCard g
  rw [h] at hd
  rcases (Nat.dvd_prime (Fact.out : p.Prime)).1 hd with h1 | h1
  · exact absurd (orderOf_eq_one_iff.1 h1) hg
  · rwa [h]

/-- **Judson 6.2.8.** Permutations are conjugate if and only if they have the same cycle type. -/
theorem isConj_iff_cycleType_eq' {α : Type*} [DecidableEq α] [Fintype α]
    {σ τ : Equiv.Perm α} : IsConj σ τ ↔ σ.cycleType = τ.cycleType :=
  Equiv.Perm.isConj_iff_cycleType_eq

/-- **Judson 6.3.1.** `U(n)` has `φ n` elements. -/
theorem card_units_eq_totient (n : ℕ) [NeZero n] : Fintype.card (ZMod n)ˣ = n.totient :=
  ZMod.card_units_eq_totient n

/-- **Judson 6.3.2** (Euler). `x ^ φ n ≡ 1 (mod n)` whenever `gcd x n = 1`. -/
theorem euler {x n : ℕ} (h : x.Coprime n) : x ^ n.totient ≡ 1 [MOD n] :=
  Nat.ModEq.pow_totient h

/-- **Judson 6.3.3** (Fermat's little theorem). `a ^ p = a` in `ℤₚ` for prime `p`. -/
theorem fermat {p : ℕ} [Fact p.Prime] (a : ZMod p) : a ^ p = a :=
  ZMod.pow_card a

end AATA
