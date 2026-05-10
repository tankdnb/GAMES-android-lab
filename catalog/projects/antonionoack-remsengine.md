# Project Entry

## Basic Info

- Project name: `RemsEngine`
- Source repository: [https://github.com/AntonioNoack/RemsEngine](https://github.com/AntonioNoack/RemsEngine)
- Author / organization: `AntonioNoack`
- License: `Apache-2.0`
- Research note: [research/findings/antonionoack-remsengine.md](../../research/findings/antonionoack-remsengine.md)
- Investigated commit: `7e5449b300e213ae223e71d542a4306d2f5c85f4`
- Last verified: `2026-05-10`

## Short Description

Large Kotlin JVM game engine and editor workspace with extension-loaded modules for physics, rendering, export, VR, scripting, and asset handling, plus a very large sample/test corpus.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `3d`, `ecs`, `opengl`, `physics`, `editor-tools`, `asset-pipeline`, `performance`
- Engine / framework: custom Kotlin engine with LWJGL/OpenGL runtime and extension-loaded capability modules
- Rendering approach: editor-first multi-window OpenGL runtime with render-step orchestration and graph-driven post-processing
- Main language(s): Kotlin
- Android target: indirect; the reviewed repo is JVM-first, but it explicitly models Android-style UI patterns and documents Android-related port/export paths outside the core repo
- Build system: IntelliJ IDEA module workspace rather than a standard root Gradle/Maven build

## Why It Matters

- It is one of the broadest architecture references in the lab for how a Kotlin engine can unify editor tooling, runtime systems, files, caches, and optional modules.
- The engine is valuable less as a ready Android solution and more as a source of reusable patterns for internal engines, tools, editors, and asset-heavy game workflows.

## Reusable Ideas

- Gameplay ideas:
  - sample-game approach where features are exercised through small runnable scenarios inside the engine workspace
- Architecture patterns:
  - extension-loaded official modules, scene hierarchy plus systems, unified file abstraction, async expiring caches
- Graphics / rendering techniques:
  - graph-driven rendering pipeline plus explicit idle-aware multi-window render loop
- Input / UI approaches:
  - Android-inspired weighted UI layouts reused for editor, inspectors, exporters, and scene tooling
- Performance or optimization ideas:
  - cache expiry, background generation, and idle rendering throttling without forcing coroutine-heavy infrastructure

## Notable Implementations

- `EngineBase` and `WindowManagement` separate lifecycle, window updates, and rendering work.
- `OfficialExtensions` loads optional capabilities from extension descriptors instead of hardwiring every subsystem.
- `Entity` and `Systems` bridge hierarchical scene editing with system-driven runtime behavior.
- `FileReference` and `CacheSection` form a strong tooling backbone for complex asset workflows.
- `BulletPhysics`, `ExportMenu`, and `OpenXR` show how optional subsystems plug into the shared engine shell.

## Android Relevance

- Native Android use:
  - indirect
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - strongest reuse is for engine architecture, tools, and asset/runtime organization rather than for drop-in Android delivery

## Risks / Limitations

- The repository is harder to build reproducibly than a standard Gradle repo.
- Android support is not self-contained in the inspected workspace.
- Some features are explicitly experimental or WIP.

## Notes

This is a strong engine-architecture reference for the lab, especially when studying modular runtime/tool design rather than mobile shipping polish.
