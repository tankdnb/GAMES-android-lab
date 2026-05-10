# Research Note

## Repository Snapshot

- Repository: `sreich/ore-infinium`
- Source URL: [https://github.com/sreich/ore-infinium](https://github.com/sreich/ore-infinium)
- Owner: `sreich`
- Batch ID: [`BATCH-2026-05-11-C`](../batches/BATCH-2026-05-11-C.md)
- Type: `gameplay-systems`
- License: `MIT`
- Selection date: `2026-05-11`
- Last pushed at selection: `2022-07-17`
- Stars at selection: `190`
- Investigated commit: `44167c43ff5328f1721ab258d9721bbc8187a1ef`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-legacy-bintray-repos`
- Catalog card: [catalog/projects/sreich-ore-infinium.md](../../catalog/projects/sreich-ore-infinium.md)

## Why This Repository Was Selected

- Fresh GitHub `updated` searches were still dominated by near-zero-signal repositories, so the strongest remaining path was a stale but systems-rich backlog candidate.
- `sreich/ore-infinium` had better gameplay-systems depth than the remaining shortlist, a permissive license, and a denser combination of ECS, networking, world generation, fluids, lighting, and device/inventory logic than narrower samples like `DinoCompose`.
- Even though the inspected revision is desktop-only, its LibGDX + Kotlin architecture still transfers well into Android-oriented sandbox or survival projects built on similar foundations.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: LibGDX + KTX + Artemis-ODB + KryoNet
- Rendering stack: LibGDX `SpriteBatch`, `TextureAtlas`, camera-scoped tile rendering, separate tile/lightmap framebuffers, shader-based lightmap blending, and Scene2D/VisUI HUD layers
- Android target: no direct Android module or launcher was found in the inspected revision; the repository is desktop/JVM-only in practice, but many of the gameplay/runtime patterns still transfer into Android LibGDX work
- Build system: multi-module Gradle Groovy DSL project with `core` and `desktop` modules, Artemis weaving, protobuf generation, texture packing tasks, and an external assets submodule
- Repository layout summary: most gameplay/runtime code lives in `core/src/`, desktop launcher/build logic lives in `desktop/`, assets are expected through `core/assets` submodule, and the repository keeps a small `core/test/` JUnit surface
- Key modules reviewed:
  - `README.md`
  - `build.gradle`
  - `core/build.gradle`
  - `settings.gradle`
  - `.gitmodules`
  - `.travis.yml`
  - `core/src/com/ore/infinium/OreWorld.kt`
  - `core/src/com/ore/infinium/OreServer.kt`
  - `core/src/com/ore/infinium/OreClient.kt`
  - `core/src/com/ore/infinium/OreEntityFactory.kt`
  - `core/src/com/ore/infinium/LoadedViewport.kt`
  - `core/src/com/ore/infinium/WorldGenerator.kt`
  - `core/src/com/ore/infinium/WorldIO.kt`
  - `core/src/com/ore/infinium/Network.kt`
  - `core/src/com/ore/infinium/Inventory.kt`
  - `core/src/com/ore/infinium/GeneratorInventory.kt`
  - `core/src/com/ore/infinium/GeneratorControlPanelView.kt`
  - `core/src/com/ore/infinium/systems/GameLoopSystemInvocationStrategy.kt`
  - `core/src/com/ore/infinium/systems/GameTickSystem.kt`
  - `core/src/com/ore/infinium/systems/MovementSystem.kt`
  - `core/src/com/ore/infinium/systems/PlayerSystem.kt`
  - `core/src/com/ore/infinium/systems/SpatialSystem.kt`
  - `core/src/com/ore/infinium/systems/client/ClientNetworkSystem.kt`
  - `core/src/com/ore/infinium/systems/client/TileRenderSystem.kt`
  - `core/src/com/ore/infinium/systems/server/ServerNetworkSystem.kt`
  - `core/src/com/ore/infinium/systems/server/ServerNetworkEntitySystem.kt`
  - `core/src/com/ore/infinium/systems/server/ServerPowerSystem.kt`
  - `core/src/com/ore/infinium/systems/server/LiquidSimulationSystem.kt`
  - `core/src/com/ore/infinium/systems/server/TileLightingSystem.kt`
  - `core/test/WorldBlockTest.kt`
  - `core/test/WorldGeneratorTest.kt`
  - `core/test/WorldIOTest.kt`
  - `core/test/WorldLiquidSimulationTest.kt`

## Build And Runtime Notes

- The repository was investigated primarily through static code review plus lightweight Gradle discovery.
- `java -version` reports `1.8.0_321`, which matches the repository README and `.travis.yml` expectation of Java `8`.
- `cmd /c gradlew.bat help --no-daemon` successfully bootstraps Gradle `3.2.1` and starts dependency resolution, but root-project configuration fails because the buildscript still points at historical Bintray-era repositories such as `https://kotlin.bintray.com/kotlinx/` and `https://dl.bintray.com/...`, which now fail with certificate/host mismatch errors.
- `.gitmodules` confirms that `core/assets` is expected as a separate Git submodule, so a plain clone is incomplete until the assets repository is initialized.
- `core/test/` contains real JUnit files for block access and liquid simulation, but world generation and world IO tests are mostly marked `@Ignore`, and `core/build.gradle` sets `test.ignoreFailures = true`.
- Known setup limitations:
  - the inspected build chain depends on dead or brittle legacy repository infrastructure
  - the repository is desktop-only in the inspected revision despite its LibGDX portability
  - the test surface exists but is narrow and partly disabled

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - it is one of the stronger systems-heavy Kotlin gameplay references in the lab, because world generation, fluids, lighting, networking, ECS, inventory-bearing devices, and UI all coexist in one codebase
  - the repository is not a turnkey Android reference, but its subsystem patterns are highly portable to Android LibGDX work
  - even with prototype rough edges, it offers more reusable sandbox architecture than the remaining stale shortlist alternatives

## Interesting Findings

### Engine Architecture And Core Loop

- `core/src/com/ore/infinium/OreWorld.kt` assembles two distinct Artemis worlds around the same shared block-array model: a client stack with input, rendering, digging, and overlays, and a server stack with AI, power, lighting, liquids, spatial indexing, and networking. This is a strong example of sharing gameplay data and component types while still separating simulation authority.
- `core/src/com/ore/infinium/systems/GameLoopSystemInvocationStrategy.kt` runs a fixed-step logic loop with a nanosecond accumulator, caps worst-case frame time to avoid spiral-of-death behavior, separates logic systems from render systems via a marker interface, and tracks per-system profiling counters. That is a reusable LibGDX/ECS pattern for keeping simulation and rendering responsibilities explicit.
- `core/src/com/ore/infinium/OreServer.kt` runs the authoritative world in its own thread, ties lifetime to latches for local host or dedicated operation, and uses the same `OreWorld` code path as the client-hosted case instead of maintaining a separate server-only gameplay codebase.
- `core/src/com/ore/infinium/systems/PlayerSystem.kt`, `core/src/com/ore/infinium/LoadedViewport.kt`, and `core/src/com/ore/infinium/systems/server/ServerNetworkEntitySystem.kt` combine block-region streaming with per-player entity interest management. Players periodically recenter a loaded viewport, receive matching block-region snapshots, and the server diffs `knownEntities` against a quadtree query to batch spawn and destroy entities.

### Rendering And Graphics

- `core/src/com/ore/infinium/systems/client/TileRenderSystem.kt` renders the tilemap into one framebuffer, generates a second tile-aligned lightmap framebuffer, then blends both with a shader on a fullscreen pass. This is a practical middle-ground lighting pipeline for 2D games that want more than flat tinting without moving to a heavier dynamic-light stack.
- The same `TileRenderSystem.kt` caches mesh-to-texture lookups for dirt, grass, and stone variants and iterates only the tiles around the camera instead of the entire world, which keeps auto-tiling compatible with large sandbox maps.
- `core/src/com/ore/infinium/systems/server/TileLightingSystem.kt` seeds sunlight from open-air top regions, attenuates propagation differently for open air, background-wall cavities, and solid blocks, and replays placed light devices through the same flood-fill logic. The implementation is rough, but the combined sunlight + placeable-device lighting model is useful to study.

### Gameplay Systems And World Simulation

- `core/src/com/ore/infinium/WorldGenerator.kt` is the highest-yield gameplay-system file in the repository. It partitions world output across available CPU cores, builds a deep Joise noise graph for ground/caves/ores, then runs a semantic contour pass that detects terrain peaks and valleys to inject lakes and volcanoes before writing a debug world image with seed and legend.
- `core/src/com/ore/infinium/OreEntityFactory.kt` treats world devices and placeables as composable ECS bundles. Lights, doors, power generators, explosives, drills, flora, and creatures all reuse the same item/sprite/velocity/component vocabulary, which keeps the gameplay model more unified than a typical hand-written object hierarchy.
- `core/src/com/ore/infinium/systems/server/ServerPowerSystem.kt` models generator fuel as inventory state rather than as ad hoc timer variables. Generators keep a dedicated burning slot, automatically promote compatible fuel from storage slots into that active slot, tick down shared fuel health, and push live control-panel updates back to subscribed clients.
- `core/src/com/ore/infinium/systems/server/LiquidSimulationSystem.kt` performs simple but reusable cell-based liquid behavior: try to fill downward first, then equalize left/right, split uneven remainders deterministically, track dirty regions, and resend only the relevant block region after updates.

### Networking, Multiplayer, And UI Flow

- `core/src/com/ore/infinium/Network.kt` defines a compact packet vocabulary instead of shipping whole entity state blindly: full block regions for coarse sync, sparse single-block updates for small edits, batched entity spawn/destroy packets, per-player spawn packets, generator-control updates, and explicit inventory move/drop messages.
- `core/src/com/ore/infinium/systems/server/ServerNetworkSystem.kt` serializes only selected gameplay components per entity and deliberately skips render-only or local-only pieces like `SpriteComponent`, `PlayerComponent`, and `ControllableComponent`. That component-subset replication approach is a useful ECS networking pattern.
- `core/src/com/ore/infinium/systems/client/ClientNetworkSystem.kt` maintains bidirectional `server-id <-> local-id` maps so the client can spawn ECS entities with local ids while still consuming authoritative move, health, door, inventory, and destroy packets from the server.
- `core/src/com/ore/infinium/Inventory.kt`, `core/src/com/ore/infinium/InventoryView.kt`, and `core/src/com/ore/infinium/GeneratorControlPanelView.kt` keep items as ECS entities even when they live in UI slots, support merging and stack updates, and wire drag-and-drop inventory actions back into the same network protocol the server uses for authoritative slot moves.
- `GeneratorControlPanelView.kt` is particularly useful because it shows how a device-specific inventory can reserve a special slot type for the currently burning fuel item while still exposing the rest of the storage through generic inventory interactions and a live progress bar.

### Physics, Persistence, And Verification

- `core/src/com/ore/infinium/systems/MovementSystem.kt` uses velocity-Verlet-style integration, separates entity collision from block collision, supports one-block step-up movement, and reuses the same block-collision path for dropped items. That combination gives the sandbox movement some Terraria-like feel without a heavyweight physics engine.
- `core/src/com/ore/infinium/WorldIO.kt` shows an intended protobuf-backed world-save format that stores block type, wall type, flags, and light level in parallel arrays. The implementation is incomplete, but the direction is useful as a compact tile-world persistence reference.
- `core/test/WorldBlockTest.kt` and `core/test/WorldLiquidSimulationTest.kt` verify block access and liquid spreading behavior directly against the world data model instead of only asserting renderer output. The test suite is not broad, but it does anchor a few low-level systems in executable checks.

## Reusable Takeaways

- A sandbox game can share one ECS/component vocabulary across client and server while still keeping simulation authority on the server and rendering/input on the client.
- Large tile worlds benefit from combining coarse block-region streaming with finer sparse block updates and separate entity-interest replication instead of trying to synchronize everything with one mechanism.
- Procedural terrain becomes more readable and gameable when a raw noise pipeline is followed by explicit semantic passes such as lake/volcano placement and debug-world image export.
- Treating generators or other devices as inventory-bearing entities is a practical way to prototype automation/survival loops before committing to a more complex resource-network model.
- A separate lightmap FBO blended over auto-tiled terrain is a useful compromise for 2D lighting in LibGDX projects that need placeable lights and ambient attenuation.

## Evidence Summary

- `core/src/com/ore/infinium/OreWorld.kt` - client/server world assembly, block storage, entity cloning, placement, and shared runtime utilities
- `core/src/com/ore/infinium/OreServer.kt` - dedicated/headless server lifecycle and join flow
- `core/src/com/ore/infinium/LoadedViewport.kt` and `systems/PlayerSystem.kt` - player-centered block streaming and viewport reload policy
- `core/src/com/ore/infinium/systems/GameLoopSystemInvocationStrategy.kt` - fixed-step loop, logic/render separation, profiler integration
- `core/src/com/ore/infinium/systems/SpatialSystem.kt` and `systems/server/ServerNetworkEntitySystem.kt` - quadtree visibility tracking and per-player entity replication
- `core/src/com/ore/infinium/systems/server/ServerNetworkSystem.kt` and `systems/client/ClientNetworkSystem.kt` - packet handling, inventory sync, id mapping, batched entity spawn/destroy, block-region transfer
- `core/src/com/ore/infinium/WorldGenerator.kt` - threaded Joise terrain/ore generation, lake/volcano post-processing, debug world image export
- `core/src/com/ore/infinium/systems/server/LiquidSimulationSystem.kt` - cell-based water flow and dirty-region resend behavior
- `core/src/com/ore/infinium/systems/server/TileLightingSystem.kt` and `systems/client/TileRenderSystem.kt` - sunlight/device light propagation plus lightmap/FBO rendering
- `core/src/com/ore/infinium/OreEntityFactory.kt`, `Inventory.kt`, `GeneratorInventory.kt`, and `GeneratorControlPanelView.kt` - ECS item/device composition, fuel-slot inventory modeling, drag-and-drop UI
- `core/src/com/ore/infinium/systems/MovementSystem.kt` - platformer/sandbox collision and dropped-item movement
- `core/src/com/ore/infinium/WorldIO.kt` and `core/test/*` - persistence intent and limited verification surface

## Risks Or Limits

- The repository is explicitly inactive, and last push at selection was `2022-07-17`.
- The inspected revision is desktop/JVM-only in practice; no Android launcher or packaging module was found.
- The build chain is fragile today because it still depends on historical Bintray-era repositories and old plugins; even `gradlew help` fails before useful task discovery finishes.
- `core/src/com/ore/infinium/systems/server/ServerNetworkSystem.kt` currently accepts client player positions directly in `receivePlayerMove()` without real authority checks, and the README explicitly states that lag compensation/prediction is not implemented yet.
- `core/src/com/ore/infinium/WorldIO.kt` is incomplete: `loadWorld()` is empty, and `writeWorldData()` iterates `y` only up to `worldSize.width`, which is suspicious for non-square worlds.
- `core/src/com/ore/infinium/systems/server/TileLightingSystem.kt` handles light removal by wiping the entire world light buffer and recomputing all lights, which is useful conceptually but not scalable as-is.
- The test surface is narrow and partly disabled through `@Ignore` plus `test.ignoreFailures = true`, so the repository should be treated as a rich reference, not as a trusted production baseline.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `gameplay-systems`
- Focus tags: `2d`, `ecs`, `libgdx`, `networking`, `procedural-generation`, `save-load`, `ui-hud`, `performance`
- Follow-up needed:
  - if the lab revisits this repository later, focus on server-authoritative movement and network prediction, world save/load completion, or deeper device/power-graph behavior instead of reopening the whole codebase
  - if a modernization pass is ever relevant, re-check whether the build can be revived by replacing dead Bintray-era repositories and revalidating the small test surface
