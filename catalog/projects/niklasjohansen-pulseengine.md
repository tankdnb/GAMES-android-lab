# Project Entry

## Basic Info

- Project name: `PulseEngine`
- Source repository: [https://github.com/NiklasJohansen/PulseEngine](https://github.com/NiklasJohansen/PulseEngine)
- Author / organization: `NiklasJohansen`
- License: `MIT`
- Research note: [research/findings/niklasjohansen-pulseengine.md](../../research/findings/niklasjohansen-pulseengine.md)
- Investigated commit: `a285b8cda0aeaf6185d25905756836199463aeb1`
- Last verified: `2026-05-11`
- Activity / maintenance status: last push recorded at selection on `2026-05-04`.

## Short Description

Compact Kotlin JVM 2D engine built on LWJGL/OpenGL, with a multithreaded frame loop, retained UI toolkit, dockable in-engine scene editor, staged asset reload, physics, and typed TCP/UDP networking.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `scene-graph`, `opengl`, `shader`, `physics`, `networking`, `editor-tools`, `performance`
- Engine / framework: custom Kotlin JVM engine with scene/entity systems and service-driven tooling
- Rendering approach: named render surfaces, offscreen composition, injected render passes, post-processing, and editor/UI surfaces inside one LWJGL/OpenGL runtime
- Main language(s): Kotlin
- Android target: indirect only; no Android module or platform layer was found in the inspected repository
- Build system: Gradle Kotlin DSL with wrapper, Shadow JAR packaging, JMH benchmarks, and JDK `23` toolchain requirement

## Why It Matters

- It is one of the clearest compact-engine references in the lab for how to keep runtime, editor, retained UI, networking, persistence, and profiling inside one coherent Kotlin architecture.
- Even without a direct Android target, many patterns transfer well to Android-oriented internal engines or gameplay tooling: service-owned subsystems, surface-based rendering, asset hot reload, retained layout/focus handling, and typed network channels.

## Reusable Ideas

- Gameplay ideas:
  - testbed pattern where gameplay, editor, console, metrics, and profiling services can be mounted into the same runtime shell
- Architecture patterns:
  - explicit frame phases, service-level metrics, reflection-backed scene registration, staged asset load/unload/reload, and retained UI with popup/layout passes
- Graphics / rendering techniques:
  - named multi-surface rendering, injected render passes, offscreen post-processing, and compact 2D GI-oriented lighting surfaces
- Input / UI approaches:
  - focus-stack input service, cursor/clipboard ownership inside the engine, and dockable editor panels built from the same retained UI primitives
- Performance or optimization ideas:
  - multithreaded barrier loop, per-service timing, engine-internal microbenchmarks, and custom flat-buffer data structures

## Notable Implementations

- `PulseEngineImpl` separates `beginFrame`, `update`, `fixedUpdate`, `render`, `drawFrame`, and `endFrame` with explicit barrier synchronization.
- `GraphicsImpl`, `SurfaceImpl`, and `EntityRenderer` form a clean surface/pass-based rendering stack.
- `SceneEditor`, `UiElement`, and `DockingPanel` show an editor-grade retained UI/tooling layer built into the engine runtime.
- `PhysicsSystem` and `ContactSolver` provide custom fixed-step collision/response logic without depending on an external full physics stack.
- `AssetManagerImpl`, `FileWatcher`, `DataImpl`, and the Kryo-based networking classes add hot reload, persistence, and multiplayer-oriented runtime services.

## Android Relevance

- Native Android use:
  - indirect
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - strongest reuse is architectural rather than platform-specific; no direct Android backend was found, but the runtime/editor/service patterns can inform Android-facing engines, tools, or debug shells

## Risks / Limitations

- The README explicitly frames the engine as a hobby, non-production-ready project.
- The repository is desktop/LWJGL-first and currently requires JDK `23` for real compilation.
- No normal `src/test` tree was found; checked-in validation is benchmark-oriented rather than full unit/integration coverage.
- Ecosystem signal is still low compared with more established engines in the catalog.

## Notes

This is a strong small-engine architecture reference for the lab, especially when the goal is to study compact but ambitious runtime/tooling integration rather than direct Android packaging.
