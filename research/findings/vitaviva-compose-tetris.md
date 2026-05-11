# Research Note

## Repository Snapshot

- Repository: `vitaviva/compose-tetris`
- Source URL: [https://github.com/vitaviva/compose-tetris](https://github.com/vitaviva/compose-tetris)
- Owner: `vitaviva`
- Batch ID: [`BATCH-2026-05-11-L`](../batches/BATCH-2026-05-11-L.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-05-11`
- Last pushed at selection: `2024-03-22`
- Stars at selection: `868`
- Investigated commit: `234416c455cd0b5524b7f2a7e91aaa9f6206457a`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java11`
- Catalog card: [catalog/projects/vitaviva-compose-tetris.md](../../catalog/projects/vitaviva-compose-tetris.md)

## Why This Repository Was Selected

- The refreshed shortlist after `gauguin` was still thin, but `compose-tetris` stood out because it combines direct Android relevance, a permissive MIT license, and much stronger ecosystem signal than most remaining Compose-game samples.
- It also looked broader than the current backlog candidate `yamin8000/Dooz`: the repository is still compact, but it covers gameplay stepping, collision/board updates, touch controls, visual theming, audio, and a fully Compose-rendered UI shell.
- `behnawwm/RacingCar-compose` remained a plausible alternative, but its weaker signal and missing license metadata made `compose-tetris` the safer public-reference choice.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Android SDK + Jetpack Compose + lifecycle `ViewModel` + coroutines
- Rendering stack: Compose `Canvas`, custom composables, and Android resources styled to mimic an LCD handheld device
- Android target: direct Android app
- Build system: single-module Gradle Groovy Android project
- Repository layout summary: `app` contains all gameplay, UI, and theme code; `.github/workflows/android.yml` provides CI; `results/` stores screenshots, video, and an MVI diagram used as visual documentation
- Source footprint:
  - total files reviewed in repository: `59`
  - Kotlin/Java files reviewed across the repository: `16`
- Test surface:
  - test files found: `2`
  - meaningful gameplay-specific tests found: `0`
- Key modules reviewed:
  - `README.md`
  - `build.gradle`
  - `settings.gradle`
  - `gradle.properties`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `.github/workflows/android.yml`
  - `app/build.gradle`
  - `app/src/main/java/com/jetgame/tetris/MainActivity.kt`
  - `app/src/main/java/com/jetgame/tetris/logic/GameViewModel.kt`
  - `app/src/main/java/com/jetgame/tetris/logic/Spirit.kt`
  - `app/src/main/java/com/jetgame/tetris/logic/Brick.kt`
  - `app/src/main/java/com/jetgame/tetris/logic/Utils.kt`
  - `app/src/main/java/com/jetgame/tetris/ui/GameScreen.kt`
  - `app/src/main/java/com/jetgame/tetris/ui/GameBody.kt`
  - `app/src/main/java/com/jetgame/tetris/ui/GameButton.kt`
  - `app/src/main/java/com/jetgame/tetris/ui/LedNumber.kt`
  - `app/src/main/java/com/jetgame/tetris/ui/AppIcon.kt`
  - `app/src/test/java/com/jetgame/tetris/ExampleUnitTest.kt`
  - `app/src/androidTest/java/com/jetgame/tetris/ExampleInstrumentedTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `7.3-rc-1` running on Java `1.8.0_321`.
- `cmd /c gradlew.bat help --no-daemon` fails while applying the Android application plugin because Android Gradle Plugin `7.1.2` requires Java `11+`, while the lab machine still exposes Java `8`.
- The checked-in build surface confirms the same floor:
  - root `build.gradle` pins Compose `1.1.1`, Android Gradle Plugin `7.1.2`, and Kotlin `1.6.10`
  - `app/build.gradle` targets `compileSdk 32`, `targetSdk 32`, `minSdk 21`, and JVM target `1.8`
  - `.github/workflows/android.yml` sets up JDK `11` and runs `./gradlew assembleDebug --stacktrace`
- The repository still depends on `jcenter()` in `settings.gradle`, which is a maintenance risk even if the current dependency graph still resolves elsewhere.
- The test surface is effectively empty:
  - `ExampleUnitTest.kt` is the default `2 + 2 = 4` template
  - `ExampleInstrumentedTest.kt` only asserts the package name
- No runtime launch was attempted.
- Known setup limitations:
  - local Gradle validation in this lab is blocked by the Java `11` floor
  - the repository is compact and useful, but it is not a strong verification reference because it lacks real tests
  - the toolchain is older and partly stale (`Gradle 7.3-rc-1`, AGP `7.1.2`, Compose `1.1.1`, `jcenter()`)

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - this repository is a solid direct Android Compose gameplay reference even though it is not a deep engine or large production app
  - the most reusable value is the combination of reducer-style game state, Compose `Canvas` rendering, small but practical touch/button patterns, and compact gameplay-state animation flow
  - it stays useful for the lab because it is permissively licensed, well scoped, easy to read, and far more visible than most small Compose-game samples
  - it is not a top-tier architecture baseline because logic, audio, and animation timing remain tightly coupled inside one `ViewModel`, and the verification surface is minimal

## Interesting Findings

### Engine Architecture And Core Loop

- `app/src/main/java/com/jetgame/tetris/logic/GameViewModel.kt` implements a compact reducer-style loop around `Action` and `ViewState`. Every gameplay mutation, from movement and rotation to line clear animation and reset flow, passes through `dispatch()` and `reduce()` rather than being spread across UI callbacks.
- The same file uses explicit `GameStatus` values such as `Onboard`, `Running`, `LineClearing`, `ScreenClearing`, `Paused`, and `GameOver` to encode short-lived animation and flow states directly into the UI model. This is a practical small-game pattern when a full scene manager would be overkill.
- `app/src/main/java/com/jetgame/tetris/MainActivity.kt` shows how to keep a tiny Compose game self-contained without `SurfaceView` or a custom engine thread: a `LaunchedEffect` dispatches `Action.GameTick` on a delay, while a lifecycle observer maps `onResume` and `onPause` into game actions.
- `GameViewModel.clearScreen()` and `updateBricks()` make the flow more reusable than a naive implementation. They compute staged board states once, then animate by emitting those states over time instead of mutating the board from multiple UI layers.

### Rendering And Graphics

- `app/src/main/java/com/jetgame/tetris/ui/GameScreen.kt` uses a single Compose `Canvas` to draw the full playfield matrix, active piece, settled bricks, border, and overlay text. The board scales from one computed `brickSize`, which keeps the matrix, the next-piece preview, and the HUD aligned without a separate rendering engine.
- `app/src/main/java/com/jetgame/tetris/ui/GameBody.kt` and `LedNumber.kt` are notable because they do not stop at functional UI. They recreate an LCD-handheld shell with custom chrome, screen bevels, ghost digits behind active digits, and a LED-style clock/scoreboard, which is directly useful for game-themed UI work in Compose.
- `app/src/main/java/com/jetgame/tetris/ui/AppIcon.kt` reuses the same screen/body/button primitives to generate icon artwork in Compose previews. That is a small but reusable example of keeping branding visuals close to the UI system instead of maintaining separate art-generation logic.

### Gameplay Systems

- `app/src/main/java/com/jetgame/tetris/logic/Spirit.kt` stores tetrominoes as simple lists of `Offset` points and uses pure transform helpers (`moveBy`, `rotate`, `adjustOffset`) to apply gameplay rules. That makes the piece logic easy to read and easy to port.
- `generateSpiritReverse()` in the same file is effectively a compact shuffled full-set reserve: it instantiates one copy of each tetromino, adjusts the spawn offset to fit the matrix, then shuffles the result. This is a clearer and fairer sample than purely random next-piece generation.
- `GameViewModel.updateBricks()` returns three board variants at once: before clear, after removing full lines, and after applying the fall offset to above bricks. That is a strong small-game technique because the line-clear blink animation can reuse the same computed snapshots instead of recomputing board state during every animation step.
- `Action.Drop` in `GameViewModel` performs hard drop by scanning downward until the piece becomes invalid, then stepping back by one row. This is basic Tetris logic, but the implementation is simple and portable.
- The scoring and pacing logic are intentionally small but explicit: `calculateScore()` maps cleared lines to values, `ScoreEverySpirit` rewards each placed piece, and `level` rises every 20 lines up to 10.

### Input And Controls

- `app/src/main/java/com/jetgame/tetris/ui/GameButton.kt` is one of the better direct Android findings in this repository. It uses `pointerInteropFilter`, a coroutine `ticker`, and manual `PressInteraction` emission to create held-button auto-repeat for movement without needing a separate gesture subsystem.
- The same component distinguishes clearly between repeatable buttons and single-fire buttons: left/right/down repeat while held, while rotate is a normal tap action. This is a useful reference for retro-controller style mobile input.
- `MainActivity.kt` maps the `Up` direction button to `Action.Drop` instead of rotation and keeps rotation on its own larger button. Even if another game would choose a different layout, the repository is a clean example of separating directional and special actions in a touch-first controller scheme.

### Tooling, Android Integration, Or Other Notable Areas

- `app/src/main/java/com/jetgame/tetris/logic/Utils.kt` contains a compact Android integration seam: `StatusBarUtil` handles immersive visual framing, and `SoundUtil` preloads short raw sounds into `SoundPool` so the reducer can trigger audio on move/rotate/drop/clean events.
- `.github/workflows/android.yml` gives the repository a minimal but real public build path by assembling the debug APK on JDK `11` and uploading it as an artifact.
- `results/mvi_arch.png`, `results/screenshot.gif`, and `results/video.mp4` are worth noting because they make the repository easier to cite later; the project carries its own visual evidence instead of relying only on README prose.

## Reusable Takeaways

- A small Android game can stay entirely inside normal Compose + `ViewModel` app structure if the runtime is simple and the state transitions are explicit.
- Compose `Canvas` is sufficient for classic board and sprite-like rendering when the scene is grid-based and the visual language is relatively flat.
- Held-button auto-repeat with `pointerInteropFilter` plus a coroutine `ticker` is a practical direct-touch control pattern for retro or arcade mobile games.
- If a game needs short animation phases such as line clear or screen wipe, precompute the meaningful board snapshots first and animate by swapping between them.
- Reusing UI primitives for auxiliary visuals such as app icons or mock screens can make a small game repository more coherent and easier to maintain.

## Evidence Summary

- `MainActivity.kt`, `GameViewModel.kt` - reducer-style runtime ownership, Compose-driven tick loop, lifecycle pause/resume, and short-lived gameplay status states
- `Spirit.kt`, `Brick.kt` - tetromino representation, rotation/movement helpers, collision validation, and shuffled full-piece reserve generation
- `GameViewModel.kt` - hard drop, line clear detection, board snapshot triples, score/level handling, and screen-clear animation
- `GameScreen.kt`, `GameBody.kt`, `LedNumber.kt`, `AppIcon.kt` - Compose `Canvas` board rendering, handheld-shell UI, LED HUD styling, and preview-generated icon assets
- `GameButton.kt` - pointer-based held-button auto-repeat and explicit press-state handling
- `Utils.kt`, `.github/workflows/android.yml`, `build.gradle`, `app/build.gradle`, `settings.gradle` - audio/status-bar integration, JDK11 CI, and the stale but coherent build surface
- `ExampleUnitTest.kt`, `ExampleInstrumentedTest.kt` - placeholder-only verification surface

## Risks Or Limits

- The repository is stale for a fast-moving Android Compose stack. It still uses Compose `1.1.1`, AGP `7.1.2`, Gradle `7.3-rc-1`, and `jcenter()`.
- The test surface is effectively nonexistent beyond Android Studio templates, so behavior confidence comes mainly from static reading and the visible demo artifacts.
- The architecture is intentionally small, but that also means gameplay state, animation timing, and audio side effects are all coupled inside one `ViewModel`.
- There is a likely code-level caveat in `MainActivity.kt`: the falling-speed loop is launched in `LaunchedEffect(Unit)` while reading `viewState.level` from the surrounding composition. Because the effect key never changes, the delay calculation likely keeps using the level captured at initial composition instead of responding to later level-ups.
- The repository is a compact gameplay/UI sample, not a broad engine or production-process reference.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `collision`, `audio`
- Follow-up needed:
  - if the lab revisits this repository later, verify the tick-speed behavior on a real device or emulator and check whether the `LaunchedEffect(Unit)` loop should instead react to level changes
  - a narrower follow-up could isolate the held-button repeat control pattern or the reducer-style `ViewModel` plus Compose `Canvas` board shell instead of reopening the whole repository broadly
