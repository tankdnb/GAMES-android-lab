# Project Entry

## Basic Info

- Project name: `Gauguin`
- Source repository: [https://github.com/meikpiep/gauguin](https://github.com/meikpiep/gauguin)
- Author / organization: `meikpiep`
- License: `GPL-3.0`
- Research note: [research/findings/meikpiep-gauguin.md](../../research/findings/meikpiep-gauguin.md)
- Investigated commit: `b6ed9deccaf26f35de87bcbb2e4a8a3f4a395c45`
- Last verified: `2026-05-11`
- Activity / maintenance status: actively maintained at selection; the repository was last pushed on `2026-05-08`, exposes a current Gradle/AGP/JDK21 CI surface, and ships through both F-Droid and Google Play according to the README.

## Short Description

Android arithmetic cage puzzle game written in Kotlin with a custom `View`-based grid UI, background board generation, a dedicated human-solver/difficulty subsystem, and a split multi-module architecture for gameplay core, generators, and Android app shell.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `save-load`, `procedural-generation`, `testing`, `performance`
- Engine / framework: custom Android SDK game with Koin, coroutines, custom `View` rendering, and shared JVM puzzle modules
- Rendering approach: custom Android `View` board rendering with adaptive cell sizing, XML layouts/fragments, and responsive keypad variants
- Main language(s): Kotlin, with a small Ruby/Fastlane release surface
- Android target: direct Android app
- Build system: multi-module Gradle Kotlin DSL Android/JVM project

## Why It Matters

- `Gauguin` is one of the stronger direct Android puzzle references in the lab because it goes well beyond a simple board app and includes reusable generation, preview, persistence, difficulty, and verification infrastructure.
- Its best Android-specific value is the way it keeps a traditional custom-`View` UI responsive while expensive puzzle generation happens in the background and prefetched boards are cached for later use.

## Reusable Ideas

- Gameplay ideas:
  - arithmetic cage puzzle generation with exact-solution checking and calibrated difficulty bands
- Architecture patterns:
  - split app/core/solver/generator modules, `StateFlow`-exposed runtime state, and prefetched next-board orchestration
- Graphics / rendering techniques:
  - custom `View` grid rendering with layered cage/cell/text passes and preview-state overlays
- Input / UI approaches:
  - adaptive keypad layouts by window size class and grid size, plus custom touch-to-cell mapping
- Performance or optimization ideas:
  - pseudo preview fallback after a short timeout, persisted next-grid caching, solver benchmarks, and screenshot-based regression checks

## Notable Implementations

- `GridCalculationService` and `GameLifecycle` precompute and persist the next playable grid while the user is solving the current one.
- `GridPreviewCalculator` can display a relaxed pseudo preview if real generation misses a short UI latency budget.
- `RandomCageGridCalculator` and `MergingCageGridCalculator` provide two different uniqueness-preserving generation strategies inside the same product.
- `HumanSolver` plus `HumanSolverStrategies` encode a weighted ladder of human solving tactics for difficulty measurement.
- `SaveGame` and `SavedGamesService` implement explicit save-version migration and autosave-plus-snapshot behavior.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android application with custom views, XML layouts, lifecycle-aware view models, and Android-specific product plumbing
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - the repository is especially useful for number puzzles, logic games, or other heavy-generation mobile titles that want to stay on the Android SDK instead of adopting a separate engine

## Risks / Limitations

- GPL-3.0 limits direct code reuse.
- Local build verification in this lab is blocked because the current environment still exposes Java `8`, while the inspected project now expects modern Gradle plus JDK `21`.
- The repository is specialized to arithmetic cage puzzles, so many domain classes are less reusable than the surrounding pipelines.

## Notes

Treat `Gauguin` as a high-quality reference for background puzzle generation, custom Android board rendering, difficulty calibration through solver heuristics, and versioned save migration. Its strongest transfer value is architectural rather than genre-specific.
