# Research Note

## Repository Snapshot

- Repository: `NiklasJohansen/PulseEngine`
- Source URL: [https://github.com/NiklasJohansen/PulseEngine](https://github.com/NiklasJohansen/PulseEngine)
- Owner: `NiklasJohansen`
- Batch ID: [`BATCH-2026-05-11-I`](../batches/BATCH-2026-05-11-I.md)
- Type: `engine-framework`
- License: `MIT`
- Selection date: `2026-05-11`
- Last pushed at selection: `2026-05-04`
- Stars at selection: `8`
- Investigated commit: `a285b8cda0aeaf6185d25905756836199463aeb1`
- Research status: `accepted`
- Build mode: `static-review + gradle-help + compile-dry-run-failed-missing-jdk23-toolchain`
- Catalog card: [catalog/projects/niklasjohansen-pulseengine.md](../../catalog/projects/niklasjohansen-pulseengine.md)

## Why This Repository Was Selected

- It was the strongest fresh carry-over candidate from the latest broader GitHub refresh after several Android-game-heavy batches.
- Even with low star count, it showed a wider engine/tooling surface than the remaining shortlist: scene runtime, retained UI, scene editor, hot reload, physics, networking, post-processing, and profiling hooks inside one Kotlin codebase.
- It added better architectural diversity than another small Android board or Compose sample would have added at this point in the catalog.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Kotlin JVM 2D engine with scene/entity systems and service-driven tooling
- Rendering stack: LWJGL + OpenGL + offscreen surfaces + post-processing pipeline + retained UI renderer
- Android target: indirect only; no Android module or mobile runtime path was found in the inspected repository
- Build system: Gradle Kotlin DSL with wrapper, Shadow JAR packaging, JMH benchmarks, and Maven publishing
- Repository layout summary: compact single-module Gradle repository with runtime/editor/testbed code in `src/main/kotlin`, microbenchmarks in `src/jmh/kotlin`, root build scripts, and a publish-oriented GitHub Actions workflow
- Key modules reviewed:
  - `src/main/kotlin/no/njoh/pulseengine/core/PulseEngineImpl.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/scene/SceneManagerImpl.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/graphics/GraphicsImpl.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/graphics/surface/SurfaceImpl.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/asset/AssetManagerImpl.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/data/DataImpl.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/input/InputImpl.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/service/ServiceManagerImpl.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/network/client/NetworkClientImpl.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/network/server/NetworkServerImpl.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/network/shared/NetworkCodec.kt`
  - `src/main/kotlin/no/njoh/pulseengine/core/shared/utils/FileWatcher.kt`
  - `src/main/kotlin/no/njoh/pulseengine/modules/editor/SceneEditor.kt`
  - `src/main/kotlin/no/njoh/pulseengine/modules/ui/UiElement.kt`
  - `src/main/kotlin/no/njoh/pulseengine/modules/ui/layout/docking/DockingPanel.kt`
  - `src/main/kotlin/no/njoh/pulseengine/modules/scene/systems/EntityRenderer.kt`
  - `src/main/kotlin/no/njoh/pulseengine/modules/lighting/global/GlobalIlluminationSystem.kt`
  - `src/main/kotlin/no/njoh/pulseengine/modules/physics/PhysicsSystem.kt`
  - `src/main/kotlin/no/njoh/pulseengine/modules/physics/ContactSolver.kt`
  - `src/main/kotlin/testbed/Testbed.kt`
  - `src/jmh/kotlin/benchmarks/BufferBenchmark.kt`
  - `src/jmh/kotlin/benchmarks/TextBuilderBenchmark.kt`

## Build And Runtime Notes

- The repository was inspected statically and with lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds in the lab and confirms the checked-in Gradle `8.13` wrapper.
- `cmd /c gradlew.bat help --no-daemon` succeeds, so the root build surface is readable and not broken at the metadata level.
- `cmd /c gradlew.bat compileKotlin --dry-run --no-daemon` fails because the repository requires `jvmToolchain(23)` while the lab machine still only exposes Java `8`.
- `cmd /c gradlew.bat jmh --dry-run --no-daemon` fails for the same reason: Gradle cannot resolve a matching Java `23` toolchain and no auto-download repository is configured.
- `.github/workflows/build-and-publish.yml` confirms upstream CI uses GraalVM JDK `23` and runs `publish`.
- No runtime launch was attempted.
- Known setup limitations:
  - local reproduction of actual compilation or benchmarks requires a real JDK `23`
  - the inspected runtime is desktop-first and depends on LWJGL/OpenGL native libraries rather than on any Android target
  - no normal `src/test` tree was found; the checked-in validation surface is JMH-oriented rather than unit-test-oriented

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - the repository is small in ecosystem signal, but the engine/runtime architecture is much denser than a typical hobby sample
  - its strongest value is not direct Android shipping, but transferable engine structure: service-oriented subsystems, retained UI, editor-as-runtime-service, multi-surface rendering, asset hot reload, and typed networking
  - the code is concentrated enough to study end-to-end without the scale cost of larger engines already in the lab

## Interesting Findings

### Engine Architecture And Core Loop

- `src/main/kotlin/no/njoh/pulseengine/core/PulseEngineImpl.kt` orchestrates the engine through explicit frame phases (`beginFrame -> update/fixedUpdate/render -> drawFrame -> endFrame`) and uses a `ThreadBarrier` to split simulation and rendering work without hiding the synchronization points.
- `src/main/kotlin/no/njoh/pulseengine/core/scene/SceneManagerImpl.kt` discovers scene entities and systems through reflection, supports asynchronous scene loading, and stages scene transitions with a fade overlay instead of treating scene changes as a special hard reset.
- `src/main/kotlin/no/njoh/pulseengine/core/service/ServiceManagerImpl.kt` treats editor, CLI, profiling, and other tooling as normal services and measures their update/fixed/render costs explicitly, which is a strong pattern for keeping engine tooling inside the same runtime model.
- `src/main/kotlin/testbed/Testbed.kt` mounts `SceneEditor`, `CommandLine`, `MetricViewer`, and `GpuMonitor` into a ready-made testbed shell, showing that the engine expects introspection and tools to run alongside gameplay rather than outside it.

### Rendering And Graphics

- `src/main/kotlin/no/njoh/pulseengine/core/graphics/GraphicsImpl.kt` builds rendering around named surfaces, cameras, texture banks, offscreen targets, post-effects, and a final composition pass instead of one monolithic sprite batch.
- `src/main/kotlin/no/njoh/pulseengine/core/graphics/surface/SurfaceImpl.kt` keeps renderers, batched draw state, and effect chains attached to each surface and can rebuild surface resources when texture or multisampling settings change.
- `src/main/kotlin/no/njoh/pulseengine/modules/scene/systems/EntityRenderer.kt` lets other systems register render passes targeted at named surfaces, which is a clean way to avoid hard-coding every render phase into the main graphics module.
- `src/main/kotlin/no/njoh/pulseengine/modules/lighting/global/GlobalIlluminationSystem.kt` pushes several lighting passes through dedicated surfaces/effects, giving the engine a surprisingly ambitious 2D GI/post-lighting pipeline for such a compact codebase.

### Gameplay Systems

- `src/main/kotlin/no/njoh/pulseengine/core/scene/SceneManagerImpl.kt` keeps scene and entity/system registration close to content loading, which makes the runtime feel more like a controllable game shell than a bare render demo.
- `src/main/kotlin/no/njoh/pulseengine/modules/physics/PhysicsSystem.kt` integrates fixed-step physics into the same service-driven scene runtime and also exposes mouse-picking and shape-debug rendering hooks useful for editor tooling.

### Input And Controls

- `src/main/kotlin/no/njoh/pulseengine/core/input/InputImpl.kt` centralizes GLFW keyboard, text, mouse, scroll, and gamepad callbacks, tracks clicked/pressed state per frame, and layers hover/current/previous focus areas on top of raw input state.
- `src/main/kotlin/no/njoh/pulseengine/core/input/InputImpl.kt` also owns cursor type/mode switching and clipboard access, keeping desktop-platform affordances inside the engine input service instead of scattering them through UI code.

### UI, HUD, And Menus

- `src/main/kotlin/no/njoh/pulseengine/modules/ui/UiElement.kt` implements a retained UI tree with layout dirtiness propagation, min/max sizing, parent-constrained focus areas, popup second-pass updates, and scroll bubbling, which is much closer to a miniature UI toolkit than to ad hoc HUD drawing.
- `src/main/kotlin/no/njoh/pulseengine/modules/ui/layout/docking/DockingPanel.kt` reuses those UI primitives to provide editor-style docking, split insertion, resizer panels, and drag-out/flyback behavior for tool windows.
- `src/main/kotlin/no/njoh/pulseengine/modules/editor/SceneEditor.kt` is implemented as a normal service that creates its own render surfaces, menu bar, docking layout, outliner, inspector, system-properties view, scene viewport, and persisted layout file.

### Physics And Collision

- `src/main/kotlin/no/njoh/pulseengine/modules/physics/PhysicsSystem.kt` keeps physics deterministic around fixed updates and can render debug geometry or support editor picking without creating a separate debug runtime.
- `src/main/kotlin/no/njoh/pulseengine/modules/physics/ContactSolver.kt` contains custom collision resolution for polygon, point, circle, and line combinations with friction, restitution, and rotational response instead of delegating all contact behavior to an external physics library.

### Tooling, Android Integration, Or Other Notable Areas

- `src/main/kotlin/no/njoh/pulseengine/core/asset/AssetManagerImpl.kt` stages concurrent asset load/unload/reload queues and lets runtime callbacks upload newly loaded textures, shaders, sounds, and cursors directly into the live subsystems.
- `src/main/kotlin/no/njoh/pulseengine/core/shared/utils/FileWatcher.kt` provides a polling-based file watcher that supports the engine's hot-reload workflow without assuming a more complex IDE-only integration path.
- `src/main/kotlin/no/njoh/pulseengine/core/data/DataImpl.kt` separates JSON/BSON save-load and async persistence from gameplay logic, while also tracking simple data-operation metrics.
- `src/main/kotlin/no/njoh/pulseengine/core/network/client/NetworkClientImpl.kt`, `src/main/kotlin/no/njoh/pulseengine/core/network/server/NetworkServerImpl.kt`, and `src/main/kotlin/no/njoh/pulseengine/core/network/shared/NetworkCodec.kt` form a typed TCP/UDP stack with Kryo-based serialization, sealed-type registration expansion, queue backpressure warnings, handshake echo over UDP, ping tracking, and connection-loss detection.
- `src/jmh/kotlin/benchmarks/BufferBenchmark.kt` and `src/jmh/kotlin/benchmarks/TextBuilderBenchmark.kt` show that the repository benchmarks low-level runtime primitives such as flat object buffers and custom text building, not only top-level game behavior.

## Reusable Takeaways

- Treat editor panels, debug tools, profiling, and console features as normal runtime services instead of maintaining a parallel tools-only architecture.
- A 2D engine can stay flexible if rendering is built around named surfaces and pass injection rather than one global draw phase.
- Retained UI with dirty-layout propagation and popup second passes can stay compact enough to live inside a game engine while still supporting editor-grade docking workflows.
- Staged asset reload queues plus a lightweight file watcher are a practical middle ground between no hot reload and a much heavier live-authoring stack.
- Typed networking with explicit reliable/unreliable channels and dynamic sealed-type registration can remain understandable when kept inside a narrow codec/transport boundary.

## Evidence Summary

- `src/main/kotlin/no/njoh/pulseengine/core/PulseEngineImpl.kt` - engine lifecycle and multithreaded frame loop
- `src/main/kotlin/no/njoh/pulseengine/core/scene/SceneManagerImpl.kt` - scene/entity/system registration, async scene load, transitions
- `src/main/kotlin/no/njoh/pulseengine/core/service/ServiceManagerImpl.kt` - service runtime and metrics
- `src/main/kotlin/no/njoh/pulseengine/core/graphics/GraphicsImpl.kt` - surface/camera/post-process orchestration
- `src/main/kotlin/no/njoh/pulseengine/core/graphics/surface/SurfaceImpl.kt` - per-surface state/effect management
- `src/main/kotlin/no/njoh/pulseengine/modules/scene/systems/EntityRenderer.kt` - render-pass injection
- `src/main/kotlin/no/njoh/pulseengine/modules/lighting/global/GlobalIlluminationSystem.kt` - lighting/GI pipeline
- `src/main/kotlin/no/njoh/pulseengine/core/input/InputImpl.kt` - input focus, cursor, clipboard, gamepad handling
- `src/main/kotlin/no/njoh/pulseengine/modules/ui/UiElement.kt` - retained UI tree and layout system
- `src/main/kotlin/no/njoh/pulseengine/modules/ui/layout/docking/DockingPanel.kt` - dockable tool-window layout
- `src/main/kotlin/no/njoh/pulseengine/modules/editor/SceneEditor.kt` - editor-as-service shell
- `src/main/kotlin/no/njoh/pulseengine/modules/physics/PhysicsSystem.kt` - fixed-step physics integration
- `src/main/kotlin/no/njoh/pulseengine/modules/physics/ContactSolver.kt` - custom collision resolution
- `src/main/kotlin/no/njoh/pulseengine/core/asset/AssetManagerImpl.kt` - staged asset loading/reloading
- `src/main/kotlin/no/njoh/pulseengine/core/data/DataImpl.kt` - async persistence and JSON/BSON save flow
- `src/main/kotlin/no/njoh/pulseengine/core/network/shared/NetworkCodec.kt` - typed Kryo codec
- `src/main/kotlin/no/njoh/pulseengine/core/network/client/NetworkClientImpl.kt` and `src/main/kotlin/no/njoh/pulseengine/core/network/server/NetworkServerImpl.kt` - TCP/UDP networking runtime
- `src/jmh/kotlin/benchmarks/BufferBenchmark.kt` and `src/jmh/kotlin/benchmarks/TextBuilderBenchmark.kt` - benchmark validation surface
- `build.gradle.kts` and `.github/workflows/build-and-publish.yml` - JDK `23` toolchain, wrapper build, publish workflow

## Risks Or Limits

- The repository is explicitly desktop-first; no direct Android target or mobile platform layer was found.
- `README.md` states the engine is a hobby project and not production-ready, so its patterns should be treated as references rather than as proven shipping guidance.
- Local compilation currently requires JDK `23`, while the lab machine still only exposes Java `8`.
- Ecosystem signal is weak at the moment because the repository has very low star count.
- No normal `src/test` tree was found, so confidence comes from static review plus build-surface inspection and JMH microbenchmarks rather than from a broad unit/integration test suite.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `scene-graph`, `opengl`, `shader`, `physics`, `networking`, `editor-tools`, `performance`
- Follow-up needed:
  - if the lab revisits this repository later, rerun compile/JMH discovery under a real JDK `23` environment and compare the editor/runtime split against other compact Kotlin engines rather than reopening the whole repo blindly
