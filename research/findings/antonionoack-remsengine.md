# Research Note

## Repository Snapshot

- Repository: `AntonioNoack/RemsEngine`
- Source URL: [https://github.com/AntonioNoack/RemsEngine](https://github.com/AntonioNoack/RemsEngine)
- Owner: `AntonioNoack`
- Batch ID: [`BATCH-2026-05-10-E`](../batches/BATCH-2026-05-10-E.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-05-10`
- Last pushed at selection: `2026-05-10`
- Stars at selection: `39`
- Investigated commit: `7e5449b300e213ae223e71d542a4306d2f5c85f4`
- Research status: `accepted`
- Build mode: `static-review-only + intellij-module-workspace`
- Catalog card: [catalog/projects/antonionoack-remsengine.md](../../catalog/projects/antonionoack-remsengine.md)

## Why This Repository Was Selected

- It was the freshest unresearched Kotlin engine candidate found in the current GitHub refresh pass.
- Despite low star count, it exposed much deeper subsystem breadth than typical small hobby engines: editor UI, ECS, rendering, caches, export, physics, scripting, VR, and file abstraction.
- It is a good wildcard counterweight to older but more popular candidates whose verified `pushedAt` values were stale.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Kotlin JVM engine with extension-loaded modules
- Rendering stack: LWJGL/OpenGL runtime with render-step orchestration, render-graph pipeline tools, and editor scene views
- Android target: indirect and partial; the reviewed repository is JVM-first, but explicitly models Android-style UI layouts and documents Android export/porting paths through separate modules and forks
- Build system: IntelliJ IDEA module workspace (`*.iml`) with module directories such as `Bullet`, `Box2d`, `Export`, `JVM`, `Lua`, `Network`, `OpenXR`, `Recast`, `SDF`, `Unpack`, and `Video`; no root Gradle or Maven build files were present
- Repository layout summary: large editor-and-engine workspace with core runtime in `src/`, optional capabilities split into sibling module folders, assets in `assets/`, and a very large `test/src/` surface used for experiments, samples, and subsystem validation
- Key modules reviewed:
  - `src/me/anno/engine/RemsEngine.kt`
  - `src/me/anno/engine/EngineBase.kt`
  - `src/me/anno/gpu/WindowManagement.kt`
  - `src/me/anno/ecs/Entity.kt`
  - `src/me/anno/ecs/systems/Systems.kt`
  - `src/me/anno/graph/visual/render/RenderGraph.kt`
  - `src/me/anno/io/files/FileReference.kt`
  - `src/me/anno/cache/CacheSection.kt`
  - `src/me/anno/engine/OfficialExtensions.kt`
  - `Bullet/src/me/anno/bullet/BulletPhysics.kt`
  - `JVM/src/me/anno/jvm/JVMExtension.kt`
  - `Export/src/me/anno/export/ExportMenu.kt`
  - `OpenXR/src/me/anno/openxr/OpenXR.kt`
  - `src/me/anno/ui/base/groups/PanelListY.kt`

## Build And Runtime Notes

- The repository was inspected statically.
- No lightweight Gradle, Maven, or checked-in wrapper entrypoint was available in the repository root, so a safe discovery build step was not attempted.
- `Engine.iml` confirms an IntelliJ module workspace with project-scoped libraries and module references instead of a standard root build script.
- No runtime launch was attempted.
- Known setup limitations:
  - local compilation would likely require recreating the author's IntelliJ/project-library environment
  - Android delivery is not self-contained inside this repository and appears to rely on related repositories or forks

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - the repository contains many reusable engine patterns even though it is not Android-first in the same way as a production mobile game
  - its strongest value is architectural breadth: modular extensions, render graph tooling, ECS/system registration, cache discipline, file abstraction, and editor-first workflows
  - several ideas transfer well to Android-oriented engines or internal tooling even if the runtime is currently JVM/LWJGL-centric

## Interesting Findings

### Engine Architecture And Core Loop

- `src/me/anno/engine/EngineBase.kt` separates startup into config loading, extension loading, audio startup, UI creation, and per-frame hooks, which gives a clean top-level lifecycle for editor or game shells.
- `src/me/anno/gpu/WindowManagement.kt` runs GLFW/window updates and OpenGL rendering in separate loops when desired, throttles idle rendering, and renders hidden windows minimally to keep background processing alive without burning full frame cost.
- `src/me/anno/engine/RemsEngine.kt` makes the editor shell the default product shape: scene tree, scene view, property inspector, dual file explorers, console, and project loading all come from one engine entrypoint instead of being bolt-on tools.
- `src/me/anno/engine/OfficialExtensions.kt` loads official capabilities from `.ext.info` descriptors, which is a strong modularization pattern for shrinking platform-port complexity without forking the whole engine.

### Rendering And Graphics

- `src/me/anno/graph/visual/render/RenderGraph.kt` exposes rendering as a node-graph execution pipeline with built-in nodes for deferred rendering, lights, SSAO, SSR, bloom, FSR1, outline, tone mapping, and more, rather than hardwiring all post-processing into one renderer class.
- `src/me/anno/gpu/WindowManagement.kt` centralizes context creation, multi-window sharing, idle frame pacing, and render-step ordering, which is useful reference material for any custom Kotlin/LWJGL runtime.
- `src/me/anno/engine/RemsEngine.kt` uses a GPU-rendered skybox even for the editor background, which shows how deeply the engine reuses its own rendering stack for tooling surfaces.

### Gameplay Systems

- `src/me/anno/ecs/Entity.kt` mixes hierarchical scene structure, serialized prefab identity, renderability, collision-mask aggregation, AABB invalidation, and transform propagation in one engine entity type, which is a very different tradeoff from pure ECS libraries but useful for editor-first game engines.
- `src/me/anno/ecs/systems/Systems.kt` keeps a sorted registry of systems and recursively syncs entities/components into systems when world structure or enabled state changes, which is a strong bridge pattern between scene hierarchy and system-driven behavior.
- `test/src/me/anno/games/simplefps/FirstPersonShooter.kt` shows how gameplay samples are composed from engine primitives by registering systems, building `Entity` trees, adding bodies/colliders/meshes, and launching a ready-made scene test UI.

### Input And Controls

- `JVM/src/me/anno/jvm/JVMExtension.kt` registers controller polling at game-loop start and wires JVM-only facilities such as clipboard, external open, spellchecking, font management, and thumbnails through one platform extension layer instead of leaking them into core runtime code.

### UI, HUD, And Menus

- `src/me/anno/ui/base/groups/PanelListY.kt` explicitly models the same vertical weighted layout role as Android's `LinearLayout`, and `UI.md` confirms the whole UI system is intentionally inspired by Android panel/layout patterns.
- `src/me/anno/engine/RemsEngine.kt` composes the editor from reusable UI panels rather than special-casing the shell, which makes engine UI patterns directly reusable inside tools or in-game editors.
- `Export/src/me/anno/export/ExportMenu.kt` builds a full preset-driven export UI from engine-native panels and background tasks, which is a useful example of treating internal tools as first-class product surfaces.

### Physics And Collision

- `Bullet/src/me/anno/bullet/BulletMod.kt` registers Bullet world, bodies, vehicles, and constraints as serializable mod classes, which fits the engine's extension-driven architecture cleanly.
- `Bullet/src/me/anno/bullet/BulletPhysics.kt` translates ECS entities and colliders into Bullet shapes, handles compound colliders, vehicle setup, character bodies, per-body gravity overrides, and GUI debug output in one reusable system component.

### Tooling, Android Integration, Or Other Notable Areas

- `src/me/anno/io/files/FileReference.kt` abstracts local files, files inside archives, web files, and pseudo-files behind one path/reference API, which is unusually valuable for game tools that need to treat project files, packed assets, and remote resources uniformly.
- `src/me/anno/cache/CacheSection.kt` provides asynchronous value generation plus automatic expiry and cleanup without coroutines, matching the repository's explicit preference for keeping browser/web size low and avoiding main-thread stalls.
- `OpenXR/src/me/anno/openxr/OpenXR.kt` shows VR support is treated as another engine subsystem instead of a totally separate runtime branch.
- `test/src/` contains `1198` Kotlin files on the inspected commit, and `test/src/me/anno/games/` includes sample game folders such as `carchase`, `creeperworld`, `flatworld`, `minesweeper`, `pacman`, `simplefps`, `snake`, `simslike`, `trainbuilder`, and `visualnovel`, which makes the repo unusually rich as a code-reading library even without a formal docs site.

## Reusable Takeaways

- Split optional engine capabilities into extension-loaded modules so platform ports and stripped-down builds do not require invasive forks.
- An editor-first engine can still stay structurally coherent if its editor panels, runtime scene views, exporters, and inspectors are all built from the same UI primitives.
- A unified file-reference abstraction is highly valuable for game tools that work across local assets, archives, generated outputs, and virtual resources.
- Aggressive cache discipline plus background generation can be implemented without immediately committing to coroutine-heavy infrastructure.

## Evidence Summary

- `src/me/anno/engine/EngineBase.kt` - engine lifecycle and per-frame orchestration
- `src/me/anno/gpu/WindowManagement.kt` - split window/render loops, context management, idle throttling
- `src/me/anno/engine/RemsEngine.kt` - editor-first shell composition
- `src/me/anno/engine/OfficialExtensions.kt` - official extension loading
- `src/me/anno/ecs/systems/Systems.kt` - system registry and world membership propagation
- `src/me/anno/ecs/Entity.kt` - hierarchical entity, transform, bounds, and component structure
- `src/me/anno/graph/visual/render/RenderGraph.kt` - render-graph node execution
- `src/me/anno/io/files/FileReference.kt` - cross-source asset/file abstraction
- `src/me/anno/cache/CacheSection.kt` - async cache section with expiry
- `Bullet/src/me/anno/bullet/BulletPhysics.kt` - physics integration
- `JVM/src/me/anno/jvm/JVMExtension.kt` - JVM platform adaptation layer
- `Export/src/me/anno/export/ExportMenu.kt` - native export tooling UI
- `OpenXR/src/me/anno/openxr/OpenXR.kt` - VR subsystem entry
- `src/me/anno/ui/base/groups/PanelListY.kt` and `UI.md` - Android-inspired UI layout model

## Risks Or Limits

- The repository is desktop/editor-first, so Android transfer is architectural rather than directly product-ready.
- The build surface is harder to reproduce than a normal Gradle Kotlin repo because it depends on IntelliJ module setup and project libraries.
- Low star count means ecosystem validation is weak compared to larger engines already in the catalog.
- The README and code both indicate some features are WIP or experimental, so not every subsystem should be treated as production-hardened.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `3d`, `ecs`, `opengl`, `physics`, `editor-tools`, `asset-pipeline`, `performance`
- Follow-up needed:
  - if the lab later wants Android-specific engine export details, inspect the related Android fork or a more self-contained multiplatform runtime with checked-in mobile build surfaces
