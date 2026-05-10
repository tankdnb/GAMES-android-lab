# Handoff

## Current Snapshot

- The repository is a documentation-first research catalog for Android-relevant game projects.
- A compact Codex file-memory system is now in place under `docs/context/`.
- Project policy now requires documenting each meaningful work session and making a local commit after each completed work unit.
- A dedicated research workflow now exists under `research/`, including a batch rule, queue, researched registry, category index, findings templates, and cleanup script.
- The repository currently has no verified project entries and no completed external research notes beyond the workflow scaffold.
- The folder is now initialized as a local git repository.

## Latest Meaningful Changes

- Added canonical memory entry point in `docs/context/CONTEXT_INDEX.md`.
- Added durable memory files for project brief, open tasks, decisions, and session notes.
- Kept `docs/context/project-overview.md` as a legacy alias instead of deleting or silently replacing it.
- Updated `AGENTS.md` so future agents route through the memory files instead of growing the root instructions.
- Recorded the workflow rule that meaningful work must be documented and completed work should end with a local commit.
- Added the research workspace, runbook, queue, researched registry, category index, findings template, cleanup script, and catalog project-card destination.
- Initialized git for the workspace so the local-commit rule is now enforceable.

## Known Risks

- The research workflow is defined, but it has not yet been exercised on a real first batch of repositories.
- No first batch of verified GitHub projects has been cataloged yet, so the new research workflow is still untested against real repositories.
- The selection rubric and category taxonomy may need tuning after the first few batches.

## Recommended Next Steps

- Fill `research/registry/CANDIDATE_QUEUE.md` with the first scouting batch of up to 4 Kotlin repositories.
- Research that batch and create the first durable findings notes in `research/findings/`.
- Promote the strongest repositories into `catalog/projects/` and `catalog/index.md`.
