# Project Entry

## Basic Info

- Project name: `Minesweeper-JC`
- Source repository: [https://github.com/jayasuryat/minesweeper-j-compose](https://github.com/jayasuryat/minesweeper-j-compose)
- Author / organization: `jayasuryat`
- License: `Apache-2.0`
- Research note: [research/findings/jayasuryat-minesweeper-j-compose.md](../../research/findings/jayasuryat-minesweeper-j-compose.md)
- Investigated commit: `92ef8a0c17172c684af00c143fb72154aec0750c`
- Last verified: `2026-05-11`
- Activity / maintenance status: moderately active but not fresh at selection; the repository was last pushed on `2024-07-12`, still has useful ecosystem signal for a small Android Compose puzzle game, and remains one of the clearer modular Minesweeper-style references in Kotlin.

## Short Description

Android Minesweeper game written in Kotlin and Jetpack Compose, with a dedicated puzzle-engine module, reusable zoomable grid UI, resumable save snapshots, difficulty-aware resume flow, and persisted user settings.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `save-load`, `procedural-generation`
- Engine / framework: Android SDK + Jetpack Compose + custom minesweeper engine + coroutines + Koin
- Rendering approach: Compose-based board/UI rendering with clamped pinch-zoom/pan transforms and saved viewport state
- Main language(s): Kotlin
- Android target: direct Android app
- Build system: multi-module Gradle Kotlin DSL Android project with a Kotlin Multiplatform `data` module and SQLDelight

## Why It Matters

- `Minesweeper-JC` is a strong lab reference for small-to-medium Android puzzle games that want to stay Compose-first without collapsing all logic into one activity or one `ViewModel`.
- Its strongest value is the combination of safe-first-click board generation, engine/UI separation, zoomable large-board handling, resumable snapshots by difficulty, and small but useful product-level UX details such as quick-toggle input mode and settings-backed feedback.

## Reusable Ideas

- Gameplay ideas:
  - safe-first-click grid generation, chord-click solving for numbered cells, and radial final reveal ordering
- Architecture patterns:
  - pure puzzle engine that reduces actions into events, plus a separate UI-side orchestrator that owns state, persistence triggers, and feedback side effects
- Graphics / rendering techniques:
  - zoomable Compose board with bounded pinch/pan and saveable transform state for large puzzle grids
- Input / UI approaches:
  - reveal-vs-flag quick toggle, long-press handling, difficulty screen with resume affordances, and settings persisted behind a shared preferences abstraction
- Performance or optimization ideas:
  - disable cell animations on very large boards and reuse deterministic difficulty-keyed save slots instead of tracking a more complex save registry

## Notable Implementations

- `MineGridGenerator` excludes the whole `3x3` block around the first revealed cell before placing mines.
- `ActionListener` handles first-click grid initialization, touch-action mapping, progress updates, and animation timing around engine events.
- `ValueCellRevealer` implements Minesweeper chording and incorrect-flag punishment cleanly inside the engine layer.
- `ZoomableContent` and `Minefield` provide a reusable Compose pinch-zoom/pan shell for dense touch boards.
- `GameDataPersister`, `GridWriteMapperImpl`, `GridReadMapperImpl`, and the KMM `data` module persist grid snapshots through SQLDelight and shared preference wrappers.

## Android Relevance

- Native Android use:
  - yes; the repository is a direct Android app with Compose UI, an Android `Application`, an Android `ComponentActivity`, Android feedback APIs, and Android resource-driven theming/assets
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for puzzle, board, or logic-heavy Android games that want a lightweight Compose shell with a separate Kotlin rules engine rather than a full external engine stack

## Risks / Limitations

- The repository is not especially fresh and still reflects a 2022-2024 Android/Compose stack.
- Local Gradle discovery in this lab failed because the current environment still exposes a Java `8` runtime without JDK tools.
- The visible automated test surface is effectively absent; the only test-like file is a debug-side generator probe.
- The multiplatform story is limited mostly to persistence/preferences, not to the gameplay/UI runtime itself.

## Notes

Treat `Minesweeper-JC` as a compact Android puzzle-product reference rather than as a general engine baseline. Its value is in how many good mobile patterns it fits into a readable modular project.
