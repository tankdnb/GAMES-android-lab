# Research Note

## Repository Snapshot

- Repository: `jrenner/kotlin-voxel`
- Source URL: [https://github.com/jrenner/kotlin-voxel](https://github.com/jrenner/kotlin-voxel)
- Owner: `jrenner`
- Batch ID: [`BATCH-2026-06-12-A`](../batches/BATCH-2026-06-12-A.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-06-12`
- Last pushed at selection: `2025-11-21`
- Stars at selection: `80`
- Default branch at selection: `master`
- Investigated commit: `0b952495194156612727043a385ebdcbd1aa4820`
- Research status: `accepted`
- Build mode: `static-review + gradle-version + gradle-help + test-dry-run`
- Catalog card: [catalog/projects/jrenner-kotlin-voxel.md](../../catalog/projects/jrenner-kotlin-voxel.md)

## Why This Repository Was Selected

- `jrenner/kotlin-voxel` stood out in the refreshed exact-license shortlist because it has clearer ecosystem signal than the fresh zero-star backlog and a real Kotlin engine codebase instead of a tiny sample shell.
- The main question for this pass was whether the repository is still only a historical voxel experiment or a reusable engine reference with enough runtime, chunking, rendering, and testing depth to keep.
- The answer is `accepted`: it is desktop-only and old in style, but it contains a coherent chunk-streaming world model, visible-face mesh generation, safe-enough build discovery, and a real test surface.

## Technical Profile

- Main language(s): Kotlin with a few Java support classes
- Engine / framework: custom libGDX-based voxel engine
- Rendering stack: libGDX + LWJGL3 desktop backend + custom GLSL shader pipeline + hand-built chunk meshes
- Android target: none in the checked-in tree; Android relevance is indirect through shared runtime and chunk/render patterns
- Build system: Gradle `8.11.1` wrapper + Groovy DSL multi-project build with `core`, `desktop`, and `test` modules
- Repository layout summary:
  - `core/src/main/kotlin/org/jrenner/learngl/` - runtime, rendering, input, HUD, lighting, physics, and world code
  - `core/src/main/java/org/jrenner/learngl/cube/` - chunk-grid and world-data backing structures
  - `core/assets/` - shaders, fonts, textures, and UI skin assets
  - `desktop/src/org/jrenner/learngl/desktop/` - LWJGL3 launcher
  - `test/src/kotlin/org/jrenner/learngl/test/` - JUnit coverage for chunk grids and world/chunk helpers
- Key modules and files reviewed:
  - `README.md`
  - `build.gradle`
  - `settings.gradle`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `core/src/main/kotlin/org/jrenner/learngl/Main.kt`
  - `core/src/main/kotlin/org/jrenner/learngl/View.kt`
  - `core/src/main/kotlin/org/jrenner/learngl/HUD.kt`
  - `core/src/main/kotlin/org/jrenner/learngl/Physics.kt`
  - `core/src/main/kotlin/org/jrenner/learngl/input/GameInput.kt`
  - `core/src/main/kotlin/org/jrenner/learngl/gameworld/World.kt`
  - `core/src/main/kotlin/org/jrenner/learngl/gameworld/WorldUpdater.kt`
  - `core/src/main/kotlin/org/jrenner/learngl/gameworld/Chunk.kt`
  - `core/src/main/kotlin/org/jrenner/learngl/gameworld/ChunkMesh.kt`
  - `test/src/kotlin/org/jrenner/learngl/test/CubeDataGridTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- With `GRADLE_USER_HOME` redirected into `research/cache/gradle-jrenner-kotlin-voxel`, `cmd /c gradlew.bat --version` succeeded under the lab's current Java `8` runtime.
- `cmd /c gradlew.bat help --no-daemon` also succeeded.
- `cmd /c gradlew.bat test --dry-run --no-daemon` succeeded and confirmed active `core`, `desktop`, and `test` task graphs.
- The dry-run emitted one warning about an invalid auto-provisioned temporary Java toolchain path under `.tmp/jdks/...`, but the build still configured successfully and the task graph was usable.
- The checked-in repository remains desktop-first:
  - no Android module
  - no multiplatform source sets
  - the public run command targets `desktop:run`

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `1`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - The codebase has real engine value beyond a screenshot demo: frustum-gated chunk generation, queued chunk realization on the render thread, visible-face mesh baking, debug/HUD instrumentation, and tests around chunk topology and hidden-face logic.
  - It stays below the strongest Android-facing engines because it is desktop-only, uses global mutable state heavily, and keeps physics/input/runtime structure much rougher than newer multiplatform projects.

## Interesting Findings

### Engine Architecture And Core Loop

- `core/src/main/kotlin/org/jrenner/learngl/Main.kt` keeps the runtime compact and readable: `create()` wires fonts, assets, view, HUD, input, world, and lights, while `render()` advances world state, renders view/HUD, updates input, and applies lightweight collision checks.
- `core/src/main/kotlin/org/jrenner/learngl/gameworld/World.kt` splits chunk lifecycle into two phases:
  - a background `WorldUpdater` discovers candidate chunks
  - the main thread processes a nearest-first `chunkCreationQueue`, updates dirty chunks, and culls far chunks every 30 frames
- `core/src/main/kotlin/org/jrenner/learngl/gameworld/WorldUpdater.kt` is the most reusable architecture seam:
  - it snapshots world occupancy into a thread-local hash set
  - scans only a clamped camera neighborhood
  - lazily queues chunks only when they are inside the current frustum and range
  - avoids Kotlin float-range boxing by using manual `while` loops

### Rendering And Graphics

- `core/src/main/kotlin/org/jrenner/learngl/View.kt` runs a direct shader-driven chunk renderer:
  - custom GLSL shader load/compile
  - fog and camera uniforms
  - per-frame frustum culling
  - per-chunk mesh draw calls
  - optional point-light debug rendering through `ModelBatch`
- `core/src/main/kotlin/org/jrenner/learngl/gameworld/ChunkMesh.kt` bakes only visible cube faces into an unindexed mesh. `reset()` computes expected face/triangle/vertex counts from `CubeDataGrid.numberOfHiddenFaces()`, then `buildMesh()` writes packed position/UV/normal data directly into one float buffer.
- `core/src/main/kotlin/org/jrenner/learngl/gameworld/Chunk.kt` keeps mesh rebuild cost explicit: dirty chunks call `dataGrid.refresh()`, rebuild the mesh, then clear the dirty bit.

### Gameplay Systems

- `core/src/main/kotlin/org/jrenner/learngl/gameworld/World.kt` uses layered simplex noise through `NoiseLayerManager` to convert one chunk-local heightfield into actual voxel fill decisions. The repository is engine-first, but this worldgen seam is still a reusable small-world baseline.
- `core/src/main/kotlin/org/jrenner/learngl/HUD.kt` exposes meaningful runtime instrumentation in-game instead of burying it in logs: FPS, Java/native heap, rendered chunk counts, queue size, altitude, movement mode, and current view distance are all visible to the player/developer.

### Input And Controls

- `core/src/main/kotlin/org/jrenner/learngl/input/GameInput.kt` combines a custom key handler with libGDX's `FirstPersonCameraController` through an `InputMultiplexer`, which keeps engine-level debug controls separate from camera movement.
- The key handling is practical rather than abstract:
  - `G` toggles GL profiling output
  - `V` rebuilds the view
  - `+/-` or `L/K` adjust view distance
  - `Space` switches between flying and walking velocities

### UI, HUD, And Menus

- `core/src/main/kotlin/org/jrenner/learngl/HUD.kt` is a small but useful example of a debug-first Scene2D overlay that rate-limits its own expensive string rebuilds through a 0.1 second update cadence instead of reformatting every frame.

### Physics And Collision

- `core/src/main/kotlin/org/jrenner/learngl/View.kt` uses `world.getBoundingBoxElevation()` plus simple fall-speed accumulation to simulate walking against the terrain without committing to a full rigid-body stack.
- `core/src/main/kotlin/org/jrenner/learngl/Physics.kt` is intentionally lightweight and incomplete, but still shows a readable pattern for camera-vs-cube probing:
  - locate current cube
  - create a cube AABB
  - cast a ray from doubled offset space toward the cube
  - keep the hit point as a correction/intersection signal

### Tooling, Android Integration, Or Other Notable Areas

- `test/src/kotlin/org/jrenner/learngl/test/CubeDataGridTest.kt` is stronger than expected for a hobby voxel engine. It covers:
  - chunk-grid construction
  - hash uniqueness
  - iteration order
  - cross-chunk lookup
  - hidden-face counting
  - snapping logic
  - world/chunk cube retrieval
- `settings.gradle` uses the Foojay resolver convention plugin, which is a modern touch for a repo that otherwise still looks historically desktop-libGDX in structure.

## Reusable Takeaways

- Frustum-aware chunk discovery can live on a background thread as long as the worker reads from a copied occupancy index and only hands back queue items, not live mesh/state mutation.
- A nearest-first main-thread chunk creation queue is a pragmatic compromise between streaming smoothness and thread safety in voxel engines.
- Hidden-face precomputation plus packed direct float-buffer mesh assembly remains a clear, portable baseline for block rendering, even when a project is not otherwise modern.
- Debug HUDs that expose memory, chunk counts, and queue pressure directly in-game make engine tuning much easier than log-only profiling.

## Evidence Summary

- `Main.kt`, `World.kt`, `WorldUpdater.kt` - runtime shell, chunk queue ownership, and threaded chunk discovery
- `Chunk.kt`, `ChunkMesh.kt` - dirty-chunk rebuilds and visible-face mesh assembly
- `View.kt` - shader pipeline, frustum culling, walking simulation, and chunk draw flow
- `GameInput.kt` and `HUD.kt` - debug controls and in-game instrumentation
- `CubeDataGridTest.kt` - real geometry/topology verification surface

## Risks Or Limits

- No Android module exists in the checked-in tree.
- The README still frames the project as a programming exercise.
- The runtime relies heavily on global mutable singletons (`world`, `view`, `lights`, `assets`, `gameInput`), which lowers portability and testability.
- Threading is pragmatic but rough: `WorldUpdater` sleeps in a loop and crashes the process on synchronization failure.
- Physics is only partial and camera-centric rather than a full gameplay-entity collision layer.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `3d`, `libgdx`, `opengl`, `input`, `testing`, `performance`, `procedural-generation`
- Follow-up needed:
  - if the lab revisits this repository, keep it narrow: isolate the chunk queue plus worker split, the visible-face mesh builder, or the chunk/grid test helpers instead of reopening it as a broad Android-runtime candidate
