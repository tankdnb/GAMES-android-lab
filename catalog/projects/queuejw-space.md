# Project Entry

## Basic Info

- Project name: `Space`
- Source repository: [https://github.com/queuejw/Space](https://github.com/queuejw/Space)
- Author / organization: `queuejw`
- License: `Apache-2.0`
- Research note: [research/findings/queuejw-space.md](../../research/findings/queuejw-space.md)
- Investigated commit: `e4da4ca519c1be17b7f0dded4e92cab836067096`
- Last verified: `2026-06-04`
- Activity / maintenance status: active enough for a compact Android reference; the repository was pushed on `2025-09-05`, GitHub still showed an update timestamp on `2026-05-04`, the default branch is `android-16`, and the latest inspected commit was `Update to Android 16 Completed`.

## Short Description

Standalone Android-native space sandbox/game derived from the Android 14-16 Easter Egg, using Compose for rendering and UI, a tiny in-repo simulator for gravity and landing, and direct Android platform integrations such as dream service and live progress notifications.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `physics`, `ai`, `procedural-generation`
- Engine / framework: custom Android-native Compose game shell with a small simulation/constraint layer
- Rendering approach: Compose-driven vector/path drawing with simulation-step invalidation and zoom-aware world rendering
- Main language(s): Kotlin
- Android target: direct and exclusive; the repository is a single Android app module with Android-specific activity, dream service, foldable handling, and notification integration
- Build system: Gradle Kotlin DSL Android application on AGP `8.13.0`, Kotlin `2.2.10`, and Java `21` source/target

## Why It Matters

- `Space` is a useful reference because it shows how far a small Android game can go without adding a separate engine, `SurfaceView`, or asset-heavy rendering stack.
- The main reuse value is not genre depth; it is the combination of Compose-hosted real-time rendering, a tiny simulator, readable touch controls, and explicitly Android-only platform features.

## Reusable Ideas

- Gameplay ideas:
  - planet exploration through landing, orbit travel, simple autopilot, and procedurally seeded solar-system targets
- Architecture patterns:
  - tiny `Simulator` plus constraints plus simulation-step listeners instead of a heavier engine runtime
- Graphics / rendering techniques:
  - zoom-aware Compose draw pipeline with path-authored ship/star art, orbit rings, and debug overlays
- Input / UI approaches:
  - one-finger flight stick, optional transformable camera controls, console-style telemetry, and explicit autopilot controls
- Performance or optimization ideas:
  - invalidate rendering only on completed simulation steps and ignore excessively large frame gaps via `MAX_VALID_DT`

## Notable Implementations

- `Physics.kt` defines the minimal simulation loop and constraint flow.
- `VisibleUniverse.kt` draws the whole world through Compose primitives and a custom `DrawModifierNode`.
- `MainActivity.kt` uses `withInfiniteAnimationFrameNanos` for the game loop, supports foldable posture-aware camera framing, and exposes a visual flight stick.
- `Universe.kt` handles gravity, orbiting planets, landing constraints, exploration state, and ship effects.
- `Autopilot.kt` provides a small relative-motion guidance system with explicit strategy transitions and renderer-friendly telemetry.
- `DreamUniverse.kt` reuses the runtime as an Android dream service.
- `UniverseProgressNotifier.kt` turns autopilot progress into Android 16 progress notifications with planet-size icons and ship-angle icon rotation.

## Android Relevance

- Native Android use:
  - yes; Android is the whole product surface
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for compact Android-only games that want continuous simulation, custom touch controls, and Android platform integration without adopting a separate engine

## Risks / Limitations

- The codebase is narrow and closely tracks AOSP Easter Egg code, so it should not be treated as a broad reusable engine or novel gameplay architecture baseline.
- No automated tests or CI workflows were found.
- Local Gradle validation in the lab is still blocked because the machine only exposes Java `8`, while the project now requires Java `17+` to configure and targets Java `21`.

## Notes

This is a strong compact Android-native reference: not large, not original in the ecosystem sense, but unusually clear about how Compose, a small physics loop, Android controls, foldable behavior, dream mode, and notification UX can fit together in one Kotlin game app.
