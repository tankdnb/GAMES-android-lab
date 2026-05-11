# Project Entry

## Basic Info

- Project name: `DinoCompose`
- Source repository: [https://github.com/wajahatkarim3/DinoCompose](https://github.com/wajahatkarim3/DinoCompose)
- Author / organization: `wajahatkarim3`
- License: `Apache-2.0`
- Research note: [research/findings/wajahatkarim3-dinocompose.md](../../research/findings/wajahatkarim3-dinocompose.md)
- Investigated commit: `10ee4069d57c3c15c47161fcf88a07107f6e83c6`
- Last verified: `2026-05-11`
- Activity / maintenance status: stale at selection; the repository last pushed on `2022-01-09`, and the inspected build stack still targets early Jetpack Compose and AGP `7.0.2`.

## Short Description

Compact Chrome Dino clone for Android built directly in Jetpack Compose, using path-drawn vector silhouettes, one-canvas endless-runner rendering, recycled obstacle/background state, and tap-to-jump gameplay.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `collision`
- Engine / framework: Android SDK + Jetpack Compose + LiveData
- Rendering approach: Compose `Canvas` plus `PathParser`-generated vector paths, dashed line effects, and Material theme recoloring
- Main language(s): Kotlin
- Android target: direct single-activity Android application
- Build system: single-module Android Gradle app

## Why It Matters

- This repository is useful as a narrow direct-Android Compose prototype reference, especially for path-based vector art, simple endless-runner recycling, and debug hitbox overlays.
- It is also valuable as a counterexample: the gameplay loop mutates state directly during composition, so the project is better treated as a compact idea source than as a primary architecture model.

## Reusable Ideas

- Gameplay ideas:
  - randomized obstacle queue recycling, dashed-ground scrolling, cloud recycling, and one-tap restart flow
- Architecture patterns:
  - tiny state-holder classes for each moving subsystem plus a clear warning that frame updates should live outside composition in production code
- Graphics / rendering techniques:
  - code-embedded SVG-like path strings, matrix-scaled Compose `Path` sprites, and light/dark theme recoloring without duplicate art assets
- Input / UI approaches:
  - full-screen tap-to-jump/replay input, compact score HUD, game-over overlay, and runtime hitbox toggle
- Performance or optimization ideas:
  - cheap Rect-based hitboxes with deflated bounds and fixed-size object recycling instead of constant respawn allocation

## Notable Implementations

- `AssetPaths.kt` parses and rescales vector path data directly into Compose paths.
- `DinoComposeGame.kt` renders the whole runner in a single Canvas and exposes optional debug bounds.
- `CactusState`, `CloudState`, and `EarthState` implement small recycled scrolling-state holders.
- `DinoState` handles jump arc and two-keyframe dinosaur animation.
- `GameState` rolls score into high score during replay and bridges `LiveData` into Compose.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android Compose game sample
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - best used when prototyping small Compose-native games or when borrowing vector-path and endless-runner ideas, not as a full architecture baseline

## Risks / Limitations

- State mutation happens during composition instead of inside a frame/tick effect.
- Tooling is stale and still depends on legacy repositories such as `jcenter()` and Bintray.
- Test coverage is essentially placeholder-only.
- The gameplay scope is very narrow.

## Notes

Keep this as a compact reference-only Compose runner sample. Reach for stronger entries like `Neon` or `compose-game` when you need a cleaner Compose-game architecture baseline.
