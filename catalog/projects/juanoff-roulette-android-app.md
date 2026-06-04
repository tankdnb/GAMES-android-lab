# Project Entry

## Basic Info

- Project name: `Roulette Android App`
- Source repository: [https://github.com/Juanoff/roulette-android-app](https://github.com/Juanoff/roulette-android-app)
- Author / organization: `Juanoff`
- License: `MIT`
- Research note: [research/findings/juanoff-roulette-android-app.md](../../research/findings/juanoff-roulette-android-app.md)
- Investigated commit: `0a4a45d6260fb5140ecda5f363b97410714c85cd`
- Last verified: `2026-06-04`
- Activity / maintenance status: fresh but still extremely low-signal; the latest inspected commit is a merge on `2026-05-28`, the repository was created the same day, and no visible CI workflows were found.

## Short Description

Small Android Compose roulette-wheel app with configurable sector counts, Canvas-rendered sectors, smooth deceleration animation, portrait/landscape adaptive layout, and a clean single-screen MVVM shell.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`
- Engine / framework: Android SDK + Jetpack Compose + Material 3 + AndroidX Lifecycle/ViewModel + Hilt + Coroutines/StateFlow
- Rendering approach: one custom Compose Canvas wheel built from arcs plus rotated native-canvas text labels, wrapped in an orientation-adaptive Material 3 shell
- Main language(s): Kotlin
- Android target: direct Android app module with `minSdk 26`, `targetSdk 37`, and `compileSdk 37`
- Build system: Gradle `9.5.1` wrapper + AGP `9.2.1` + Kotlin `2.3.21` + Java toolchain `21`

## Why It Matters

- `roulette-android-app` is worth keeping because it is a compact direct Android reference for three reusable patterns that often get implemented messily in small casual apps:
  - custom wheel rendering in Compose Canvas
  - a configuration-driven result model kept outside the composables
  - resumable in-flight animation state stored in the `ViewModel`
- It is not a deep gameplay repository, but it is a good example of how to keep a small Android game-like product shell readable and separated without introducing a full engine.

## Reusable Ideas

- Gameplay ideas:
  - configurable sector counts and deterministic winner calculation from normalized final angle
- Architecture patterns:
  - `StateFlow`-owned session state, explicit UI events, and thin route-to-screen binding
- Graphics / rendering techniques:
  - Compose Canvas arc wheel with rotated label drawing through `nativeCanvas`
- Input / UI approaches:
  - idle-only configuration changes, disabled spin CTA while animating, and orientation-specific layout composition
- Performance or optimization ideas:
  - resumable finite animation state based on start angle, target angle, start time, and duration instead of restarting from zero after recreation

## Notable Implementations

- `RouletteViewModel.kt` centralizes spin state, wheel configuration, target rotation, and selected sector.
- `RouletteAnimationStateCalculator.kt` reconstructs current rotation and remaining duration from stored spin metadata so the UI can resume a spin cleanly.
- `RouletteWheel.kt` and `RouletteSectorView.kt` render the full wheel directly in Compose Canvas.
- `CalculateRouletteResultUseCase.kt` keeps sector result logic independent from UI animation code.
- `RouletteScreen.kt` uses a small but clean portrait/landscape split around the same shared state and render surface.

## Android Relevance

- Native Android use:
  - yes, direct single-module Android app
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - strongest as a reference for small Compose game shells, custom wheel/dial rendering, and resumable finite animation handling; weaker as a reference for persistence, testing, or larger gameplay architecture

## Risks / Limitations

- The repository is intentionally narrow and small.
- Automated tests are effectively absent beyond templates, and the checked-in instrumentation example appears stale.
- No CI workflows or stronger ecosystem signal were found.
- Hilt is present even though the current dependency graph is tiny, so the DI setup is more educational than necessary for this exact scope.

## Notes

`roulette-android-app` is not one of the lab's highest-depth game references, but it is a useful compact Android Compose sample for teams that need a clean starting point for spinner, wheel, or other timed custom-canvas casual-game interactions.
