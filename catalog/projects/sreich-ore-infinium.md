# Project Entry

## Basic Info

- Project name: `Ore Infinium`
- Source repository: [https://github.com/sreich/ore-infinium](https://github.com/sreich/ore-infinium)
- Author / organization: `Shaun Reich`
- License: `MIT`
- Research note: [research/findings/sreich-ore-infinium.md](../../research/findings/sreich-ore-infinium.md)
- Investigated commit: `44167c43ff5328f1721ab258d9721bbc8187a1ef`
- Last verified: `2026-05-11`
- Activity / maintenance status: repository README marks the project as inactive, and last push recorded at selection was `2022-07-17`.

## Short Description

Terraria-inspired Kotlin/LibGDX sandbox prototype with multiplayer-first architecture, ECS-driven world simulation, procedural terrain generation, liquid and lighting systems, inventory-bearing devices, and a device-focused survival/automation direction.

## Technical Profile

- Primary category: `gameplay-systems`
- Focus tags: `2d`, `ecs`, `libgdx`, `networking`, `procedural-generation`, `save-load`, `ui-hud`, `performance`
- Engine / framework: LibGDX + KTX + Artemis-ODB + KryoNet
- Rendering approach: auto-tiled block rendering into a tile framebuffer, separate lightmap framebuffer, shader-based lightmap blending, and Scene2D/VisUI overlays
- Main language(s): Kotlin
- Android target: no direct Android target in the inspected revision; desktop/JVM build surface only, but subsystem patterns transfer well to Android LibGDX work
- Build system: multi-module Gradle Groovy DSL with `core` + `desktop`, protobuf generation, Artemis weaving, and asset submodule expectations

## Why It Matters

- This is one of the stronger sandbox/gameplay-systems references in the lab because it combines ECS, networking, world generation, lighting, liquids, inventories, and devices inside one coherent prototype instead of isolating them into separate demos.
- For Android game development, its value is not as a turnkey product but as a library of transferable LibGDX/Kotlin architecture ideas for survival, sandbox, or automation-heavy games.

## Reusable Ideas

- Gameplay ideas:
  - world devices as placeable items with their own inventories, fuel burn state, and live control-panel feedback
  - world generation that combines raw noise with semantic post-passes like lakes and volcanoes
- Architecture patterns:
  - shared client/server ECS vocabulary with separate simulation/render stacks
  - viewport-based block streaming plus quadtree-backed entity interest management
- Graphics / rendering techniques:
  - tile FBO + lightmap FBO + fullscreen blend shader
  - auto-tiled block-mesh texture lookup cached by mesh id
- Input / UI approaches:
  - Scene2D/VisUI inventory windows with drag-and-drop reflected back into server-authoritative slot moves
  - device-specific control panels built on top of the same generic inventory model
- Performance or optimization ideas:
  - fixed-step logic accumulator separated from render passes
  - camera-limited tile iteration, quadtree visibility queries, and dirty-region liquid resync

## Notable Implementations

- `OreWorld` assembles distinct client and server Artemis worlds around one shared tile/block data model.
- `GameLoopSystemInvocationStrategy` separates logic and render systems and keeps a fixed 25 ms logic tick with profiler counters.
- `ServerNetworkEntitySystem` tracks per-player `knownEntities` and diffs them against quadtree results to batch entity spawn/destroy.
- `WorldGenerator` partitions terrain generation across CPU cores, then applies explicit lake/volcano passes and debug world-image export.
- `LiquidSimulationSystem` implements simple but reusable downward-plus-lateral cell-based water flow.
- `TileRenderSystem` and `TileLightingSystem` form a complete tile/lightmap rendering pipeline for a large 2D sandbox.
- `ServerPowerSystem` and `GeneratorControlPanelView` treat generators as inventory-driven devices with dedicated burn slots and progress feedback.

## Android Relevance

- Native Android use:
  - none verified; the inspected revision is desktop-first
- Kotlin relevance:
  - high, because world simulation, networking, inventory systems, worldgen, and UI integration are Kotlin-first throughout
- Porting or adaptation notes:
  - the strongest Android value is architectural reuse inside LibGDX-based Kotlin games, not reuse of the repository's outdated build chain
  - networking, device inventories, fluid simulation, and world streaming are the most portable ideas for Android sandbox work

## Risks / Limitations

- Inactive maintenance status.
- No direct Android target in the inspected revision.
- Build depends on dead or brittle Bintray-era repositories and old Gradle plugins.
- Player movement is effectively client-authoritative in the current network model.
- World persistence is only partially implemented.
- Test coverage exists but is narrow and partly disabled.

## Notes

This repository is accepted mainly as a `gameplay-systems` reference rather than as an `android-game` baseline. It is especially useful when the lab wants to study how a Kotlin sandbox prototype ties ECS, tile streaming, entity replication, liquids, lighting, and device inventories together in one stack. The `core/assets` submodule and legacy build repositories should be treated as reproducibility caveats, not as part of a modern recommended setup.
