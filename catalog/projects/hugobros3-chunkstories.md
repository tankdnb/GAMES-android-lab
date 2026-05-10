# Project Entry

## Basic Info

- Project name: `Chunk Stories`
- Source repository: [https://github.com/Hugobros3/chunkstories](https://github.com/Hugobros3/chunkstories)
- Author / organization: `Hugobros3`
- License: `LGPL v3 text in LICENSE.MD`
- Research note: [research/findings/hugobros3-chunkstories.md](../../research/findings/hugobros3-chunkstories.md)
- Investigated commit: `4450708feca935997647877d0e41c900fc6cae3b`
- Last verified: `2026-05-10`

## Short Description

Custom Kotlin voxel engine and Minecraft-like game stack with mod-layered content loading, dual Vulkan/OpenGL rendering backends, asynchronous chunk-derived data, and a dedicated-server shell that can redistribute mods to clients.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `opengl`, `shader`, `networking`, `asset-pipeline`, `performance`
- Engine / framework: custom voxel engine plus the game implementation in the same repository
- Rendering approach: rendergraph-driven 3D pipeline with deferred shading, forward water/model passes, bloom, dynamic shadow buffers, and backend fallback between Vulkan and OpenGL 3.3
- Main language(s): Kotlin, Java
- Android target: no direct Android target found on the inspected revision
- Build system: Gradle Kotlin DSL monorepo with external `api` / content dependencies required for full builds

## Why It Matters

- It is a strong reference for large-scope engine architecture in Kotlin even though the inspected branch is currently unstable as a product snapshot.
- The main value for the lab is not turnkey Android packaging. It is the way the repository structures content/mod loading, render passes, chunk meshing, plugin bootstrapping, and server-side mod delivery.

## Reusable Ideas

- Gameplay ideas:
  - staged world-slice generation and distance-limited chunk physics ticking near active players
- Architecture patterns:
  - fixed-step simulation thread beside a render thread, derived-data rebuild tasks, layered mod filesystem, mod-bundled plugin loading, and content-id translator rebuilding
- Graphics / rendering techniques:
  - backend-neutral rendergraph declarations, material-bucketed chunk meshing, face-level ambient occlusion, and chunk-side occlusion flood fill
- Input / UI approaches:
  - trait-driven HUD overlays plus in-runtime reload/debug controls for content, plugins, and rendergraphs
- Performance or optimization ideas:
  - asynchronous rebuild scheduling for chunk meshes and other derived data, near-player chunk ticking, and thread-local scratch structures for occlusion work

## Notable Implementations

- `GameContentStore` and `ModsManagerImplementation` build a coherent content pipeline across base assets, mods, jar code, and plugin descriptors.
- `GraphicsEngineImplementation`, `GraphicsBackendsEnum`, and the rendergraph declarations keep Vulkan/OpenGL backend choice separate from pass layout.
- `TaskCreateChunkMesh` is a high-value reference for chunk meshing with AO, lighting, texture id packing, and custom block models.
- `AutoRebuildingProperty` captures a reusable invalidation-and-task pattern for expensive derived world data.
- `ServerModsProvider` and `ConnectionsManager` show a practical approach for advertising and redistributing required mods from a dedicated server.

## Android Relevance

- Native Android use:
  - none verified on the inspected revision
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - best reused as an architecture reference for Kotlin engine subsystems, mod/content runtimes, and chunked-world rendering rather than as a direct Android runtime base

## Risks / Limitations

- The inspected `master` branch is explicitly documented upstream as heavy work in progress.
- No Android launcher, mobile renderer path, or Android packaging flow was found.
- Full builds depend on external `chunkstories-api` / `chunkstories-core` pieces not present in this research clone.
- Some multiplayer and remote-content paths remain incomplete or commented out.
- `LGPL v3` is a less convenient reuse license than MIT or Apache references.

## Notes

This repository is especially useful when the lab wants ideas for backend-agnostic rendergraph organization, mod-heavy content loading, and derived chunk-task pipelines inside a larger Kotlin voxel engine.
