-- Sidecar: FAA/Homomorphisms.md
/-
Copyright (c) 2026 Formalizing-Abstract-Algebra contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Formalizing-Abstract-Algebra contributors
-/
import Mathlib.GroupTheory.QuotientGroup.Basic

/-!
# Homomorphisms

Judson, *Abstract Algebra: Theory and Applications*, Chapter 11:
group homomorphisms, kernels, and the isomorphism theorems.

## Statements

- Judson 11.1.5 (kernel is normal): `ker_normal`
- Judson 11.2.1 (first isomorphism theorem): `quotient_ker_equiv_range`
- Judson 11.2.3 (second isomorphism theorem): `second_isomorphism`
- Judson 11.2.4 (correspondence): `exists_subgroup_over`
- Judson 11.2.5 (third isomorphism theorem): `third_isomorphism`
-/

namespace AATA

variable {G H : Type*} [Group G] [Group H]

/-- **Judson 11.1.5.** The kernel of a homomorphism is a normal subgroup. -/
theorem ker_normal (φ : G →* H) : φ.ker.Normal := inferInstance

/-- **Judson 11.2.1** (First Isomorphism Theorem). `G ⧸ ker φ ≅ im φ`. -/
noncomputable def quotient_ker_equiv_range (φ : G →* H) : G ⧸ φ.ker ≃* φ.range :=
  QuotientGroup.quotientKerEquivRange φ

/-- **Judson 11.2.3** (Second Isomorphism Theorem).
`H ⧸ (H ∩ N) ≅ (H ⊔ N) ⧸ N` for normal `N`. -/
noncomputable def second_isomorphism (H' N : Subgroup G) [N.Normal] :
    H' ⧸ N.subgroupOf H' ≃* (H' ⊔ N : Subgroup G) ⧸ N.subgroupOf (H' ⊔ N) :=
  QuotientGroup.quotientInfEquivProdNormalQuotient H' N

/-- **Judson 11.2.4** (Correspondence Theorem, surjectivity direction).
Every subgroup of `G ⧸ N` is `H' ⧸ N` for a subgroup `H'` containing `N`. -/
theorem exists_subgroup_over {N : Subgroup G} [N.Normal] (K : Subgroup (G ⧸ N)) :
    ∃ H' : Subgroup G, N ≤ H' ∧ H'.map (QuotientGroup.mk' N) = K := by
  refine ⟨K.comap (QuotientGroup.mk' N), ?_, ?_⟩
  · rw [← Subgroup.map_le_iff_le_comap]
    have hker : N ≤ (QuotientGroup.mk' N).ker := le_of_eq (QuotientGroup.ker_mk' N).symm
    have hbot : N.map (QuotientGroup.mk' N) ≤ (⊥ : Subgroup (G ⧸ N)) := by
      rw [Subgroup.map_le_iff_le_comap, MonoidHom.comap_bot]
      exact hker
    exact le_trans hbot bot_le
  · exact Subgroup.map_comap_eq_self_of_surjective (QuotientGroup.mk'_surjective N) K

/-- **Judson 11.2.5** (Third Isomorphism Theorem).
`(G ⧸ N) ⧸ (M ⧸ N) ≅ G ⧸ M` for `N ≤ M`. -/
noncomputable def third_isomorphism (N M : Subgroup G) [N.Normal] [M.Normal] (h : N ≤ M) :
    (G ⧸ N) ⧸ M.map (QuotientGroup.mk' N) ≃* G ⧸ M :=
  QuotientGroup.quotientQuotientEquivQuotient N M h

end AATA
