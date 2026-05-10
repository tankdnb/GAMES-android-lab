# Research Note

## Repository Snapshot

- Repository: `Hugobros3/chunkstories`
- Source URL: [https://github.com/Hugobros3/chunkstories](https://github.com/Hugobros3/chunkstories)
- Owner: `Hugobros3`
- Batch ID: [`BATCH-2026-05-10-H`](../batches/BATCH-2026-05-10-H.md)
- Type: `engine-framework`
- License: `LGPL v3 text in LICENSE.MD`; GitHub metadata reported `Other` / `NOASSERTION`
- Selection date: `2026-05-10`
- Last pushed at selection: `2025-04-21`
- Stars at selection: `223`
- Investigated commit: `4450708feca935997647877d0e41c900fc6cae3b`
- Research status: `accepted`
- Build mode: `static-review + gradle-help + buildAll-dry-run-failed-missing-api-submodule`
- Catalog card: [catalog/projects/hugobros3-chunkstories.md](../../catalog/projects/hugobros3-chunkstories.md)

## Why This Repository Was Selected

- It was not the freshest Kotlin candidate in the queue, but it offered a stronger architecture surface than the low-signal recent hits returned by the same search pass.
- The repository combines several subsystems that are useful for the lab even without direct Android packaging: a mod/content runtime, a backend-agnostic rendergraph, asynchronous chunk-derived data, and a dedicated-server shell that can redistribute mods.
- It is a useful contrast against the earlier 2D/libGDX and tooling-heavy batches because it shows how a large voxel runtime organizes world, rendering, and content concerns in Kotlin.

## Technical Profile

- Main language(s): Kotlin, Java
- Engine / framework: custom voxel engine plus Minecraft-like game implementation
- Rendering stack: custom rendergraph-driven world renderer with Vulkan and OpenGL 3.3 backends, chunk meshing, deferred shading, forward water/model passes, bloom, and shadow buffers
- Android target: no Android module, launcher, or mobile runtime path was found on the inspected revision; the client is GLFW/LWJGL-based and desktop-first
- Build system: Gradle Kotlin DSL monorepo with `common`, `client`, `server`, `converter`, and `launcher` modules plus an expected external `api` submodule
- Repository layout summary: root Gradle build, engine/runtime code in `common/`, desktop client in `client/`, dedicated server shell in `server/`, converter/launcher utilities, and an empty `api/` submodule placeholder in this standalone clone
- Source footprint:
  - Kotlin/Java files reviewed across `client/`, `common/`, and `server/`: `422`
- Key modules reviewed:
  - `client/src/main/java/xyz/chunkstories/client/ClientImplementation.kt`
  - `client/src/main/java/xyz/chunkstories/client/ingame/IngameClientImplementation.kt`
  - `client/src/main/java/xyz/chunkstories/client/commands/ReloadContentCommand.kt`
  - `client/src/main/java/xyz/chunkstories/graphics/GraphicsEngineImplementation.kt`
  - `client/src/main/java/xyz/chunkstories/graphics/GraphicsBackendsEnum.kt`
  - `client/src/main/java/xyz/chunkstories/graphics/GLFWBasedGraphicsBackend.kt`
  - `client/src/main/java/xyz/chunkstories/graphics/common/world/deffered_world_render_graph.kt`
  - `client/src/main/java/xyz/chunkstories/graphics/common/world/TaskCreateChunkMesh.kt`
  - `client/src/main/java/xyz/chunkstories/graphics/vulkan/util/BuiltInRendergraphs.kt`
  - `client/src/main/java/xyz/chunkstories/gui/layer/ingame/IngameUI.kt`
  - `common/src/main/java/xyz/chunkstories/TickingThread.kt`
  - `common/src/main/java/xyz/chunkstories/content/GameContentStore.kt`
  - `common/src/main/java/xyz/chunkstories/content/mods/ModsManagerImplementation.kt`
  - `common/src/main/java/xyz/chunkstories/content/translator/LoadedContentTranslator.kt`
  - `common/src/main/java/xyz/chunkstories/plugin/DefaultPluginManager.kt`
  - `common/src/main/java/xyz/chunkstories/task/WorkerThreadPool.kt`
  - `common/src/main/java/xyz/chunkstories/world/WorldImplementation.kt`
  - `common/src/main/java/xyz/chunkstories/world/chunk/ChunkImplementation.kt`
  - `common/src/main/java/xyz/chunkstories/world/chunk/ChunkLightBaker.kt`
  - `common/src/main/java/xyz/chunkstories/world/chunk/TaskComputeChunkOcclusion.kt`
  - `common/src/main/java/xyz/chunkstories/world/chunk/deriveddata/AutoRebuildingProperty.kt`
  - `common/src/main/java/xyz/chunkstories/world/generator/TaskGenerateWorldSlice.kt`
  - `server/src/main/java/xyz/chunkstories/server/DedicatedServer.kt`
  - `server/src/main/java/xyz/chunkstories/server/net/ConnectionsManager.kt`
  - `server/src/main/java/xyz/chunkstories/server/propagation/ServerModsProvider.kt`

## Build And Runtime Notes

- The repository was investigated through static review plus limited Gradle discovery.
- `.\gradlew.bat help --no-daemon` succeeded on the inspected clone, so the root Gradle surface is readable and the module graph is discoverable.
- `.\gradlew.bat buildAll --dry-run --no-daemon` failed with `Task with path ':api:publishToMavenLocal' not found in root project 'chunkstories'`, which matches the checked-in `.gitmodules` entry and the README build instructions that require separate `chunkstories-api` and `chunkstories-core` repositories.
- `settings.gradle.kts` still includes `api` and `enklume`, but the `api/` directory in this standalone research clone is empty, so this snapshot is not a self-contained full-build reference.
- No runtime launch was attempted.
- Known setup limitations:
  - `README.md` explicitly warns that the current `master` branch is in heavy work in progress and says multiplayer and sound are currently non-functional
  - the client runtime is GLFW/LWJGL desktop code, not an Android target
  - several multiplayer and remote-content paths remain unfinished or commented out in code, which reduces confidence in current end-to-end runtime completeness

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `1`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - the repository is still strong as an engine-architecture reference even though its current product branch is unstable
  - the most reusable parts are the mod/content layering, backend-agnostic rendergraph design, derived chunk-task pipeline, and server-side mod redistribution mechanics
  - Android transfer is indirect, but the ideas are concrete enough to justify keeping the repository in the main catalog as a desktop-first reference

## Interesting Findings

### Engine Architecture And Core Loop

- `client/src/main/java/xyz/chunkstories/client/ClientImplementation.kt` wires logging, configuration, sound, graphics, content loading, and a shared `WorkerThreadPool`, then runs a simple frame loop that polls GLFW, updates sound and input, ticks the active in-game state per frame, and delegates drawing to the graphics backend.
- `client/src/main/java/xyz/chunkstories/client/ingame/IngameClientImplementation.kt` separates render-frame work from simulation work by creating a `TickingThread` around the world, while also bootstrapping plugins, commands, world renderer, and in-game UI before entering the play state.
- `common/src/main/java/xyz/chunkstories/TickingThread.kt` is a reusable fixed-step loop shell: it keeps a `TPS = 60` target, runs scheduled tasks after each tick, and exposes `logicThread()` / `logicThreadBlocking()` helpers for marshaling work back onto the simulation thread.
- `common/src/main/java/xyz/chunkstories/world/WorldImplementation.kt` and `WorldMasterImplementation.tick()` keep the shared world model centralized, then apply selective expensive work only on cadence: region chunk compression every 60 ticks and chunk-local physics ticking every 4 ticks only for chunks near connected players.
- `common/src/main/java/xyz/chunkstories/task/WorkerThreadPool.kt` plus `world/chunk/deriveddata/AutoRebuildingProperty.kt` show a practical derived-data pattern: expensive mesh/light/occlusion-style work is represented as reschedulable tasks that remember how many updates are pending instead of forcing immediate synchronous rebuilds.

### Rendering And Graphics

- `client/src/main/java/xyz/chunkstories/graphics/GraphicsEngineImplementation.kt` chooses a graphics backend from CLI/config, defaults to Vulkan, and falls back to OpenGL if the chosen backend is unavailable.
- `client/src/main/java/xyz/chunkstories/graphics/GraphicsBackendsEnum.kt` centralizes backend-specific GLFW hints and constructors, which keeps the rest of the graphics engine mostly backend-neutral.
- `client/src/main/java/xyz/chunkstories/graphics/common/world/deffered_world_render_graph.kt` defines the world pipeline as data rather than hard-coded render order: `sky`, `opaque`, `deferredSun`, `deferredLights`, `forward`, and multiple bloom passes share declared render buffers, while shadow buffers are created dynamically from the configured cascade count.
- `client/src/main/java/xyz/chunkstories/graphics/vulkan/util/BuiltInRendergraphs.kt` shows that the same rendergraph DSL is reused even for the GUI-only menu path, not only for the main 3D world.
- `client/src/main/java/xyz/chunkstories/graphics/common/world/TaskCreateChunkMesh.kt` is one of the highest-yield files in the repository. It waits until neighbor chunks are present, batches generated geometry by material tag, supports both custom block-model draw routines and standard cube faces, and packs AO, sunlight, blocklight, normals, UVs, and texture ids into raw scratch buffers for later GPU upload.
- `common/src/main/java/xyz/chunkstories/world/chunk/TaskComputeChunkOcclusion.kt` precomputes chunk-side visibility by flood-filling empty space through a 32x32x32 chunk and marking which external faces are connected, using thread-local queues and masks to avoid repeated allocations.

### Gameplay Systems

- `common/src/main/java/xyz/chunkstories/world/chunk/ChunkImplementation.kt` keeps chunk state compressed around a 32x32x32 voxel array, tracks unsaved modifications and revisions atomically, and invalidates derived mesh state when block data changes instead of entangling rendering logic directly with block writes.
- `common/src/main/java/xyz/chunkstories/world/generator/TaskGenerateWorldSlice.kt` generates one world slice in eight directional waves by scheduling `TaskGenerateWorldThinSlice` jobs column by column. This is a useful example of staged chunk-region generation instead of launching a whole region as one opaque task.
- `common/src/main/java/xyz/chunkstories/world/WorldImplementation.kt` also keeps entity ticking inside the world abstraction and exposes box-based entity and cell queries, which makes the chunk/world split more explicit than in many tightly coupled voxel projects.

### UI, HUD, And Menus

- `client/src/main/java/xyz/chunkstories/gui/layer/ingame/IngameUI.kt` reads gameplay HUD state through entity traits such as `TraitHealth`, `TraitInventory`, `TraitSelectedItem`, and `TraitHasOverlay`, which matches the repository's trait-oriented entity model and keeps the HUD less dependent on one hard-coded player class.
- `client/src/main/java/xyz/chunkstories/gui/layer/ingame/IngameUI.kt` and `client/src/main/java/xyz/chunkstories/client/commands/ReloadContentCommand.kt` expose reload hooks directly in the runtime: content reload, plugin reload, rendergraph reload, screenshot/debug toggles, and chunk redraw shortcuts are treated as first-class iteration tools.

### Tooling, Modding, Networking, Or Other Notable Areas

- `common/src/main/java/xyz/chunkstories/content/GameContentStore.kt` reloads content in a layered order that is easy to reuse elsewhere: mods first, then loot, items, blocks, recipes, entities, packets, particles, generators, animations, models, and finally localization.
- `common/src/main/java/xyz/chunkstories/content/mods/ModsManagerImplementation.kt` builds a virtual asset filesystem from base content plus requested mods, lets later mods override earlier assets, extracts embedded JARs into a cache directory, and chains custom classloaders so mods can contribute both data and code.
- `common/src/main/java/xyz/chunkstories/plugin/DefaultPluginManager.kt` extends that model by loading plugin JARs from both `./plugins/` and enabled mods, filtering them by client-vs-host plugin type, and re-creating plugin instances on reload.
- `common/src/main/java/xyz/chunkstories/content/translator/LoadedContentTranslator.kt` is a strong reference for network/save compatibility. It reconstructs id mappings for blocks, entities, items, and packets from a serialized text format, verifies required mods, then rebuilds local lookup arrays only after compatibility checks pass.
- `server/src/main/java/xyz/chunkstories/server/propagation/ServerModsProvider.kt` repacks folder-based mods into zip redistributables, caches them under `./cache/servermods-*`, and publishes a compact `internalName:hash:size` string that can be advertised to clients.
- `server/src/main/java/xyz/chunkstories/server/net/ConnectionsManager.kt` uses that mod string in the server-info handshake alongside server name, MOTD, player counts, and version metadata.
- `client/src/main/java/xyz/chunkstories/client/net/packets/PacketInitializeContentTranslator.kt`, `client/src/main/java/xyz/chunkstories/world/WorldClientRemote.kt`, `server/src/main/java/xyz/chunkstories/world/WorldServer.kt`, and several `TODO`s inside `server/src/main/java/xyz/chunkstories/server/DedicatedServer.kt` confirm that the current branch is still mid-refactor in remote-world and server-lifecycle code. That lowers runtime trust, but it also clearly exposes the intended architecture for future study.

## Reusable Takeaways

- A layered content system can treat base content, user mods, bundled plugin jars, and standalone plugins as one coherent override-and-classloading pipeline instead of as unrelated extension points.
- Backend-agnostic rendergraph declarations are a good fit for engines that need to keep world, GUI, and post-processing pipelines conceptually aligned across OpenGL and Vulkan backends.
- Chunked voxel engines benefit from treating meshing, lighting, occlusion, and generation as derived tasks with explicit invalidation rather than as side effects of every immediate world mutation.
- If a large simulation only matters near active players, distance-limited chunk ticking and wave-based region generation are simpler and cheaper than globally sweeping the whole world every logic step.

## Evidence Summary

- `client/src/main/java/xyz/chunkstories/client/ClientImplementation.kt` - desktop client bootstrap, shared worker pool, per-frame loop, content reload entrypoint
- `client/src/main/java/xyz/chunkstories/client/ingame/IngameClientImplementation.kt` - render/simulation split, world renderer, plugin bootstrap, in-game lifecycle
- `client/src/main/java/xyz/chunkstories/graphics/GraphicsEngineImplementation.kt` - backend choice and frame rendering shell
- `client/src/main/java/xyz/chunkstories/graphics/GraphicsBackendsEnum.kt` - Vulkan/OpenGL backend registration and fallback
- `client/src/main/java/xyz/chunkstories/graphics/common/world/deffered_world_render_graph.kt` - declared world rendergraph with deferred and forward passes
- `client/src/main/java/xyz/chunkstories/graphics/common/world/TaskCreateChunkMesh.kt` - async chunk meshing, material bucketing, AO/light packing
- `client/src/main/java/xyz/chunkstories/graphics/vulkan/util/BuiltInRendergraphs.kt` - GUI/menu rendergraph reuse
- `client/src/main/java/xyz/chunkstories/gui/layer/ingame/IngameUI.kt` - trait-driven HUD and runtime reload/debug controls
- `common/src/main/java/xyz/chunkstories/TickingThread.kt` - 60 TPS loop, scheduler, logic-thread handoff helpers
- `common/src/main/java/xyz/chunkstories/content/GameContentStore.kt` - ordered registry reload pipeline
- `common/src/main/java/xyz/chunkstories/content/mods/ModsManagerImplementation.kt` - layered mod filesystem, asset overrides, embedded-jar classloading
- `common/src/main/java/xyz/chunkstories/content/translator/LoadedContentTranslator.kt` - verified id mapping and required-mod compatibility layer
- `common/src/main/java/xyz/chunkstories/plugin/DefaultPluginManager.kt` - plugin loading from both folders and mods
- `common/src/main/java/xyz/chunkstories/world/WorldImplementation.kt` - world base class, cadence-based master-world work
- `common/src/main/java/xyz/chunkstories/world/chunk/ChunkImplementation.kt` - compressed chunk state, revision tracking, mesh invalidation
- `common/src/main/java/xyz/chunkstories/world/chunk/TaskComputeChunkOcclusion.kt` - chunk face connectivity flood fill
- `common/src/main/java/xyz/chunkstories/world/chunk/deriveddata/AutoRebuildingProperty.kt` - generic derived-data task invalidation pattern
- `common/src/main/java/xyz/chunkstories/world/generator/TaskGenerateWorldSlice.kt` - staged wave-based world-slice generation
- `server/src/main/java/xyz/chunkstories/server/DedicatedServer.kt` - host bootstrap and current WIP server lifecycle state
- `server/src/main/java/xyz/chunkstories/server/net/ConnectionsManager.kt` - server-info handshake and authenticated player registry
- `server/src/main/java/xyz/chunkstories/server/propagation/ServerModsProvider.kt` - mod redistribution packaging for clients

## Risks Or Limits

- `README.md` explicitly states that the current `master` branch is heavy WIP and that multiplayer and sound are currently non-functional.
- No Android runtime path was found; the inspected implementation is GLFW/LWJGL desktop code.
- The standalone clone is not a self-contained full-build reference because `buildAll` depends on `:api:publishToMavenLocal`, while `.gitmodules` and the README point to separate external repositories.
- Several remote-world and translator initialization paths are unfinished or commented out, so the current branch should be treated as an architecture reference more than a product-stability reference.
- `LGPL v3` is more restrictive for direct reuse than the permissive licenses of some other repositories already in the lab.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `3d`, `opengl`, `shader`, `networking`, `asset-pipeline`, `performance`
- Follow-up needed:
  - if the lab revisits this repository later, scope it to one subsystem such as the rendergraph/shader pipeline, the mod/plugin loader, or the content-translator and mod-sync path instead of reopening the whole workspace
