# Project Entry

## Basic Info

- Project name: `Fleks`
- Source repository: [https://github.com/Quillraven/Fleks](https://github.com/Quillraven/Fleks)
- Author / organization: `Quillraven`
- License: `MIT`
- Research note: [research/findings/quillraven-fleks.md](../../research/findings/quillraven-fleks.md)
- Investigated commit: `c332ffc04b2b2db7f362dda7c5541b00e9ef4658`
- Last verified: `2026-06-04`
- Activity / maintenance status: active library maintenance; the latest inspected commit is `version 2.15-SNAPSHOT` from `2026-05-14`, and the repository still carries current CI, publish automation, and benchmark/test coverage.

## Short Description

Fast Kotlin Multiplatform entity-component-system library focused on reusable gameplay and runtime architecture rather than on rendering or platform hosting.

## Technical Profile

- Primary category: `library-sdk`
- Focus tags: `multiplatform`, `ecs`, `save-load`, `performance`, `testing`
- Engine / framework: custom Kotlin Multiplatform ECS library with world configuration DSL, family queries, system scheduling, snapshots, and JVM benchmarks
- Rendering approach: none in the library itself; intended to be embedded into another engine, Android app shell, or multiplatform game runtime
- Main language(s): Kotlin
- Android target: indirect but strong; no dedicated Android module is checked in, but the shared ECS, snapshot, and scheduling patterns are directly reusable in Kotlin Android game logic
- Build system: Gradle Kotlin DSL KMP build with custom convention plugins, Dokka, publishing, signing, and benchmark support

## Why It Matters

- `Fleks` is valuable because it isolates a serious Kotlin ECS core from any specific renderer or engine stack, which makes the patterns easier to transfer into Android games, internal engines, or shared multiplatform gameplay modules.
- It also complements the already researched `korlibs/korge-fleks` repository by showing the underlying ECS runtime ideas without KorGE-specific integration noise.

## Reusable Ideas

- Gameplay ideas:
  - fixed-step and frame-based system scheduling
  - one-shot component cleanup for transient gameplay state
- Architecture patterns:
  - versioned entity recycling
  - array-backed component holders indexed by entity ID
  - bit-mask-based family queries with delayed-removal-safe iteration
- Graphics / rendering techniques:
  - none directly; this repository intentionally stops at the gameplay/runtime layer
- Input / UI approaches:
  - none directly
- Performance or optimization ideas:
  - dirty family caches, compact component storage, snapshot support, and benchmark-backed ECS comparisons

## Notable Implementations

- `WorldConfiguration` provides a concise Kotlin DSL for injectables, families, and systems.
- `EntityService` and `ComponentService` keep components in array-backed holders with bit-mask membership tracking.
- `IntervalSystem` supports both `EachFrame` and fixed-step `Fixed(step)` updates with interpolation support.
- `OneShotComponentSystem` formalizes auto-removal of transient components and tags.
- Snapshot APIs plus serialization tests make save/load a first-class ECS capability.
- JVM benchmarks compare Fleks against Ashley and Artemis instead of relying only on anecdotal performance claims.

## Android Relevance

- Native Android use:
  - indirect only; the library is host-agnostic and needs an Android runtime or engine around it
- Kotlin relevance:
  - very high
- Porting or adaptation notes:
  - especially useful for shared Android game logic, ECS-driven gameplay modules, and internal runtime architecture rather than for teams looking for rendering, UI, or Android platform glue

## Risks / Limitations

- No Android renderer, audio, input, or UI shell is included.
- Local Gradle discovery in this lab still stops at the missing JDK compiler.
- The public README has a few presentation quirks in the current environment, including odd Windows-console encoding for some symbols.

## Notes

`Fleks` is strong enough for the main catalog because it captures a compact, well-tested, benchmark-aware Kotlin ECS core that is easy to reference later when building Android-relevant gameplay architecture.
