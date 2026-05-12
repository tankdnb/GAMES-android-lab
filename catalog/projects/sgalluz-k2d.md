# Project Entry

## Basic Info

- Project name: `K2D`
- Source repository: [https://github.com/sgalluz/k2d](https://github.com/sgalluz/k2d)
- Author / organization: `sgalluz`
- License: `Apache-2.0`
- Research note: [research/findings/sgalluz-k2d.md](../../research/findings/sgalluz-k2d.md)
- Investigated commit: `da72e4948a6d952995c74850f20379c5992d2efd`
- Last verified: `2026-05-13`
- Activity / maintenance status: active at selection; the repository was pushed on `2026-05-08`, carries live CI plus publication plumbing, and currently looks like an actively iterated pre-alpha engine.

## Short Description

Desktop-first Compose Multiplatform 2D micro-engine written in Kotlin, with a pure timing core, flat ECS, configurable input mapping, simple collision responses, and a deliberate runtime-adapter boundary around Compose.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `multiplatform`, `ecs`, `input`, `collision`, `testing`
- Engine / framework: custom `K2D` engine
- Rendering approach: Compose Desktop `Canvas` hosted through a runtime-layer game-loop adapter plus ECS-owned render systems
- Main language(s): Kotlin
- Android target: future-oriented only; current checked-in sample is desktop-first and no Android module is present
- Build system: Gradle Kotlin DSL multi-module JVM workspace

## Why It Matters

- `K2D` is a useful lab reference for teams exploring whether Compose can remain just a runtime and rendering adapter instead of becoming the whole engine architecture.
- Its strongest value is architectural clarity relative to its size: the frame clock, ECS, input, collision, rendering, and publication seams are all easy to inspect and reuse.

## Reusable Ideas

- Gameplay ideas:
  - mostly engine-oriented rather than game-content-oriented
- Architecture patterns:
  - pure timing core separated from the Compose frame host and a flat ECS with deferred deletion cleanup
- Graphics / rendering techniques:
  - Compose `Canvas` driven by an injected frame clock plus ECS-rendered primitive shapes with simple collision tinting
- Input / UI approaches:
  - abstract action mapping and projection of host keyboard/mouse state into ECS systems
- Performance or optimization ideas:
  - keep the runtime small, deterministic, and testable before adding heavier asset or scene systems

## Notable Implementations

- `GameLoop` and `TimeTicker` keep frame-step math independent from Compose.
- `rememberGameLoop()` and `k2dProvideGameLoop()` inject the runtime clock through a `CompositionLocal`.
- `World` and `Entity` implement a tiny class-keyed ECS with post-update `DeletionMark` cleanup.
- `InputSystem` and `MouseSystem` translate host input state into ECS velocity and position updates.
- `CollisionSystem` plus `CollisionResponseDispatcher` separate overlap detection from `STATIC`, `BOUNCE`, `PUSH`, and `EXPLODE` response policies.
- `engine/build.gradle.kts` wires coverage gates, Dokka, publishing, and signing earlier than most hobby-engine repositories do.

## Android Relevance

- Native Android use:
  - not yet; the current repository only ships a desktop sample
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - most useful as a reference for future Compose-based Android runtime experiments where the engine core should stay host-agnostic even before a real Android backend exists

## Risks / Limitations

- The engine is still pre-alpha and has almost no public ecosystem signal yet.
- Android support is only an architectural intention in the inspected revision.
- Collision handling is still naive `O(n^2)` AABB scanning.
- The sample is small and primitive-focused, so it is not a reference for content pipelines or large-scale gameplay flow.
- Local Gradle validation in the lab is blocked by the workspace Java `8` runtime, while the repository expects Java `17+` and even pins `21.0.7`.

## Notes

This is a good low-signal engine reference for studying how to keep Compose in the runtime layer instead of letting it dictate the whole game architecture.
