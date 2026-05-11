# Project Entry

## Basic Info

- Project name: `Dooz`
- Source repository: [https://github.com/yamin8000/Dooz](https://github.com/yamin8000/Dooz)
- Author / organization: `yamin8000`
- License: `GPL-3.0`
- Research note: [research/findings/yamin8000-dooz.md](../../research/findings/yamin8000-dooz.md)
- Investigated commit: `3f73f84f463e7f954e6a9d315571b4032152baa9`
- Last verified: `2026-05-11`
- Activity / maintenance status: active at selection; the repository was last pushed on `2026-05-10`, still has live GitHub Actions CI plus F-Droid/release metadata, and shows enough recent maintenance to treat it as a current Android sample.

## Short Description

Android tic-tac-toe game written fully in Kotlin and Jetpack Compose, with adjustable board size, heuristic AI difficulty, DataStore-backed settings, and explicit RTL/Persian text handling.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `ai`, `save-load`, `audio`
- Engine / framework: Android SDK + Jetpack Compose + Material3 + DataStore
- Rendering approach: Compose UI primitives with `LazyVerticalGrid`, animated cards, custom shapes, and Material3 theming
- Main language(s): Kotlin
- Android target: direct Android app
- Build system: single-module Gradle Kotlin DSL Android project

## Why It Matters

- `Dooz` is a useful compact reference for Android teams that want a fully Compose-native board or puzzle game without introducing a separate engine shell.
- Its strongest value for the lab is the combination of a controller-like game-state owner, heuristic AI, persisted game rules/settings, and locale-aware UI behavior in a real shipped mobile surface.

## Reusable Ideas

- Gameplay ideas:
  - configurable grid-size tic-tac-toe with simple PvP/PvC mode switching and first-player policy variants
- Architecture patterns:
  - one remembered state owner that hydrates settings, owns the board/session flow, and delegates only narrow rule/AI seams to small domain classes
- Graphics / rendering techniques:
  - screen-width-derived board sizing, winner-cell highlighting, and Compose-only board/HUD rendering
- Input / UI approaches:
  - human-only click gating, animated dice-roll player cards, and locale-aware RTL text wrappers for mixed-language casual-game UI
- Performance or optimization ideas:
  - keep the runtime small and rule-based instead of using a heavier game loop or search-based AI for a tiny turn-based mobile game

## Notable Implementations

- `GameState` centralizes board flow, AI turns, undo, dice rolling, and persisted rule loading.
- `SimpleGameAi` implements readable win/block/fork heuristics instead of a heavier MinMax search.
- `SettingsState` and `DataStoreHelper` persist both product and gameplay configuration through one preference store.
- `PersianText` automatically swaps directionality and typography for Persian content.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android app with a single `ComponentActivity`, Compose UI, DataStore, vibration permission, and release-facing F-Droid/fastlane metadata
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for small Android board, puzzle, or educational games that want a lightweight Compose-first implementation rather than an engine-first stack

## Risks / Limitations

- GPL-3.0 licensing limits direct code reuse compared with permissive samples.
- The repository is narrow in genre and architecture scope; treat it as a compact board-game/product-shell reference, not as a deep engine benchmark.
- No automated test files were found.
- Local Gradle discovery in this lab currently stops at the Java `17` floor, and some public metadata is slightly stale around the maximum board size.

## Notes

The repository is worth citing mainly for its Compose-first board-game shell, heuristic AI, persisted settings flow, and explicit localization/RTL handling. It is less valuable as a model for large-scale architecture or verification practices.
