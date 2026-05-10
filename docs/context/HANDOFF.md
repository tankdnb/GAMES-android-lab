# Handoff

## Current Snapshot

- The repository is a documentation-first research catalog for Android-relevant game projects.
- A compact Codex file-memory system is now in place under `docs/context/`.
- Project policy now requires documenting each meaningful work session and making a local commit after each completed work unit.
- A dedicated research workflow now exists under `research/`, including a batch rule, queue, researched registry, category index, findings templates, and cleanup script.
- The workflow now also includes normalized catalog categories, batch notes, and a dedicated code-analysis guide for evaluating cloned repositories.
- The seventh real research batch is now completed and documented end-to-end.
- The lab now has 13 researched repositories recorded:
  - `lucasnlm/antimine-android` - `accepted`
  - `korlibs/korge` - `accepted`
  - `libktx/ktx` - `accepted`
  - `utopia-rise/godot-kotlin-jvm` - `reference-only`
  - `littlektframework/littlekt` - `accepted`
  - `pandulapeter/kubriko` - `accepted`
  - `retrowars/retrowars` - `accepted`
  - `AlmasB/FXGL` - `reference-only`
  - `yairm210/Unciv` - `accepted`
  - `TobseF/Candy-Crush-Clone` - `accepted`
  - `AntonioNoack/RemsEngine` - `accepted`
  - `minigdx/tiny` - `accepted`
  - `curioustorvald/Terrarum` - `accepted`
- Public-facing root documentation has been tightened for GitHub publication.
- The repository direction is now explicitly framed as a referenceable library of game-development ideas.
- Local default branch is now `main`.
- Public GitHub repository exists at `https://github.com/tankdnb/GAMES-android-lab`.
- `origin` is configured and `main` is already pushed.
- `research/worktrees/` has been cleaned after documentation and currently contains only `.gitkeep`.
- A thread heartbeat automation named `GAMES-android-lab research` with id `games-android-lab-research` is now active on a 1-minute cadence for continuing research runs in this thread.
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
- Completed `BATCH-2026-05-10-C` as a dedicated heavy-repo pass for `yairm210/Unciv`.
- Populated `research/registry/RESEARCHED_REPOS.md` and `research/registry/CATEGORY_INDEX.md` with the first verified research outputs.
- Expanded `research/registry/RESEARCHED_REPOS.md`, `research/registry/CATEGORY_INDEX.md`, `catalog/index.md`, and `catalog/CATEGORY_INDEX.md` for the second batch.
- Added normalized catalog cards for 9 researched repositories under `catalog/projects/`.
- Added durable `Unciv` findings for gameplay systems, moddability, pathfinding, multiplayer, and Android integration.
- Recorded another Gradle discovery timeout outcome for `Unciv` after a `.\gradlew.bat help --no-daemon` attempt.
- Cleaned transient research clones from `research/worktrees/` after documenting the findings.
- Validated that `research/worktrees/` again contains only `.gitkeep` after the third batch cleanup.
- Hardened `research/scripts/cleanup-research.ps1` so it now stops worktree-owned Gradle/Java processes before removing transient research artifacts.
- Completed `BATCH-2026-05-10-D` as a lightweight single-repo pass for `TobseF/Candy-Crush-Clone`.
- Added durable `Candy Crush Clone` findings for event-driven match-3 flow, renderer/model separation, reserve-based tile feeds, HUD feedback, and `commonTest` board-mechanics coverage.
- Recorded a distinct Gradle discovery failure shape for `Candy-Crush-Clone`: wrapper bootstrapped, but `.\gradlew.bat help --no-daemon` failed because no Java compiler or JDK was available in the environment.
- Completed `BATCH-2026-05-10-E` as a wildcard engine pass for `AntonioNoack/RemsEngine`.
- Added durable `RemsEngine` findings for extension-loaded modules, editor-first shell composition, split window/render loops, file abstraction, async cache design, Bullet integration, and Android-inspired UI layout patterns.
- Verified that `RemsEngine` does not expose a standard root Gradle or Maven build surface; the repository was documented as an IntelliJ-module workspace and static-reading reference instead of a reproducible build reference.
- Completed `BATCH-2026-05-10-F` as a compact engine/tooling pass for `minigdx/tiny`.
- Added durable `Tiny Game Engine` findings for state-preserving Lua reload, ordered resource bootstrapping, LDtk-to-Lua bridging, palette-index rendering, built-in debugger/export tooling, JSON-backed saves, and engine-integrated procedural audio generation.
- Recorded another distinct Gradle discovery limitation: `minigdx/tiny` bootstrapped Gradle successfully, but `.\gradlew.bat help --no-daemon` still failed because the environment exposed only a Java runtime without a full JDK/compiler.
- Completed `BATCH-2026-05-10-G` as a modular engine+game pass for `curioustorvald/Terrarum`.
- Added durable `Terrarum` findings for GL-thread-safe module/resource loading, metadata-driven mods, PRTree-backed actor queries, RGB+UV tiled lighting, layered Float16 rendering, weather-linked global lighting, graph-based wire simulation, and staged procedural world generation.
- Verified that `Terrarum` does not expose a standard Gradle or Maven root build; the inspected revision points instead to IntelliJ module files, JDK 17+, GraalVM JS setup, and `buildapp/Makefile` packaging scripts.
- Cleaned the transient `Terrarum` clone from `research/worktrees/` after documenting the results and revalidated that the directory again contains only `.gitkeep`.
- Created and activated heartbeat automation `games-android-lab-research` to continue repository research every minute in the current thread using the established documentation, registry, cleanup, commit, and push workflow.
- Reworked `README.md` to describe the repository as a public research lab, with current status, workflow, and quick links.
- Added root `CONTRIBUTING.md` for public research contributions.
- Added root `.gitattributes` and expanded `.gitignore` for cleaner GitHub publication.
- Renamed the local default branch from `master` to `main`.
- Clarified in public docs and project memory that notes and catalog cards must be written as future reference material.
- Created the public GitHub repository and pushed branch `main` to `origin`.
- Recorded the rule that completed research batches should be prepared and pushed to GitHub.

## Known Risks

- The workflow has now been validated across 6 completed batches, but the scoring rubric and category usage may still need minor tuning.
- Build validation remains selective; several lightweight `gradlew help` discovery attempts have timed out, 2 additional discovery attempts failed because the environment lacked a full JDK/compiler, and runtime execution is still intentionally uncommon.
- `korlibs/korge` has repository license metadata reported as `Other`, so direct reuse should be reviewed carefully.
- `utopia-rise/godot-kotlin-jvm` was kept as `reference-only` because its Android transfer value is indirect.
- `AlmasB/FXGL` was kept as `reference-only` because the reviewed runtime path is JavaFX-first and only indirectly aligned with Android.
- `littlektframework/littlekt` is valuable architecturally, but direct Android support is still in progress on the inspected branch.
- `yairm210/Unciv` is so large that a later follow-up may still be useful for map-generation and server internals beyond the hotspot review completed here.
- `TobseF/Candy-Crush-Clone` is a strong small reference, but its narrow scope means it should not be treated as evidence for persistence, networking, or large Android packaging practices.
- `AntonioNoack/RemsEngine` has strong architectural value, but its desktop/editor-first orientation and nonstandard build surface lower its direct Android transfer and reproducibility.
- `minigdx/tiny` is valuable as a tooling/runtime reference, but it has no verified Android target and keeps gameplay code Lua-first rather than Kotlin-first.
- `curioustorvald/Terrarum` has strong subsystem value, but it remains GPL-licensed, desktop/OpenGL-first, and harder to reproduce than a normal Gradle-based repository.
- The active 1-minute heartbeat is intentionally aggressive; if it starts producing more churn than value, it should be paused or retuned to a slower cadence instead of leaving it to spam trivial passes.
- Root repository license has not been selected yet, so the public repository is still published without an explicit reuse license.

## Recommended Next Steps

- Choose the root repository license so public reuse terms are explicit.
- Refresh the queue and prepare the next lightweight batch from `Hugobros3/chunkstories` plus newly searched repositories with stronger direct Android signal if available.
- If a future follow-up is needed for `Unciv`, target map generation or server internals as a scoped revisit instead of reopening the whole repository blindly.
- If a future follow-up is needed for `RemsEngine`, scope it to one subsystem such as export, render graph tooling, or the separate Android fork rather than reopening the whole workspace at once.
- If a future follow-up is needed for `minigdx/tiny`, focus it on the debugger/editor protocol or on later revisions that add a clearer Android or mobile export path.
- If a future follow-up is needed for `Terrarum`, scope it to one subsystem such as the module/content pipeline, light-weather rendering, or the world generator instead of reopening the entire workspace at once.
- If the minute-based automation proves too aggressive in practice, update or pause `games-android-lab-research` rather than duplicating it with another automation.
- Keep the new rule in force: after each completed batch, prepare the durable outputs and push them to GitHub.
