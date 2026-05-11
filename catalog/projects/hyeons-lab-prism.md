# Project Entry

## Basic Info

- Project name: `prism`
- Source repository: [https://github.com/hyeons-lab/prism](https://github.com/hyeons-lab/prism)
- Author / organization: `hyeons-lab`
- License: `Apache-2.0`
- Research note: [research/findings/hyeons-lab-prism.md](../../research/findings/hyeons-lab-prism.md)
- Investigated commit: `84261cc5c8de24dbba23f8c62cbbecc6b8e1d2ec`
- Last verified: `2026-05-11`
- Activity / maintenance status: last push recorded at selection on `2026-05-09`.

## Short Description

Experimental Kotlin Multiplatform 3D/WebGPU engine with modular runtime layers, Android and Compose embedding paths, glTF/PBR asset loading, simple ECS and scene graph modules, and a Vulkan-backed Android demo.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `android`, `multiplatform`, `ecs`, `scene-graph`, `shader`, `asset-pipeline`, `performance`
- Engine / framework: custom Kotlin Multiplatform engine with modular runtime, ECS, scene graph, and Compose bridge
- Rendering approach: `wgpu4k`-backed WebGPU renderer with PBR materials, CPU-generated IBL, HDR render target, tone mapping, and platform-native surface setup
- Main language(s): Kotlin
- Android target: direct Android demo plus Android Compose embedding path
- Build system: Gradle Kotlin DSL monorepo with AGP `8.13.2`, Kotlin `2.3.10`, Android KMP library modules, `wgpu4k 0.2.0-SNAPSHOT`, and JDK `25` / `21+` expectations

## Why It Matters

- It gives the lab a rare Android-relevant Kotlin Multiplatform WebGPU/Vulkan reference instead of another only-desktop OpenGL engine or tiny Compose game sample.
- Its strongest value is the combination of reusable seams: subsystem-driven core loop, explicit bind-group-based PBR renderer, progressive glTF texture upload, Compose `StateFlow` bridge, and platform-specific native surface creation hidden behind a small API.

## Reusable Ideas

- Gameplay ideas:
  - more of a technical demo shell than a full game, but the progressive setup queue and orbit-camera control are reusable for 3D viewers or tool scenes
- Architecture patterns:
  - subsystem-owned engine lifecycle, external-frame `tick()` mode, simple ECS render-system composition, and reducer-driven UI state around the engine
- Graphics / rendering techniques:
  - split scene/object/material/environment bind groups, HDR-to-tone-map frame routing, CPU-side IBL generation, and on-demand object/material GPU resource pools
- Input / UI approaches:
  - Compose-facing engine store, frame-scheduled render loop, race-safe Android surface recreation, and dual embedding paths through direct `SurfaceView` or Compose
- Performance or optimization ideas:
  - progressive glTF structure-first loading, zero-copy GLB byte-range support for WASM, material cache invalidation on texture upload, and per-draw object UBO pooling

## Notable Implementations

- `Engine` + `GameLoop` separate fixed-step ownership from platform-driven external ticking.
- `WgpuRenderer` packages PBR, HDR, tone mapping, texture/sampler caches, and per-draw uniform pools inside one explicit WebGPU renderer.
- `GltfLoader` and `GlbReader` support structure-first glTF loading, raw compressed texture extraction, and later GPU upload/material refresh.
- `PrismSurface` and its Android actual implementation hide Vulkan-backed `WGPUContext` creation behind a minimal cross-platform surface API.
- `EngineStore`, `DemoStore`, `PrismView.android`, and `PrismDemoActivity` together show both Compose and direct-activity ways to host the same shared rendering core on Android.

## Android Relevance

- Native Android use:
  - direct
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - the Android runtime path is real, but build reproduction currently assumes newer JDKs and locally published `wgpu4k` snapshots; reuse is strongest at the architecture level unless the same upstream toolchain is adopted

## Risks / Limitations

- The README explicitly frames the repository as an experiment being "vibe-coded with Claude".
- Ecosystem signal is still extremely low.
- Real builds likely require prepared `mavenLocal()` snapshot artifacts plus JDK `25` / `21+`, and Gradle discovery timed out in the current lab environment.
- The ECS layer is intentionally lightweight and should not be treated as proof of high-scale runtime performance.

## Notes

This is one of the more interesting Android-adjacent engine references in the lab for future 3D work, especially when the goal is to study Kotlin Multiplatform WebGPU, platform surface abstraction, and progressive asset/render integration rather than to copy a fully stabilized production stack.
