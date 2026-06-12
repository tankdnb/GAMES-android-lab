# Project Entry

## Basic Info

- Project name: `kotlin-voxel`
- Source repository: [https://github.com/jrenner/kotlin-voxel](https://github.com/jrenner/kotlin-voxel)
- Author / organization: `jrenner`
- License: `Apache-2.0`
- Research note: [research/findings/jrenner-kotlin-voxel.md](../../research/findings/jrenner-kotlin-voxel.md)
- Investigated commit: `0b952495194156612727043a385ebdcbd1aa4820`
- Last verified: `2026-06-12`
- Activity / maintenance status: older desktop-first engine with non-trivial niche signal; the last pushed code revision at selection was `2025-11-21`, which is not current-hot but clearly newer than its original 2015 roots.

## Short Description

Small Kotlin voxel engine built on libGDX and LWJGL3, with background chunk discovery, simplex-noise terrain generation, visible-face mesh baking, direct shader rendering, and a stronger-than-expected JUnit test surface for chunk/grid logic.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `libgdx`, `opengl`, `input`, `testing`, `performance`, `procedural-generation`
- Engine / framework: custom voxel engine on top of libGDX
- Rendering approach: custom GLSL shader pipeline plus hand-built chunk meshes rendered through libGDX/LWJGL3
- Main language(s): Kotlin with some Java support classes
- Android target: none in the checked-in tree
- Build system: Gradle `8.11.1` wrapper + Groovy multi-project build (`core`, `desktop`, `test`)

## Why It Matters

- `kotlin-voxel` matters because it gives the lab a readable block-world engine reference that is more substantial than a toy demo but smaller than the large modern multiplatform engines already cataloged.
- Its strongest value for Android game development is indirect: chunk streaming, hidden-face mesh construction, worldgen layering, input/debug ownership, and testable chunk-grid helpers all transfer well into future voxel, terrain, or procedural-world work.

## Reusable Ideas

- Gameplay ideas:
  - simplex-noise heightfield world generation as a compact baseline for block terrain
- Architecture patterns:
  - background frustum/range-based chunk discovery with a main-thread realization queue
  - global world/view/input shell kept very small and inspectable
- Graphics / rendering techniques:
  - hidden-face-aware voxel mesh baking
  - direct shader uniform control for fog, camera position, and distance fading
- Input / UI approaches:
  - debug-first `InputMultiplexer` split between camera controls and engine commands
  - in-game HUD for chunk, memory, altitude, and streaming pressure
- Performance or optimization ideas:
  - queue-pressure-based chunk creation budget per frame
  - manual `while` loops in the worker to avoid float-range boxing/GC churn

## Notable Implementations

- `WorldUpdater` does frustum-gated chunk discovery on a background thread while keeping live world mutation on the main thread.
- `ChunkMesh` builds packed position/UV/normal buffers only for non-hidden voxel faces.
- `World` keeps a nearest-first chunk creation queue and periodically culls distant chunks.
- `CubeDataGridTest` and `WorldTest` provide meaningful regression coverage for chunk topology and hidden-face logic.

## Android Relevance

- Native Android use:
  - none in the checked-in tree
- Kotlin relevance:
  - strong as a compact engine/reference codebase written mostly in Kotlin
- Porting or adaptation notes:
  - best reused as a source of chunk, mesh, worldgen, and instrumentation ideas rather than as a direct Android engine baseline

## Risks / Limitations

- Desktop-only; no Android host module exists.
- README still frames the project as a programming exercise.
- Heavy reliance on global mutable state lowers portability and testability.
- Worker-thread design is practical but rough and crash-on-failure.
- Physics is only partial and camera-centered.

## Notes

Keep `kotlin-voxel` as an `accepted` engine reference, but use it selectively. Its value is strongest around chunk streaming, voxel mesh generation, and geometry tests, not around modern multiplatform product architecture.
