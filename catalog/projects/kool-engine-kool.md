# Project Entry

## Basic Info

- Project name: `Kool`
- Source repository: [https://github.com/kool-engine/kool](https://github.com/kool-engine/kool)
- Author / organization: `kool-engine`
- License: `Apache-2.0`
- Research note: [research/findings/kool-engine-kool.md](../../research/findings/kool-engine-kool.md)
- Investigated commit: `27da5cfeda200128331a052c74ee6de8d938e1d9`
- Last verified: `2026-06-04`
- Activity / maintenance status: active engine/editor work; the latest inspected commit is `Also apply tsaa to combined view proj matrix` from `2026-06-03`, and the checked-in build/publish workflows are current.

## Short Description

Large Kotlin Multiplatform 3D engine with shared scene graph and rendering abstractions, desktop Vulkan / OpenGL / `wgpu4k` backends, browser WebGPU / WebGL targets, a real Android OpenGL path, embedded Compose-style UI, physics modules, editor modules, and demos.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `android`, `multiplatform`, `scene-graph`, `shader`, `physics`, `editor-tools`, `asset-pipeline`, `performance`
- Engine / framework: custom Kotlin engine stack across `kool-core`, `kool-physics`, `kool-physics-2d`, `kool-compose-ui`, `kool-editor`, and `kool-backend-wgpu4k`
- Rendering approach: shared backend contract over desktop Vulkan / OpenGL / `wgpu4k`, browser WebGPU / WebGL, and Android GLES3, with dependency-ordered screen/offscreen/compute passes
- Main language(s): Kotlin
- Android target: direct but disabled by default in Gradle; Android source sets and platform glue are checked in, while a minimal starter app lives in `kool-templates`
- Build system: Gradle Kotlin DSL monorepo with custom convention plugins, optional Android enablement, Dokka, Maven publishing, and JDK `25` CI

## Why It Matters

- `Kool` is a strong engine reference because it combines real Android support, serious multiplatform backend work, an integrated editor story, and a Compose-style UI layer inside one coherent Kotlin codebase.
- It is especially useful when we want patterns for internal engines or shared Android/desktop/web runtimes rather than only finished end-user games.

## Reusable Ideas

- Gameplay ideas:
  - the repository is engine-first; the main value is runtime and tooling architecture rather than gameplay rules
- Architecture patterns:
  - explicit frontend / backend / synced frame phases
  - dependency-ordered GPU pass graph under a scene-level API
  - Android kept in-repo but disabled by default for easier non-Android consumption
- Graphics / rendering techniques:
  - backend-normalized NDC rules
  - multiplatform backend contract
  - offscreen + compute pass composition
  - desktop `wgpu4k` bridge with higher-JDK path isolated to one module
- Input / UI approaches:
  - Android `GLSurfaceView` host with shared pointer/key abstraction
  - Compose-style UI composition over the engine's native UI nodes
- Performance or optimization ideas:
  - async next-frame preparation
  - dirty world-matrix propagation
  - async interpolated physics stepping

## Notable Implementations

- `KoolContext` and `Lwjgl3Context` split render preparation, synced capture, and backend submission.
- `Scene` supports extra compute/offscreen passes and sorts them by dependency.
- `UiSurfaceComposition` runs a `MinimalComposition` from the engine frame clock.
- `PhysicsWorld` and `Physics2dWorld` use fixed-step async stepping plus interpolation capture.
- `kool-physics/build.gradle.kts` transforms shared physics sources into Android and web variants.
- `ProjectFiles` stores editor output inside `src/commonMain` resources/layouts instead of a separate opaque project format.

## Android Relevance

- Native Android use:
  - yes; Android context, surface, input, assets, and GLES backend are checked in
- Kotlin relevance:
  - very high
- Porting or adaptation notes:
  - most useful as a reference for internal Kotlin engine/runtime work, Android host shells, and shared rendering/input layers rather than as a simple drop-in Android game sample

## Risks / Limitations

- The repository is large and subsystem-heavy, so it is more of a study reference than a minimal starter.
- Android is disabled by default in the checked-in Gradle flow and still expects explicit enablement plus Android SDK tooling.
- Effective toolchain requirements are high: Gradle needs Java `17+`, conventions use JDK `25`, and the `wgpu4k` module needs Java `22`.
- Automated tests exist, but the strongest visible coverage is in core math / filesystem / picking utilities rather than across the full renderer/editor/physics surface.

## Notes

`Kool` is one of the stronger multiplatform engine references in the lab because it joins platform abstractions, editor/tooling, physics, and Android platform seams in one actively maintained Kotlin repository without hiding the real build and portability tradeoffs.
