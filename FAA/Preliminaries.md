# FAA.Preliminaries

**Source.** [`Preliminaries.lean`](Preliminaries.lean)

**Book.** Judson, *Abstract Algebra: Theory and Applications*, Chapter 1 (sets, mappings, equivalence relations and partitions).

**Content.** De Morgan's laws, composition properties of mappings, the bijective–invertible equivalence, and the correspondence between partitions and equivalence classes — each stated in the book's form and proved from the corresponding Mathlib fact.

| Lean | Math |
|------|------|
| `s.r x a` | $x \sim a$ (the setoid relation) |
| `s.classes` | the equivalence classes $[x] = \{y \mid y \sim x\}$ |
| `Setoid.IsPartition P` | $P$ partitions $X$: no empty block, each $x$ in a unique block |
| `Function.LeftInverse g f ∧ Function.RightInverse g f` | $f$ invertible with inverse $g$ |

---

**Theorem ([`deMorgan_union`](Preliminaries.lean#L34))** / ([`deMorgan_inter`](Preliminaries.lean#L38))

De Morgan's laws (Judson 1.2.3): $(A \cup B)' = A' \cap B'$ and $(A \cap B)' = A' \cup B'$ — instantiations of `Set.compl_union` / `Set.compl_inter`.

**Theorem ([`comp_assoc`](Preliminaries.lean#L48))**

Judson 1.2.15(1): composition of mappings is associative, $(h \circ g) \circ f = h \circ (g \circ f)$.

*Remark:* definitional (`rfl`).

**Theorem ([`injective_comp`](Preliminaries.lean#L52))** / ([`surjective_comp`](Preliminaries.lean#L57)) / ([`bijective_comp`](Preliminaries.lean#L62))

Judson 1.2.15(2–4): the composite $g \circ f$ of two one-to-one (resp. onto, bijective) mappings is one-to-one (resp. onto, bijective) — the Mathlib `comp` lemmas for `Injective` / `Surjective` / `Bijective`.

**Theorem ([`bijective_iff_invertible`](Preliminaries.lean#L67))**

Judson 1.2.20: $f$ is invertible if and only if it is both one-to-one and onto — `Function.bijective_iff_has_inverse`.

**Theorem ([`eqvClasses_isPartition`](Preliminaries.lean#L79))**

Judson 1.2.25 (forward): the equivalence classes of an equivalence relation $\sim$ on $X$ form a partition of $X$ — `Setoid.isPartition_classes`.

**Theorem ([`exists_setoid_classes`](Preliminaries.lean#L83))**

Judson 1.2.25 (converse): if $P$ is a partition of $X$, there is an equivalence relation on $X$ whose equivalence classes are exactly the blocks of $P$ — `Setoid.mkClasses` builds the relation ("same block"), and `Setoid.classes_mkClasses` identifies its classes with $P$.

**Theorem ([`eqv_class_eq_or_disjoint`](Preliminaries.lean#L88))**

Judson 1.2.26 (corollary): two equivalence classes of an equivalence relation are either disjoint or equal.

*Proof.*

> Show: $[a] = [b]$ or $[a] \cap [b] = \varnothing$
> Ass: $[a] \cap [b] \neq \varnothing$, say $z \in [a] \cap [b]$
> Have: $[a] = [b]$ — a partition puts each element in a unique block, and $z$ lies in both classes (`Setoid.eq_of_mem_classes`)
> QED
