# Project Entry

## Basic Info

- Project name: `KRender`
- Source repository: [https://github.com/Dmytro-Pashko/KRender](https://github.com/Dmytro-Pashko/KRender)
- Author / organization: `Dmytro-Pashko`
- License: `Apache-2.0`
- Research note: [research/findings/dmytro-pashko-krender.md](../../research/findings/dmytro-pashko-krender.md)
- Investigated commit: `1340df930963ea14a3d4d02c7f666202a9f3d17a`
- Last verified: `2026-06-04`
- Activity / maintenance status: active at selection; GitHub showed a push on `2026-06-03`, the default branch is `feature/v2`, and the latest inspected commit added new runtime-UI and sandbox wiring rather than only metadata churn.

## Short Description

Kotlin engine-and-toolset workspace with a backend-neutral runtime core, LibGDX 3D renderer/backend, scene serialization, terrain pipeline, editor scenes, a desktop launcher, and a direct Android application module.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `android`, `ecs`, `libgdx`, `editor-tools`, `asset-pipeline`, `testing`
- Engine / framework: custom Kotlin engine with LibGDX backend and built-in editor tools
- Rendering approach: backend-neutral render-command pipeline resolved by a LibGDX / OpenGL / `gdx-gltf` renderer, with static models, dynamic terrain meshes, debug overlays, and editor UI
- Main language(s): Kotlin
- Android target: direct; the repository contains a real Android app module alongside shared engine/runtime code
- Build system: Gradle multi-module workspace with `android`, `core`, and `lwjgl3` modules, Android Gradle Plugin `8.9.3`, Kotlin `2.2.21`, and an explicit Java `21` toolchain/daemon configuration

## Why It Matters

- `KRender` is a strong reference for teams that want one shared Kotlin engine core with both Android runtime delivery and richer desktop tooling.
- Its main reuse value is not a finished game; it is the way runtime, ECS, render commands, scene persistence, terrain, runtime UI, and editor tools are all kept inside one coherent architecture.

## Reusable Ideas

- Gameplay ideas:
  - mostly engine/tooling oriented rather than genre-specific gameplay
- Architecture patterns:
  - backend-neutral `EngineContext` and render-command boundaries, deferred ECS mutation, and serialized runtime scene loading
- Graphics / rendering techniques:
  - command-buffered 3D rendering, terrain-as-dynamic-mesh generation, debug/PBR preview flows, and skybox/environment submission as engine commands
- Input / UI approaches:
  - normalized input snapshots with UI capture plus ordered runtime UI layers and scene-hosted editor panels
- Performance or optimization ideas:
  - fixed-step accumulator, cached asset metadata/bounds/preview handles, and generated runtime textures for terrain instead of repeated heavyweight reloads

## Notable Implementations

- `EngineRuntime` owns a clear frame pipeline around scenes, assets, tasks, profiler/stats, and render submission.
- `SceneWorld`, `SystemPipeline`, and `CommandBuffer` provide a readable ECS with deferred entity/component changes.
- `RenderCommandBuffer` and `GdxRenderer3D` separate scene-side rendering intent from backend execution.
- `RuntimeSceneBuilder` validates serialized scene descriptors, applies them to a world, resolves terrain/environment setup, and wires the needed systems.
- `AssetBrowserScene` and `SceneEditorScene` turn the same runtime into practical editor/tool surfaces instead of keeping tooling out-of-band.
- `SceneSerializer` round-trips `.krscene` content, including cameras, models, terrain, and nested scene settings.
- The Android module includes explicit asset/native preparation tasks instead of assuming desktop-only execution.

## Android Relevance

- Native Android use:
  - yes; there is a real Android application module with current SDK targets
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - especially useful for Android teams that want a shared engine core plus a better desktop tooling host, even if they later replace LibGDX-specific backend pieces

## Risks / Limitations

- The inspected default branch is still `feature/v2`, so the architecture should be treated as active work rather than as a stable product baseline.
- The codebase is editor-heavy and backend-specific enough that some subsystems are better reused as patterns than as direct copy targets.
- The lab did not run a real Android build or runtime session.

## Notes

This is one of the clearer current examples in the lab of a Kotlin engine that tries to be both an Android-capable runtime and a real desktop tooling workspace instead of choosing only one side.
