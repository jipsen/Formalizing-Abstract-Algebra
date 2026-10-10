# Preliminaries

**Source.** [`FAA/Ch01Preliminaries.lean`](FAA/Ch01Preliminaries.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications* (ed. 2026-08-04), ch. 1 §1.2 — [`bibliography/aata-20260811.txt`](../bibliography/aata-20260811.txt). Book numbering `Thm ch.sec.item` (e.g. `Thm 1.2.25`).

**Content.** Sets, functions, equivalence relations, and partitions — Chapter 1, §1.2 of the book; §1.1 (a note on proofs) carries no formalized content.

| Lean | Math |
|------|------|
| `s t u : Set α` | $A, B, C \subseteq X$ |
| `f g h` | $f : A \to B$, $g : B \to C$, $h : C \to D$ |
| `s : Setoid α` | an equivalence relation $\sim$ on $X$ |
| `s.classes` | the equivalence classes $[x] = \lbrace y : y \sim x \rbrace$ |
| `Setoid.IsPartition P` | a partition $\mathcal{P}$ of $X$ |
| `LeftInverse g f`, `RightInverse g f` | $g \circ f = \mathrm{id}_A$, $f \circ g = \mathrm{id}_B$ |
| `Int.ModEq n a b` | $a \equiv b \pmod n$ |

---

**Theorem ([`set_idem`](Ch01Preliminaries.lean#L34))** — aata Prop 1.2.2 (1).

$A \cup A = A$, $A \cap A = A$, and $A \setminus A = \emptyset$.

*Proof.* Idempotence of $\cup$ and $\cap$ and emptiness of the self-difference (`union_self`, `inter_self`, `Set.sdiff_self`).

**Theorem ([`set_empty`](Ch01Preliminaries.lean#L38))** — aata Prop 1.2.2 (2).

$A \cup \emptyset = A$ and $A \cap \emptyset = \emptyset$.

*Proof.* $\emptyset$ is the unit of $\cup$ and annihilates $\cap$ (`union_empty`, `inter_empty`).

**Theorem ([`union_assoc'`](Ch01Preliminaries.lean#L42))** — aata Prop 1.2.2 (3).

$A \cup (B \cup C) = (A \cup B) \cup C$.

*Proof.* Associativity of $\cup$ (`union_assoc`, reversed to the book's order).

**Theorem ([`inter_assoc'`](Ch01Preliminaries.lean#L46))** — aata Prop 1.2.2 (3).

$A \cap (B \cap C) = (A \cap B) \cap C$.

*Proof.* Associativity of $\cap$ (`inter_assoc`, reversed).

**Theorem ([`set_comm`](Ch01Preliminaries.lean#L50))** — aata Prop 1.2.2 (4).

$A \cup B = B \cup A$ and $A \cap B = B \cap A$.

*Proof.* Commutativity of $\cup$ and $\cap$ (`union_comm`, `inter_comm`).

**Theorem ([`union_inter_distrib`](Ch01Preliminaries.lean#L54))** — aata Prop 1.2.2 (5).

$A \cup (B \cap C) = (A \cup B) \cap (A \cup C)$.

*Proof.* Distributivity of $\cup$ over $\cap$ (`union_inter_distrib_left`).

**Theorem ([`inter_union_distrib`](Ch01Preliminaries.lean#L58))** — aata Prop 1.2.2 (6).

$A \cap (B \cup C) = (A \cap B) \cup (A \cap C)$.

*Proof.* Distributivity of $\cap$ over $\cup$ (`inter_union_distrib_left`).

**Theorem ([`compl_union'`](Ch01Preliminaries.lean#L62))** — aata Thm 1.2.3 (1).

$(A \cup B)' = A' \cap B'$.

*Proof.* De Morgan for $\cup$ (`compl_union`).

**Theorem ([`compl_inter'`](Ch01Preliminaries.lean#L66))** — aata Thm 1.2.3 (2).

$(A \cap B)' = A' \cup B'$.

*Proof.* De Morgan for $\cap$ (`compl_inter`).

**Theorem ([`comp_assoc'`](Ch01Preliminaries.lean#L72))** — aata Thm 1.2.15 (1).

$(h \circ g) \circ f = h \circ (g \circ f)$.

*Proof.* Both sides map $a$ to $h(g(f(a)))$ (`comp_assoc`).

**Theorem ([`injective_comp`](Ch01Preliminaries.lean#L76))** — aata Thm 1.2.15 (2).

If $f$ and $g$ are one-to-one, so is $g \circ f$.

*Proof.* `Function.Injective.comp`.

**Theorem ([`surjective_comp`](Ch01Preliminaries.lean#L80))** — aata Thm 1.2.15 (3).

If $f$ and $g$ are onto, so is $g \circ f$.

*Proof.* Given $c$, take $b$ with $g(b) = c$, then $a$ with $f(a) = b$ (`Function.Surjective.comp`).

**Theorem ([`bijective_comp`](Ch01Preliminaries.lean#L84))** — aata Thm 1.2.15 (4).

If $f$ and $g$ are bijective, so is $g \circ f$.

*Proof.* Conjunction of the previous two (`Function.Bijective.comp`).

**Theorem ([`invertible_iff_bijective`](Ch01Preliminaries.lean#L89))** — aata Thm 1.2.20.

A map $f : A \to B$ has an inverse iff it is bijective: $(\exists g, g \circ f = \mathrm{id}_A \wedge f \circ g = \mathrm{id}_B) \iff f$ bijective.

*Proof.* Forward: left cancellation gives injectivity, $f(g(b)) = b$ gives surjectivity. Back: surjectivity chooses a preimage, injectivity makes it unique (`bijective_iff_has_inverse`).

**Theorem ([`classes_partition`](Ch01Preliminaries.lean#L97))** — aata Thm 1.2.25, forward direction.

The equivalence classes $[x]$ of $\sim$ form a partition of $X$.

*Proof.* Each class is nonempty since $x \in [x]$; each $a$ lies in the unique class $[a]$ (`isPartition_classes`).

**Theorem ([`partition_setoid`](Ch01Preliminaries.lean#L102))** — aata Thm 1.2.25, converse.

A partition $\mathcal{P}$ of $X$ determines an equivalence relation whose classes are exactly the blocks of $\mathcal{P}$.

*Proof.* Declare $x \sim y$ when every block containing $x$ contains $y$ (`mkClasses`); its classes recover $\mathcal{P}$ (`classes_mkClasses`).

**Theorem ([`eqv_classes_disjoint_or_eq`](Ch01Preliminaries.lean#L107))** — aata Cor 1.2.26.

Two equivalence classes $[x]$, $[y]$ are either disjoint or equal.

*Proof.*

> Show: $[x] \cap [y] = \emptyset$ or $[x] = [y]$
>
> > Ass: some $z \in [x] \cap [y]$
> > Have: $z \sim x$ and $z \sim y$, so $x \sim y$ by symmetry and transitivity
> > Have: $[x] = [y]$ (a member of two classes lies in equal classes — `eq_of_mem_classes`)
>
> QED

**Theorem ([`intModEq_equiv`](Ch01Preliminaries.lean#L117))** — aata Ex 1.2.30.

Congruence modulo $n$ is an equivalence relation on $\mathbb{Z}$.

*Proof.* Reflexive since $n \mid r - r$; symmetric since $n \mid s - r$ gives $n \mid r - s$; transitive since $n \mid r - s$ and $n \mid s - t$ give $n \mid (r - s) + (s - t) = r - t$ (`Int.ModEq.refl`, `.symm`, `.trans`).
