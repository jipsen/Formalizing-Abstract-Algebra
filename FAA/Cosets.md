# FAA.Cosets

**Source.** [`Cosets.lean`](Cosets.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications*, Chapter 6 (cosets, Lagrange's theorem, Euler's theorem, Fermat's little theorem).

**Content.** The left-coset partition of a group, Lagrange's theorem in index and divisibility form, its corollaries (element orders, prime-order groups), the conjugacy–cycle-type correspondence, and the theorems of Euler and Fermat — mostly Mathlib facts; the coset partition is proved from the one-step characterization.

| Lean | Math |
|------|------|
| `x • (H : Set G)` | the left coset $xH$ |
| `H.index` | $[G : H]$ |
| `Nat.card G` | $|G|$ |
| `orderOf g` | $|g|$ |
| `IsCyclic G` | $G$ is cyclic |
| `σ.cycleType` | the cycle type of $\sigma$ |
| `n.totient` | Euler's totient $\varphi(n)$ |
| `(ZMod n)ˣ` | $U(n)$ |
| `a ≡ b [MOD n]` | $a \equiv b \pmod{n}$ |

---

**Theorem ([`leftCoset_eq_or_disjoint`](Cosets.lean#L37))**

Judson 6.1.4: two left cosets of $H$ are either equal or disjoint.

*Proof.*

> Show: $xH = yH$ or $xH \cap yH = \varnothing$
> Ass: $z \in xH \cap yH$, say $z = xh_1 = yh_2$ with $h_1, h_2 \in H$
> Have: $x^{-1}y = h_1 h_2^{-1} \in H$
> Have: $xH = yH$ by the coset equality criterion `leftCoset_eq_iff`
> QED

**Theorem ([`index_mul_card'`](Cosets.lean#L54))**

Judson 6.1.8 / 6.2.2 (index form): $|G| = [G : H] \cdot |H|$ — `Subgroup.index_mul_card`.

**Theorem ([`lagrange`](Cosets.lean#L58))**

Judson 6.2.2 (Lagrange's theorem): $|H|$ divides $|G|$ — `Subgroup.card_subgroup_dvd_card`.

**Theorem ([`orderOf_dvd_card`](Cosets.lean#L62))**

Judson 6.2.3: $|g|$ divides $|G|$ — `orderOf_dvd_natCard`.

**Theorem ([`isCyclic_of_prime_card'`](Cosets.lean#L66))**

Judson 6.2.4: a group of prime order is cyclic — `isCyclic_of_prime_card`.

**Theorem ([`orderOf_eq_card_of_prime_card`](Cosets.lean#L70))**

Judson 6.2.4: in a group of prime order $p$, every nonidentity element has order $p$.

*Proof.*

> Ass: $|G| = p$ prime and $g \neq 1$
> Have: $|g| \mid p$ by `orderOf_dvd_natCard`
> Have: $|g| = 1$ or $|g| = p$ by `Nat.dvd_prime`
> Have: $|g| \neq 1$ since $|g| = 1$ iff $g = 1$ (`orderOf_eq_one_iff`)
> Have: $|g| = p = |G|$
> QED

**Theorem ([`isConj_iff_cycleType_eq'`](Cosets.lean#L79))**

Judson 6.2.8: two permutations are conjugate in $S_X$ if and only if they have the same cycle type — `Equiv.Perm.isConj_iff_cycleType_eq`.

**Theorem ([`card_units_eq_totient`](Cosets.lean#L84))**

Judson 6.3.1: $|U(n)| = \varphi(n)$ — `ZMod.card_units_eq_totient`.

**Theorem ([`euler`](Cosets.lean#L88))**

Judson 6.3.2 (Euler's theorem): if $\gcd(x, n) = 1$ then $x^{\varphi(n)} \equiv 1 \pmod{n}$ — `Nat.ModEq.pow_totient`.

**Theorem ([`fermat`](Cosets.lean#L92))**

Judson 6.3.3 (Fermat's little theorem): $a^p = a$ in $\mathbb{Z}_p$ for prime $p$ — `ZMod.pow_card`.
