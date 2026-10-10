# FAA.Integers

**Source.** [`Integers.lean`](Integers.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications*, Chapter 2 (induction, the division algorithm, the Euclidean algorithm, prime numbers).

**Content.** The two induction principles, well-ordering of $\mathbb{N}$, the division algorithm on $\mathbb{Z}$, Bézout's identity for $\gcd$, Euclid's lemma, the infinitude of primes, and the fundamental theorem of arithmetic — each stated in the book's form and proved from the corresponding Mathlib fact.

| Lean | Math |
|------|------|
| `Int.gcd a b` | $\gcd(a, b)$ |
| `a / b`, `a % b` | quotient $q$ and remainder $r$ of $a$ by $b$ |
| `sInf S` | $\inf S$, least element of a nonempty $S \subseteq \mathbb{N}$ |
| `p.Prime` | $p$ prime |
| `List.Perm l l'` | $l'$ a rearrangement of $l$ |
| `n.primeFactorsList` | the list of prime factors of $n$ |

---

**Theorem ([`induction_principle`](Integers.lean#L39))**

Judson 2.1.1 (First Principle of Mathematical Induction): if $S(1)$ holds and $S(k) \Rightarrow S(k+1)$ for every $k \geq 1$, then $S(n)$ holds for every $n \geq 1$ — `Nat.le_induction` at $m = 1$.

**Theorem ([`strong_induction_principle`](Integers.lean#L45))**

Judson 2.1.5 (Second Principle of Mathematical Induction): if $S(n)$ follows whenever $S(m)$ holds for all $m < n$, then $S(n)$ holds for every $n$ — `Nat.strong_induction_on`.

**Theorem ([`well_ordering`](Integers.lean#L50))**

Judson 2.1.6 / 2.1.8 (Principle of Well-Ordering): every nonempty $S \subseteq \mathbb{N}$ contains a least element — the least element is $\inf S$ (`Nat.sInf_mem`, `Nat.sInf_le`).

**Theorem ([`division_algorithm`](Integers.lean#L59))**

Judson 2.2.1 (Division Algorithm): for integers $a$ and $b$ with $b > 0$ there exist unique integers $q$ and $r$ with $a = bq + r$ and $0 \leq r < b$.

*Proof.*

> Show: $\exists!\, (q, r)$ with $a = bq + r \;\land\; 0 \leq r < b$
> Have: the pair $(q, r) = (a/b,\, a \bmod b)$ satisfies the conditions — `Int.mul_ediv_add_emod`, `Int.emod_nonneg`, `Int.emod_lt_of_pos`
> Ass: $(q', r')$ also satisfies $a = bq' + r'$ with $0 \leq r' < b$
> Have: $q' = a/b$ and $r' = a \bmod b$ — uniqueness clause of `Int.ediv_emod_unique` applied to $r' + bq' = a$
> QED

**Theorem ([`gcd_eq_linear_combination`](Integers.lean#L70))**

Judson 2.2.2 (Bézout): $\gcd(a, b) = ar + bs$ for some integers $r$, $s$ — the extended Euclidean algorithm produces the witnesses `Int.gcdA`, `Int.gcdB` (`Int.gcd_eq_gcd_ab`).

**Theorem ([`exists_eq_one_of_gcd_eq_one`](Integers.lean#L75))**

Judson 2.2.3 (corollary): relatively prime integers satisfy $ar + bs = 1$ — specialization of Bézout at $\gcd(a,b) = 1$.

**Theorem ([`euclid_lemma`](Integers.lean#L83))**

Judson 2.2.5 (Euclid's lemma): a prime $p$ dividing $ab$ divides $a$ or divides $b$ — `Int.Prime.dvd_mul'`.

**Theorem ([`infinite_primes`](Integers.lean#L92))**

Judson 2.2.6 (Euclid): there are infinitely many primes — the set $\{p \mid p \text{ prime}\} \subseteq \mathbb{N}$ is infinite (`Nat.infinite_setOfPred_prime`).

**Theorem ([`exists_prime_factorization`](Integers.lean#L96))**

Judson 2.2.7 (existence): every integer $n > 1$ is a product of primes — the factors are `n.primeFactorsList`, a list of primes with product $n$ (`Nat.prime_of_mem_primeFactorsList`, `Nat.prod_primeFactorsList`).

**Theorem ([`prime_factorization_unique`](Integers.lean#L102))**

Judson 2.2.7 (uniqueness): two prime factorizations of $n$ are equal up to rearrangement — each is a permutation of `n.primeFactorsList` (`Nat.primeFactorsList_unique`), so they are permutations of each other.
