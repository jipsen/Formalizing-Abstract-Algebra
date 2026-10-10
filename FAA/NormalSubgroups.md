# FAA.NormalSubgroups

**Source.** [`NormalSubgroups.lean`](NormalSubgroups.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications*, Chapter 10 (normal subgroups, factor groups, simplicity of the alternating groups).

**Content.** The conjugation and coset characterizations of normality, the group structure on a quotient by a normal subgroup, generation of $A_X$ by 3-cycles, and the simplicity of $A_5$ — all Mathlib instantiations.

| Lean | Math |
|------|------|
| `N.Normal` | $N \trianglelefteq G$ |
| `g • (N : Set G)` | left coset $gN$ |
| `MulOpposite.op g • (N : Set G)` | right coset $Ng$ |
| `G ⧸ N` | the factor group $G/N$ |
| `alternatingGroup α` | $A_X$ |
| `IsThreeCycle` | a 3-cycle |
| `IsSimpleGroup` | a simple group (no nontrivial normal subgroups) |

---

**Theorem ([`normal_iff_conj_mem`](NormalSubgroups.lean#L34))**

Judson 10.1.3(a): $N \trianglelefteq G$ if and only if $gng^{-1} \in N$ for every $n \in N$ and $g \in G$ — `Subgroup.Normal.conj_mem'` (the constructor and the inverse-indexed accessor).

**Theorem ([`normal_iff_leftCoset_eq_rightCoset`](NormalSubgroups.lean#L40))**

Judson 10.1.3(b): $N \trianglelefteq G$ if and only if $gN = Ng$ for every $g \in G$ — `normal_iff_eq_cosets`.

**Def ([`quotient_group`](NormalSubgroups.lean#L45))**

Judson 10.1.4: if $N \trianglelefteq G$ then $G/N$ is a group under coset multiplication — the Mathlib `Group (G ⧸ N)` instance.

**Theorem ([`alternatingGroup_closure_isThreeCycles`](NormalSubgroups.lean#L48))**

Judson 10.2.1: the 3-cycles generate $A_X$ — `alternatingGroup.closure_isThreeCycles_eq_top`.

**Theorem ([`alternatingGroup_five_simple`](NormalSubgroups.lean#L54))**

Judson 10.2.4: $A_5$ is a simple group — the Mathlib instance `IsSimpleGroup (alternatingGroup (Fin 5))`.
