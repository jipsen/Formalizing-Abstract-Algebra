# Preliminaries

**Source.** [`FAA/Preliminaries.lean`](FAA/Preliminaries.lean)

**Content.** Formalization of Chapter 1 of *Abstract Algebra: Theory and Applications*.

## 1.1 A Short Note on Proofs

Proof techniques (direct, contrapositive, contradiction, induction) are built into Lean's proof system:
- Direct proof: `intro`, `apply`
- Contrapositive: `byContradiction` or `not_not`
- Contradiction: `byContradiction`
- Induction: `induction`

These are foundational to all subsequent proofs in this project.

## 1.2 Sets and Equivalence Relations

### 1.2.1 Set Theory

Basic set operations and identities from Proposition 1.2.2 and Theorem 1.2.3.

- `union_idempotent` (#L40): A ∪ A = A
- `inter_idempotent` (#L44): A ∩ A = A
- `diff_idempotent` (#L48): A \ A = ∅
- `union_empty` (#L52): A ∪ ∅ = A
- `inter_empty` (#L56): A ∩ ∅ = ∅
- `union_assoc` (#L60): A ∪ (B ∪ C) = (A ∪ B) ∪ C
- `inter_assoc` (#L64): A ∩ (B ∩ C) = (A ∩ B) ∩ C
- `union_comm` (#L68): A ∪ B = B ∪ A
- `inter_comm` (#L72): A ∩ B = B ∩ A
- `union_distrib_inter` (#L76): A ∪ (B ∩ C) = (A ∪ B) ∩ (A ∪ C)
- `inter_distrib_union` (#L80): A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C)
- `deMorgan_union` (#L84): (A ∪ B)ᶜ = Aᶜ ∩ Bᶜ
- `deMorgan_inter` (#L88): (A ∩ B)ᶜ = Aᶜ ∪ Bᶜ

### 1.2.2 Cartesian Products and Mappings

Function properties from Theorem 1.2.15 and Theorem 1.2.20.

- `comp_assoc` (#L100): (h ∘ g) ∘ f = h ∘ (g ∘ f)
- `comp_injective` (#L104): Composition of injective functions is injective
- `comp_surjective` (#L109): Composition of surjective functions is surjective
- `comp_bijective` (#L114): Composition of bijective functions is bijective
- `bijective_iff_invertible` (#L119): A mapping is invertible iff it is bijective

### 1.2.3 Equivalence Relations and Partitions

Equivalence relations and partitions from Theorem 1.2.25 and Corollary 1.2.26.

- `Equivalence` (#L131): Structure defining equivalence relations (reflexive, symmetric, transitive)
- `equivalenceClass` (#L139): The equivalence class of an element x
- `equivalence_classes_partition` (#L143): Equivalence classes form a partition
- `equivalence_classes_disjoint_or_equal` (#L149): Two equivalence classes are either disjoint or equal
- `Int.modEq` (#L155): Congruence modulo n on ℤ
- `Int.modEq_equivalence` (#L159): Instance showing mod n is an equivalence relation
