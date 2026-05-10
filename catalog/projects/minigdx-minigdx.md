# Project Entry

## Basic Info

- Project name: `miniGDX`
- Source repository: [https://github.com/minigdx/minigdx](https://github.com/minigdx/minigdx)
- Author / organization: `minigdx`
- License: `MIT`
- Research note: [research/findings/minigdx-minigdx.md](../../research/findings/minigdx-minigdx.md)
- Investigated commit: `494b3929176b773dac5226a601e4f26dbcbb3cbe`
- Last verified: `2026-05-11`
- Activity / maintenance status: last push recorded at selection on `2022-10-10`; repository still reads as a real engine framework, but not an actively updated one.

## Short Description

Small Kotlin Multiplatform game engine/framework with direct Android, JVM, and JS targets, combining ECS-style runtime composition, custom OpenGL/WebGL rendering, scene import, collision helpers, and coroutine-based scripting.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `3d`, `android`, `multiplatform`, `ecs`, `collision`, `input`, `shader`, `testing`
- Engine / framework: `miniGDX`
- Rendering approach: custom OpenGL/WebGL renderer with shader stages, framebuffer graph support, mesh/sprite rendering, and transparent back-to-front ordering
- Main language(s): Kotlin
- Android target: direct Android engine path through `MiniGdxActivity`, `GLSurfaceView`, Android GL/input/file adapters, and asset-backed sound loading
- Build system: Gradle Kotlin DSL Kotlin Multiplatform library

## Why It Matters

- It is one of the more direct Kotlin engine references in the lab for a shared Android/JVM/JS runtime, not just a sample game or utility library.
- The repository is especially useful for studying how a relatively compact engine can expose framebuffer pipelines, content import, platform-neutral input, coroutine scripting, and Android runtime bootstrapping without a huge monorepo.

## Reusable Ideas

- Gameplay ideas:
  - storyboard-style nested game switching and coroutine-based script helpers for lightweight cutscenes or modal flows
- Architecture patterns:
  - staged engine bootstrap, queued ECS mutations, scene-to-ECS conversion, and typed asset caching with delayed `onLoad` hooks
- Graphics / rendering techniques:
  - dependency-aware framebuffer graph, fullscreen post-process quad stage, and transparent primitive sorting relative to camera direction
- Input / UI approaches:
  - shared touch/key state model across Android, desktop, and web plus aspect-safe device-to-game coordinate conversion
- Performance or optimization ideas:
  - pooled internal input events, broad-phase sphere gate before SAT checks, and deferred asset/system startup order

## Notable Implementations

- `GameNode` turns render stages and framebuffers into a staged bootstrap pipeline instead of a single hardwired renderer.
- `FrameBuffer` and `TextureFrameBuffer` model post-processing as dependency-aware systems that can render to textures or directly to screen.
- `EntityFactoryDelegate` imports scene graphs into ECS entities and generates sprite UVs after texture load completion.
- `ScriptExecutorSystem` runs one coroutine per `ScriptComponent` and provides yield/event/main-thread helpers through `ScriptContext`.
- `TouchManager`, `LwjglInput`, and the viewport strategy create one portable input abstraction for Android touch, web touch, and desktop mouse/keyboard flows.
- The `commonTest` tree covers engine updates, input semantics, viewport conversion, render-stage camera behavior, and collision math.

## Android Relevance

- Native Android use:
  - yes; the repository includes Android-specific runtime, GL, input, and file-loading code rather than relying on desktop-first shims only
- Kotlin relevance:
  - high, because the engine contract, ECS, scripting, rendering, and Android adapters are all Kotlin-first
- Porting or adaptation notes:
  - the engine is directly relevant as an Android runtime reference, but the inspected revision should be treated carefully because it is old, uses snapshot dependencies, and shows likely multitouch issues in the Android adapter

## Risks / Limitations

- Stale maintenance status relative to fresher engine options.
- Several dependencies use `LATEST-SNAPSHOT`, which weakens reproducibility.
- Local build validation was blocked because the lab machine has no full JDK/compiler.
- Android multitouch handling appears fragile in the inspected adapter.
- Coroutine helper `moveOf()` appears to compute movement speed incorrectly for non-unit distances.

## Notes

This repository is especially valuable when the lab wants examples of direct Android engine bootstrapping and shared KMP runtime architecture, not only gameplay code. It pairs well with the already researched `minigdx/tiny` note because `miniGDX` explains the lower-level runtime and rendering seams that the higher-level `tiny` toolchain builds upon.
