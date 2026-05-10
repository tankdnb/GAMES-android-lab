# Handoff

## Current Snapshot

- The repository is a documentation-first research catalog for Android-relevant game projects.
- A compact Codex file-memory system is now in place under `docs/context/`.
- Project policy now requires documenting each meaningful work session and making a local commit after each completed work unit.
- A dedicated research workflow now exists under `research/`, including a batch rule, queue, researched registry, category index, findings templates, and cleanup script.
- The workflow now also includes normalized catalog categories, batch notes, and a dedicated code-analysis guide for evaluating cloned repositories.
- The first real research batch is now completed and documented end-to-end.
- The lab now has 4 researched repositories recorded:
  - `lucasnlm/antimine-android` - `accepted`
  - `korlibs/korge` - `accepted`
  - `libktx/ktx` - `accepted`
  - `utopia-rise/godot-kotlin-jvm` - `reference-only`
- `research/worktrees/` has been cleaned after documentation and currently contains only `.gitkeep`.
- The folder is now initialized as a local git repository.

## Latest Meaningful Changes

- Added canonical memory entry point in `docs/context/CONTEXT_INDEX.md`.
- Added durable memory files for project brief, open tasks, decisions, and session notes.
- Kept `docs/context/project-overview.md` as a legacy alias instead of deleting or silently replacing it.
- Updated `AGENTS.md` so future agents route through the memory files instead of growing the root instructions.
- Recorded the workflow rule that meaningful work must be documented and completed work should end with a local commit.
- Added the research workspace, runbook, queue, researched registry, category index, findings template, cleanup script, and catalog project-card destination.
- Added a normalized catalog category schema, category index, batch templates, and a dedicated code-analysis guide.
- Initialized git for the workspace so the local-commit rule is now enforceable.
- Completed `BATCH-2026-05-10-A` and added 4 durable research notes under `research/findings/`.
- Populated `research/registry/RESEARCHED_REPOS.md` and `research/registry/CATEGORY_INDEX.md` with the first verified research outputs.
- Added normalized catalog cards for the first 4 researched repositories under `catalog/projects/`.
- Cleaned transient research clones from `research/worktrees/` after documenting the findings.

## Known Risks

- The workflow has only been validated on one completed batch, so the scoring rubric and category usage may still need minor tuning.
- Build validation remains selective; two `gradlew help` discovery attempts timed out, and no runtime execution was used in the first batch.
- `korlibs/korge` has repository license metadata reported as `Other`, so direct reuse should be reviewed carefully.
- `utopia-rise/godot-kotlin-jvm` was kept as `reference-only` because its Android transfer value is indirect.

## Recommended Next Steps

- Start the next batch with at most 4 new repositories and record it in `research/registry/CANDIDATE_QUEUE.md` and `research/batches/`.
- Decide whether the next pass should stay lightweight or become a dedicated heavy-repo batch for `yairm210/Unciv`.
- Keep `littlektframework/littlekt` in consideration for the next balanced engine/framework slot.
- Revisit accepted projects only when the lab needs deeper subsystem extraction, not by default.
