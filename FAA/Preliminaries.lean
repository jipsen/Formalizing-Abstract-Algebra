-- Sidecar: FAA/Preliminaries.md
/-
Copyright (c) 2026 Formalizing-Abstract-Algebra contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Formalizing-Abstract-Algebra contributors
-/
import Mathlib.Data.Setoid.Partition
import Mathlib.Logic.Function.Basic
import Mathlib.Order.BooleanAlgebra.Set

/-!
# Preliminaries

Judson, *Abstract Algebra: Theory and Applications*, Chapter 1:
sets, mappings, equivalence relations, and partitions.

## Statements

- Judson 1.2.3 (De Morgan's laws): `deMorgan_union`, `deMorgan_inter`
- Judson 1.2.15 (composition of mappings): `comp_assoc`, `injective_comp`,
  `surjective_comp`, `bijective_comp`
- Judson 1.2.20 (invertible iff bijective): `bijective_iff_invertible`
- Judson 1.2.25–26 (partitions and equivalence classes): `eqvClasses_isPartition`,
  `exists_setoid_classes`, `eqv_class_eq_or_disjoint`
-/

namespace AATA

section Sets

variable {α : Type*} (A B : Set α)

/-- **Judson 1.2.3(1)** (De Morgan). Complement of a union is an intersection of complements. -/
theorem deMorgan_union : (A ∪ B)ᶜ = Aᶜ ∩ Bᶜ :=
  Set.compl_union A B

/-- **Judson 1.2.3(2)** (De Morgan). Complement of an intersection is a union of complements. -/
theorem deMorgan_inter : (A ∩ B)ᶜ = Aᶜ ∪ Bᶜ :=
  Set.compl_inter A B

end Sets

section Mappings

variable {α β γ δ : Type*} {f : α → β} {g : β → γ}

/-- **Judson 1.2.15(1).** Composition of mappings is associative. -/
theorem comp_assoc (h : γ → δ) : (h ∘ g) ∘ f = h ∘ (g ∘ f) :=
  rfl

/-- **Judson 1.2.15(2).** The composite of one-to-one mappings is one-to-one. -/
theorem injective_comp (hf : Function.Injective f) (hg : Function.Injective g) :
    Function.Injective (g ∘ f) :=
  hg.comp hf

/-- **Judson 1.2.15(3).** The composite of onto mappings is onto. -/
theorem surjective_comp (hf : Function.Surjective f) (hg : Function.Surjective g) :
    Function.Surjective (g ∘ f) :=
  hg.comp hf

/-- **Judson 1.2.15(4).** The composite of bijective mappings is bijective. -/
theorem bijective_comp (hf : Function.Bijective f) (hg : Function.Bijective g) :
    Function.Bijective (g ∘ f) :=
  hg.comp hf

/-- **Judson 1.2.20.** A mapping is invertible if and only if it is one-to-one and onto. -/
theorem bijective_iff_invertible (f : α → β) :
    Function.Bijective f ↔
      ∃ g : β → α, Function.LeftInverse g f ∧ Function.RightInverse g f :=
  Function.bijective_iff_has_inverse

end Mappings

section EquivalenceRelations

variable {α : Type*} (s : Setoid α)

/-- **Judson 1.2.25** (forward). The equivalence classes of a setoid partition the type. -/
theorem eqvClasses_isPartition : Setoid.IsPartition s.classes :=
  Setoid.isPartition_classes s

/-- **Judson 1.2.25** (converse). A partition is the equivalence classes of a setoid. -/
theorem exists_setoid_classes {P : Set (Set α)} (hP : Setoid.IsPartition P) :
    ∃ s : Setoid α, s.classes = P :=
  ⟨Setoid.mkClasses P hP.2, Setoid.classes_mkClasses P hP⟩

/-- **Judson 1.2.26** (corollary). Two equivalence classes are disjoint or equal. -/
theorem eqv_class_eq_or_disjoint (a b : α) :
    { x | s.r x a } = { x | s.r x b } ∨ Disjoint { x | s.r x a } { x | s.r x b } := by
  rw [or_iff_not_imp_right, Set.not_disjoint_iff]
  rintro ⟨z, hza, hzb⟩
  exact Setoid.eq_of_mem_classes (Setoid.mem_classes s a) hza (Setoid.mem_classes s b) hzb

end EquivalenceRelations

end AATA
