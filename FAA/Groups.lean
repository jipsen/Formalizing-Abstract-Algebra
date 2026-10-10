-- Sidecar: FAA/Groups.md
/-
Copyright (c) 2026 Formalizing-Abstract-Algebra contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Formalizing-Abstract-Algebra contributors
-/
import Mathlib.Algebra.Group.Subgroup.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Group

/-!
# Groups

Judson, *Abstract Algebra: Theory and Applications*, Chapter 3:
groups, elementary properties, and subgroups.

## Statements

- Judson 3.2.10–13 (elementary properties): `exists_unique_id`, `exists_unique_inv`,
  `mul_inv_rev'`, `inv_inv'`
- Judson 3.2.14–15 (equations and cancellation): `exists_unique_mul_right`,
  `exists_unique_mul_left`, `mul_left_cancel'`, `mul_right_cancel'`
- Judson 3.2.16 (laws of exponents): `zpow_add'`, `zpow_pow`
- Judson 3.3.7–8 (subgroup criteria): `subgroup_of_mem_closed`, `subgroup_of_div_closed`
- Judson 3.1.4 / 3.3.9 (`ZMod n` and `U(n)`): `zmod_add_comm_group`, `zmod_isUnit_iff_coprime`
-/

namespace AATA

variable {G : Type*} [Group G]

section ElementaryProperties

/-- **Judson 3.2.10.** The identity of a group is unique. -/
theorem exists_unique_id : ∃! e : G, ∀ g : G, e * g = g ∧ g * e = g :=
  ⟨1, fun _g ↦ ⟨one_mul _, mul_one _⟩, fun _e he ↦ (mul_one _).symm.trans (he 1).1⟩

/-- **Judson 3.2.11.** The inverse of a group element is unique. -/
theorem exists_unique_inv (g : G) : ∃! h : G, g * h = 1 ∧ h * g = 1 :=
  ⟨g⁻¹, ⟨mul_inv_cancel g, inv_mul_cancel g⟩,
    fun _h hh ↦ (inv_eq_of_mul_eq_one_right hh.1).symm⟩

/-- **Judson 3.2.12.** `(a * b)⁻¹ = b⁻¹ * a⁻¹`. -/
theorem mul_inv_rev' (a b : G) : (a * b)⁻¹ = b⁻¹ * a⁻¹ :=
  mul_inv_rev a b

/-- **Judson 3.2.13.** `(a⁻¹)⁻¹ = a`. -/
theorem inv_inv' (a : G) : a⁻¹⁻¹ = a :=
  inv_inv a

/-- **Judson 3.2.14 (a).** The equation `a * x = b` has a unique solution. -/
theorem exists_unique_mul_right (a b : G) : ∃! x : G, a * x = b :=
  ⟨a⁻¹ * b, by group, fun x h ↦ by rw [← h]; group⟩

/-- **Judson 3.2.14 (b).** The equation `x * a = b` has a unique solution. -/
theorem exists_unique_mul_left (a b : G) : ∃! x : G, x * a = b :=
  ⟨b * a⁻¹, by group, fun x h ↦ by rw [← h]; group⟩

/-- **Judson 3.2.15 (a).** Left cancellation holds in a group. -/
theorem mul_left_cancel' {a b c : G} (h : a * b = a * c) : b = c :=
  mul_left_cancel h

/-- **Judson 3.2.15 (b).** Right cancellation holds in a group. -/
theorem mul_right_cancel' {a b c : G} (h : b * a = c * a) : b = c :=
  mul_right_cancel h

/-- **Judson 3.2.16 (a).** `a ^ (m + n) = a ^ m * a ^ n` for integer exponents. -/
theorem zpow_add' (a : G) (m n : ℤ) : a ^ (m + n) = a ^ m * a ^ n :=
  zpow_add a m n

/-- **Judson 3.2.16 (b).** `(a ^ m) ^ n = a ^ (m * n)` for integer exponents. -/
theorem zpow_pow (a : G) (m n : ℤ) : (a ^ m) ^ n = a ^ (m * n) := by
  rw [mul_comm m n]
  exact (zpow_mul' a n m).symm

end ElementaryProperties

section Subgroups

/-- **Judson 3.3.7.** A subset closed under multiplication and inversion is a subgroup. -/
theorem subgroup_of_mem_closed {s : Set G} (h1 : 1 ∈ s)
    (hmul : ∀ a ∈ s, ∀ b ∈ s, a * b ∈ s) (hinv : ∀ a ∈ s, a⁻¹ ∈ s) :
    ∃ H : Subgroup G, (H : Set G) = s :=
  ⟨{ carrier := s, mul_mem' := fun ha hb ↦ hmul _ ha _ hb, one_mem' := h1,
      inv_mem' := fun ha ↦ hinv _ ha }, rfl⟩

/-- **Judson 3.3.8** (one-step subgroup test).
A nonempty subset closed under `a * b⁻¹` is a subgroup. -/
theorem subgroup_of_div_closed {s : Set G} (hne : s.Nonempty)
    (hdiv : ∀ a ∈ s, ∀ b ∈ s, a * b⁻¹ ∈ s) : ∃ H : Subgroup G, (H : Set G) = s := by
  obtain ⟨x, hx⟩ := hne
  have h1 : 1 ∈ s := by
    have h := hdiv x hx x hx
    rwa [mul_inv_cancel] at h
  have hinv : ∀ a ∈ s, a⁻¹ ∈ s := fun a ha ↦ by
    have h := hdiv 1 h1 a ha
    rwa [one_mul] at h
  have hmul : ∀ a ∈ s, ∀ b ∈ s, a * b ∈ s := fun a ha b hb ↦ by
    have h := hdiv a ha b⁻¹ (hinv b hb)
    rwa [inv_inv] at h
  exact subgroup_of_mem_closed h1 hmul hinv

end Subgroups

section Examples

/-- **Judson 3.1.4.** `ℤₙ` is an abelian group under addition modulo `n`. -/
abbrev zmod_add_comm_group (n : ℕ) : AddCommGroup (ZMod n) := inferInstance

/-- **Judson 3.3.9.** `m` is a unit in `ℤₙ` if and only if `gcd m n = 1`. -/
theorem zmod_isUnit_iff_coprime (m n : ℕ) : IsUnit (m : ZMod n) ↔ m.Coprime n :=
  ZMod.isUnit_iff_coprime m n

end Examples

end AATA
