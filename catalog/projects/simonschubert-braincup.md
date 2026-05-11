# Project Entry

## Basic Info

- Project name: `Braincup`
- Source repository: [https://github.com/SimonSchubert/Braincup](https://github.com/SimonSchubert/Braincup)
- Author / organization: `SimonSchubert`
- License: `Apache-2.0`
- Research note: [research/findings/simonschubert-braincup.md](../../research/findings/simonschubert-braincup.md)
- Investigated commit: `27000335bef3e0f8a3d59d19eaf21644d12f166b`
- Last verified: `2026-05-11`
- Activity / maintenance status: active at selection; the repository was last pushed on `2026-05-08`, has live multiplatform release workflows, and looks like a maintained single-developer product rather than an abandoned sample.

## Short Description

Kotlin Multiplatform brain-training game collection built with Compose Multiplatform. The app packages many small math, memory, logic, and perception mini-games behind one shared product shell with Android, iOS, desktop, and web targets.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `android`, `multiplatform`, `ui-hud`, `input`, `audio`, `save-load`, `ai`, `testing`
- Engine / framework: Kotlin Multiplatform + Compose Multiplatform + Android SDK + coroutines + multiplatform-settings
- Rendering approach: Compose UI and navigation shell with immutable per-game UI-state projection instead of a separate GL runtime
- Main language(s): Kotlin
- Android target: direct Android app, with shared code reused across iOS, desktop, and web
- Build system: multi-module Gradle Kotlin DSL KMP project with `androidApp`, `composeApp`, and `screenshotTests`

## Why It Matters

- `Braincup` is one of the stronger references in the lab for how to ship a multi-game Kotlin product without pulling in a heavyweight external engine.
- Its value is not just in the mini-games themselves, but in the surrounding product architecture: shared controller-owned state, per-game UI-state mapping, local progression/session systems, platform feedback seams, screenshot tooling, and broad distribution packaging.

## Reusable Ideas

- Gameplay ideas:
  - small timed puzzle/memory modes with explicit memorizing, animating, answering, and feedback phases
  - a custom Mini Chess mode with weighted scenario generation and depth-based AI difficulty
- Architecture patterns:
  - one shared product shell over many mini-games, with each mode projecting into immutable UI-state models
  - metadata-driven scoring and progression through centralized game descriptors plus multiplatform settings storage
- Graphics / rendering techniques:
  - Compose-first game/product UI where menu, gameplay, achievements, finish screens, and scoreboards all live in one shared shell
- Input / UI approaches:
  - touch-friendly game screens, audio/haptic feedback seams, and daily-session interstitial flow
- Performance or optimization ideas:
  - keep each mini-game self-contained, use coroutine-owned timed phases, and separate platform feedback implementations through `expect`/`actual`

## Notable Implementations

- `GameController` owns navigation, timers, progression, session flow, highscores, XP, and per-game state emission through `StateFlow`.
- `GameUiState` defines a separate immutable state model for each mini-game so the UI shell can stay generic.
- `UserStorage` implements highscores, achievements, streaks, session state, XP leveling, and score-direction-aware persistence on top of `multiplatform-settings`.
- `MiniSudokuGame` preserves uniqueness while removing clues from generated boards.
- `VisualMemoryGame`, `GhostGridGame`, and `OrbitTrackerGame` show coroutine-driven phase-based mini-game flow.
- `MiniChessGame`, `ScenarioGenerator`, and `ChessAi` provide a surprisingly deep self-contained tactics subsystem with real tests.
- `StoreScreenshotTest` and the release workflows show strong productization around screenshots, packaging, and multiplatform distribution.

## Android Relevance

- Native Android use:
  - yes; the repository ships a direct Android app, keeps a thin `MainActivity`, supports dynamic colors, splash screen, in-app review prompting, Android haptics, and Android audio playback
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android teams building a Compose-first game app or a mini-game collection where product shell, progression, and platform polish matter as much as the raw gameplay logic

## Risks / Limitations

- The repository is closer to a polished mini-game product shell than to a reusable engine baseline.
- `GameController` is effective but branch-heavy; the pattern may need decomposition at larger scale.
- Local Gradle discovery in the lab is blocked because the inspected build requires JVM `17+` while the current machine still exposes Java `8`.
- Automated verification is meaningful but concentrated in the Mini Chess subsystem plus screenshot tests rather than all game modes.

## Notes

Treat `Braincup` as a reference for multi-game product architecture, progression, and packaging in Kotlin/Compose, not just as a source of isolated puzzle implementations.
