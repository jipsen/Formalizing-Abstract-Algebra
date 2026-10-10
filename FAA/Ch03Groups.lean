-- Sidecar: FAA/Ch03Groups.md
import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.Group.MinimalAxioms
import Mathlib.Algebra.Group.Subgroup.Basic
import Mathlib.Data.Int.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.GroupTheory.Perm.Basic

/-!
# Groups (aata ch 3)

Group axioms, the first properties of groups, and subgroup criteria, following
Judson, *Abstract Algebra: Theory and Applications*, Chapter 3. The book's
group axioms (associativity, two-sided identity, two-sided inverses) are
restated as a constructor landing on Mathlib's `Group`.

## Main declarations

* `zmod_ring_laws`, `zmod_unit_iff_gcd_one` — aata Prop 3.1.4, `ℤₙ` ring laws
  and the coprime-inverse criterion.
* `perm_group` — aata §3.1.2, symmetries (permutations) form a group.
* `zmod_add_group` — aata Ex 3.2.2, `ℤₙ` is a group under `+`.
* `groupOfAxioms` — aata §3.2, the book's group axioms yield a `Group`.
* `one_unique`, `inv_unique'`, `mul_inv_rev'`, `inv_inv'` — aata Props
  3.2.10–3.2.13.
* `eq_mul_unique_sol` — aata Prop 3.2.14, unique solutions of `ax = b`, `xa = b`.
* `mul_cancel'` — aata Prop 3.2.15, cancellation laws.
* `zpow_laws`, `mul_zpow'` — aata Thm 3.2.16, laws of exponents.
* `subgroup_iff_three_conditions`, `subgroup_iff_div_mem` — aata Props
  3.3.7–3.3.8, subgroup tests.
* `evenInt_subgroup` — aata §3.3.1, `2ℤ` is a subgroup of `ℤ`.
-/

namespace FAA

variable {G : Type*} [Group G]

/-! ### The integers mod `n` and symmetries (aata §3.1) -/

/-- aata Prop 3.1.4 (1–5): on `ℤₙ`, addition and multiplication are commutative
and associative, `0` and `1` are identities, `·` distributes over `+`, and
every element has an additive inverse — together, `ZMod n` is a `CommRing`. -/
theorem zmod_ring_laws (n : ℕ) :
    (∀ a b : ZMod n, a + b = b + a ∧ a * b = b * a) ∧
    (∀ a b c : ZMod n, (a + b) + c = a + (b + c) ∧ (a * b) * c = a * (b * c)) ∧
    (∀ a : ZMod n, a + 0 = a ∧ a * 1 = a) ∧
    (∀ a b c : ZMod n, a * (b + c) = a * b + a * c) ∧
    (∀ a : ZMod n, a + (-a) = 0) :=
  ⟨fun a b ↦ ⟨add_comm a b, mul_comm a b⟩,
   fun a b c ↦ ⟨add_assoc a b c, mul_assoc a b c⟩,
   fun a ↦ ⟨add_zero a, mul_one a⟩,
   fun a b c ↦ left_distrib a b c,
   fun a ↦ add_neg_cancel a⟩

/-- aata Prop 3.1.4 (6): a nonzero `a ∈ ℤₙ` has a multiplicative inverse modulo
`n` — is a unit — iff `gcd a n = 1`. This is `ZMod.isUnit_iff_coprime`. -/
theorem zmod_unit_iff_gcd_one {n : ℕ} (a : ℕ) :
    IsUnit (a : ZMod n) ↔ Nat.gcd a n = 1 := by
  rw [ZMod.isUnit_iff_coprime]

/-- aata §3.1.2: the symmetries of a figure are permutations of its points and
form a group (the triangle's symmetries are `S₃`); Mathlib `Equiv.Perm`. -/
abbrev perm_group (α : Type*) : Group (Equiv.Perm α) := inferInstance

/-- aata Example 3.2.2: `ℤₙ` is a group under addition modulo `n`. -/
abbrev zmod_add_group (n : ℕ) : AddCommGroup (ZMod n) := inferInstance

/-! ### Definitions and basic properties (aata §3.2) -/

/-- aata §3.2, the group axioms: a binary operation that is associative, has a
two-sided identity, and has two-sided inverses makes `G` a group (Mathlib
`Group`). The left-sided fragment already suffices (`Group.ofLeftAxioms`). -/
abbrev groupOfAxioms {G : Type*} [Mul G] [One G] [Inv G]
    (hassoc : ∀ a b c : G, (a * b) * c = a * (b * c))
    (hid : ∀ a : G, 1 * a = a ∧ a * 1 = a)
    (hinv : ∀ a : G, a * a⁻¹ = 1 ∧ a⁻¹ * a = 1) : Group G :=
  Group.ofLeftAxioms hassoc (fun a ↦ (hid a).1) (fun a ↦ (hinv a).2)

/-- aata Prop 3.2.10: the identity element of a group is unique. -/
theorem one_unique : ∃! e : G, ∀ g : G, e * g = g ∧ g * e = g := by
  refine ⟨1, fun g ↦ ⟨one_mul g, mul_one g⟩, fun e he ↦ ?_⟩
  have := (he 1).1
  rwa [mul_one] at this

/-- aata Prop 3.2.11: the inverse of `g` is unique. -/
theorem inv_unique' (g : G) : ∃! g' : G, g * g' = 1 ∧ g' * g = 1 := by
  refine ⟨g⁻¹, ⟨mul_inv_cancel g, inv_mul_cancel g⟩, fun g' h ↦ ?_⟩
  calc g' = 1 * g' := (one_mul g').symm
    _ = (g⁻¹ * g) * g' := by rw [inv_mul_cancel]
    _ = g⁻¹ * (g * g') := by rw [mul_assoc]
    _ = g⁻¹ * 1 := by rw [h.1]
    _ = g⁻¹ := mul_one g⁻¹

/-- aata Prop 3.2.12: `(ab)⁻¹ = b⁻¹a⁻¹`. -/
theorem mul_inv_rev' (a b : G) : (a * b)⁻¹ = b⁻¹ * a⁻¹ :=
  mul_inv_rev a b

/-- aata Prop 3.2.13: `(a⁻¹)⁻¹ = a`. -/
theorem inv_inv' (a : G) : (a⁻¹)⁻¹ = a :=
  inv_inv a

/-- aata Prop 3.2.14: for `a, b ∈ G`, the equations `a * x = b` and `x * a = b`
each have a unique solution in `G`. -/
theorem eq_mul_unique_sol (a b : G) :
    (∃! x : G, a * x = b) ∧ ∃! x : G, x * a = b :=
  ⟨⟨a⁻¹ * b, by
      change a * (a⁻¹ * b) = b
      rw [← mul_assoc, mul_inv_cancel, one_mul],
    fun y hy ↦ eq_inv_mul_iff_mul_eq.mpr hy⟩,
   ⟨b * a⁻¹, by
      change b * a⁻¹ * a = b
      rw [mul_assoc, inv_mul_cancel, mul_one],
    fun y hy ↦ eq_mul_inv_iff_mul_eq.mpr hy⟩⟩

/-- aata Prop 3.2.15, cancellation laws: `ba = ca` implies `b = c`, and
`ab = ac` implies `b = c`. -/
theorem mul_cancel' (a b c : G) :
    (b * a = c * a → b = c) ∧ (a * b = a * c → b = c) :=
  ⟨mul_right_cancel, mul_left_cancel⟩

/-- aata Thm 3.2.16: the usual laws of exponents hold in a group —
`gᵐ gⁿ = gᵐ⁺ⁿ`, `(gᵐ)ⁿ = gᵐⁿ`, and `(gh)ⁿ = (h⁻¹ g⁻¹)⁻ⁿ` for `m n ∈ ℤ`. -/
theorem zpow_laws (g h : G) (m n : ℤ) :
    g ^ m * g ^ n = g ^ (m + n) ∧ (g ^ m) ^ n = g ^ (m * n) ∧
    (g * h) ^ n = (h⁻¹ * g⁻¹) ^ (-n) :=
  ⟨(zpow_add g m n).symm, (zpow_mul g m n).symm, by
    rw [← mul_inv_rev, inv_zpow', neg_neg]⟩

/-- aata Thm 3.2.16, abelian case: `(gh)ⁿ = gⁿ hⁿ` when `G` is abelian. -/
theorem mul_zpow' {G : Type*} [CommGroup G] (g h : G) (n : ℤ) :
    (g * h) ^ n = g ^ n * h ^ n :=
  mul_zpow g h n

/-! ### Subgroups (aata §3.3) -/

/-- aata §3.3.1, example: the even integers `2ℤ` form a subgroup of `ℤ`
(Mathlib `AddSubgroup`). -/
theorem evenInt_subgroup : ∃ H : AddSubgroup ℤ, (H : Set ℤ) = {x | 2 ∣ x} :=
  ⟨{ carrier := {x | 2 ∣ x},
     zero_mem' := ⟨0, rfl⟩,
     add_mem' := fun ha hb ↦ dvd_add ha hb,
     neg_mem' := fun ha ↦ dvd_neg.mpr ha },
   rfl⟩

/-- aata Prop 3.3.7: a subset `H` of `G` is a subgroup iff `1 ∈ H`, `H` is
closed under `*`, and `H` is closed under `⁻¹`. -/
theorem subgroup_iff_three_conditions {H : Set G} :
    (∃ H' : Subgroup G, (H' : Set G) = H) ↔
      1 ∈ H ∧ (∀ a ∈ H, ∀ b ∈ H, a * b ∈ H) ∧ ∀ a ∈ H, a⁻¹ ∈ H := by
  constructor
  · rintro ⟨H', rfl⟩
    exact ⟨one_mem H', fun a ha b hb ↦ mul_mem ha hb, fun a ha ↦ inv_mem ha⟩
  · rintro ⟨h1, hmul, hinv⟩
    exact ⟨{ carrier := H,
             mul_mem' := fun ha hb ↦ hmul _ ha _ hb,
             one_mem' := h1,
             inv_mem' := fun ha ↦ hinv _ ha },
          rfl⟩

/-- aata Prop 3.3.8, the one-step subgroup test: `H` is a subgroup iff `H ≠ ∅`
and `g * h⁻¹ ∈ H` for all `g, h ∈ H`. The book's derivation — `e = gg⁻¹`,
`h⁻¹ = eh⁻¹`, `h₁h₂ = h₁(h₂⁻¹)⁻¹` — runs through Prop 3.3.7. -/
theorem subgroup_iff_div_mem {H : Set G} :
    (∃ H' : Subgroup G, (H' : Set G) = H) ↔
      H.Nonempty ∧ ∀ g ∈ H, ∀ h ∈ H, g * h⁻¹ ∈ H := by
  rw [subgroup_iff_three_conditions]
  constructor
  · rintro ⟨h1, hmul, hinv⟩
    exact ⟨⟨1, h1⟩, fun g hg h hh ↦ hmul g hg (h⁻¹) (hinv h hh)⟩
  · rintro ⟨⟨g, hg⟩, hdiv⟩
    have h1 : (1 : G) ∈ H := by
      have := hdiv g hg g hg
      rwa [mul_inv_cancel] at this
    have hinv : ∀ a ∈ H, a⁻¹ ∈ H := fun a ha ↦ by
      have := hdiv 1 h1 a ha
      rwa [one_mul] at this
    exact ⟨h1, fun a ha b hb ↦ by
      have := hdiv a ha (b⁻¹) (hinv b hb)
      rwa [inv_inv] at this, hinv⟩

end FAA
