# Rosetta (terminology & conventions)

**Consult this file before naming** a declaration, docstring, or doc section. When a source uses a different term, record the mismatch in a docstring or sidecar `*Remark:*` — do not silently switch conventions.

For shared enriched-category / order-theoretic terms, defer to the QEF rosetta: [`quantale-enriched-foundations/docs/rosetta.md`](../../quantale-enriched-foundations/docs/rosetta.md) (sister checkout; on GitHub: [alexhkurz/quantale-enriched-foundations](https://github.com/alexhkurz/quantale-enriched-foundations/blob/main/docs/rosetta.md)). Keep only FAA-specific rows here.

Sidecar policy: [`lean-sidecar-policy.md`](lean-sidecar-policy.md). Per-file Lean↔Math tables in each sidecar header define that file's local math *symbols*; this file records repo-wide naming *decisions* (which term, not which symbol).

## Preferred terms

| Say | Not | Why |
|-----|-----|-----|
| Judson n.m.p | AATA theorem n.m.p | docstrings cite the book by author + theorem number |
| `Setoid` classes / `IsPartition` | "partition" as bespoke def | Mathlib `Setoid.IsPartition` is the partition predicate (`Mathlib.Data.Setoid.Partition`) |

## Concept table: source ↔ Mathlib ↔ Lean

Source: Judson, *AATA* ([`bibliography/aata-20260811.txt`](../bibliography/aata-20260811.txt)).

| AATA | Mathlib | FAA decl |
|------|---------|----------|
| De Morgan's laws (1.2.3) | `Set.compl_union`, `Set.compl_inter` | `AATA.deMorgan_union`, `AATA.deMorgan_inter` |
| composition of mappings (1.2.15) | `∘`, `Function.Injective/Surjective/Bijective.comp` | `AATA.comp_assoc`, `AATA.injective_comp`, `AATA.surjective_comp`, `AATA.bijective_comp` |
| invertible iff bijective (1.2.20) | `Function.bijective_iff_has_inverse` | `AATA.bijective_iff_invertible` |
| equivalence classes partition (1.2.25–26) | `Setoid.classes`, `Setoid.IsPartition`, `Setoid.mkClasses` | `AATA.eqvClasses_isPartition`, `AATA.exists_setoid_classes`, `AATA.eqv_class_eq_or_disjoint` |
| mathematical induction (2.1.1, 2.1.5) | `Nat.le_induction`, `Nat.strong_induction_on` | `AATA.induction_principle`, `AATA.strong_induction_principle` |
| well-ordering (2.1.6/2.1.8) | `Nat.sInf_mem`, `Nat.sInf_le` | `AATA.well_ordering` |
| division algorithm (2.2.1) | `Int.mul_ediv_add_emod`, `Int.ediv_emod_unique` | `AATA.division_algorithm` |
| gcd linear combination (2.2.2–3) | `Int.gcd_eq_gcd_ab`, `Int.gcdA`, `Int.gcdB` | `AATA.gcd_eq_linear_combination`, `AATA.exists_eq_one_of_gcd_eq_one` |
| Euclid's lemma (2.2.5) | `Int.Prime.dvd_mul'` | `AATA.euclid_lemma` |
| infinitude of primes (2.2.6) | `Nat.infinite_setOfPred_prime` | `AATA.infinite_primes` |
| fundamental theorem of arithmetic (2.2.7) | `Nat.primeFactorsList`, `Nat.primeFactorsList_unique` | `AATA.exists_prime_factorization`, `AATA.prime_factorization_unique` |
| elementary group laws (3.2.10–16) | `mul_inv_rev`, `inv_inv`, `mul_left_cancel`, `zpow_add`, `zpow_mul'` | `AATA.exists_unique_id`, `AATA.exists_unique_inv`, `AATA.mul_inv_rev'`, `AATA.inv_inv'`, `AATA.exists_unique_mul_right`, `AATA.exists_unique_mul_left`, `AATA.mul_left_cancel'`, `AATA.mul_right_cancel'`, `AATA.zpow_add'`, `AATA.zpow_pow` |
| subgroup criteria (3.3.7–8) | `Subgroup` structure fields | `AATA.subgroup_of_mem_closed`, `AATA.subgroup_of_div_closed` |
| units mod n (3.1.4, 3.3.9) | `ZMod`, `ZMod.isUnit_iff_coprime` | `AATA.zmod_add_comm_group`, `AATA.zmod_isUnit_iff_coprime` |
| cyclic subgroup ⟨a⟩ (4.1.3) | `Subgroup.zpowers`, `Subgroup.mem_zpowers_iff` | `AATA.cyclicSubgroup`, `AATA.mem_cyclicSubgroup` |
| cyclic group properties (4.1.9–10) | `IsCyclic`, `Subgroup.isCyclic` | `AATA.commutative_of_isCyclic`, `AATA.isCyclic_subgroup` |
| order of an element (4.1.11–13) | `orderOf`, `orderOf_dvd_of_pow_eq_one`, `orderOf_pow` | `AATA.orderOf_dvd_of_pow_eq_one'`, `AATA.orderOf_pow'` |
| `ℤₙ` cyclic, generators (4.1.14) | `ZMod.instIsAddCyclic`, `ZMod.addOrderOf_coe` | `AATA.zmod_isAddCyclic`, `AATA.addOrderOf_zmod_eq_iff_coprime` |
| symmetric group size (5.1.1) | `Equiv.Perm`, `Fintype.card_perm` | `AATA.card_perm'` |
| disjoint cycles commute, cycle decomposition (5.1.8–9) | `Equiv.Perm.Disjoint`, `cycleFactorsFinset` | `AATA.disjoint_commute`, `AATA.cycleFactorsFinset_prod`, `AATA.cycleFactorsFinset_pairwise_disjoint'` |
| sign, alternating group (5.1.14–17) | `Equiv.Perm.sign`, `alternatingGroup`, `card_alternatingGroup` | `AATA.sign_mul'`, `AATA.sign_swap'`, `AATA.alternatingGroup_is_sign_ker`, `AATA.mem_alternatingGroup'`, `AATA.card_alternatingGroup'` |
| dihedral group (5.2.2–3) | `DihedralGroup` (`r`, `sr`, `card`, `orderOf_r_one`) | `AATA.dihedralGroup_card`, `AATA.dihedral_r_mul_r`, `AATA.dihedral_sr_mul_r`, `AATA.dihedral_reflection_conjugate`, `AATA.dihedral_orderOf_r_one` |
| cosets partition (6.1.4) | `leftCoset_eq_iff`, pointwise `Set` smul | `AATA.leftCoset_eq_or_disjoint` |
| Lagrange's theorem (6.1.8, 6.2.2) | `Subgroup.index_mul_card`, `Subgroup.card_subgroup_dvd_card` | `AATA.index_mul_card'`, `AATA.lagrange` |
| orders, prime-order groups (6.2.3–4) | `orderOf_dvd_natCard`, `isCyclic_of_prime_card` | `AATA.orderOf_dvd_card`, `AATA.isCyclic_of_prime_card'`, `AATA.orderOf_eq_card_of_prime_card` |
| conjugation ↔ cycle type (6.2.8) | `Equiv.Perm.isConj_iff_cycleType_eq` | `AATA.isConj_iff_cycleType_eq'` |
| Euler, Fermat (6.3.1–3) | `ZMod.card_units_eq_totient`, `Nat.ModEq.pow_totient`, `ZMod.pow_card` | `AATA.card_units_eq_totient`, `AATA.euler`, `AATA.fermat` |
| isomorphism properties (9.1.6) | `MulEquiv` (`≃*`), `map_one`, `map_inv`, `map_zpow`, `orderOf_injective` | `AATA.map_one'`, `AATA.map_inv'`, `AATA.map_zpow'`, `AATA.orderOf_map` |
| cyclic classification (9.1.7–9) | `intEquivOfZPowersEqTop`, `zmodCyclicMulEquiv` | `AATA.exists_mulEquiv_multiplicative_int`, `AATA.exists_mulEquiv_zmod_of_isCyclic`, `AATA.exists_mulEquiv_zmod_of_prime_card` |
| Cayley's theorem (9.1.12) | `MulAction.toPermHom` | `AATA.cayley` |
| direct products (9.2.1, 9.2.5, 9.2.9) | `Prod` group instance, `Prod.orderOf_mk`, `ZMod.chineseRemainder`, `coprime_card_of_isAddCyclic_prod` | `AATA.prod_group`, `AATA.orderOf_prod`, `AATA.zmod_prod_addEquiv_zmod` |
| normality criteria (10.1.3–4) | `Subgroup.Normal`, `normal_iff_eq_cosets`, `QuotientGroup` | `AATA.normal_iff_conj_mem`, `AATA.normal_iff_leftCoset_eq_rightCoset`, `AATA.quotient_group` |
| `Aₙ` and 3-cycles, `A₅` simple (10.2.1, 10.2.4) | `alternatingGroup.closure_isThreeCycles_eq_top`, `IsSimpleGroup (alternatingGroup (Fin 5))` | `AATA.alternatingGroup_closure_isThreeCycles`, `AATA.alternatingGroup_five_simple` |
| kernel normal (11.1.5) | `MonoidHom.ker.Normal` | `AATA.ker_normal` |
| isomorphism theorems (11.2.1–5) | `QuotientGroup.quotientKerEquivRange`, `quotientInfEquivProdNormalQuotient`, `quotientQuotientEquivQuotient` | `AATA.quotient_ker_equiv_range`, `AATA.second_isomorphism`, `AATA.exists_subgroup_over`, `AATA.third_isomorphism` |
