# Project Entry

## Basic Info

- Project name: `Materia`
- Source repository: [https://github.com/codeyousef/Materia](https://github.com/codeyousef/Materia)
- Author / organization: `codeyousef`
- License: `Apache-2.0`
- Research note: [research/findings/codeyousef-materia.md](../../research/findings/codeyousef-materia.md)
- Investigated commit: `018c94cef6077494cdb46d69feb1e49628ab81c7`
- Last verified: `2026-06-04`
- Activity / maintenance status: active alpha engine work; the latest inspected commit is `Add GLTF cache and WebGL readback guard (#12)` from `2026-05-10`, and the checked-in code plus publish workflow show ongoing renderer, loader, and release-pipeline development.

## Short Description

Kotlin Multiplatform 3D engine stack with a three.js-style scene API, a separate GPU abstraction layer, broad loader support, validation and benchmark tooling, and Android host paths that currently span both wgpu-oriented and Filament-backed renderers.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `android`, `multiplatform`, `scene-graph`, `shader`, `asset-pipeline`, `performance`, `testing`
- Engine / framework: custom KMP engine built around shared scene graph types, wgpu/Vulkan/WebGPU-oriented renderer abstractions, `materia-engine`, `materia-gpu`, and validation tooling
- Rendering approach: scene-first renderer stack with Vulkan/WebGPU/WebGL abstractions, optional FXAA/post-process resources, shader compilation from WGSL to SPIR-V, and Android-specific Filament host implementations
- Main language(s): Kotlin
- Android target: direct but transitional; Android-specific renderers and wrapper apps exist, but the checked-in implementation currently mixes wgpu-oriented code with Filament-backed runtime/example paths
- Build system: Gradle Kotlin DSL monorepo on Kotlin `2.2.20`, AGP `8.12.3`, Android SDK `34`, and an effective JDK `22` publish/runtime baseline for key paths

## Why It Matters

- `Materia` is valuable because it combines a broad scene-first 3D API with a serious multiplatform backend story instead of stopping at a small rendering demo.
- Its strongest reuse value is the combination of a shared scene graph, explicit GPU abstraction, clone-on-read asset loading, built-in shader/benchmark/validation workflows, and concrete Android host seams.

## Reusable Ideas

- Gameplay ideas:
  - not a gameplay-first repo; the value is mostly in runtime and tooling architecture
- Architecture patterns:
  - dual renderer layers where a higher-level engine renderer can evolve independently from a lower-level platform renderer stack
  - scene-first object hierarchy with dirty-flagged world-matrix propagation
- Graphics / rendering techniques:
  - backend-aware renderer interfaces, shared GPU abstractions, FXAA/offscreen resources, WGSL-to-SPIR-V pipeline, and built-in LOD generation
- Input / UI approaches:
  - Android `SurfaceView` + `Choreographer` render-loop hosts and platform-specific renderer bootstrapping
- Performance or optimization ideas:
  - clone-on-read GLTF asset caching, deferred GPU resource creation, explicit benchmark capture pipeline, and object/matrix dirtiness tracking

## Notable Implementations

- `GLTFLoader` plus `GLTFAssetCache` deduplicate in-flight loads and clone scene graphs while sharing heavy render assets.
- `Object3D` provides a rich three.js-style hierarchy with cached local/world transforms and selective traversal helpers.
- `EngineRendererImpl` acquires GPU instance/device/surface state explicitly and keeps optional FXAA resources cached around resize and backend changes.
- `materia-gpu` shows a clean Kotlin-side GPU abstraction over `wgpu4k-toolkit`.
- Android runtime code demonstrates both a wgpu/Vulkan-oriented renderer path and a Filament-backed engine/example path.
- Benchmark and validation tooling are first-class build features rather than separate scripts hidden outside the repo.

## Android Relevance

- Native Android use:
  - yes, but currently through several evolving renderer/host paths rather than one fully unified Android implementation
- Kotlin relevance:
  - very high
- Porting or adaptation notes:
  - especially useful for teams building internal Kotlin engine/runtime layers, Android host shells, or shared 3D asset/render pipelines rather than for teams looking only for a finished drop-in Android game engine

## Risks / Limitations

- The repo is clearly transitional and carries multiple overlapping renderer/runtime stories.
- Android examples still rely on Filament/OpenGL or CPU-side fallback in places where the higher-level positioning suggests a cleaner shared Vulkan/wgpu story.
- Architecture docs drift from the current active module graph.
- Some standalone `tests/` suites are placeholder-only and do not appear wired into the normal Gradle build.
- Real local validation needs a proper JDK and Android-ready environment.

## Notes

`Materia` is strong enough for the main catalog because it captures a real Kotlin multiplatform 3D engine effort in motion: not fully settled, but rich in reusable backend, scene, Android-host, asset, validation, and benchmark patterns.
