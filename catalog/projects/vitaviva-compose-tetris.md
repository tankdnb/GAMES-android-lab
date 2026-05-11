# Project Entry

## Basic Info

- Project name: `Compose Tetris`
- Source repository: [https://github.com/vitaviva/compose-tetris](https://github.com/vitaviva/compose-tetris)
- Author / organization: `vitaviva`
- License: `MIT`
- Research note: [research/findings/vitaviva-compose-tetris.md](../../research/findings/vitaviva-compose-tetris.md)
- Investigated commit: `234416c455cd0b5524b7f2a7e91aaa9f6206457a`
- Last verified: `2026-05-11`
- Activity / maintenance status: stale but still useful at selection; the repository was last pushed on `2024-03-22`, still has strong ecosystem signal for a Kotlin Compose game sample, and exposes a simple JDK11 GitHub Actions APK build workflow.

## Short Description

Android Tetris game written fully in Kotlin and Jetpack Compose, with a reducer-like `ViewModel`, Compose `Canvas` board rendering, retro handheld UI styling, and direct touch controls built from custom Compose buttons.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `collision`, `audio`
- Engine / framework: Android SDK + Jetpack Compose + lifecycle `ViewModel` + coroutines
- Rendering approach: Compose `Canvas` for the board and next-piece preview, plus custom Compose HUD/body components that mimic an LCD handheld shell
- Main language(s): Kotlin
- Android target: direct Android app
- Build system: single-module Gradle Groovy Android project

## Why It Matters

- `Compose Tetris` is a good compact reference for small Android games that want to stay inside normal Compose app structure instead of building a separate engine shell.
- Its strongest value for the lab is the combination of reducer-style game state, fully Compose-based board rendering, held-button auto-repeat controls, and small but reusable animation-state handling.

## Reusable Ideas

- Gameplay ideas:
  - shuffled full-piece reserve generation and compact line/score progression rules for a grid-based arcade game
- Architecture patterns:
  - reducer-style `dispatch`/`reduce` flow inside a `ViewModel`, with game phases represented explicitly as UI state
- Graphics / rendering techniques:
  - Compose `Canvas` board drawing and LED-style HUD rendering inside a themed retro handheld shell
- Input / UI approaches:
  - held-button auto-repeat built with `pointerInteropFilter` and coroutine `ticker`, plus a separated rotate button
- Performance or optimization ideas:
  - precomputed board snapshots for line-clear animation instead of recomputing the board during every animation frame

## Notable Implementations

- `GameViewModel` keeps the runtime inside one reducer-like state machine with explicit `GameStatus` transitions.
- `Spirit` models tetromino transforms as simple pure data operations over `Offset` lists.
- `GameButton` implements repeat-while-held controls without a heavyweight gesture stack.
- `GameScreen`, `GameBody`, and `LedNumber` build a distinctive LCD handheld presentation entirely with Compose primitives.
- `AppIcon` reuses the same UI primitives to generate icon art through Compose previews.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android app built around `ComponentActivity`, Compose UI, Android resources, `SoundPool`, and a single app module
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for small arcade, puzzle, or retro-style Android games that want a lightweight Compose-first architecture rather than an engine-first stack

## Risks / Limitations

- The repository is stale and still uses an older Compose/AGP stack plus `jcenter()`.
- Local Gradle validation in this lab is blocked because the current environment still exposes Java `8`, while the inspected Android Gradle Plugin requires Java `11+`.
- The checked-in test surface is only placeholder template tests.
- The main falling-speed loop likely does not react to later level-ups because it is launched in `LaunchedEffect(Unit)` with a captured `viewState.level`.

## Notes

Treat `Compose Tetris` as a compact Android Compose gameplay/UI reference rather than as a deep engine or process benchmark. Its value is in small, readable patterns for state handling, board rendering, and touch controls.
