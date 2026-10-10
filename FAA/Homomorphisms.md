# FAA.Homomorphisms

**Source.** [`Homomorphisms.lean`](Homomorphisms.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications*, Chapter 11 (homomorphisms, kernels, the isomorphism theorems).

**Content.** Normality of the kernel, the three isomorphism theorems, and the surjectivity half of the correspondence theorem — all Mathlib instantiations except the small `map`/`comap` argument for correspondence.

| Lean | Math |
|------|------|
| `φ : G →* H` | a group homomorphism $\varphi : G \to H$ |
| `φ.ker` | $\ker \varphi$ |
| `φ.range` | $\operatorname{im} \varphi$ |
| `G ⧸ N` | $G/N$ |
| `N.subgroupOf H'` | $H' \cap N$ as a subgroup of $H'$ |
| `H' ⊔ N` | $H'N$ |
| `M.map (QuotientGroup.mk' N)` | $M/N$ as a subgroup of $G/N$ |

---

**Theorem ([`ker_normal`](Homomorphisms.lean#L29))**

Judson 11.1.5: the kernel of a homomorphism is a normal subgroup — the Mathlib `φ.ker.Normal` instance.

**Def ([`quotient_ker_equiv_range`](Homomorphisms.lean#L32))**

Judson 11.2.1 (First Isomorphism Theorem): $G / \ker \varphi \cong \operatorname{im} \varphi$ — `QuotientGroup.quotientKerEquivRange`.

**Def ([`second_isomorphism`](Homomorphisms.lean#L37))**

Judson 11.2.3 (Second Isomorphism Theorem): $H/(H \cap N) \cong HN/N$ for $N \trianglelefteq G$ — `QuotientGroup.quotientInfEquivProdNormalQuotient`.

**Theorem ([`exists_subgroup_over`](Homomorphisms.lean#L43))**

Judson 11.2.4 (Correspondence Theorem, surjectivity): every subgroup $K \leq G/N$ has the form $H'/N$ for a subgroup $H'$ with $N \leq H'$.

*Proof.*

> Show: some $H' \supseteq N$ satisfies $\operatorname{map}(\pi)\, H' = K$, where $\pi$ is the projection $G \to G/N$
> Have: take $H' = \pi^{-1}(K)$
> Have: $N \leq H'$: since $\pi(N) = \ker \pi / \ker \pi$ is trivial and $\operatorname{map}(\pi)\,N \leq K$ iff $N \leq \pi^{-1}(K)$
> Have: $\operatorname{map}(\pi)\,H' = K$ because $\pi$ is surjective (`map_comap_eq_self_of_surjective`, `mk'_surjective`)
> QED

**Def ([`third_isomorphism`](Homomorphisms.lean#L56))**

Judson 11.2.5 (Third Isomorphism Theorem): for $N \leq M$ both normal, $(G/N)/(M/N) \cong G/M$ — `QuotientGroup.quotientQuotientEquivQuotient`.
