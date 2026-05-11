# Project Entry

## Basic Info

- Project name: `SeaBattle`
- Source repository: [https://github.com/AlinaStepanova/SeaBattle](https://github.com/AlinaStepanova/SeaBattle)
- Author / organization: `AlinaStepanova`
- License: `No explicit license found; GitHub metadata reports null license info`
- Research note: [research/findings/alinastepanova-seabattle.md](../../research/findings/alinastepanova-seabattle.md)
- Investigated commit: `acf346188d0a4d39fb667ec6d0d82880153f4ba5`
- Last verified: `2026-05-11`
- Activity / maintenance status: moderately active at selection; the repository was last pushed on `2025-07-20`, uses a current Android toolchain, and still has Java `17` CI configured on branch `dev`.

## Short Description

Small Android Battleship game written directly on the Android SDK with Kotlin, `Canvas`, `Custom View`, `LiveData`, and coroutines, plus a focused rules/test surface around ship placement, touch-grid selection, and opponent shot logic.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `testing`
- Engine / framework: custom Android SDK implementation with `ViewModel`, `LiveData`, `DataBinding`, and coroutines
- Rendering approach: custom `View` subclasses that draw the board, hits, misses, ships, and selection state on Android `Canvas`
- Main language(s): Kotlin
- Android target: direct Android app
- Build system: single-app Gradle Groovy Android project

## Why It Matters

- This repository fills an important gap in the lab because it shows how to build a small but real Kotlin Android game without LibGDX, Compose, or a reusable engine layer.
- Its best value is the combination of Android-native rendering, touch-grid interaction, `ViewModel`-owned turn flow, and a compact opponent AI that is richer than pure randomness.

## Reusable Ideas

- Gameplay ideas:
  - Battleship placement validation, killed-ship neighbor marking, and remaining-ship-aware opponent targeting
- Architecture patterns:
  - single-activity shell with a `ViewModel` owning turn state and observable board data for custom views
- Graphics / rendering techniques:
  - measured grid rendering through reusable `Canvas` helpers and state-specific board overlays
- Input / UI approaches:
  - touch-to-grid conversion with selected-cell highlight and separate fire confirmation
- Performance or optimization ideas:
  - narrow view invalidation and event-driven coroutine delays instead of a full custom frame loop

## Notable Implementations

- `SquareView`, `ComputerSquareView`, and `PersonSquareView` form a compact reusable pattern for Android `Canvas` board rendering.
- `MainViewModel` coordinates two battlefields, one shot manager, status text, selection state, and delayed computer turns through `LiveData` plus `viewModelScope`.
- `BattleField` keeps the ship-placement and shot-resolution rules isolated from UI code.
- `ShotManager` turns computer firing into a small state machine that remembers partial hits and remaining ship sizes.
- `.github/workflows/android_build.yml` shows that the repository has a real CI surface for tests, lint, and assemble.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android SDK game built around activities, custom views, resources, and touch input
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - the repository is especially useful for board games, puzzle games, and other small 2D titles that want full Android UI integration without taking on a heavier game engine

## Risks / Limitations

- The repository has no explicit license file, so treat it as an ideas/reference source rather than as code intended for direct reuse.
- The project scope is small and narrow compared with the engine-heavy or systems-heavy references in the lab.
- Local Gradle verification in this lab is blocked by the machine still exposing Java `8`, while the inspected build now requires Java `11+` and upstream CI runs on Java `17`.
- There is no persistence, networking, or large content pipeline here; its value is concentrated in Android-native board-game structure.

## Notes

Treat `SeaBattle` as a focused Android-native reference for `Canvas`/`Custom View` games. It is most useful when future work needs direct SDK rendering, touch-grid input, lightweight turn orchestration, or a compact rules-plus-AI shell for a board or puzzle game.
