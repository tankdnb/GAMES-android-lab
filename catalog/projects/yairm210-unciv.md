# Project Entry

## Basic Info

- Project name: `Unciv`
- Source repository: [https://github.com/yairm210/Unciv](https://github.com/yairm210/Unciv)
- Author / organization: `yairm210`
- License: `MPL-2.0`
- Research note: [research/findings/yairm210-unciv.md](../../research/findings/yairm210-unciv.md)
- Investigated commit: `13d9e09006c34eb907c9b8d8964a86b3ebe50701`
- Last verified: `2026-05-10`
- Activity / maintenance status: last push recorded at selection on `2026-05-10`.

## Short Description

Large LibGDX-based Kotlin 4X strategy game for Android and desktop with deep moddability, threaded turn processing, integrated multiplayer, and explicit Android platform adaptation.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `save-load`, `ai`, `networking`, `ui-hud`
- Engine / framework: LibGDX
- Rendering approach: LibGDX Scene2D UI with custom world-map visualization and layered HUD/minimap/status overlays
- Main language(s): Kotlin
- Android target: dedicated Android launcher with SAF save/load, deep links, background multiplayer turn checks, immersive mode, cutout, and orientation control
- Build system: Gradle Kotlin DSL multi-module repository

## Why It Matters

- It is one of the strongest direct Android game references in the lab for large-scale Kotlin game architecture.
- It combines gameplay simulation, modding, multiplayer, AI automation, and Android host integration in one production-scale codebase.

## Reusable Ideas

- Gameplay ideas:
  - turn-resolution pipeline with cloned authoritative state and long-running simulation support
- Architecture patterns:
  - serializable `GameInfo` plus explicit `setTransients()` runtime reconstruction
  - combined ruleset cache with base-plus-extension mod assembly and validation
  - off-thread next-turn processing with GL-thread-only screen refresh
- Graphics / rendering techniques:
  - deferred heavy world-screen refresh on the GL thread to avoid broken asset access and ANRs
- Input / UI approaches:
  - stage-visible-area change events for keyboard/system-UI-aware layout
  - layered world HUD composition around minimap, chat, diplomacy, tile info, and battle overlays
- Performance or optimization ideas:
  - reusable pathing caches, cached unique parsing, and once-per-civ sight/resource recomputation

## Notable Implementations

- `WorldScreen.nextTurn()` clones `GameInfo`, resolves the turn on a worker pool, then swaps to a fresh world screen.
- `GameInfo.setTransients()` rebuilds runtime links after load and repairs several compatibility and missing-mod cases.
- `RulesetCache`, `Ruleset`, and `RulesetValidator` form a full ruleset/mod merge-and-validation pipeline.
- `PathingMap` and `PathingMapAStarPathfinder` provide reusable multi-turn path caching rather than one-off shortest-path searches.
- `AndroidSaverLoader` uses the Storage Access Framework instead of raw filesystem assumptions.

## Android Relevance

- Native Android use:
  - yes, through a dedicated Android launcher and platform integration layer
- Kotlin relevance:
  - very high
- Porting or adaptation notes:
  - best reused as subsystem guidance and reference architecture rather than by copying the whole game stack

## Risks / Limitations

- Very large codebase, so extracting only the desired subsystem ideas matters.
- `gradlew help` timed out during this batch, so build validation was not completed.
- No runtime validation was attempted.
- `MPL-2.0` should be reviewed before direct file-level reuse.

## Notes

This is a strong anchor project for the lab's `android-game` catalog and a cross-reference for `save-load`, `ai`, `networking`, and moddable data-pipeline design.
