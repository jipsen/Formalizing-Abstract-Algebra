# Integers

**Source.** [`FAA/Ch02Integers.lean`](FAA/Ch02Integers.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications* (ed. 2026-08-04), ch. 2 — [`bibliography/aata-20260811.txt`](../bibliography/aata-20260811.txt). Book numbering `Thm ch.sec.item` (e.g. `Thm 2.2.7`).

**Content.** Induction principles on $\mathbb{Z}$, well-ordering of $\mathbb{N}$, the division algorithm, the greatest common divisor and Bézout's identity, Euclid's lemma, infinitude of primes, and the fundamental theorem of arithmetic — Chapter 2 of the book.

| Lean | Math |
|------|------|
| `S : ℤ → Prop` | a statement $S(n)$ about integers |
| `S : Set ℕ` | a set of positive integers |
| `Int.gcd a b` | $\gcd(a, b)$ |
| `a % b`, `a / b` | remainder $r$ and quotient $q$ of the division of $a$ by $b$ |
| `p.Prime` | $p$ is prime |
| `List.Perm qs ps` | $qs$ is a rearrangement of $ps$ |
| `n.primeFactorsList` | the prime factorization of $n$ as a multiset |

---

**Theorem ([`int_induction`](Ch02Integers.lean#L44))** — aata Principle 2.1.1, first principle of mathematical induction.

If $S(n_0)$ holds, and $S(k) \Rightarrow S(k+1)$ for all $k \geq n_0$, then $S(n)$ holds for all integers $n \geq n_0$.

*Proof.* This is induction on the set $\lbrace n \in \mathbb{Z} : n \geq n_0 \rbrace$ (`Int.leInduction`).

**Theorem ([`two_pow_gt`](Ch02Integers.lean#L49))** — aata Example 2.1.2.

$2^n > n + 4$ for all integers $n \geq 3$.

*Proof.* Induction on $n$. Base: $2^3 = 8 > 7$. Step: $2^{k+1} = 2 \cdot 2^k > 2(k+4) \geq k + 5$ for $k \geq 3$.

**Theorem ([`nine_dvd_ten_pow`](Ch02Integers.lean#L58))** — aata Example 2.1.3.

$9 \mid 10^{n+1} + 3 \cdot 10^n + 5$ for all $n \geq 1$.

*Proof.* Induction on $n$. Base: $9 \mid 10^2 + 30 + 5 = 135$. Step: write $10^{k+2} + 3 \cdot 10^{k+1} + 5 = 10 \cdot (10^{k+1} + 3 \cdot 10^k + 5) - 45$; the first term is divisible by $9$ by the induction hypothesis, and $9 \mid 45$.

**Theorem ([`binomial`](Ch02Integers.lean#L76))** — aata Example 2.1.4, the binomial theorem.

$$(a + b)^n = \sum_{k=0}^{n} \binom{n}{k} a^k b^{\,n-k}$$

for real numbers $a, b$.

*Proof.* Induction on $n$ with Pascal's identity $\binom{n}{k} + \binom{n}{k-1} = \binom{n+1}{k}$; in Mathlib this is `add_pow`.

**Theorem ([`int_strong_induction`](Ch02Integers.lean#L84))** — aata Principle 2.1.5, second principle of mathematical induction.

If $S(n_0)$ holds, and $S(j)$ for all $n_0 \leq j \leq k$ implies $S(k+1)$ for all $k \geq n_0$, then $S(n)$ holds for all $n \geq n_0$.

*Proof.*

> Show: $S(n)$ for all $n \geq n_0$
>
> > Have: every $j$ with $n_0 \leq j \leq n$ satisfies $S$, by ordinary induction on $n$
> > > Base: $j \leq n_0$ forces $j = n_0$, and $S(n_0)$ holds
> > > Step: either $j \leq k$ (induction hypothesis) or $j = k+1$, and then all of $n_0 \leq j' \leq k$ satisfy $S$, so $S(k+1)$ follows by the step hypothesis
>
> > Have: $S(n)$ by taking $j = n$
>
> QED

**Theorem ([`nat_well_ordering`](Ch02Integers.lean#L100))** — aata Principle 2.1.6, the principle of well-ordering.

Every nonempty set of positive integers has a least element.

*Proof.* The least element is the infimum of the set (`Nat.sInf_mem`, `Nat.sInf_le`).

**Theorem ([`one_least_positive`](Ch02Integers.lean#L104))** — aata Lemma 2.1.7.

$1$ is the least positive integer.

*Proof.* $1$ is positive, and every positive $n$ satisfies $1 \leq n$.

**Theorem ([`well_ordering_of_induction`](Ch02Integers.lean#L110))** — aata Thm 2.1.8.

The principle of mathematical induction implies the principle of well-ordering: every nonempty set $S$ of positive integers has a least element.

*Proof.* The book's argument, induction on the claim "if $S$ has an element $\leq n$, then $S$ has a least element":

> Show: $S$ has a least element
>
> > Ass: $S$ contains some element $\leq n$; induction on $n$
> > > Base ($n = 0$): the element $\leq 0$ is $0$, which lies below every element of $S$
> > > Step: either $S$ has an element $\leq k$ — then the induction hypothesis applies — or every element of $S$ is $\geq k+1$, and the element $\leq k+1$ equals $k+1$ and is least
>
> QED

**Theorem ([`division_algorithm`](Ch02Integers.lean#L133))** — aata Thm 2.2.1, the division algorithm.

For $a \in \mathbb{Z}$ and $b > 0$ there exist unique integers $q, r$ with $a = bq + r$ and $0 \leq r < b$.

*Proof.*

> Show: existence and uniqueness of $(q, r)$
>
> > Have: $q = a / b$, $r = a \mathbin{\%} b$ satisfy $a = bq + r$ with $0 \leq r < b$ (`Int.mul_ediv_add_emod`, `Int.emod_nonneg`, `Int.emod_lt_of_pos`)
> > Ass: $a = bq' + r'$ with $0 \leq r' < b$
> > Have: $q' = a/b$ and $r' = a \mathbin{\%} b$ — the pair $(q, r)$ is determined by the equation and bounds (`Int.ediv_emod_unique''`)
>
> QED

**Theorem ([`gcd_common_dvd`](Ch02Integers.lean#L149))** — aata §2.2, definition of the greatest common divisor.

$d = \gcd(a, b)$ is a common divisor of $a$ and $b$, and every common divisor of $a$ and $b$ divides $d$.

*Proof.* `Int.gcd_dvd_left`/`Int.gcd_dvd_right` give the two divisibilities. For the universal property, write $\gcd(a,b) = a \cdot \gcdA + b \cdot \gcdB$ (`Int.gcd_eq_gcd_ab`); any $d$ dividing $a$ and $b$ divides this linear combination.

**Theorem ([`gcd_eq_lin_comb`](Ch02Integers.lean#L158))** — aata Thm 2.2.2, Bézout's identity.

$\gcd(a, b)$ is an integer linear combination of $a$ and $b$: there exist $r, s \in \mathbb{Z}$ with $\gcd(a,b) = ar + bs$.

*Proof.* The extended Euclidean algorithm yields the coefficients (`Int.gcd_eq_gcd_ab` with `gcdA`, `gcdB`).

**Theorem ([`relatively_prime_lin_comb`](Ch02Integers.lean#L163))** — aata Cor 2.2.3.

If $a$ and $b$ are relatively prime, there exist $r, s \in \mathbb{Z}$ with $ar + bs = 1$.

*Proof.* Specialize Bézout's identity to $\gcd(a,b) = 1$.

**Theorem ([`gcd_945_2415`](Ch02Integers.lean#L168))** — aata Example 2.2.4, Euclidean algorithm.

$\gcd(945, 2415) = 105$.

*Proof.* $2415 = 2 \cdot 945 + 525$, $945 = 1 \cdot 525 + 420$, $525 = 1 \cdot 420 + 105$, $420 = 4 \cdot 105$ (`decide`).

**Theorem ([`bezout_945_2415`](Ch02Integers.lean#L171))** — aata Example 2.2.4, back-substitution.

$105 = 945 \cdot (-5) + 2415 \cdot 2$.

*Proof.* Back-substitute the Euclidean remainders (`decide`).

**Theorem ([`euclid_dvd`](Ch02Integers.lean#L175))** — aata Lemma 2.2.5, Euclid's lemma.

If a prime $p$ divides $ab$, then $p \mid a$ or $p \mid b$.

*Proof.* Write $1 = pr + as$ for the case $p \nmid a$, then $b = b(pr + as)$ is divisible by $p$; in Mathlib this is `Int.Prime.dvd_mul'`.

**Theorem ([`primes_infinite`](Ch02Integers.lean#L181))** — aata Thm 2.2.6.

There are infinitely many primes: above any bound $n$ there is a prime.

*Proof.* Any prime factor of $n! + 1$ exceeds $n$ (`Nat.exists_infinite_primes`).

**Theorem ([`fundamental_theorem_arithmetic`](Ch02Integers.lean#L187))** — aata Thm 2.2.7, the fundamental theorem of arithmetic.

Every integer $n \geq 2$ is a product of primes, uniquely up to the order of the factors.

*Proof.*

> Show: a prime factorization exists and is unique up to permutation
>
> > Have: `n.primeFactorsList` is a list of primes whose product is $n$ (`Nat.prime_of_mem_primeFactorsList`, `Nat.prod_primeFactorsList`)
> > Ass: $qs$ is a list of primes with product $n$
> > Have: $qs$ is a permutation of `n.primeFactorsList` (`Nat.primeFactorsList_unique`)
>
> QED
