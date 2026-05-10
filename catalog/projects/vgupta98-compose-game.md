# Project Entry

## Basic Info

- Project name: `Compose Game Engine`
- Source repository: [https://github.com/vgupta98/compose-game](https://github.com/vgupta98/compose-game)
- Author / organization: `vgupta98`
- License: `Apache-2.0`
- Research note: [research/findings/vgupta98-compose-game.md](../../research/findings/vgupta98-compose-game.md)
- Investigated commit: `bb548e2eb911337c11da53094c3ce6e2ccad45c4`
- Last verified: `2026-05-11`
- Activity / maintenance status: last pushed at selection on `2024-07-26`; no CI workflow was found, and `jitpack.yml` targets `openjdk17` but references a missing prepare script.

## Short Description

Compact 2D Jetpack Compose micro-engine packaged as an Android library plus sample app, centered on analytical motion, simple restitution-based collisions, and `Canvas`/`VectorPainter` rendering.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `android`, `collision`, `physics`, `ui-hud`
- Engine / framework: Android SDK + Jetpack Compose + coroutine-driven micro-engine library
- Rendering approach: Compose `Canvas` with ID-mapped `VectorPainter` sprites and line-boundary drawing
- Main language(s): Kotlin
- Android target: direct Android library module with a sample Android host app
- Build system: multi-module Android Gradle project with version catalog and `maven-publish`

## Why It Matters

- This repository is useful because it shows the smallest viable shape of a reusable Compose-native engine/library rather than another app-level game sample.
- Its strongest Android value is the library-host split: the host app owns UI and coroutine scope, while the engine owns simulation state, collision math, and render projection.

## Reusable Ideas

- Gameplay ideas:
  - not the main value; the sample is mostly a bounce/physics demo rather than a content-rich game
- Architecture patterns:
  - public engine API plus factory, immutable game objects inside a Compose state list, and analytical state derived from `lastCollisionTime`
- Graphics / rendering techniques:
  - ID-mapped render resources, `Canvas`-based engine drawing, `VectorPainter` rotation/translation, and draw hooks above/below engine objects
- Input / UI approaches:
  - engine embedded into a normal Compose activity, with the host app controlling start/pause and resource wiring
- Performance or optimization ideas:
  - derive positions and velocities analytically and rewrite object state only when a collision changes the motion path

## Notable Implementations

- `GameEngineImpl` runs the loop off an `Animatable<Float>` clock and resumes from pause by preserving partial-loop time.
- `InitialConditionsChecker` constrains momentum, velocity, acceleration, restitution, and object shape before the engine accepts inputs.
- `GameBoard` renders engine objects through a resource layer instead of mixing painters and physics data.
- `checkForCollisions()` handles both circle-circle and circle-boundary interactions with restitution and simple angular response.

## Android Relevance

- Native Android use:
  - yes; the repository is directly built as Android library plus app sample around Compose
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful when building small Compose-native Android games or physics toys that need a reusable runtime but do not justify a full engine stack

## Risks / Limitations

- Best treated as a micro-engine reference for small games only.
- Only round objects and straight boundaries are supported.
- `GameBoard` leaks the implementation by casting `GameEngine` to `GameEngineImpl`.
- Automated test coverage is effectively absent.
- Build/publication verification in the lab currently needs a full Java `17` JDK.

## Notes

This repository is most valuable when the lab wants a compact reference for Compose-hosted simulation loops, simple physics, and library-style engine embedding inside a normal Android app.
