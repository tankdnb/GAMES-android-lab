# Project Entry

## Basic Info

- Project name: `Kubriko`
- Source repository: [https://github.com/pandulapeter/kubriko](https://github.com/pandulapeter/kubriko)
- Author / organization: `pandulapeter`
- License: `MPL-2.0`
- Research note: [research/findings/pandulapeter-kubriko.md](../../research/findings/pandulapeter-kubriko.md)
- Investigated commit: `c78e2ced9b72226dd01105873673e0812f0bfea3`
- Last verified: `2026-05-10`

## Short Description

Compose Multiplatform-based 2D engine with Android support, manager/plugin architecture, and built-in subsystems for input, physics, collision, serialization, and debug overlays.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `android`, `multiplatform`, `input`, `physics`, `editor-tools`
- Engine / framework: Kubriko
- Rendering approach: Compose viewport with manager-provided rendering and overlay layers
- Main language(s): Kotlin
- Android target: direct Android support through Compose Multiplatform embedding
- Build system: Gradle Kotlin DSL

## Why It Matters

- It is one of the clearest references for a Compose-native game engine shape that still behaves like an engine rather than just a custom UI app.
- The modular manager/plugin structure is directly useful for future Android game architecture.

## Reusable Ideas

- Gameplay ideas:
  - the main value is engine/plugin architecture rather than one finished game
- Architecture patterns:
  - engine instance composed from managers and plugins
- Graphics / rendering techniques:
  - viewport-aware actor filtering, overlay layers, and aspect-ratio modes
- Input / UI approaches:
  - normalized pointer/gesture manager inside an embeddable Compose viewport
- Performance or optimization ideas:
  - sleeping far-away actors and focus-aware runtime gating

## Notable Implementations

- `KubrikoViewport` embeds the runtime as a normal Compose `@Composable`.
- `InternalViewport` owns lifecycle focus, frame ticking, and viewport scaling.
- `ActorManagerImpl` filters visible actors and can skip updating far-away dynamics.
- `PointerInputManagerImpl` translates Compose pointer events into engine callbacks.
- `PhysicsManagerImpl` and `CollisionManagerImpl` keep simulation and collision as separate managers.
- `SerializationManagerImpl` uses typed metadata registration for actor save/load.

## Android Relevance

- Native Android use:
  - yes
- Kotlin relevance:
  - very high
- Porting or adaptation notes:
  - especially useful for projects that want to stay close to Compose Multiplatform and avoid a separate activity-owned engine shell

## Risks / Limitations

- The project is still early-stage.
- `MPL-2.0` requires care for modified engine-code reuse.
- Build validation was inconclusive because the Gradle discovery attempt timed out.

## Notes

This is currently one of the strongest direct Android-oriented engine references in the lab.
