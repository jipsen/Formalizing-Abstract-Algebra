# FAA.Permutations

**Source.** [`Permutations.lean`](Permutations.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications*, Chapter 5 (permutation groups, cycles, the alternating group, dihedral groups).

**Content.** The order of the symmetric group, disjointness of cycle factors and the cycle decomposition, the sign homomorphism and the alternating group, and the dihedral relations — all Mathlib instantiations.

| Lean | Math |
|------|------|
| `Equiv.Perm α` | $S_X$, the symmetric group on $X$ |
| `f.cycleFactorsFinset` | the disjoint cycle factors of $f$ |
| `Equiv.Perm.sign f` | $\operatorname{sgn}(f) \in \{\pm 1\}$ |
| `alternatingGroup α` | $A_X$, the alternating group |
| `DihedralGroup n` | $D_n$ |
| `DihedralGroup.r i`, `DihedralGroup.sr i` | rotation $r^i$, reflection $s r^i$ |

---

**Theorem ([`card_perm'`](Permutations.lean#L34))**

Judson 5.1.1: $|S_X| = |X|!$ — `Fintype.card_perm`.

**Theorem ([`disjoint_commute`](Permutations.lean#L39))**

Judson 5.1.8: disjoint permutations commute — `Equiv.Perm.Disjoint.commute`.

**Theorem ([`cycleFactorsFinset_prod`](Permutations.lean#L43))** / ([`cycleFactorsFinset_pairwise_disjoint'`](Permutations.lean#L48))

Judson 5.1.9: every permutation is the product of its cycle factors, which are pairwise disjoint — `cycleFactorsFinset_noncommProd`, `cycleFactorsFinset_pairwise_disjoint`.

**Theorem ([`sign_mul'`](Permutations.lean#L53))**

Judson 5.1.14: the sign of a permutation is multiplicative, $\operatorname{sgn}(fg) = \operatorname{sgn}(f)\operatorname{sgn}(g)$ — `Equiv.Perm.sign` is a `MonoidHom`.

**Theorem ([`sign_swap'`](Permutations.lean#L58))**

Judson 5.1.14: a transposition has sign $-1$ — `Equiv.Perm.sign_swap`.

**Theorem ([`alternatingGroup_is_sign_ker`](Permutations.lean#L62))** / ([`mem_alternatingGroup'`](Permutations.lean#L66))

Judson 5.1.16: $A_X$ is the kernel of the sign homomorphism; $f \in A_X$ iff $\operatorname{sgn}(f) = 1$ — `alternatingGroup_eq_sign_ker`, `Equiv.Perm.mem_alternatingGroup`.

**Theorem ([`card_alternatingGroup'`](Permutations.lean#L71))**

Judson 5.1.17: $|A_X| = |X|! / 2$ for $|X| \geq 2$ — `card_alternatingGroup`.

**Theorem ([`dihedralGroup_card`](Permutations.lean#L76))**

Judson 5.2.2: $|D_n| = 2n$ — `DihedralGroup.card`.

**Theorem ([`dihedral_r_mul_r`](Permutations.lean#L81))** / ([`dihedral_sr_mul_r`](Permutations.lean#L86))

Judson 5.2.3: the dihedral multiplication rules $r^i r^j = r^{i+j}$ and $sr^i \cdot r^j = sr^{i+j}$ (indices mod $n$) — `DihedralGroup.r_mul_r`, `DihedralGroup.sr_mul_r`.

**Theorem ([`dihedral_reflection_conjugate`](Permutations.lean#L91))**

Judson 5.2.3: conjugating a rotation by a reflection inverts it, $s r^i s = r^{-i}$.

*Proof.*

> Have: $sr^0 \cdot r^i = sr^i$ by `sr_mul_r`
> Have: $sr^i \cdot sr^0 = r^{0-i} = r^{-i}$ by `sr_mul_sr`
> QED

**Theorem ([`dihedral_orderOf_r_one`](Permutations.lean#L96))**

Judson 5.2.3: the single-step rotation $r$ has order $n$ in $D_n$ — `DihedralGroup.orderOf_r_one`.
