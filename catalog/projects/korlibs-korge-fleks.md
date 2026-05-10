# Project Entry

## Basic Info

- Project name: `Korge-fleks`
- Source repository: [https://github.com/korlibs/korge-fleks](https://github.com/korlibs/korge-fleks)
- Author / organization: `korlibs`
- License: `MIT`
- Research note: [research/findings/korlibs-korge-fleks.md](../../research/findings/korlibs-korge-fleks.md)
- Investigated commit: `ce31c5548475fed4cba17192f0ad3cf449757e45`
- Last verified: `2026-05-10`
- Activity / maintenance status: last push recorded at selection on `2026-05-10`.

## Short Description

KorGE + Fleks gameplay framework for Kotlin 2D platformers that combines ECS blueprints, pooled serializable components, camera-relative chunk streaming, rewindable snapshots, and an ECS-driven render/collision stack.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `android`, `ecs`, `korge`, `save-load`, `asset-pipeline`, `performance`
- Engine / framework: KorGE addon and gameplay framework on top of Fleks ECS
- Rendering approach: KorGE 2D rendering through ECS object, tile-map, parallax, and debug render systems
- Main language(s): Kotlin
- Android target: direct Android target is enabled in the root KorGE build
- Build system: Gradle Kotlin DSL with KorGE plugin, `kproject`, and local dependency bootstrap modules

## Why It Matters

- This repository is a strong reference for teams that want an Android-relevant Kotlin gameplay framework instead of only a low-level engine.
- The main value is the way it treats serializable ECS state, pooling, world streaming, and rewind/save systems as one coherent architecture rather than as separate features bolted on later.

## Reusable Ideas

- Gameplay ideas:
  - blueprint-driven entity assembly, quadrant-based chunk spawning, tween-sequence-triggered scripted events, and platformer grid collisions
- Architecture patterns:
  - ordered ECS system stack, string-keyed entity blueprints, message-based entity coordination, and YAML-backed game bootstrap
- Graphics / rendering techniques:
  - ECS-owned sprite/text/tile rendering, visible-window tile iteration, and camera-driven parallax updates
- Input / UI approaches:
  - entity-bounded touch actions with optional coordinate forwarding, plus screen-vs-world rendering separation through tags and camera conversion
- Performance or optimization ideas:
  - pooled components with leak accounting, 30 Hz snapshot recording, chunk-scoped asset lifetimes, and stepped collision movement to avoid tunneling

## Notable Implementations

- `WorldConfigurationExt` wires a ready-made framework runtime with injectables, default systems, tween support, and common blueprints.
- `SnapshotSerializer` and `SnapshotSerializerSystem` provide JSON save/load plus rewind/forward recording over ECS world state.
- `AssetStore` and `WorldMapData` separate common vs chunk-scoped assets and stream chunk entities relative to camera position.
- `GridMoveSystem` and `PlatformerCollisionResolver` implement readable stepped platformer collision over a tile/grid world.
- `Pool` and `PoolableComponent` keep component reuse explicit and testable instead of relying on best-effort cleanup.

## Android Relevance

- Native Android use:
  - direct Android target is enabled through the KorGE build
- Kotlin relevance:
  - very high; the repository is Kotlin-first and exposes the gameplay shell in common code
- Porting or adaptation notes:
  - most useful as a reusable architecture reference for Android-friendly Kotlin platformers, especially if the lab wants ECS state to remain serializable and memory-conscious

## Risks / Limitations

- Build discovery currently needs Java `21+`, while the available environment only has Java `8`.
- Asset hot reload appears only partially implemented on the inspected revision.
- Some subsystems are present but not fully active, including the unused `TouchInputSystem` and the commented-out logic inside `PlatformerGroundSystem`.
- The repository is still niche and lightly adopted relative to larger engines.

## Notes

This repository is especially useful when the lab wants a concrete example of how to combine Android-relevant Kotlin targets, ECS-driven gameplay, snapshot/rewind architecture, and pooled data-only components inside one compact framework.
