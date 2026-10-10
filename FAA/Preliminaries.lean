-- Sidecar: FAA/Preliminaries.md
/-
Copyright (c) 2026 Formalizing-Abstract-Algebra contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Formalizing-Abstract-Algebra contributors
-/
import Mathlib.Data.Set.Basic
import Mathlib.Data.Set.Image
import Mathlib.Logic.Equiv.Basic

/-!
# Preliminaries

Formalization of Chapter 1 of *Abstract Algebra: Theory and Applications*.
Sets, equivalence relations, and basic function properties.

## Main results

- Proposition 1.2.2: Basic set operation identities
- Theorem 1.2.3: De Morgan's Laws for sets
- Theorem 1.2.15: Properties of function composition
- Theorem 1.2.20: A mapping is invertible iff it is bijective
- Theorem 1.2.25: Equivalence classes form a partition
- Corollary 1.2.26: Equivalence classes are either disjoint or equal
-/

namespace FAA

/-!
## 1.1 A Short Note on Proofs

Proof techniques (direct, contrapositive, contradiction, induction) are
fundamental to mathematical reasoning. These are built into Lean's
proof system (e.g., `intro`, `apply`, `byContradiction`, `induction`).
-/

/-!
## 1.2 Sets and Equivalence Relations

### 1.2.1 Set Theory

Basic set operations and identities.
-/

section SetTheory

variable {α β γ : Type*} [DecidableEq α] [DecidableEq β] [DecidableEq γ]
variable (A B C : Set α)

/-- Proposition 1.2.2 (1): Idempotent laws for set operations. -/
@[simp]
theorem union_idempotent : A ∪ A = A := by
  sorry

/-- Proposition 1.2.2 (1): Idempotent laws for set operations. -/
@[simp]
theorem inter_idempotent : A ∩ A = A := by
  sorry

/-- Proposition 1.2.2 (1): Idempotent laws for set operations. -/
@[simp]
theorem diff_idempotent : A \ A = ∅ := by
  sorry

/-- Proposition 1.2.2 (2): Identity laws for set operations. -/
@[simp]
theorem union_empty : A ∪ ∅ = A := by
  sorry

/-- Proposition 1.2.2 (2): Identity laws for set operations. -/
@[simp]
theorem inter_empty : A ∩ ∅ = ∅ := by
  sorry

/-- Proposition 1.2.2 (3): Associative laws for set operations. -/
theorem union_assoc : A ∪ (B ∪ C) = (A ∪ B) ∪ C := by
  sorry

/-- Proposition 1.2.2 (3): Associative laws for set operations. -/
theorem inter_assoc : A ∩ (B ∩ C) = (A ∩ B) ∩ C := by
  sorry

/-- Proposition 1.2.2 (4): Commutative laws for set operations. -/
@[simp]
theorem union_comm : A ∪ B = B ∪ A := by
  sorry

/-- Proposition 1.2.2 (4): Commutative laws for set operations. -/
@[simp]
theorem inter_comm : A ∩ B = B ∩ A := by
  sorry

/-- Proposition 1.2.2 (5): Distributive laws for set operations. -/
theorem union_distrib_inter : A ∪ (B ∩ C) = (A ∪ B) ∩ (A ∪ C) := by
  sorry

/-- Proposition 1.2.2 (6): Distributive laws for set operations. -/
theorem inter_distrib_union : A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C) := by
  sorry

/-- Theorem 1.2.3 (1): De Morgan's Law for union. -/
theorem deMorgan_union : (A ∪ B)ᶜ = Aᶜ ∩ Bᶜ := by
  sorry

/-- Theorem 1.2.3 (2): De Morgan's Law for intersection. -/
theorem deMorgan_inter : (A ∩ B)ᶜ = Aᶜ ∪ Bᶜ := by
  sorry

end SetTheory

/-!
### 1.2.2 Cartesian Products and Mappings

Functions and their properties.
-/

section Mappings

variable {α β γ δ : Type*}

/-- Theorem 1.2.15 (1): Composition of mappings is associative. -/
theorem comp_assoc {f : α → β} {g : β → γ} {h : γ → δ} :
    (h ∘ g) ∘ f = h ∘ (g ∘ f) := by
  sorry

/-- Theorem 1.2.15 (2): Composition of injective functions is injective. -/
theorem comp_injective {f : α → β} {g : β → γ}
    (hf : Function.Injective f) (hg : Function.Injective g) :
    Function.Injective (g ∘ f) := by
  sorry

/-- Theorem 1.2.15 (3): Composition of surjective functions is surjective. -/
theorem comp_surjective {f : α → β} {g : β → γ}
    (hf : Function.Surjective f) (hg : Function.Surjective g) :
    Function.Surjective (g ∘ f) := by
  sorry

/-- Theorem 1.2.15 (4): Composition of bijective functions is bijective. -/
theorem comp_bijective {f : α → β} {g : β → γ}
    (hf : Function.Bijective f) (hg : Function.Bijective g) :
    Function.Bijective (g ∘ f) := by
  sorry

/-- Theorem 1.2.20: A mapping is invertible iff it is bijective. -/
theorem bijective_iff_invertible {f : α → β} :
    Function.Bijective f ↔ (∃ g : β → α, g ∘ f = id ∧ f ∘ g = id) := by
  sorry

end Mappings

/-!
### 1.2.3 Equivalence Relations and Partitions

Equivalence relations and their equivalence classes.
-/

section EquivalenceRelations

variable {α : Type*} (r : α → α → Prop)

/-- An equivalence relation on a type α. -/
structure Equivalence where
  refl : ∀ x : α, r x x
  symm : ∀ {x y : α}, r x y → r y x
  trans : ∀ {x y z : α}, r x y → r y z → r x z

variable {r} [E : Equivalence r]

/-- The equivalence class of an element x. -/
def equivalenceClass (x : α) : Set α :=
  { y | r x y }

/-- Theorem 1.2.25: Equivalence classes form a partition of α. -/
theorem equivalence_classes_partition :
    ∀ x y : α, equivalenceClass r x = equivalenceClass r y ∨
                Disjoint (equivalenceClass r x) (equivalenceClass r y) := by
  sorry

/-- Corollary 1.2.26: Two equivalence classes are either disjoint or equal. -/
theorem equivalence_classes_disjoint_or_equal (x y : α) :
    equivalenceClass r x = equivalenceClass r y ∨
    Disjoint (equivalenceClass r x) (equivalenceClass r y) := by
  sorry

/-- Congruence modulo n is an equivalence relation on ℤ. -/
def Int.modEq (n : ℕ) (r s : ℤ) : Prop :=
  n ∣ (r - s)

instance Int.modEq_equivalence (n : ℕ) : Equivalence (Int.modEq n) where
  refl := by sorry
  symm := by sorry
  trans := by sorry

end EquivalenceRelations

end FAA
