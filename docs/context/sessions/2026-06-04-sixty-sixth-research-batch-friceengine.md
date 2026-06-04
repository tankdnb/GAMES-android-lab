# Session Note

## Summary

- Completed `BATCH-2026-06-04-AI` for `icela/FriceEngine`.
- Added durable findings and a catalog card, updated registries plus public and internal snapshot counts, and kept the repository as `reference-only` instead of promoting it into the main accepted catalog.
- Exhausted the current exact-license shortlist, so the next run must refresh `research/registry/CANDIDATE_QUEUE.md` before opening another batch.

## Verified State

- `icela/FriceEngine` is now recorded as a `reference-only` repository.
- The investigated commit was `8374f87a286d7323348d7aea8213eaebd64dfe6c`.
- The repository is a desktop JVM engine with:
  - a shared runtime surface split across Swing and JavaFX
  - buffered object and text mutation queues in `Layer`
  - tiny explicit-time helpers such as `FClock`, `FTimer`, and delayed events
  - resource helpers for files, images, URLs, and lightweight preferences
- Its strongest reusable value is the combination of:
  - the clean drawer abstraction across Swing and JavaFX
  - buffered layer mutation instead of direct in-loop list edits
  - small event, timer, and image-resource helpers that are easy to mine selectively
  - compact resource and preference utilities that can inspire Android-side helper seams
- Its most important caveats are:
  - no Android target
  - stale code activity, with the last pushed code on `2019-12-28`
  - `AGPL-3.0` licensing
  - legacy build breakage around the old Bintray plugin and missing `http-builder`
  - verified button-removal bookkeeping bugs in `Layer`
  - a demo-heavy test surface with weak regression coverage
- The repository state should now reflect `66` completed research batches, `72` researched repositories, and a `62 accepted / 10 reference-only` split.
- `research/worktrees/` should be cleaned after the batch and return to only `.gitkeep`.

## Follow-Up

- Refresh the shortlist before the next batch; do not carry an empty queue forward.
- If `FriceEngine` needs a future revisit, keep it narrow: isolate the Swing/JavaFX drawer seam, the buffered mutation pattern, the timer/event helpers, or the resource-cache utilities instead of reopening the whole project broadly.

## References

- `research/batches/BATCH-2026-06-04-AI.md`
- `research/findings/icela-friceengine.md`
- `catalog/projects/icela-friceengine.md`
- `research/registry/CANDIDATE_QUEUE.md`
- `research/registry/RESEARCHED_REPOS.md`
- `docs/context/HANDOFF.md`
