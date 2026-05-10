# Project Entry

## Basic Info

- Project name: `Tiny Game Engine`
- Source repository: [https://github.com/minigdx/tiny](https://github.com/minigdx/tiny)
- Author / organization: `minigdx`
- License: `MIT`
- Research note: [research/findings/minigdx-tiny.md](../../research/findings/minigdx-tiny.md)
- Investigated commit: `4d40cb5aa3ae8e53f90d3823dd812965090455f9`
- Last verified: `2026-05-10`

## Short Description

Compact Kotlin Multiplatform 2D engine that hosts Lua gameplay scripts and bundles its own browser editor, debugger, export pipeline, and generated script documentation.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `multiplatform`, `input`, `audio`, `editor-tools`, `asset-pipeline`
- Engine / framework: Tiny Game Engine
- Rendering approach: custom palette-index 2D framebuffer over KGL, with LWJGL/OpenGL on JVM and WebGL on web
- Main language(s): Kotlin, Lua
- Android target: no direct Android target found on the inspected revision
- Build system: Gradle Kotlin DSL monorepo

## Why It Matters

- It is a strong reference for how a small engine can keep runtime, hot reload, debugger, editor, export tooling, and docs generation in one coherent codebase.
- Even without Android support, its KMP runtime boundaries, virtual input model, content configuration, and iteration workflow are portable into Android-oriented internal tools or lightweight engines.

## Reusable Ideas

- Gameplay ideas:
  - multi-script scene flow with boot-script transitions and LDtk-backed data access
- Architecture patterns:
  - state-preserving script reload and deterministic resource boot ordering
- Graphics / rendering techniques:
  - palette-index framebuffer, texture batching, stencil draw modes, and cached readback
- Input / UI approaches:
  - unified touch/key abstraction plus same-runtime browser editor and debugger control
- Performance or optimization ideas:
  - clip/camera culling, pooled input events, profiler surfacing, and lightweight audio mixing safeguards

## Notable Implementations

- `GameEngine` keeps a fixed-step loop with resource-event processing, reload flow, GIF/screenshot capture, and profiler toggles.
- `GameResourceProcessor` and `GameScript` manage concurrent resource loading, Lua validation, and state handoff across reloads.
- `DefaultVirtualFrameBuffer` handles batching, stencil-based draw modes, cached frame reads, and palette-index rendering.
- `MapLib` bridges LDtk levels, entities, and flags into Lua.
- `RunCommand` exposes a debugger web app, live file watching, and remote key-control endpoints.
- `ExportCommand` packages web and desktop builds with safe path resolution and asset inclusion.

## Android Relevance

- Native Android use:
  - none verified on the inspected revision
- Kotlin relevance:
  - high, because the runtime, tooling, and platform abstractions are Kotlin-first
- Porting or adaptation notes:
  - best reused today as an architecture and workflow reference, especially for hot reload, scripting hosts, browser tooling, and compact content pipelines rather than as a direct Android runtime

## Risks / Limitations

- No Android target was found.
- Lua-first gameplay scripting reduces direct Kotlin gameplay reuse.
- Hot reload is polling-based rather than event-driven.
- Build validation was limited because the local environment lacked a full JDK.

## Notes

This repository is especially useful as a reference for keeping research, documentation, tooling, and runtime close together instead of scattering them across separate repos or ad hoc scripts.
