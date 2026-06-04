# Project Entry

## Basic Info

- Project name: `PlanetEngine`
- Source repository: [https://github.com/Saar25/PlanetEngine](https://github.com/Saar25/PlanetEngine)
- Author / organization: `Saar25`
- License: `GPL-3.0`
- Research note: [research/findings/saar25-planetengine.md](../../research/findings/saar25-planetengine.md)
- Investigated commit: `015bd8c61db2a0f08d4144ad60a49e6e9b8d3f90`
- Last verified: `2026-06-04`
- Activity / maintenance status: mixed; GitHub shows repository-level activity on `2026-05-29`, but the default branch `master` inspected in this batch ends at a `2022-10-28` merge commit, while fresher visible work lives on the separate `dev` branch.

## Short Description

Java and Kotlin LWJGL/OpenGL engine monorepo with strongly typed low-level bindings, annotation-driven renderer prototypes, deferred or shadow render passes, a small retained GUI toolkit, and example applications.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `scene-graph`, `opengl`, `shader`, `input`, `ui-hud`
- Engine / framework: custom LWJGL / OpenGL engine with separate math, binding, core, GUI, and examples modules
- Rendering approach: strongly typed shader or uniform wrappers, prototype-driven renderers, deferred lighting or shadow full-screen passes, and FBO-backed rendering paths
- Main language(s): Java, Kotlin
- Android target: none found in the inspected default branch
- Build system: Maven reactor + Kotlin Maven plugin `1.7.20` + Java `11`

## Why It Matters

- This repository is worth keeping because it is a real engine workspace rather than a tiny rendering demo. The binding layer, render-prototype architecture, per-pass scene traversal, and retained GUI pieces all give reusable ideas for internal engine work.
- For the lab, the value is indirect rather than direct: `PlanetEngine` is not an Android-ready runtime, but it is a useful OpenGL/LWJGL architecture reference for teams building tools, editors, or desktop-side shared engine components that may later inform Android game work.

## Reusable Ideas

- Gameplay ideas:
  - use lightweight node-attached components with `start`, `update`, and `delete` lifecycle hooks instead of requiring a full ECS for every behavior
- Architecture patterns:
  - split scene traversal into forward, deferred, and shadow-capable node groups so one scene can participate in several render paths cleanly
- Graphics / rendering techniques:
  - declare shaders and uniforms on prototype objects, then use reflection helpers to auto-bind programs and upload schedules by trigger
- Input / UI approaches:
  - translate raw GLFW callbacks into a retained UI focus or hover or drag helper instead of having each widget poll hardware state directly
- Performance or optimization ideas:
  - compile shader variants with small generated `#define` values and drive lighting or shadow evaluation through full-screen quad passes over deferred buffers

## Notable Implementations

- `Node3D.kt` combines a `Model3D`, component composition, and forward or deferred or shadow render interfaces in one reusable scene node.
- `RendererPrototypeHelper.kt`, `Renderers.java`, and `RenderPassPrototypeWrapper.kt` build shader programs and uniform upload schedules from annotated prototype fields.
- `DeferredRenderer3D.kt`, `LightRenderPass.kt`, and `ShadowsRenderPass.kt` show a compact deferred stack with explicit per-render-cycle or per-instance uniforms.
- `Window.java` wraps GLFW lifecycle, callbacks, and typed input around a single engine-owned window object.
- `UIDisplay.kt`, `UIInputHelper.kt`, `UIButton.kt`, and `UIText.kt` form a small retained GUI layer with focus, layout, and text wrapping.
- The Maven reactor splits low-level bindings, math, core rendering, GUI, and examples into readable boundaries instead of one monolith.

## Android Relevance

- Native Android use:
  - no direct Android host layer or module was found in the inspected default branch
- Kotlin relevance:
  - medium to high
- Porting or adaptation notes:
  - the strongest transferable pieces are the render-prototype helpers, per-pass scene traversal, and retained GUI or input model; the raw LWJGL bindings themselves are desktop-only and would need replacement for Android

## Risks / Limitations

- The default branch is materially older than the repo-level activity signal suggests.
- No actual automated tests were found.
- No visible CI workflows were found.
- There is no Android target in the inspected default branch.
- The lab cannot currently validate the Maven build because Maven is unavailable locally.
- Reuse value is stronger for engine or tooling architecture than for immediate Android app-shell adoption.

## Notes

`PlanetEngine` is a good example of a repository that still belongs in the catalog even though it is not Android-native: it contains enough renderer, scene, input, and UI architecture to stay useful as a reference, but future sessions should be careful not to overstate its current freshness or Android readiness.
