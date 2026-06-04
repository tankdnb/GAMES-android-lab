# Project Entry

## Basic Info

- Project name: `glare`
- Source repository: [https://github.com/johron/glare](https://github.com/johron/glare)
- Author / organization: `johron`
- License: `MIT`
- Research note: [research/findings/johron-glare.md](../../research/findings/johron-glare.md)
- Investigated commit: `3593e76e29399928b798b14aa79aa7295b360701`
- Last verified: `2026-06-04`
- Activity / maintenance status: low-signal but not abandoned at selection; the repository was pushed on `2025-09-01`, and the latest inspected commit only updated the README rather than advancing the runtime itself.

## Short Description

Compact Kotlin LWJGL/OpenGL engine-and-editor project with a node/component runtime, shader-backed mesh rendering, and an ImGui-based in-process editor shell.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `3d`, `opengl`, `scene-graph`, `shader`, `editor-tools`
- Engine / framework: custom Kotlin JVM engine with a node/component tree plus editor panels in the same process
- Rendering approach: LWJGL/OpenGL renderer with per-node shader components, mesh/texture/material components, and ImGui dockspace tooling
- Main language(s): Kotlin
- Android target: none in the checked-in runtime or build; useful only indirectly for engine/tooling patterns
- Build system: single-module Gradle Groovy DSL JVM app with generated constants, split engine/editor jars, and JDK `22` CI

## Why It Matters

- `glare` is useful as a compact reference for dependency-aware scene assembly, a small fixed-step engine loop, and an editor that runs inside the same process as the runtime.
- It is not strong enough to use as a primary baseline because the inspected revision is clearly unfinished in several core runtime paths.

## Reusable Ideas

- Gameplay ideas:
  - none directly; the main value is engine/editor structure rather than shipped gameplay systems
- Architecture patterns:
  - node/component assembly with dependency auto-wiring and queued child insertion
- Graphics / rendering techniques:
  - small shader-per-node OpenGL rendering path plus ImGui dockspace tooling inside the same frame loop
- Input / UI approaches:
  - direct GLFW polling split cleanly from script-level behaviors such as a freecam controller
- Performance or optimization ideas:
  - fixed-step accumulator around a simple update/render loop and separate engine/editor packaging from one small build

## Notable Implementations

- `Engine.kt` owns the runtime loop directly and flushes deferred node insertions before rendering.
- `Node.kt` auto-adds missing component dependencies and enforces tree ownership through the builder.
- `Renderer.kt`, `MeshRenderer.kt`, and `ShaderComponent.kt` show a small, readable OpenGL component-rendering path.
- `ImGuiRenderer.kt`, `ExplorerPanel.kt`, and `PropertiesPanel.kt` show an editor-in-runtime shell built on docked ImGui panels.
- `build.gradle` emits separate engine and editor jars and generates constants before compile.

## Android Relevance

- Native Android use:
  - no checked-in Android target
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - best mined for node/component assembly, editor embedding, and small-engine build ideas rather than reused as an Android runtime foundation

## Risks / Limitations

- `Physics.update()` is currently short-circuited, so the checked-in rigidbody/collision path is not a trustworthy baseline.
- The renderer only walks direct root children, which weakens the current scene-graph implementation.
- The README and examples are partially stale, and the visible test surface is demo-oriented rather than a real regression suite.
- The runtime is desktop LWJGL/OpenGL-first despite the broader wording in the repository description.

## Notes

This is worth keeping as a reference-only engine sample: small enough to read quickly, with a few useful ideas around node assembly, immediate-mode tooling, and build packaging, but not stable enough to promote into the lab's main engine shortlist.
