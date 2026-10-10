---
name: faa-log
description: >-
  Append brief progress entries to LOG.md during FAA work — what was done,
  mistakes hit, fixes applied. Use when the user says log, progress log,
  work log, or as a running habit during multi-step tasks.
argument-hint: "[entry text]"
disable-model-invocation: false
triggers:
  - user
allowed-tools:
  - read
  - write
  - edit
permissions:
  allow:
    - Read(**)
    - Write(LOG.md)
---

# FAA log

Keep a lightweight work log in [`LOG.md`](../../LOG.md) at the repo root.

## Format

- One `## YYYY-MM-DD — <task>` section per work session, newest at the bottom.
- Bullet lines only: what was done, mistakes hit, fixes applied, verification results.
- Terse — a few bullets per milestone, not per tool call. No narration of plans, no code dumps, no commit hashes.
- If `LOG.md` does not exist, create it with a `# Log` header.

## What to record

- Files created/edited and why (one line).
- Compile/build/test outcomes; errors and the fix that resolved them.
- Naming or convention decisions (point to `docs/rosetta.md` rows rather than restating them).
- Skill runs (`faa-maintain`, `faa-semi-informalize`, …) that changed files.

## What not to record

- Routine reads and searches, TODO bookkeeping, anything already obvious from `git diff`.
- Explanations of the mathematics — the Fitch sidecars own that.
