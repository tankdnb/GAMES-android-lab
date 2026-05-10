# Handoff

## Current Snapshot

- The repository is a documentation-first research catalog for Android-relevant game projects.
- A compact Codex file-memory system is now in place under `docs/context/`.
- Project policy now requires documenting each meaningful work session and making a local commit after each completed work unit.
- A dedicated research workflow now exists under `research/`, including a batch rule, queue, researched registry, category index, findings templates, and cleanup script.
- The workflow now also includes normalized catalog categories, batch notes, and a dedicated code-analysis guide for evaluating cloned repositories.
- The second real research batch is now completed and documented end-to-end.
- The lab now has 8 researched repositories recorded:
  - `lucasnlm/antimine-android` - `accepted`
  - `korlibs/korge` - `accepted`
  - `libktx/ktx` - `accepted`
  - `utopia-rise/godot-kotlin-jvm` - `reference-only`
  - `littlektframework/littlekt` - `accepted`
  - `pandulapeter/kubriko` - `accepted`
  - `retrowars/retrowars` - `accepted`
  - `AlmasB/FXGL` - `reference-only`
- Public-facing root documentation has been tightened for GitHub publication.
- The repository direction is now explicitly framed as a referenceable library of game-development ideas.
- Local default branch is now `main`.
- Public GitHub repository exists at `https://github.com/tankdnb/GAMES-android-lab`.
- `origin` is configured and `main` is already pushed.
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
- Completed `BATCH-2026-05-10-B` and added 4 more durable research notes under `research/findings/`.
- Populated `research/registry/RESEARCHED_REPOS.md` and `research/registry/CATEGORY_INDEX.md` with the first verified research outputs.
- Expanded `research/registry/RESEARCHED_REPOS.md`, `research/registry/CATEGORY_INDEX.md`, `catalog/index.md`, and `catalog/CATEGORY_INDEX.md` for the second batch.
- Added normalized catalog cards for 8 researched repositories under `catalog/projects/`.
- Cleaned transient research clones from `research/worktrees/` after documenting the findings.
- Validated that `research/worktrees/` again contains only `.gitkeep` after the second batch cleanup.
- Hardened `research/scripts/cleanup-research.ps1` so it now stops worktree-owned Gradle/Java processes before removing transient research artifacts.
- Reworked `README.md` to describe the repository as a public research lab, with current status, workflow, and quick links.
- Added root `CONTRIBUTING.md` for public research contributions.
- Added root `.gitattributes` and expanded `.gitignore` for cleaner GitHub publication.
- Renamed the local default branch from `master` to `main`.
- Clarified in public docs and project memory that notes and catalog cards must be written as future reference material.
- Created the public GitHub repository and pushed branch `main` to `origin`.
- Recorded the rule that completed research batches should be prepared and pushed to GitHub.

## Known Risks

- The workflow has only been validated on one completed batch, so the scoring rubric and category usage may still need minor tuning.
- Build validation remains selective; two `gradlew help` discovery attempts timed out, and no runtime execution was used in the first batch.
- Build validation remains selective; the second batch added two more `gradlew help` timeout outcomes and still relied on static-first analysis.
- `korlibs/korge` has repository license metadata reported as `Other`, so direct reuse should be reviewed carefully.
- `utopia-rise/godot-kotlin-jvm` was kept as `reference-only` because its Android transfer value is indirect.
- `AlmasB/FXGL` was kept as `reference-only` because the reviewed runtime path is JavaFX-first and only indirectly aligned with Android.
- `littlektframework/littlekt` is valuable architecturally, but direct Android support is still in progress on the inspected branch.
- Root repository license has not been selected yet, so the public repository is still published without an explicit reuse license.

## Recommended Next Steps

- Choose the root repository license so public reuse terms are explicit.
- Decide whether the next pass should be a dedicated heavy-repo batch for `yairm210/Unciv` or another lightweight mixed batch from the backlog.
- Keep the new rule in force: after each completed batch, prepare the durable outputs and push them to GitHub.
