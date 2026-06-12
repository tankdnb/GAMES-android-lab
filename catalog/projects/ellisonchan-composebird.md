# ComposeBird

## Basic Info

- Project name: `ComposeBird`
- Source repository: `https://github.com/ellisonchan/ComposeBird`
- Author / organization: `ellisonchan`
- License: `MIT`
- Research note: [research/findings/ellisonchan-composebird.md](../../research/findings/ellisonchan-composebird.md)
- Investigated commit: `1ac908f8899c9e4a54b248c897b3e8996a74c83f`
- Last verified: `2026-06-12`
- Activity / maintenance status: older code push at selection; last push visible on `2023-11-16`

## Short Description

Compact Android Jetpack Compose Flappy Bird clone with a coroutine-driven tick loop, direct tap input, offset-based pipe and road recycling, splash-screen choreography, and a small `GameViewModel` state machine.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `animation`
- Engine / framework: Android SDK + Jetpack Compose + AndroidX `ViewModel` + splash-screen API
- Rendering approach: Compose image/layout tree with offset-based movement and simple gameplay-state rotation
- Main language(s): `Kotlin`
- Android target: direct Android app only
- Build system: `Gradle` (Groovy DSL)

## Why It Matters

This project is useful as a small direct-Android Compose comparison sample:

- simple coroutine-driven game ticking
- readable tap-to-flap interaction
- direct Compose collision and boundary checks
- polished custom splash-screen exit animation

## Reusable Ideas

- Gameplay ideas: compact endless-runner flap/fall loop with pipe-cross scoring
- Architecture patterns: small `GameViewModel` action dispatcher for tiny Compose games
- Graphics / rendering techniques: offset-based sprite scrolling and gameplay-state bird rotation
- Input / UI approaches: full-screen tap handling via `pointerInteropFilter`
- Performance or optimization ideas: repeated scenery recycling rather than recreating moving background elements

## Notable Implementations

- `MainActivity.kt` drives the runtime through a `LaunchedEffect` tick loop
- `GameViewModel.kt` centralizes state transitions for ticking, resets, scoring, and death
- `GameScreen.kt` couples measured layout size to runtime pipe and bird scaling
- `SplashScreenController.kt` adds a custom Android 12 splash exit animation

## Android Relevance

- Native Android use: direct Android-only game sample
- Kotlin relevance: high for small Compose-native game shells
- Porting or adaptation notes: best reused selectively for loop/input/splash ideas, not as a full architecture baseline

## Risks / Limitations

- gameplay checks still live partly in composables
- mutable fields inside `ViewState`
- no visible persistence beyond in-memory best score
- effectively no real automated test surface
- stale `jcenter()` dependency source and mixed-era Compose test dependency versions

## Notes

This is best treated as a compact reference for Compose-native mini-game wiring and presentation polish, not as a stronger source of reusable gameplay-core architecture.
