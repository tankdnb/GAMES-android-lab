# Project Entry

## Basic Info

- Project name: `LinkGame`
- Source repository: [https://github.com/Amigoconglomeration918/LinkGame](https://github.com/Amigoconglomeration918/LinkGame)
- Author / organization: `Amigoconglomeration918`
- License: `MIT`
- Research note: [research/findings/amigoconglomeration918-linkgame.md](../../research/findings/amigoconglomeration918-linkgame.md)
- Investigated commit: `60b5f85c1b243b99bae9977d5161e0138013354b`
- Last verified: `2026-06-04`
- Activity / maintenance status: freshly updated but still very low-signal; the latest inspected commit is `Update README.md` from `2026-06-04`, with no visible CI workflows or broader ecosystem traction yet.

## Short Description

Small Android tile-link puzzle game built with Jetpack Compose, featuring challenge and endless modes, solvability-checked board generation, local leaderboard and nickname persistence, sound controls, and a compact Material 3 casual-game shell.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `audio`, `save-load`, `procedural-generation`
- Engine / framework: Android SDK + Jetpack Compose + Material 3 + ViewModel + DataStore + MediaPlayer
- Rendering approach: Compose layout and Material 3 cards with a custom tile-grid renderer, off-board path overlays, pulsing hint states, and a warning-style timer HUD
- Main language(s): Kotlin
- Android target: direct Android app module with `minSdk 24`, `targetSdk 36`, and `compileSdk 36`
- Build system: Gradle `8.13` wrapper + AGP `8.13.0` + Kotlin `2.3.0`

## Why It Matters

- `LinkGame` is worth keeping because it is a direct Android casual-game shell with a few clean implementation ideas that are easy to lift into future Kotlin puzzle projects.
- The strongest pieces are not the overall scale of the app, but the solvability-aware board generator, padded-grid pathfinding and path overlay rendering, split DataStore persistence seams, and process-lifecycle-aware audio handling.

## Reusable Ideas

- Gameplay ideas:
  - challenge vs endless mode split, hint pair scanning, remaining-pair tracking, and solvable tile-board generation
- Architecture patterns:
  - one `ViewModel`-owned session state, one small manual navigation shell, and separate repositories for leaderboard, nickname, and settings
- Graphics / rendering techniques:
  - Compose board rendering that includes a padded outer border so valid link paths can visibly travel outside the main grid
- Input / UI approaches:
  - click-to-select tile flow, back-button-aware save or exit dialogs, endless difficulty chip selection, and a compact local leaderboard UX
- Performance or optimization ideas:
  - generate until solvable instead of repairing impossible boards at runtime, and keep background music lifecycle-aware rather than screen-aware

## Notable Implementations

- `BoardGenerator.kt` retries random boards until `Solver.kt` says the puzzle can actually be cleared.
- `ConnectionChecker.kt` and `PathFinder.kt` implement two-turn padded-grid path rules and reconstruct the drawn route for UI feedback.
- `GameBoard.kt` renders path states, hint states, and off-board connection segments directly in Compose.
- `GameController.kt` centralizes timer, progression, scoring, hinting, and save-return flow.
- `LeaderboardRepository.kt`, `NicknameRepository.kt`, and `SettingsRepository.kt` keep local persistence responsibilities intentionally separate.
- `AudioManager.kt` binds BGM ownership to `ProcessLifecycleOwner` and settings flows.

## Android Relevance

- Native Android use:
  - yes, direct single-module Android app
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - strongest as a reference for small Compose puzzle shells, local persistence, and product polish seams; weaker as a build-discipline or test-discipline baseline

## Risks / Limitations

- Test coverage is effectively template-only.
- The repository has zero stars and no visible CI.
- Build hygiene is rough, with duplicate dependency declarations and mirror-heavy repository configuration.
- The README is download-oriented and a zip artifact is checked into `src/main/java`, which lowers confidence as a clean development baseline.
- The app is intentionally narrow in genre and scale.

## Notes

`LinkGame` is not one of the lab's deepest Android references, but it is a good compact example of how to package puzzle logic, Compose rendering, local product state, and audio/settings flows into a usable Android game shell without adding an engine or service stack that would be too heavy for the problem.
