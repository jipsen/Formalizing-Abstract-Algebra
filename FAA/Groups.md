# FAA.Groups

**Source.** [`Groups.lean`](Groups.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications*, Chapter 3 (groups, elementary properties, subgroups).

**Content.** The elementary group laws (uniqueness of identity and inverses, solvability of equations, cancellation, laws of exponents), the two subgroup criteria, and the abelian groups $\mathbb{Z}_n$ and $U(n)$ — mostly Mathlib instantiations, with the two-step and one-step subgroup tests proved from the axioms.

| Lean | Math |
|------|------|
| `a⁻¹` | $a^{-1}$ |
| `a ^ n` for `n : ℤ` | $a^n$ (integer powers) |
| `Subgroup G` | a subgroup $H \leq G$ |
| `ZMod n` | $\mathbb{Z}_n$ |
| `IsUnit (m : ZMod n)` | $m \in U(n)$ |
| `s.Nonempty` | $s \neq \varnothing$ |

---

**Theorem ([`exists_unique_id`](Groups.lean#L35))**

Judson 3.2.10: there is a unique $e \in G$ with $eg = ge = g$ for all $g$ — the witness is $1$; uniqueness follows because $e = e \cdot 1 = 1$.

**Theorem ([`exists_unique_inv`](Groups.lean#L39))**

Judson 3.2.11: each $g \in G$ has a unique two-sided inverse — `mul_inv_cancel` and `inv_eq_of_mul_eq_one_right`.

**Theorem ([`mul_inv_rev'`](Groups.lean#L44))** / ([`inv_inv'`](Groups.lean#L48))

Judson 3.2.12–13: $(ab)^{-1} = b^{-1} a^{-1}$ and $(a^{-1})^{-1} = a$ — `mul_inv_rev`, `inv_inv`.

**Theorem ([`exists_unique_mul_right`](Groups.lean#L52))** / ([`exists_unique_mul_left`](Groups.lean#L56))

Judson 3.2.14: for $a, b \in G$ each of the equations $ax = b$ and $xa = b$ has a unique solution — the witnesses are $a^{-1}b$ and $ba^{-1}$; both goals are group identities (`group`).

**Theorem ([`mul_left_cancel'`](Groups.lean#L60))** / ([`mul_right_cancel'`](Groups.lean#L64))

Judson 3.2.15: $ab = ac$ implies $b = c$, and $ba = ca$ implies $b = c$ — `mul_left_cancel`, `mul_right_cancel`.

**Theorem ([`zpow_add'`](Groups.lean#L68))** / ([`zpow_pow`](Groups.lean#L72))

Judson 3.2.16 (laws of exponents): $a^{m+n} = a^m a^n$ and $(a^m)^n = a^{mn}$ for $m, n \in \mathbb{Z}$ — `zpow_add`, `zpow_mul'`.

**Theorem ([`subgroup_of_mem_closed`](Groups.lean#L81))**

Judson 3.3.7: if a subset $S \subseteq G$ contains $1$ and is closed under multiplication and inversion, then $S$ is a subgroup — the `Subgroup` structure fields are exactly these closure conditions.

**Theorem ([`subgroup_of_div_closed`](Groups.lean#L89))**

Judson 3.3.8 (one-step subgroup test): if $S \neq \varnothing$ and $ab^{-1} \in S$ for all $a, b \in S$, then $S$ is a subgroup.

*Proof.*

> Ass: $x \in S$ and $ab^{-1} \in S$ for all $a, b \in S$
> Have: $1 = xx^{-1} \in S$
> Have: $a^{-1} = 1 a^{-1} \in S$ for each $a \in S$
> Have: $ab = a(b^{-1})^{-1} \in S$ for all $a, b \in S$
> Have: $S$ is a subgroup by `subgroup_of_mem_closed`
> QED

**Def ([`zmod_add_comm_group`](Groups.lean#L108))**

Judson 3.1.4: $\mathbb{Z}_n$ is an abelian group under addition modulo $n$ — the Mathlib `AddCommGroup (ZMod n)` instance.

**Theorem ([`zmod_isUnit_iff_coprime`](Groups.lean#L111))**

Judson 3.3.9: $m$ is a unit in $\mathbb{Z}_n$ (i.e. $m \in U(n)$) if and only if $\gcd(m, n) = 1$ — `ZMod.isUnit_iff_coprime`.
