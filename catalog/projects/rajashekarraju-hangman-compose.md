# Project Entry

## Basic Info

- Project name: `Hangman Compose`
- Source repository: [https://github.com/RajashekarRaju/hangman-compose](https://github.com/RajashekarRaju/hangman-compose)
- Author / organization: `RajashekarRaju`
- License: `Apache-2.0`
- Research note: [research/findings/rajashekarraju-hangman-compose.md](../../research/findings/rajashekarraju-hangman-compose.md)
- Investigated commit: `f8cc2e3fa714b48e3d63f108e128188918c69443`
- Last verified: `2026-06-04`
- Activity / maintenance status: active at selection; the repository was last pushed on `2026-03-12`, updated on GitHub on `2026-04-01`, and still shows live multiplatform packaging and deployment workflows.

## Short Description

Kotlin Multiplatform hangman product built with Compose Multiplatform. The repository targets Android, desktop, web, and iOS from one shared codebase and combines a pure gameplay session engine with a product-like UI shell, persistence layer, audio seams, and packaging automation.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `ui-hud`, `input`, `audio`, `save-load`, `testing`
- Engine / framework: Kotlin Multiplatform + Compose Multiplatform + Android SDK + Room + Koin
- Rendering approach: Compose-first shared game/product UI with screen models projected from a pure gameplay core rather than a separate GL runtime
- Main language(s): Kotlin
- Android target: direct; Android is a first-class target alongside desktop, web, and iOS
- Build system: multi-module Gradle Kotlin DSL KMP project

## Why It Matters

- `Hangman Compose` is a strong reference for Android teams building a small Compose-first game product rather than a raw rendering experiment.
- Its main value is the combination of a clean gameplay core, a real app shell, settings/history/achievement persistence, platform audio/storage seams, and a stronger-than-usual release/test surface for a casual game.

## Reusable Ideas

- Gameplay ideas:
  - pure session engine, difficulty-by-word-shape, hints, timers, and category-driven word selection
- Architecture patterns:
  - controller-style feature `ViewModel`s above a pure gameplay core, plus reactive app bootstrap for language/theme/cursor/banner state
- Graphics / rendering techniques:
  - Compose-first shared UI shell without needing a custom GL/runtime layer for a product-scale casual game
- Input / UI approaches:
  - menu/settings/game/history/achievements all stay in one route shell, with hints, overlays, and timer flow handled as explicit UI states
- Performance or optimization ideas:
  - keep platform storage/audio differences behind interfaces, and validate content upfront through a DSL instead of pushing that complexity into runtime flows

## Notable Implementations

- `GameSessionEngine` keeps rules, progression, attempts, hints, and scoring outside the UI.
- `WordCatalogDsl` validates category content, normalization, duplicate prevention, and difficulty coverage.
- `GameViewModel` orchestrates timers, overlays, achievements, sounds, and history on top of the pure gameplay core.
- `AppInitializerViewModel` and `HangmanRoot` show a compact app-shell pattern for global theme/language/cursor/bootstrap state in Compose Multiplatform.
- `RoomGameSettingsRepository` and `RoomAchievementsRepository` show pragmatic product-state persistence with observable settings and achievement flows.
- Platform data actuals reuse the same shared repository interfaces across Room-backed Android/desktop targets and localStorage-backed WASM.
- The GitHub workflows package Android, desktop, and web outputs from the same codebase.

## Android Relevance

- Native Android use:
  - yes; Android is a first-class product target rather than only a theoretical future backend
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android casual or word/puzzle games that want a Compose-first shell, shared gameplay rules, persistent settings/history, and platform seams kept outside feature logic

## Risks / Limitations

- The repository is more useful for product-shell and gameplay-core patterns than for low-level rendering/runtime architecture.
- `GameViewModel` is already fairly branch-heavy, so teams should treat it as a small-product reference, not as a universal scaling pattern.
- Some workflow triggers still target `master` while the default branch is `development`, so release automation intent should be rechecked before copying it blindly.
- Local lab build verification is still limited by the current Java `8` machine even though the repository expects JDK `17+` and often `21`.

## Notes

Treat `hangman-compose` as a strong Compose-first Android game product reference: it is most valuable where gameplay rules, persistence, product shell, and multiplatform delivery all need to stay readable in one Kotlin codebase.
