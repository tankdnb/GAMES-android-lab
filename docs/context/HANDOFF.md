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
- Public-facing root documentation has been tightened for GitHub publication.
- The repository direction is now explicitly framed as a referenceable library of game-development ideas.
- Local default branch is now `main`.
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
- Reworked `README.md` to describe the repository as a public research lab, with current status, workflow, and quick links.
- Added root `CONTRIBUTING.md` for public research contributions.
- Added root `.gitattributes` and expanded `.gitignore` for cleaner GitHub publication.
- Renamed the local default branch from `master` to `main`.
- Clarified in public docs and project memory that notes and catalog cards must be written as future reference material.

## Known Risks

- The workflow has only been validated on one completed batch, so the scoring rubric and category usage may still need minor tuning.
- Build validation remains selective; two `gradlew help` discovery attempts timed out, and no runtime execution was used in the first batch.
- `korlibs/korge` has repository license metadata reported as `Other`, so direct reuse should be reviewed carefully.
- `utopia-rise/godot-kotlin-jvm` was kept as `reference-only` because its Android transfer value is indirect.
- Root repository license has not been selected yet, so public publication would still ship without an explicit reuse license.
- No GitHub remote is configured yet.

## Recommended Next Steps

- Choose the root repository license before the first public push.
- Create the public GitHub repository, add `origin`, and push branch `main`.
- After publication, continue with the next research batch using the existing queue and batch workflow.
