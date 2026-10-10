# FAA.Isomorphisms

**Source.** [`Isomorphisms.lean`](Isomorphisms.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications*, Chapter 9 (isomorphisms, cyclic groups, Cayley's theorem, direct products).

**Content.** The elementary properties of group isomorphisms, the classification of cyclic groups ($\mathbb{Z}$ and $\mathbb{Z}_n$ up to isomorphism), Cayley's embedding theorem, and the direct-product facts including $\mathbb{Z}_m \times \mathbb{Z}_n \cong \mathbb{Z}_{mn}$ iff $\gcd(m,n)=1$ — all Mathlib instantiations.

| Lean | Math |
|------|------|
| `G ≃* H` | $G \cong H$ (group isomorphism) |
| `Multiplicative ℤ` | the additive group $\mathbb{Z}$ written multiplicatively |
| `Multiplicative (ZMod n)` | $\mathbb{Z}_n$ written multiplicatively |
| `orderOf g` | $|g|$ |
| `Equiv.Perm G` | $S_G$ |
| `ZMod m × ZMod n` | $\mathbb{Z}_m \times \mathbb{Z}_n$ (additive group) |
| `e : G →* H` | a group homomorphism |

---

**Theorem ([`map_one'`](Isomorphisms.lean#L35))** / ([`map_inv'`](Isomorphisms.lean#L39))** / ([`map_zpow'`](Isomorphisms.lean#L43))

Judson 9.1.6(1–3): for $f : G \to H$ an isomorphism, $f(1) = 1$, $f(g^{-1}) = f(g)^{-1}$, and $f(g^n) = f(g)^n$ for $n \in \mathbb{Z}$ — `map_one`, `map_inv`, `map_zpow`.

**Theorem ([`orderOf_map`](Isomorphisms.lean#L47))**

Judson 9.1.6(5): isomorphisms preserve the order of an element, $|f(g)| = |g|$ — `orderOf_injective`.

**Theorem ([`exists_mulEquiv_multiplicative_int`](Isomorphisms.lean#L51))**

Judson 9.1.7: every infinite cyclic group is isomorphic to $\mathbb{Z}$ — a generator $g$ gives the bijection $k \mapsto g^k$ (`intEquivOfZPowersEqTop`).

**Theorem ([`exists_mulEquiv_zmod_of_isCyclic`](Isomorphisms.lean#L57))**

Judson 9.1.8: every cyclic group of order $n$ is isomorphic to $\mathbb{Z}_n$ — `zmodCyclicMulEquiv`.

**Theorem ([`exists_mulEquiv_zmod_of_prime_card`](Isomorphisms.lean#L62))**

Judson 9.1.9: every group of prime order $p$ is isomorphic to $\mathbb{Z}_p$ — cyclicity from `isCyclic_of_prime_card`, then `zmodCyclicMulEquiv`.

**Theorem ([`cayley`](Isomorphisms.lean#L67))**

Judson 9.1.12 (Cayley's theorem): every group $G$ is isomorphic to a subgroup of the symmetric group $S_G$ — left multiplication $g \mapsto (x \mapsto gx)$ is an injective homomorphism (`MulAction.toPermHom`).

*Proof.*

> Ass: $\varphi(g) = \varphi(h)$ where $\varphi$ is the left-multiplication map
> Have: $g \cdot 1 = h \cdot 1$, evaluating both permutations at $1$
> Have: $g = h$
> QED

**Def ([`prod_group`](Isomorphisms.lean#L77))**

Judson 9.2.1: the direct product $G \times H$ of two groups is a group — the Mathlib product `Group` instance.

**Theorem ([`orderOf_prod`](Isomorphisms.lean#L80))**

Judson 9.2.5: $|(a, b)| = \operatorname{lcm}(|a|, |b|)$ in $G \times H$ — `Prod.orderOf_mk`.

**Theorem ([`zmod_prod_addEquiv_zmod`](Isomorphisms.lean#L85))**

Judson 9.2.9: $\mathbb{Z}_m \times \mathbb{Z}_n \cong \mathbb{Z}_{mn}$ as additive groups if and only if $\gcd(m, n) = 1$ (for $m, n \geq 1$).

*Proof.*

> Show: $\mathbb{Z}_m \times \mathbb{Z}_n \cong \mathbb{Z}_{mn} \iff \gcd(m, n) = 1$
> Ass: $\mathbb{Z}_m \times \mathbb{Z}_n \cong \mathbb{Z}_{mn}$ via an additive equivalence $e$
> Have: $\mathbb{Z}_m \times \mathbb{Z}_n$ is cyclic — $\mathbb{Z}_{mn}$ is cyclic and cyclicity transfers along $e^{-1}$ (`isAddCyclic_of_surjective`)
> Have: $\gcd(m, n) = \gcd(|\mathbb{Z}_m|, |\mathbb{Z}_n|) = 1$ (`coprime_card_of_isAddCyclic_prod`, `Nat.card_zmod`)
> Conversely, $\gcd(m,n)=1$ gives the ring equivalence `ZMod.chineseRemainder`, whose additive part is the group isomorphism
> QED
