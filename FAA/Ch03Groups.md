# Ch 3 — Groups

**Source.** [`FAA/Ch03Groups.lean`](FAA/Ch03Groups.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications* (ed. 2026-08-04), ch. 3 — [`bibliography/aata-20260811.txt`](../bibliography/aata-20260811.txt). Book numbering `Thm ch.sec.item` (e.g. `Thm 3.2.16`).

**Content.** The integers modulo $n$ and permutation groups as examples, the group axioms and their first consequences, subgroup criteria — Chapter 3 of the book. Cayley-table examples, the historical note, reading questions, and exercises carry no formalized content.

| Lean | Math |
|------|------|
| `G : Type*`, `[Group G]` | a group $G$ |
| `a ⁻¹` | the inverse $a^{-1}$ |
| `a ^ n` for `n : ℤ` | $a^n$ in exponential notation, $na$ for additive groups |
| `ZMod n` | the integers modulo $n$, $\mathbb{Z}_n$ |
| `Equiv.Perm α` | the symmetries / permutations of $\alpha$ |
| `H : Set G`, `H' : Subgroup G` | a subset $H$ of $G$; $H$ as a subgroup |
| `IsUnit (a : ZMod n)` | $a$ has a multiplicative inverse mod $n$ |

---

**Theorem ([`zmod_ring_laws`](Ch03Groups.lean#L43))** — aata Prop 3.1.4 (1–5).

In $\mathbb{Z}_n$, addition and multiplication are commutative and associative, $0$ and $1$ are identities, multiplication distributes over addition, and every element has an additive inverse.

*Proof.* Each clause is the corresponding ring axiom of the `CommRing (ZMod n)` instance (`add_comm`, `mul_comm`, `add_assoc`, `mul_assoc`, `add_zero`, `mul_one`, `left_distrib`, `add_neg_cancel`).

**Theorem ([`zmod_unit_iff_gcd_one`](Ch03Groups.lean#L57))** — aata Prop 3.1.4 (6).

A nonzero $a \in \mathbb{Z}_n$ has a multiplicative inverse iff $\gcd(a, n) = 1$.

*Proof.* Forward: $\gcd(a,n)=1$ gives $ar + ns = 1$ by Bézout, so $ar \equiv 1 \pmod{n}$. Back: $ab \equiv 1 \pmod{n}$ means $ab - nk = 1$, and $\gcd(a,n)$ divides the left side hence equals $1$. In Mathlib this equivalence is `ZMod.isUnit_iff_coprime`.

**Declaration ([`perm_group`](Ch03Groups.lean#L63))** — aata §3.1.2.

The symmetries of a figure — the permutations of its points — form a group; the symmetries of the triangle are $S_3$.

*Remark:* This instantiates Mathlib's `Group (Equiv.Perm α)`; composition of symmetries is function composition, the identity is the trivial permutation, and inverses are inverse permutations.

**Declaration ([`zmod_add_group`](Ch03Groups.lean#L66))** — aata Example 3.2.2.

$\mathbb{Z}_n = \lbrace 0, 1, \dots, n-1 \rbrace$ is a group under addition modulo $n$.

*Remark:* This instantiates `AddCommGroup (ZMod n)`; the underlying laws are clauses (1–5) of Prop 3.1.4.

**Declaration ([`groupOfAxioms`](Ch03Groups.lean#L73))** — aata §3.2, the group axioms.

A set $G$ with a binary operation that is associative, has an element $e$ with $ea = ae = a$, and has for each $a$ an element $a^{-1}$ with $aa^{-1} = a^{-1}a = e$, is a group.

*Proof.* The book's two-sided axioms specialize `Group.ofLeftAxioms`, which already builds a `Group` from left identity and left inverse.

**Theorem ([`one_unique`](Ch03Groups.lean#L80))** — aata Prop 3.2.10.

The identity element of a group is unique: there is exactly one $e$ with $eg = ge = g$ for all $g$.

*Proof.* If $e$ and $e'$ are identities, then $e = ee' = e'$ — evaluating the candidate identity at $g = e$ itself (`mul_one`).

**Theorem ([`inv_unique'`](Ch03Groups.lean#L86))** — aata Prop 3.2.11.

The inverse of $g$ is unique: there is exactly one $g'$ with $gg' = g'g = e$.

*Proof.* The book's chain: $g' = eg' = (g^{-1}g)g' = g^{-1}(gg') = g^{-1}e = g^{-1}$.

**Theorem ([`mul_inv_rev'`](Ch03Groups.lean#L95))** — aata Prop 3.2.12.

$(ab)^{-1} = b^{-1}a^{-1}$.

*Proof.* $(ab)(b^{-1}a^{-1}) = aea^{-1} = e$, and inverses are unique (`mul_inv_rev`).

**Theorem ([`inv_inv'`](Ch03Groups.lean#L99))** — aata Prop 3.2.13.

$(a^{-1})^{-1} = a$.

*Proof.* $a^{-1}(a^{-1})^{-1} = e$ multiplied on the left by $a$ gives $(a^{-1})^{-1} = a$ (`inv_inv`).

**Theorem ([`eq_mul_unique_sol`](Ch03Groups.lean#L104))** — aata Prop 3.2.14.

For $a, b \in G$, each of the equations $ax = b$ and $xa = b$ has a unique solution in $G$.

*Proof.*

> Show: $ax = b$ has a unique solution (the case $xa = b$ is symmetric)
>
> > Have: $x = a^{-1}b$ is a solution, since $a(a^{-1}b) = (aa^{-1})b = eb = b$
> > Ass: $ax = b$
> > Have: $x = a^{-1}(ax) = a^{-1}b$ — multiplication by $a^{-1}$ is injective (`eq_inv_mul_iff_mul_eq`)
>
> QED

**Theorem ([`mul_cancel'`](Ch03Groups.lean#L117))** — aata Prop 3.2.15.

In a group, $ba = ca$ implies $b = c$ and $ab = ac$ implies $b = c$: both cancellation laws hold.

*Proof.* Right cancellation multiplies on the right by $a^{-1}$; left cancellation on the left (`mul_right_cancel`, `mul_left_cancel`).

**Theorem ([`zpow_laws`](Ch03Groups.lean#L123))** — aata Thm 3.2.16.

For $g, h \in G$ and $m, n \in \mathbb{Z}$: $g^m g^n = g^{m+n}$, $(g^m)^n = g^{mn}$, and $(gh)^n = (h^{-1}g^{-1})^{-n}$.

*Proof.* Integer-exponent laws `zpow_add` and `zpow_mul`; the third is $h^{-1}g^{-1} = (gh)^{-1}$ together with $(a^{-1})^n = a^{-n}$ (`mul_inv_rev`, `inv_zpow'`).

**Theorem ([`mul_zpow'`](Ch03Groups.lean#L130))** — aata Thm 3.2.16, abelian case.

If $G$ is abelian, then $(gh)^n = g^n h^n$ for all $n \in \mathbb{Z}$.

*Proof.* `mul_zpow` in a commutative group.

**Theorem ([`evenInt_subgroup`](Ch03Groups.lean#L138))** — aata §3.3.1, example.

The even integers $2\mathbb{Z} = \lbrace \dots, -2, 0, 2, 4, \dots \rbrace$ form a subgroup of $\mathbb{Z}$.

*Proof.* $0$ is even; the sum of two even integers is even (`dvd_add`); the negative of an even integer is even (`dvd_neg`).

**Theorem ([`subgroup_iff_three_conditions`](Ch03Groups.lean#L147))** — aata Prop 3.3.7.

A subset $H$ of a group $G$ is a subgroup iff (1) $e \in H$, (2) $h_1, h_2 \in H$ implies $h_1 h_2 \in H$, and (3) $h \in H$ implies $h^{-1} \in H$.

*Proof.* Forward: a subgroup's own identity satisfies $e_H e_H = e_H$, so $e_H = e$ by cancellation; closure under product and inverse then read off the group axioms. Back: the three conditions plus associativity inherited from $G$ are exactly the group axioms — the fields of Mathlib's `Subgroup`.

**Theorem ([`subgroup_iff_div_mem`](Ch03Groups.lean#L163))** — aata Prop 3.3.8, the one-step subgroup test.

A subset $H$ of a group $G$ is a subgroup iff $H \neq \emptyset$ and $g, h \in H$ implies $gh^{-1} \in H$.

*Proof.* Forward is immediate from closure under inverse and product. The converse is the book's derivation through Prop 3.3.7:

> Show: $H$ satisfies the three subgroup conditions
>
> > Have: $e = gg^{-1} \in H$ for any $g \in H$ (which exists since $H \neq \emptyset$)
> > Have: $h^{-1} = e h^{-1} \in H$ for $h \in H$
> > Have: $h_1 h_2 = h_1 (h_2^{-1})^{-1} \in H$ for $h_1, h_2 \in H$
>
> QED
