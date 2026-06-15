# Zernikalos/Zernikalos

- Repository: [Zernikalos/Zernikalos](https://github.com/Zernikalos/Zernikalos)
- Repository type: `engine-framework`
- Final status: `accepted`
- Reviewed on: `2026-06-15`
- License: `MPL-2.0`
- Stars at review: `2`
- Last pushed at review: `2026-06-10`
- Default branch: `main`
- Investigated commit: `269a57b5de33d509c9d1eb5e8e8baa1dcbb7ac12`
- Build mode: `static-review + gradle-version + gradle-help-failed-java8-needs-java17`

## What This Repository Is

`Zernikalos` is a Kotlin-first multiplatform 3D engine aimed at Android, Apple, and Web targets from a shared scene and rendering core.

The repository is not just a promise-heavy shell. The checked-in tree already includes:

- a real `commonMain` scene/model/material/math core
- platform-specific Android/OpenGL, Apple/Metal, and Web/WebGPU actual implementations
- explicit surface and initialization abstractions
- serialization and loader infrastructure
- a small but meaningful common test surface
- architecture notes for initialization, disposal, uniforms, textures, materials, and lighting

## Why It Is Interesting For The Lab

- It is one of the clearest current examples in the lab of a Kotlin-first engine that keeps Android as a first-class platform instead of as a later adapter.
- The engine separates scene state, rendering context, platform view, and lifecycle callbacks more deliberately than many hobby engines.
- The repository preserves useful Android-transfer patterns even where the runtime is still experimental, especially around `GLSurfaceView` ownership, queued input processing, and explicit initialization/disposal sequencing.

## Architecture Snapshot

### 1. Common engine shell with platform-specific entry points

- `engine/src/commonMain/kotlin/zernikalos/ZernikalosBase.kt` is the shared engine shell: it owns the attached `ZSurfaceView`, the unified `ZContext`, settings, stats, and event-handler wiring.
- Platform-specific `Zernikalos` classes such as `engine/src/androidMain/.../Zernikalos.kt` adapt native views into the common engine flow and delegate context creation to a `ZContextCreator`.
- This gives the repo a strong engine-host split: platform view setup happens locally, while lifecycle coordination stays shared.

### 2. Explicit initialization state machine

- `engine/src/commonMain/kotlin/zernikalos/statehandler/ZCreateSurfaceViewEventHandler.kt` implements a small init state machine with `NOT_STARTED`, `SCENE_INIT`, `RENDERER_INIT`, `READY`, and `DISPOSED`.
- `ZSceneStateHandler` exposes callback-driven `onReady`, `onResize`, `onUpdate`, and `onRender`, so scene startup work can be sequenced before rendering starts.
- Pending resize and queued render handling are explicit, which is stronger than the common "do everything immediately inside the native renderer callback" approach.

### 3. Unified context and scene graph

- `ZContext` splits scene state and rendering state into `ZSceneContext` and `ZRenderingContext`, while also owning `eventQueue`, `input`, active scene, and active camera.
- `ZObject` provides the scene tree with transform, enable/visible flags, child hierarchy, recursive initialization, recursive rendering, resize propagation, and recursive disposal.
- `ZScene` keeps viewport ownership local to the scene and injects default camera/light composition through `defaultScene()`.

### 4. Backend-specific actuals over shared rendering contracts

- `ZRenderer` is an `expect`/`actual` renderer family, with OpenGL, Metal, and WebGPU actuals.
- The OpenGL renderer path is intentionally thin in `ZRenderer.ogl.kt`: it forwards rendering into the scene graph and keeps backend specifics deeper in component renderers.
- `ZModel` shows the intended flow clearly: build shader parameters from mesh/material/skeleton state, generate shaders, enable only required buffers, initialize mesh/material/shader resources, then render through a backend-specific model renderer.

### 5. Asset and scene serialization pipeline

- `engine/src/commonMain/kotlin/zernikalos/loader/ZkoLoader.kt` defines a protobuf-driven loader path for serializing and reconstructing `ZObject` hierarchies plus skeletal actions.
- The loader is one of the stronger reasons to keep this repository: it is not only a renderer shell, but an engine trying to preserve import/bundle/runtime asset flow.
- README and docs claim import from GLB/glTF/FBX/OBJ, while the checked-in runtime side we verified is the serialized `ZKo` loading seam.

### 6. Lifecycle and disposal are treated as architecture, not cleanup trivia

- `docs/architecture/dispose-lifecycle.md` documents ownership-driven deterministic disposal across OpenGL ES, Metal, and WebGPU.
- `ZComponentLifecycleTest.kt` verifies pre-init dispose, one-time renderer disposal, cleanup when component disposal fails, and partially initialized renderer teardown.
- That lifecycle focus is unusually valuable for Android and mobile engine work, where context loss and teardown mistakes tend to be expensive.

## Reusable Technical Ideas

- common engine shell over platform-specific surface adapters
- callback-driven init state machine before renderer activation
- scene-context vs rendering-context split inside one unified runtime context
- queued input event processing during frame updates instead of mutating input state directly from native callbacks
- recursive scene graph lifecycle with viewport resize propagation
- data-driven shader-parameter assembly from mesh/material/skeleton traits
- protobuf-backed serialized scene/object hierarchy loading
- documented and tested deterministic disposal lifecycle for render components

## Android Relevance

Android relevance is **direct**.

Why it matters:

- the repository includes a real `androidMain` path, not only future intent
- Android uses `GLSurfaceView` and explicit touch-event conversion into the shared event queue
- the engine treats Android as a first-class multiplatform backend rather than as a documentation-only target

Why it is still not a drop-in production baseline:

- the repo is still framed as experimental/prototyping-oriented
- the visible Android rendering path is a custom engine foundation, not a full shipped game stack
- many broader product-level systems are intentionally outside scope

## Build And Verification Notes

- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.4.1`.
- `cmd /c gradlew.bat help --no-daemon` fails in the lab because Gradle now requires Java `17+` while the current machine still exposes Java `8`.
- `gradle/libs.versions.toml` shows a modern toolchain surface: Kotlin `2.4.0`, Android Gradle Plugin `9.2.0`, compile SDK `36`, min SDK `24`, Dokka `2.2.0`, and current coroutine/serialization versions.
- The visible automated test surface is not huge, but it is meaningful: around `14` common tests covering math, transforms, angles, skeletal animation, perspective-lens degree helpers, and component lifecycle/disposal.

## Risks And Caveats

- Public ecosystem signal is still very low at the time of research.
- The runtime looks real, but still clearly experimental and evolving.
- The OpenGL top-level renderer is intentionally thin, so understanding the actual rendering depth requires following component renderers rather than only one central render loop.
- `buildLogic` includes release automation and shell-driven release tasks that add workflow complexity beyond the core engine itself.

## Verdict

Keep `Zernikalos/Zernikalos` as `accepted`.

It is a strong engine-framework reference for the lab because it combines direct Android relevance, a serious multiplatform architecture split, explicit lifecycle/disposal thinking, real loader and scene infrastructure, and a cleaner-than-usual initialization model for a young Kotlin 3D engine.
