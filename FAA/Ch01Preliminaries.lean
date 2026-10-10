-- Sidecar: FAA/Ch01Preliminaries.md
import Mathlib.Data.Set.Basic
import Mathlib.Data.Setoid.Partition
import Mathlib.Data.Int.ModEq

/-!
# Preliminaries (aata ch 1)

Sets, functions, and equivalence relations, following Judson, *Abstract Algebra:
Theory and Applications*, Chapter 1, §1.2.
Section 1.1 is a note on proofs and carries no formalized content.

## Main declarations

* `set_idem`, `set_empty`, `union_assoc'`, `inter_assoc'`, `set_comm`,
  `union_inter_distrib`, `inter_union_distrib` — aata Prop 1.2.2, set algebra.
* `compl_union'`, `compl_inter'` — aata Thm 1.2.3, De Morgan's laws.
* `comp_assoc'`, `injective_comp`, `surjective_comp`, `bijective_comp` — aata Thm 1.2.15.
* `invertible_iff_bijective` — aata Thm 1.2.20.
* `classes_partition`, `partition_setoid` — aata Thm 1.2.25.
* `eqv_classes_disjoint_or_eq` — aata Cor 1.2.26.
* `intModEq_equiv` — aata Ex 1.2.30, congruence modulo `n` is an equivalence relation.
-/

namespace FAA

open Set Function

variable {α β γ δ : Type*} {f : α → β} {g : β → γ} {h : γ → δ}

/-! ### Set theory (aata §1.2.1) -/

/-- aata Prop 1.2.2 (1): union and intersection are idempotent and `s \ s = ∅`. -/
theorem set_idem (s : Set α) : s ∪ s = s ∧ s ∩ s = s ∧ s \ s = ∅ :=
  ⟨union_self s, inter_self s, Set.sdiff_self⟩

/-- aata Prop 1.2.2 (2): `∅` is the identity for `∪` and annihilates `∩`. -/
theorem set_empty (s : Set α) : s ∪ ∅ = s ∧ s ∩ ∅ = ∅ :=
  ⟨union_empty s, inter_empty s⟩

/-- aata Prop 1.2.2 (3): union is associative. -/
theorem union_assoc' (s t u : Set α) : s ∪ (t ∪ u) = (s ∪ t) ∪ u :=
  (union_assoc s t u).symm

/-- aata Prop 1.2.2 (3): intersection is associative. -/
theorem inter_assoc' (s t u : Set α) : s ∩ (t ∩ u) = (s ∩ t) ∩ u :=
  (inter_assoc s t u).symm

/-- aata Prop 1.2.2 (4): union and intersection are commutative. -/
theorem set_comm (s t : Set α) : s ∪ t = t ∪ s ∧ s ∩ t = t ∩ s :=
  ⟨union_comm s t, inter_comm s t⟩

/-- aata Prop 1.2.2 (5): union distributes over intersection. -/
theorem union_inter_distrib (s t u : Set α) : s ∪ (t ∩ u) = (s ∪ t) ∩ (s ∪ u) :=
  union_inter_distrib_left s t u

/-- aata Prop 1.2.2 (6): intersection distributes over union. -/
theorem inter_union_distrib (s t u : Set α) : s ∩ (t ∪ u) = (s ∩ t) ∪ (s ∩ u) :=
  inter_union_distrib_left s t u

/-- aata Thm 1.2.3 (1): complement of a union. -/
theorem compl_union' (s t : Set α) : (s ∪ t)ᶜ = sᶜ ∩ tᶜ :=
  compl_union s t

/-- aata Thm 1.2.3 (2): complement of an intersection. -/
theorem compl_inter' (s t : Set α) : (s ∩ t)ᶜ = sᶜ ∪ tᶜ :=
  compl_inter s t

/-! ### Cartesian products and mappings (aata §1.2.2) -/

/-- aata Thm 1.2.15 (1): composition of mappings is associative. -/
theorem comp_assoc' (f : α → β) (g : β → γ) (h : γ → δ) : (h ∘ g) ∘ f = h ∘ (g ∘ f) :=
  comp_assoc h g f

/-- aata Thm 1.2.15 (2): a composite of injective maps is injective. -/
theorem injective_comp (hf : Injective f) (hg : Injective g) : Injective (g ∘ f) :=
  hg.comp hf

/-- aata Thm 1.2.15 (3): a composite of surjective maps is surjective. -/
theorem surjective_comp (hf : Surjective f) (hg : Surjective g) : Surjective (g ∘ f) :=
  hg.comp hf

/-- aata Thm 1.2.15 (4): a composite of bijective maps is bijective. -/
theorem bijective_comp (hf : Bijective f) (hg : Bijective g) : Bijective (g ∘ f) :=
  hg.comp hf

/-- aata Thm 1.2.20: a mapping is invertible iff it is bijective.
Invertible means `f` has a two-sided inverse `g` in the book's sense. -/
theorem invertible_iff_bijective (f : α → β) :
    (∃ g : β → α, LeftInverse g f ∧ RightInverse g f) ↔ Bijective f :=
  bijective_iff_has_inverse.symm

/-! ### Equivalence relations and partitions (aata §1.2.3) -/

/-- aata Thm 1.2.25, forward direction: the equivalence classes of an equivalence
relation on `α` form a partition of `α` (Mathlib `Setoid.IsPartition`). -/
theorem classes_partition (s : Setoid α) : Setoid.IsPartition s.classes :=
  s.isPartition_classes

/-- aata Thm 1.2.25, converse: a partition determines an equivalence relation
whose equivalence classes are the blocks of the partition. -/
theorem partition_setoid {P : Set (Set α)} (hP : Setoid.IsPartition P) :
    ∃ s : Setoid α, s.classes = P :=
  ⟨Setoid.mkClasses P hP.2, Setoid.classes_mkClasses P hP⟩

/-- aata Cor 1.2.26: two equivalence classes are disjoint or equal. -/
theorem eqv_classes_disjoint_or_eq (s : Setoid α) {b₁ b₂ : Set α}
    (h₁ : b₁ ∈ s.classes) (h₂ : b₂ ∈ s.classes) : Disjoint b₁ b₂ ∨ b₁ = b₂ := by
  by_cases hd : Disjoint b₁ b₂
  · exact Or.inl hd
  · right
    rw [not_disjoint_iff] at hd
    obtain ⟨x, hx₁, hx₂⟩ := hd
    exact Setoid.eq_of_mem_classes h₁ hx₁ h₂ hx₂

/-- aata Ex 1.2.30: congruence modulo `n` is an equivalence relation on `ℤ`. -/
theorem intModEq_equiv (n : ℤ) : Equivalence (Int.ModEq n) :=
  ⟨Int.ModEq.refl, Int.ModEq.symm, Int.ModEq.trans⟩

end FAA
