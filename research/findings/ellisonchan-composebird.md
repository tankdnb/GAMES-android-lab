# Findings: `ellisonchan/ComposeBird`

## Snapshot

- Repository: `https://github.com/ellisonchan/ComposeBird`
- Investigated commit: `1ac908f8899c9e4a54b248c897b3e8996a74c83f`
- License: `MIT`
- Repository type: `android-game`
- Primary language: `Kotlin`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-agp811-needs-java11`
- Research date: `2026-06-12`

## What It Is

`ComposeBird` is a compact Android Jetpack Compose clone of Flappy Bird. The inspected tree is a single-app repository that combines a coroutine-driven tick loop, a `GameViewModel` state machine, and Compose-based rendering for the bird, pipes, foreground scrolling, score overlays, and splash-screen choreography.

The project is a real playable Android game sample, but it stays very small and keeps a lot of gameplay and collision behavior close to the UI layer.

## Why It Matters

This repository is worth recording as a narrow Android Compose reference:

- it shows one practical way to drive a simple game from a `LaunchedEffect` tick loop instead of a custom `SurfaceView`
- it demonstrates direct Compose handling for gesture input, repeated pipe recycling, road scrolling, and bird rotation/position updates
- it includes a richer-than-usual custom Android 12 splash-screen exit animation for a tiny game sample

At the same time, the repo is too monolithic and lightly tested to count as a stronger main-catalog architecture baseline.

## Verified Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `animation`
- Engine / framework: Android SDK + Jetpack Compose + AndroidX `ViewModel` + splash-screen API
- Rendering approach: Compose layout tree with offset-based sprite movement and image-based backgrounds/pipes
- Android target: direct Android app only
- Other targets seen in repo: none
- Build system: Gradle Groovy DSL

## High-Value Reusable Ideas

### 1. A very small coroutine-driven game tick loop

`MainActivity.kt` uses a `LaunchedEffect(Unit)` loop that:

- delays for `50L`
- skips updates while still in `Waiting`
- dispatches `GameAction.AutoTick` into the `GameViewModel`

This is not an engine abstraction, but it is a readable reference for tiny Compose-native games where a custom rendering thread would be excessive.

### 2. Game state still lives in a central `GameViewModel`

`GameViewModel.kt` is the main structural value:

- `dispatch()` translates UI events and recycling callbacks into a single action path
- `AutoTick` advances bird fall, pipe movement, and road movement together
- `ScreenSizeDetect` rescales pipe gaps and bird size from measured screen height
- score counting, restart, pipe reset, and death transitions all pass through one state reducer-style branch

This is a useful comparison sample for simple Android games that want a little more structure than putting all logic straight into composables.

### 3. Compose-side gameplay checks are easy to study

`GameScreen.kt` keeps the moment-to-moment interactions visible:

- `pointerInteropFilter` translates taps into start or flap actions
- `onGloballyPositioned` captures playfield size and triggers one-time runtime rescaling
- `CheckPipeStatus()` computes pipe-crossing and hit detection from offsets plus bird dimensions

That makes the repo a practical reading reference for understanding how a tiny Compose game can map layout coordinates directly into gameplay events.

### 4. Custom splash-screen exit animation is unusually polished for a tiny sample

`SplashScreenController.kt` adds:

- full-surface fade/scale exit
- icon translation/scale choreography
- Android 12 splash-screen API wiring

This is valuable outside the game itself because Android game prototypes often need a more branded startup experience than default app samples show.

## Other Useful Implementations

- `Bird.kt` rotates the bird by gameplay state and clamps the final fall against the ground boundary.
- `PipeCouple.kt` and `NearForeground.kt` use offset-based recycling rather than constantly recreating scenery.
- `ScoreBoard.kt` cleanly splits real-time score and game-over overlays into separate small composables.

## Testing Surface

The visible test surface is effectively template-only.

Verified:

- one default unit test under `app/src/test`
- one default instrumentation test under `app/src/androidTest`
- no visible gameplay, collision, or `ViewModel` tests

This substantially lowers reuse confidence.

## Android Relevance

### Direct relevance

High.

This is a direct Android Compose game with touch input, runtime resizing, score overlay handling, and a branded splash flow.

### Indirect relevance

Moderate.

The repo is more useful as a compact pattern library for small Compose-game shells than as a source of deep reusable gameplay-core architecture.

## Build And Environment Notes

Verified locally:

- `cmd /c gradlew.bat --version` succeeded after redirecting `GRADLE_USER_HOME` into `research/cache/gradle-composebird`
- `cmd /c gradlew.bat help --no-daemon` failed during Android Gradle Plugin resolution because the lab machine exposes Java `8`

Observed failure shape:

- AGP `8.1.1` resolves as a Java `11` plugin dependency
- the current lab consumer is still `compatible with Java 8`

Interpretation:

- the checked-in wrapper is present and structurally healthy
- the current local failure is an environment/JVM-floor issue, not a broken repository wrapper

Additional build notes:

- root `settings.gradle` still includes `jcenter()`
- `app/build.gradle` mixes newer Compose BOM usage with `androidTestImplementation 'androidx.compose.ui:ui-test-junit4:1.0.0-beta07'`
- lifecycle pause/resume actions are still left as TODO comments

## Risks And Limits

- collision, ground-hit, and some recycling side effects are still triggered from composables rather than from a cleaner pure gameplay core
- `ViewState` contains mutable `var` fields, and `dispatch()` mutates parts of the current state before reduction
- best score is kept only in memory for the current run; no persistence layer was found
- visible tests are template-only
- some imports and commented code in `MainActivity.kt` and other files show a still-rough sample state

## Catalog Verdict

`reference-only`

The repository is worth keeping as a compact Android Compose comparison sample for coroutine-driven ticking, direct tap handling, offset-based scenery recycling, and splash-screen animation polish. It is too small, UI-coupled, and under-tested to count as a stronger main catalog reference.
