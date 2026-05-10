# Research Note

## Repository Snapshot

- Repository: `korlibs/korge-fleks`
- Source URL: [https://github.com/korlibs/korge-fleks](https://github.com/korlibs/korge-fleks)
- Owner: `korlibs`
- Batch ID: [`BATCH-2026-05-10-I`](../batches/BATCH-2026-05-10-I.md)
- Type: `engine-framework`
- License: `MIT`
- Selection date: `2026-05-10`
- Last pushed at selection: `2026-05-10`
- Stars at selection: `19`
- Investigated commit: `ce31c5548475fed4cba17192f0ad3cf449757e45`
- Research status: `accepted`
- Build mode: `static-review + gradle-discovery-failed-java8-needs-java21`
- Catalog card: [catalog/projects/korlibs-korge-fleks.md](../../catalog/projects/korlibs-korge-fleks.md)

## Why This Repository Was Selected

- It was the strongest fresh Kotlin candidate in the current search pass once already researched repositories were excluded.
- Compared with the fallback gameplay candidate `Quillraven/Quilly-s-Adventure`, this repository promised a denser engine-architecture surface for one pass: ECS composition, streaming assets, serialization, rewind, collision, rendering, and Android-aware memory handling.
- It is directly relevant to the lab because it is a Kotlin-first KorGE addon that already exposes an Android target and explicitly optimizes for constrained JVM memory environments.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: KorGE addon and gameplay framework built on top of Fleks ECS
- Rendering stack: KorGE 2D rendering with ECS-driven object, parallax, tile-map, and debug render systems
- Android target: direct Android target is enabled in the root KorGE build, and the framework explicitly uses pooling to reduce GC pressure on tight-memory JVM targets such as Android
- Build system: Gradle Kotlin DSL with KorGE plugin, `kproject`, and local `deps` bootstrap modules
- Repository layout summary: root KorGE test application plus `fleks/` source import, `korge-fleks/` addon module, Gradle bootstrap files, and `commonTest` coverage for serialization and tween systems
- Source footprint:
  - Kotlin/Java files reviewed across the repository: `168`
- Key modules reviewed:
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `README.md`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/utils/WorldConfigurationExt.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/entity/EntityFactory.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/entity/EntityBlueprint.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/assets/AssetStore.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/assets/AssetReload.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/assets/data/WorldMapData.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/utils/SnapshotSerializer.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/utils/Pool.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/utils/PoolableComponent.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/state/GameStateManager.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/SnapshotSerializerSystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/MessagePassingSystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/SpawnerSystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/WorldChunkSystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/TouchInputSystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/CameraSystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/SoundSystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/collision/GridMoveSystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/collision/PlatformerGravitySystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/collision/PlatformerGroundSystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/logic/collision/resolver/PlatformerCollisionResolver.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/renderSystems/ObjectRenderSystem.kt`
  - `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/renderSystems/LevelMapRenderSystem.kt`
  - `korge-fleks/src/commonTest/kotlin/korlibs/korge/fleks/systems/SnapshotSerializerSystemTest.kt`
  - `korge-fleks/src/commonTest/kotlin/korlibs/korge/fleks/components/TweenPropertyComponentTest.kt`
  - `korge-fleks/src/commonTest/kotlin/korlibs/korge/fleks/components/TweenSequenceComponentTest.kt`

## Build And Runtime Notes

- The repository was investigated primarily through static code review plus lightweight Gradle discovery.
- `.\gradlew.bat help --no-daemon` and `.\gradlew.bat :korge-fleks:commonTest --dry-run --no-daemon` both failed before task graph resolution because the KorGE settings plugin `6.0.0-beta4` requires Java `21+`, while the current environment exposes only Java `8`.
- `build.gradle.kts` still confirms that the inspected root project enables `targetJvm()`, `targetJs()`, and `targetAndroid()`.
- No runtime launch was attempted.
- Known setup limitations:
  - Java `21+` is required even for basic Gradle discovery on the inspected revision
  - `AssetReload.kt` contains JVM-only watcher scaffolding, but most concrete asset-reload branches are still commented out or marked TODO
  - `TouchInputSystem` is explicitly marked "currently not used"
  - `PlatformerGroundSystem` is present, but its actual ground-check logic is commented out on the inspected revision

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - this is not just a thin adapter around Fleks; the repository bundles a reusable gameplay shell around ECS, chunked world streaming, rendering, collision, snapshots, tweening, and sound
  - the strongest value is that the framework keeps components serializable and poolable, which makes rewind/save systems and Android-conscious memory behavior first-class concerns instead of afterthoughts
  - some subsystems remain partial, but the amount of concrete, reusable Kotlin code is already high enough to justify keeping it in the main catalog

## Interesting Findings

### Engine Architecture And Core Loop

- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/utils/WorldConfigurationExt.kt` is one of the highest-yield files in the repository. It defines a ready-made world composition with injectables, ordered ECS systems, tween-engine integration, snapshot recording, and common blueprint registration, which turns the addon into a framework shell rather than just a set of helpers.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/entity/EntityFactory.kt` and `EntityBlueprint.kt` use string-addressable blueprints as the main composition boundary. Spawners, tween steps, and message receivers can configure entities by blueprint name instead of keeping hard references to constructors.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/MessagePassingSystem.kt` adds a small message bus for ECS entities. Published messages can trigger blueprint execution on subscribers and can also release waits inside `TweenSequenceComponent`, which is a practical way to coordinate cutscenes or scripted events without tight coupling.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/state/GameStateManager.kt` loads `game_config.yaml` from resources through YAML and falls back to a default config if the file is missing or broken. That keeps game bootstrap data externalized without making startup brittle.

### Persistence, Snapshots, And Memory Discipline

- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/utils/SnapshotSerializer.kt` builds a composable `SerializersModule` for internal components, tags, tween data, and custom KorGE types such as `RGBA`, `Easing`, and `Tile`, while still allowing external serializer modules to be registered later.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/SnapshotSerializerSystem.kt` records world snapshots at `30` snapshots per second, keeps rewind/forward buffers, saves and loads JSON snapshots via `resourcesVfs`, and pauses or resumes world systems while special-casing sound behavior.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/utils/Pool.kt` and `PoolableComponent.kt` show a consistent pool-based component lifecycle. Pools track generated, allocated, and freed objects, and components separate runtime init/cleanup from snapshot-load behavior so rewind does not accidentally re-run world side effects.
- `korge-fleks/src/commonTest/kotlin/korlibs/korge/fleks/systems/SnapshotSerializerSystemTest.kt` is unusually valuable for this lab: it simulates roughly `70` seconds of updates, triggers rewind and pause transitions, then asserts that all pools return to a zero-leak state after entity removal.

### Asset Loading, World Streaming, And Tooling

- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/assets/AssetStore.kt` separates common assets from world-cluster assets and supports removing sounds, textures, fonts, parallax layers, tilesets, and tile maps by cluster name. This is a strong reference for chunk- or region-scoped asset lifetimes.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/assets/data/WorldMapData.kt` implements camera-relative chunk activation. It checks the camera quadrant inside the current chunk, asynchronously loads neighboring chunks through `Dispatchers.ResourceDecoder`, and spawns entities from those chunks only when the viewport approaches them.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/WorldChunkSystem.kt` keeps entity chunk assignments synchronized with movement and delegates viewport-driven loading to `WorldMapData`, which keeps streaming logic out of the general movement systems.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/assets/AssetReload.kt` shows the intended iteration workflow: resource watchers, type-specific callbacks, and JVM-only live updates. On the inspected revision it should be treated as partial scaffolding rather than as a fully verified hot-reload system.

### Rendering And Presentation

- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/renderSystems/ObjectRenderSystem.kt` renders sprites, text, nine-patches, and tile-map objects directly from ECS families. It centralizes camera conversion, layer sorting, flip handling, and visible-window tile rendering without storing KorGE view objects inside components.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/renderSystems/LevelMapRenderSystem.kt` iterates only the visible tile window and renders across chunk boundaries through `WorldMapData.forEachTile`, which is a good reference for tile-map streaming that stays compatible with camera-driven chunk lifetimes.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/CameraSystem.kt` provides smooth follow movement, world-bound clamping, and automatic parallax velocity updates based on camera displacement, rather than making parallax systems poll the followed actor directly.

### Gameplay Systems, Collision, And Interaction

- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/collision/GridMoveSystem.kt` is a high-value collision reference. It converts velocity into substeps based on total movement magnitude, applies gravity, resolves horizontal and vertical collisions separately, supports debug collision shapes, and keeps entities inside playfield guards.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/logic/collision/resolver/PlatformerCollisionResolver.kt` resolves collisions by snapping entity-local grid fractions back to the nearest valid cell edge, then zeroing the corresponding velocity component. This is a compact and readable pattern for platformer grid movement.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/collision/PlatformerGravitySystem.kt` shows a simple but reusable pattern where platformer state gates gravity instead of burying grounded checks inside the generic motion system.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/SpawnerSystem.kt` spawns entities from blueprint names, supports animation-frame-based offsets, applies time and position variation, and can either create fresh entities or reconfigure a supplied target entity.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/TouchInputSystem.kt` defines entity-bounded touch actions with optional continuous-touch behavior and optional touch-position forwarding into entity state. It is promising for Android, but it is not wired into the default runtime on the inspected revision.
- `korge-fleks/src/commonMain/kotlin/korlibs/korge/fleks/systems/SoundSystem.kt` persists playback position inside ECS state, which lets sound pause and resume alongside snapshot and world-pause behavior instead of living in a separate opaque runtime.

### Tests And Verification Surface

- `korge-fleks/src/commonTest/kotlin/korlibs/korge/fleks/components/TweenPropertyComponentTest.kt` verifies the mapping between tween-property enum values and actual component types, then confirms serialization of float, int, bool, and string-backed tween data.
- `korge-fleks/src/commonTest/kotlin/korlibs/korge/fleks/components/TweenSequenceComponentTest.kt` verifies nested tween-sequence serialization, including parallel tween groups, entity spawns, waits, and blueprint invocation.
- `korge-fleks/src/commonTest/kotlin/korlibs/korge/fleks/components/CommonTestEnv.kt` also checks that serialized snapshots use short `@SerialName` identifiers instead of long class names, which is a practical safeguard for long-term save compatibility and JSON readability.

## Reusable Takeaways

- If entity components stay data-only and serializable, features such as rewind, save/load, and even multiplayer-state transport become much easier to layer onto gameplay code later.
- String-keyed blueprints plus ECS systems are a workable compromise between data-driven authoring and code-defined composition when the game needs reusable factories, scripted spawns, and cutscene steps.
- Camera-quadrant chunk loading is a good fit for 2D worlds because it keeps asset lifetimes and entity spawning aligned with what the player is about to see, not just what exists globally.
- Pool accounting is worth treating as first-class developer feedback. This repository's tests do not just verify logic; they also verify that snapshotting and entity teardown return pooled objects correctly.

## Evidence Summary

- `build.gradle.kts` - explicit `targetAndroid()` plus KorGE plugin setup
- `README.md` - framework scope, Android memory rationale, and claimed feature surface
- `WorldConfigurationExt.kt` - ordered runtime composition and common injectables
- `EntityFactory.kt` and `EntityBlueprint.kt` - string-keyed entity composition
- `AssetStore.kt` - common vs chunk-scoped asset lifetimes and unloading
- `WorldMapData.kt` - quadrant-based chunk loading and chunk-entity spawning
- `SnapshotSerializer.kt` - polymorphic serializer registration and custom KorGE type support
- `SnapshotSerializerSystem.kt` - rewind, pause, JSON save/load, and snapshot recording policy
- `Pool.kt` and `PoolableComponent.kt` - pooled component lifecycle and leak accounting
- `MessagePassingSystem.kt` - loose-coupled ECS event dispatch and tween wait release
- `ObjectRenderSystem.kt` and `LevelMapRenderSystem.kt` - ECS-driven rendering and visible-window tile drawing
- `GridMoveSystem.kt` and `PlatformerCollisionResolver.kt` - stepped platformer collision and grid-edge snap resolution
- `SpawnerSystem.kt` - config-driven spawning with frame-based offsets and variance
- `SoundSystem.kt` - ECS-owned sound playback state
- `SnapshotSerializerSystemTest.kt`, `TweenPropertyComponentTest.kt`, and `TweenSequenceComponentTest.kt` - serialization, rewind, and pooling verification

## Risks Or Limits

- The repository is still partially documented: several README sections end with "to be continued", and some runtime pieces are clearly still evolving.
- Gradle discovery currently requires Java `21+`, so build validation could not progress in the current Java `8` environment.
- Asset hot reload is not fully proven on the inspected revision because much of the actual reload logic in `AssetReload.kt` is still commented out.
- `TouchInputSystem` is present but marked unused, and `PlatformerGroundSystem` is effectively dormant because its active logic is commented out.
- The repository has only `19` stars at selection time, so it should be treated as a high-signal niche reference rather than a widely battle-tested default.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `android`, `ecs`, `korge`, `save-load`, `asset-pipeline`, `performance`
- Follow-up needed:
  - if the lab revisits this repository later, focus on one subsystem such as snapshot/pooling architecture, chunk streaming, or the partially implemented hot-reload path
  - if a Java `21+` environment becomes available, verify whether `:korge-fleks:commonTest` actually passes and whether the live asset-reload workflow works beyond watcher setup
