-- Sidecar: FAA/Ch02Integers.md
import Mathlib.Data.Int.Init
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.Int.GCD
import Mathlib.Data.Nat.Choose.Sum
import Mathlib.Data.Nat.Factors
import Mathlib.Data.Nat.Prime.Infinite
import Mathlib.Data.Real.Basic
import Mathlib.Order.Lattice.Nat
import Mathlib.RingTheory.Int.Basic

/-!
# The Integers (aata ch 2)

Induction, the division algorithm, the greatest common divisor, and the
fundamental theorem of arithmetic, following Judson, *Abstract Algebra: Theory
and Applications*, Chapter 2. The book's induction principles are stated over
the integers `n ≥ n₀`; its well-ordering principle is stated over `ℕ`.

## Main declarations

* `int_induction` — aata Principle 2.1.1, first principle of induction on `ℤ`.
* `two_pow_gt`, `nine_dvd_ten_pow`, `binomial` — aata Ex 2.1.2, 2.1.3, 2.1.4.
* `int_strong_induction` — aata Principle 2.1.5, second (strong) induction.
* `nat_well_ordering` — aata Principle 2.1.6, well-ordering of `ℕ`.
* `one_least_positive` — aata Lemma 2.1.7, `1` is the least positive integer.
* `well_ordering_of_induction` — aata Thm 2.1.8, induction implies well-ordering.
* `division_algorithm` — aata Thm 2.2.1, existence and uniqueness of `q, r`.
* `gcd_common_dvd`, `gcd_eq_lin_comb` — aata §2.2 gcd definition, Thm 2.2.2.
* `relatively_prime_lin_comb` — aata Cor 2.2.3.
* `gcd_945_2415`, `bezout_945_2415` — aata Ex 2.2.4, Euclidean algorithm.
* `euclid_dvd` — aata Lemma 2.2.5, Euclid's lemma.
* `primes_infinite` — aata Thm 2.2.6, infinitely many primes.
* `fundamental_theorem_arithmetic` — aata Thm 2.2.7, unique prime factorization.
-/

namespace FAA

/-! ### Induction (aata §2.1) -/

/-- aata Principle 2.1.1, first principle of mathematical induction: if `S(n₀)`
holds and `S(k)` implies `S(k + 1)` for all `k ≥ n₀`, then `S(n)` holds for all
`n ≥ n₀`. This is `Int.leInduction`. -/
theorem int_induction {n₀ : ℤ} {S : ℤ → Prop} (h0 : S n₀)
    (hstep : ∀ k ≥ n₀, S k → S (k + 1)) : ∀ n ≥ n₀, S n :=
  fun n hn ↦ Int.leInduction h0 (fun k hk hSk ↦ hstep k hk hSk) n hn

/-- aata Example 2.1.2: `2 ^ n > n + 4` for all `n ≥ 3`. -/
theorem two_pow_gt (n : ℕ) (hn : 3 ≤ n) : n + 4 < 2 ^ n := by
  induction n, hn using Nat.le_induction with
  | base => decide
  | succ k hk ih =>
      rw [pow_succ]
      omega

/-- aata Example 2.1.3: `9` divides `10 ^ (n + 1) + 3 * 10 ^ n + 5` for `n ≥ 1`.
The inductive step factors `10` out of the first two terms and subtracts `45`. -/
theorem nine_dvd_ten_pow (n : ℕ) (hn : 1 ≤ n) : 9 ∣ 10 ^ (n + 1) + 3 * 10 ^ n + 5 := by
  induction n, hn using Nat.le_induction with
  | base => decide
  | succ k hk ih =>
      obtain ⟨m, hm⟩ := ih
      refine ⟨10 * m - 5, ?_⟩
      rw [Nat.mul_sub]
      have hsum : 10 ^ (k + 2) + 3 * 10 ^ (k + 1) + 5 + 45 = 9 * (10 * m) := by
        calc 10 ^ (k + 2) + 3 * 10 ^ (k + 1) + 5 + 45
            = 10 * (10 ^ (k + 1) + 3 * 10 ^ k + 5) := by
              rw [pow_succ 10 (k + 1), pow_succ 10 k]
              ring
          _ = 10 * (9 * m) := by rw [hm]
          _ = 9 * (10 * m) := by ring
      omega

/-- aata Example 2.1.4, the binomial theorem: `(a + b) ^ n` expands as a sum of
`n.choose k`-weighted monomials. Stated for real `a, b`; this is `add_pow`. -/
theorem binomial (a b : ℝ) (n : ℕ) :
    (a + b) ^ n = ∑ k ∈ Finset.range (n + 1), a ^ k * b ^ (n - k) * n.choose k :=
  add_pow a b n

/-- aata Principle 2.1.5, second principle of mathematical induction: if `S(n₀)`
holds and `S(j)` for all `n₀ ≤ j ≤ k` implies `S(k + 1)` for all `k ≥ n₀`, then
`S(n)` holds for all `n ≥ n₀`. Proved by ordinary induction on the strengthened
statement "every `j` with `n₀ ≤ j ≤ n` satisfies `S`". -/
theorem int_strong_induction {n₀ : ℤ} {S : ℤ → Prop} (h0 : S n₀)
    (hstep : ∀ k ≥ n₀, (∀ j, n₀ ≤ j → j ≤ k → S j) → S (k + 1)) :
    ∀ n ≥ n₀, S n := by
  intro n hn
  have key : ∀ j, n₀ ≤ j → j ≤ n → S j := by
    induction n, hn using Int.leInduction with
    | base => intro j hj₁ hj₂; rwa [le_antisymm hj₂ hj₁]
    | succ k hk ih =>
        intro j hj₁ hj₂
        rcases eq_or_lt_of_le hj₂ with rfl | hlt
        · exact hstep k hk ih
        · exact ih j hj₁ (Int.lt_add_one_iff.mp hlt)
  exact key n hn (le_refl n)

/-- aata Principle 2.1.6, the principle of well-ordering: every nonempty set of
natural numbers has a least element. This is `Nat.sInf_mem`/`Nat.sInf_le`. -/
theorem nat_well_ordering {S : Set ℕ} (hS : S.Nonempty) : ∃ a ∈ S, ∀ b ∈ S, a ≤ b :=
  ⟨sInf S, Nat.sInf_mem hS, fun _b hb ↦ Nat.sInf_le hb⟩

/-- aata Lemma 2.1.7: `1` is the least positive natural number. -/
theorem one_least_positive : IsLeast {n : ℕ | 0 < n} 1 :=
  ⟨Nat.one_pos, fun _b hb ↦ hb⟩

/-- aata Thm 2.1.8: the principle of mathematical induction implies the
principle of well-ordering. The proof is the book's induction on `n` of the
claim "if `S` contains an element `≤ n`, then `S` has a least element". -/
theorem well_ordering_of_induction {S : Set ℕ} (hS : S.Nonempty) :
    ∃ a ∈ S, ∀ b ∈ S, a ≤ b := by
  obtain ⟨n, hn⟩ := hS
  suffices key : ∀ n, (∃ s ∈ S, s ≤ n) → ∃ a ∈ S, ∀ b ∈ S, a ≤ b from
    key n ⟨n, hn, le_refl n⟩
  intro n
  induction n with
  | zero =>
      rintro ⟨s, hs, hs0⟩
      rw [Nat.le_zero] at hs0
      exact ⟨0, hs0 ▸ hs, fun b _ ↦ Nat.zero_le b⟩
  | succ k ih =>
      rintro ⟨s, hs, hsk⟩
      by_cases h : ∃ s' ∈ S, s' ≤ k
      · exact ih h
      · push Not at h
        have hsk' : s = k + 1 := le_antisymm hsk (Nat.succ_le_of_lt (h s hs))
        exact ⟨s, hs, fun b hb ↦ hsk' ▸ Nat.succ_le_of_lt (h b hb)⟩

/-! ### The division algorithm and gcd (aata §2.2) -/

/-- aata Thm 2.2.1, the division algorithm: for `a ∈ ℤ` and `b > 0` there exist
unique integers `q, r` with `a = b * q + r` and `0 ≤ r < b`. -/
theorem division_algorithm {a b : ℤ} (hb : 0 < b) :
    ∃! qr : ℤ × ℤ, a = b * qr.1 + qr.2 ∧ 0 ≤ qr.2 ∧ qr.2 < b := by
  refine ⟨⟨a / b, a % b⟩, ⟨?_, ?_, ?_⟩, ?_⟩
  · exact (Int.mul_ediv_add_emod a b).symm
  · exact Int.emod_nonneg a hb.ne'
  · exact Int.emod_lt_of_pos a hb
  · rintro ⟨q, r⟩ ⟨hqr, hr0, hrb⟩
    have hqa : a = b * q + r := hqr
    have hr0a : 0 ≤ r := hr0
    have hrba : r < b := hrb
    obtain ⟨hq, hr⟩ : a / b = q ∧ a % b = r := (Int.ediv_emod_unique'' hb.ne').mpr
      ⟨by rw [hqa, add_comm], hr0a, by rwa [abs_of_pos hb]⟩
    exact Prod.ext_iff.mpr ⟨hq.symm, hr.symm⟩

/-- aata §2.2, definition of the greatest common divisor: `gcd a b` is a common
divisor of `a` and `b`, and every common divisor of `a` and `b` divides it. -/
theorem gcd_common_dvd (a b : ℤ) :
    (Int.gcd a b : ℤ) ∣ a ∧ (Int.gcd a b : ℤ) ∣ b ∧
      ∀ d : ℤ, d ∣ a → d ∣ b → d ∣ (Int.gcd a b : ℤ) :=
  ⟨Int.gcd_dvd_left a b, Int.gcd_dvd_right a b, fun d hda hdb ↦ by
    rw [Int.gcd_eq_gcd_ab]
    exact Int.dvd_add (hda.mul_right _) (hdb.mul_right _)⟩

/-- aata Thm 2.2.2 (Bézout): the greatest common divisor of `a` and `b` is an
integer linear combination of `a` and `b`. This is `Int.gcd_eq_gcd_ab`. -/
theorem gcd_eq_lin_comb (a b : ℤ) : ∃ r s : ℤ, (Int.gcd a b : ℤ) = a * r + b * s :=
  ⟨Int.gcdA a b, Int.gcdB a b, Int.gcd_eq_gcd_ab a b⟩

/-- aata Cor 2.2.3: if `a` and `b` are relatively prime (`gcd a b = 1`), there
exist integers `r, s` with `a * r + b * s = 1`. -/
theorem relatively_prime_lin_comb {a b : ℤ} (h : Int.gcd a b = 1) :
    ∃ r s : ℤ, a * r + b * s = 1 :=
  ⟨Int.gcdA a b, Int.gcdB a b, by rw [← Int.gcd_eq_gcd_ab a b, h, Nat.cast_one]⟩

/-- aata Example 2.2.4, the Euclidean algorithm: `gcd 945 2415 = 105`. -/
theorem gcd_945_2415 : Int.gcd 945 2415 = 105 := by decide

/-- aata Example 2.2.4, back-substitution: `105 = 945 * (-5) + 2415 * 2`. -/
theorem bezout_945_2415 : (945 : ℤ) * (-5) + 2415 * 2 = 105 := by decide

/-- aata Lemma 2.2.5 (Euclid's lemma): if a prime `p` divides `a * b`, then
`p` divides `a` or `p` divides `b`. This is `Int.Prime.dvd_mul`. -/
theorem euclid_dvd {p : ℕ} (hp : p.Prime) {a b : ℤ} :
    (p : ℤ) ∣ a * b → (p : ℤ) ∣ a ∨ (p : ℤ) ∣ b :=
  fun h ↦ Int.Prime.dvd_mul' hp h

/-- aata Thm 2.2.6: there are infinitely many primes — above any bound `n`
there is a prime. This is `Nat.exists_infinite_primes`. -/
theorem primes_infinite (n : ℕ) : ∃ p ≥ n, p.Prime :=
  Nat.exists_infinite_primes n

/-- aata Thm 2.2.7, the fundamental theorem of arithmetic: every `n ≥ 2` is a
product of primes, uniquely up to a permutation of the factors. Existence is
`Nat.prod_primeFactorsList`; uniqueness is `Nat.primeFactorsList_unique`. -/
theorem fundamental_theorem_arithmetic {n : ℕ} (hn : 2 ≤ n) :
    ∃ ps : List ℕ, (∀ p ∈ ps, p.Prime) ∧ ps.prod = n ∧
      ∀ qs : List ℕ, (∀ q ∈ qs, q.Prime) → qs.prod = n → List.Perm qs ps := by
  refine ⟨n.primeFactorsList, fun _p hp ↦ Nat.prime_of_mem_primeFactorsList hp,
    Nat.prod_primeFactorsList (by omega), fun qs hq hprod ↦ ?_⟩
  exact Nat.primeFactorsList_unique hprod hq

end FAA
