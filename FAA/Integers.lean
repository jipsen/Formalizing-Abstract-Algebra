-- Sidecar: FAA/Integers.md
/-
Copyright (c) 2026 Formalizing-Abstract-Algebra contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Formalizing-Abstract-Algebra contributors
-/
import Mathlib.Data.Int.GCD
import Mathlib.Data.Nat.Factors
import Mathlib.Data.Nat.PrimeFin
import Mathlib.Order.Lattice.Nat
import Mathlib.RingTheory.Int.Basic

/-!
# The Integers

Judson, *Abstract Algebra: Theory and Applications*, Chapter 2:
mathematical induction, the division algorithm, the Euclidean algorithm,
and the Fundamental Theorem of Arithmetic.

## Statements

- Judson 2.1.1 / 2.1.5 (induction): `induction_principle`, `strong_induction_principle`
- Judson 2.1.6 / 2.1.8 (well-ordering): `well_ordering`
- Judson 2.2.1 (division algorithm): `division_algorithm`
- Judson 2.2.2–3 (gcd as a linear combination): `gcd_eq_linear_combination`,
  `exists_eq_one_of_gcd_eq_one`
- Judson 2.2.5 (Euclid's lemma): `euclid_lemma`
- Judson 2.2.6 (infinitude of primes): `infinite_primes`
- Judson 2.2.7 (fundamental theorem of arithmetic): `exists_prime_factorization`,
  `prime_factorization_unique`
-/

namespace AATA

section Induction

/-- **Judson 2.1.1** (First Principle of Mathematical Induction).
`S(1)` and `S(k) → S(k + 1)` for all `k ≥ 1` give `S(n)` for all `n ≥ 1`. -/
theorem induction_principle {P : ℕ → Prop} (h1 : P 1)
    (hk : ∀ k ≥ 1, P k → P (k + 1)) : ∀ n ≥ 1, P n :=
  fun n hn ↦ Nat.le_induction h1 (fun k h1k hPk ↦ hk k h1k hPk) n hn

/-- **Judson 2.1.5** (Second Principle of Mathematical Induction).
If `S(n)` follows from `S(m)` for all `m < n`, then `S(n)` holds for every `n`. -/
theorem strong_induction_principle {P : ℕ → Prop}
    (h : ∀ n, (∀ m < n, P m) → P n) : ∀ n, P n :=
  fun n ↦ Nat.strong_induction_on n h

/-- **Judson 2.1.6 / 2.1.8** (Well-Ordering). Every nonempty subset of `ℕ` has a least element. -/
theorem well_ordering {S : Set ℕ} (hS : S.Nonempty) : ∃ m ∈ S, ∀ n ∈ S, m ≤ n :=
  ⟨sInf S, Nat.sInf_mem hS, fun _n hn ↦ Nat.sInf_le hn⟩

end Induction

section DivisionAlgorithm

/-- **Judson 2.2.1** (Division Algorithm).
For `b > 0` there are unique `q r : ℤ` with `a = b * q + r` and `0 ≤ r < b`. -/
theorem division_algorithm (a : ℤ) {b : ℤ} (hb : 0 < b) :
    ∃! qr : ℤ × ℤ, a = b * qr.1 + qr.2 ∧ 0 ≤ qr.2 ∧ qr.2 < b := by
  refine ⟨⟨a / b, a % b⟩,
    ⟨(Int.mul_ediv_add_emod a b).symm, Int.emod_nonneg _ hb.ne', Int.emod_lt_of_pos _ hb⟩,
    ?_⟩
  rintro ⟨q, r⟩ ⟨ha, hr0, hrb⟩
  have key : r + b * q = a := by rw [add_comm]; exact ha.symm
  obtain ⟨hq, hr⟩ := (Int.ediv_emod_unique hb).2 ⟨key, hr0, hrb⟩
  exact Prod.ext_iff.2 ⟨hq.symm, hr.symm⟩

/-- **Judson 2.2.2** (Bézout). `gcd a b` is an integer linear combination `a * r + b * s`. -/
theorem gcd_eq_linear_combination (a b : ℤ) :
    ∃ r s : ℤ, (Int.gcd a b : ℤ) = a * r + b * s :=
  ⟨Int.gcdA a b, Int.gcdB a b, Int.gcd_eq_gcd_ab a b⟩

/-- **Judson 2.2.3** (corollary). `gcd a b = 1` gives `a * r + b * s = 1` for some `r s : ℤ`. -/
theorem exists_eq_one_of_gcd_eq_one {a b : ℤ} (h : Int.gcd a b = 1) :
    ∃ r s : ℤ, a * r + b * s = 1 := by
  refine ⟨Int.gcdA a b, Int.gcdB a b, ?_⟩
  have key := (Int.gcd_eq_gcd_ab a b).symm
  rw [h] at key
  simpa using key

/-- **Judson 2.2.5** (Euclid's lemma). A prime dividing `a * b` divides `a` or `b`. -/
theorem euclid_lemma {p : ℕ} (hp : p.Prime) {a b : ℤ} (h : (p : ℤ) ∣ a * b) :
    (p : ℤ) ∣ a ∨ (p : ℤ) ∣ b :=
  Int.Prime.dvd_mul' hp h

end DivisionAlgorithm

section PrimeNumbers

/-- **Judson 2.2.6** (Euclid). There are infinitely many primes. -/
theorem infinite_primes : { p : ℕ | p.Prime }.Infinite :=
  Nat.infinite_setOfPred_prime

/-- **Judson 2.2.7** (FTA, existence). Every `n > 1` is a product of primes. -/
theorem exists_prime_factorization {n : ℕ} (hn : 1 < n) :
    ∃ l : List ℕ, (∀ p ∈ l, p.Prime) ∧ l.prod = n :=
  ⟨n.primeFactorsList, fun _p hp ↦ Nat.prime_of_mem_primeFactorsList hp,
    Nat.prod_primeFactorsList (by omega)⟩

/-- **Judson 2.2.7** (FTA, uniqueness). Prime factorizations are unique up to permutation. -/
theorem prime_factorization_unique {n : ℕ} {l l' : List ℕ}
    (hl : l.prod = n) (hlp : ∀ p ∈ l, p.Prime)
    (hl' : l'.prod = n) (hlp' : ∀ p ∈ l', p.Prime) : List.Perm l l' :=
  (Nat.primeFactorsList_unique hl hlp).trans (Nat.primeFactorsList_unique hl' hlp').symm

end PrimeNumbers

end AATA
