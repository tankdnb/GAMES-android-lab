# Research Note

## Repository Snapshot

- Repository: `zeganstyl/thelema-engine`
- Source URL: [https://github.com/zeganstyl/thelema-engine](https://github.com/zeganstyl/thelema-engine)
- Owner: `zeganstyl`
- Batch ID: [`BATCH-2026-05-11-D`](../batches/BATCH-2026-05-11-D.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2022-12-21`
- Stars at selection: `83`
- Investigated commit: `8e2943b6d2de3376ce338025b58ff31c14097caf`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/zeganstyl-thelema-engine.md](../../catalog/projects/zeganstyl-thelema-engine.md)

## Why This Repository Was Selected

- The refreshed `updated` searches were still dominated by very fresh but near-zero-signal repositories, so the strongest remaining option was a backlog repository with more substantial engine depth.
- `thelema-engine` stood out because it combines Kotlin Multiplatform, a direct Android source set, a 3D renderer, shader-node tooling, glTF 2.0 loading, physics bindings, and a separate studio/editor module under a permissive license.
- Even though the repository is stale, it still fills a gap in the lab: a Kotlin-first 3D engine reference with more rendering and asset-pipeline depth than the remaining gameplay-only backlog.

## Technical Profile

- Main language(s): Kotlin, plus embedded GLSL shader code and small native interop definitions for platform bindings
- Engine / framework: custom Thelema engine, described by the repository as redesigned from libGDX sources
- Rendering stack: custom KMP GL abstraction, scene/entity-component tree, shader-node graph generation, forward post-processing pipeline, deferred/G-buffer hooks, PBR shading, IBL baking, glTF 2.0 import, and ODE-based JVM physics integration
- Android target: direct Android target exists in `androidMain`, root `com.android.library` configuration, and the `tests` application module; the repository also includes a custom `GLSurfaceView`-based `AndroidApp`
- Build system: Gradle Kotlin DSL monorepo with Kotlin Multiplatform, Android Gradle Plugin, `buildSrc` version constants, a `tests` app module, and a separate `thelema-studio` JVM module
- Repository layout summary: the core engine lives in root `src/` across `commonMain`, `jvmCommonMain`, `androidMain`, `jsMain`, and `linuxX64Main`; `tests/` is a sample/testbed application matrix; `thelema-studio/` is a reusable desktop editor shell; `buildSrc/` holds shared version/dependency definitions
- Key modules reviewed:
  - `README.md`
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `gradle.properties`
  - `gradle/wrapper/gradle-wrapper.properties`
  - `buildSrc/src/main/kotlin/versions.kt`
  - `tests/build.gradle.kts`
  - `thelema-studio/build.gradle.kts`
  - `src/commonMain/kotlin/app/thelema/ecs/ECS.kt`
  - `src/commonMain/kotlin/app/thelema/ecs/Entity.kt`
  - `src/commonMain/kotlin/app/thelema/ecs/MainLoop.kt`
  - `src/commonMain/kotlin/app/thelema/ecs/EntityLoader.kt`
  - `src/commonMain/kotlin/app/thelema/g3d/scene.kt`
  - `src/commonMain/kotlin/app/thelema/g3d/sceneInstance.kt`
  - `src/commonMain/kotlin/app/thelema/g3d/IBLMapBaker.kt`
  - `src/commonMain/kotlin/app/thelema/gltf/GLTF.kt`
  - `src/commonMain/kotlin/app/thelema/gltf/GLTFSceneInstance.kt`
  - `src/commonMain/kotlin/app/thelema/gltf/GLTFSettings.kt`
  - `src/commonMain/kotlin/app/thelema/res/Project.kt`
  - `src/commonMain/kotlin/app/thelema/res/Loader.kt`
  - `src/commonMain/kotlin/app/thelema/shader/PBRShader.kt`
  - `src/commonMain/kotlin/app/thelema/shader/ForwardRenderingPipeline.kt`
  - `src/commonMain/kotlin/app/thelema/shader/node/PBRNode.kt`
  - `src/commonMain/kotlin/app/thelema/shader/node/GBufferOutputNode.kt`
  - `src/androidMain/kotlin/app/thelema/android/AndroidApp.kt`
  - `src/androidMain/kotlin/app/thelema/android/AndroidTouch.kt`
  - `src/androidMain/kotlin/app/thelema/android/AndroidMouse.kt`
  - `src/androidMain/kotlin/app/thelema/android/AndroidFS.kt`
  - `src/jvmCommonMain/kotlin/app/thelema/jvm/ode/RigidBodyPhysicsWorld.kt`
  - `src/commonTest/kotlin/app.thelema.ecs/FileTest.kt`
  - `src/commonTest/kotlin/app.thelema.ecs/EntityPaths.kt`

## Build And Runtime Notes

- The repository was investigated primarily through static code review plus lightweight Gradle discovery.
- `java -version` reports `1.8.0_321` in the lab environment.
- `cmd /c gradlew.bat help --no-daemon` bootstraps Gradle `7.3`, but fails at `:buildSrc:compileKotlin` because Kotlin cannot find JDK compiler tools in the current Java installation; the environment exposes a JRE, not a full JDK.
- The inspected build surface is from a 2021-2022 era stack: Gradle `7.3`, Android Gradle Plugin `7.0.0`, Kotlin `1.6.20-RC`, Ktor `1.6.7`, and LWJGL `3.3.0`.
- `commonTest` exists but is very small and covers file/path utilities rather than rendering, asset loading, Android, or physics behavior.
- The separate `tests` module is a multiplatform application/testbed rather than a strong automated verification surface.
- Known setup limitations:
  - a full JDK is required even for basic Gradle discovery in this lab
  - no runtime launch was attempted
  - the repository is stale enough that successful modern build verification should not be assumed from the presence of Gradle files alone

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - it is one of the more complete Kotlin-first 3D engine references in the lab, combining renderer architecture, asset loading, shader generation, Android platform glue, physics, and editor-facing metadata
  - it offers direct Android relevance through an actual `androidMain` platform layer instead of only indirect theoretical portability
  - even though the repository is stale, the architectural ideas remain reusable for future Android/Kotlin engine work, especially around scene composition, GL-thread-safe loading, shader graphs, and thin platform adapters

## Interesting Findings

### Engine Architecture And Core Loop

- `src/commonMain/kotlin/app/thelema/ecs/Entity.kt` implements a hierarchical entity tree with typed components, JSON serialization, path-based addressing, and branch-level notifications for entity/component additions and removals. It is a useful middle ground between a scene graph and a stricter data-only ECS.
- `src/commonMain/kotlin/app/thelema/ecs/ECS.kt` registers component descriptors, aliases, enums, references, and property metadata centrally. That descriptor registry makes serialization, editor tooling, and prefab-like authoring possible without hand-writing custom inspectors for each component.
- `src/commonMain/kotlin/app/thelema/res/Project.kt`, `Loader.kt`, and `EntityLoader.kt` form a reusable resource graph: loaders are monitored centrally, optionally run on separate threads, can request GL-thread work, and only start scene simulation after the main scene finishes loading.
- `src/commonMain/kotlin/app/thelema/g3d/sceneInstance.kt` provides a prefab-style scene instancing mechanism by copying a source entity tree into a local instance and then mirroring later branch changes through `EntityListener`s. That is a notable reuse pattern for editor-authored scene classes or glTF-instanced content.
- `src/commonMain/kotlin/app/thelema/gltf/GLTF.kt` combines off-thread parsing with a queued GL-call model. It parses glTF/GLB structures first, then defers GPU-bound work through `runGLCall()` so resource loading can overlap with background work without violating render-thread constraints.

### Rendering And Graphics

- `src/commonMain/kotlin/app/thelema/g3d/scene.kt` gathers renderables and lights from the entity branch, uploads one scene uniform buffer per frame, optionally frustum-culls renderables, and separates opaque/masked/translucent draw paths before invoking a pluggable rendering pipeline.
- `src/commonMain/kotlin/app/thelema/shader/PBRShader.kt` and `shader/node/PBRNode.kt` build glTF-oriented PBR shaders from reusable nodes instead of fixed monolithic shader strings. The engine wires together texture nodes, normal mapping, metallic/roughness/occlusion packing, cascaded shadows, and optional IBL.
- `src/commonMain/kotlin/app/thelema/shader/node/GBufferOutputNode.kt` shows that the shader-node system is not only for forward shading; it can also emit a deferred-style G-buffer path with color, normal, and position targets while preserving alpha/cull-face configuration at the node level.
- `src/commonMain/kotlin/app/thelema/g3d/IBLMapBaker.kt` performs in-engine environment preprocessing: irradiance convolution, specular prefilter cubemap generation across mip levels, and BRDF LUT baking. This is a strong compact reference for image-based-lighting preparation in a Kotlin engine.
- `src/commonMain/kotlin/app/thelema/shader/ForwardRenderingPipeline.kt` layers post-effects through framebuffer swapping rather than baking them into the main scene pass. Bloom, motion blur, god rays, vignette, and FXAA are stacked by rendering intermediate maps and reusing a velocity buffer channel.

### Input And Controls

- `src/androidMain/kotlin/app/thelema/android/AndroidApp.kt` adapts Android into the engine through a compact platform shell: `GLSurfaceView` rendering, global service wiring (`FS`, `GL`, `IMG`, `AL`, `KB`, `MOUSE`, `TOUCH`, `WS`), optional init on the GL thread, and small helper threads for background work.
- `src/androidMain/kotlin/app/thelema/android/AndroidTouch.kt` and `AndroidMouse.kt` translate `MotionEvent` input into engine-wide touch and mouse listeners, including drag deltas, scale gestures, and a unified left-button abstraction. This is a reusable example of projecting Android touch events into a platform-neutral engine API.
- The input layer is notable less for complex gameplay helpers and more for its thin-platform philosophy: higher-level scene handlers such as `KeyboardHandler` and `MouseHandler` in `commonMain` consume unified input services instead of depending directly on Android classes.

### Physics And Collision

- `src/jvmCommonMain/kotlin/app/thelema/jvm/ode/RigidBodyPhysicsWorld.kt` wraps ODE into an entity-component world that tracks begin/update/end contact phases, configurable shape descriptors, gravity, fixed-step stepping, and optional quick-step iteration tuning.
- The physics layer is integrated back into the same descriptor system used by the rest of the engine. `RigidBodyPhysicsWorld.initOdeComponents()` registers world, body, and shape metadata so physics components can participate in the same serialized/editor-driven workflow as rendering and scene components.

### Tooling, Android Integration, Or Other Notable Areas

- `src/commonMain/kotlin/app/thelema/gltf/GLTFSettings.kt` makes the loader unusually configurable for a compact engine: CPU retention of buffers/textures/meshes, shader generation, depth/velocity/G-buffer setup, tangent/normal recalculation, IBL configuration, and material-configuration callbacks.
- `thelema-studio/build.gradle.kts` confirms that the repository is not only an engine runtime but also an editor/studio workspace built on top of the same engine and LWJGL stack. That makes the descriptor-driven ECS and resource system more valuable, because they are clearly meant to support authoring tools as well as runtime loading.
- `src/commonTest/kotlin/app.thelema.ecs/FileTest.kt` and `EntityPaths.kt` show at least some effort to keep core file/path behavior executable across platforms, even though the automated test surface remains tiny relative to the engine's overall scope.

## Reusable Takeaways

- A hybrid entity tree with typed component descriptors can support runtime composition, serialization, editor tooling, and prefab-like scene instancing without needing a separate scene format and a separate ECS metadata layer.
- Background asset parsing plus a queued GL-thread upload model is a practical pattern for Android/Kotlin engines that need to keep OpenGL work on the render thread while still benefiting from asynchronous loading.
- Shader-node composition can stay useful when it is grounded in real engine needs such as glTF materials, cascaded shadows, deferred/G-buffer targets, and post-processing stages, not only as an abstract graph editor experiment.
- A thin Android shell that only adapts rendering, input, files, audio, and background threading can keep most engine logic shared inside `commonMain`.
- Scene instancing backed by live branch mirroring is a strong reference for reusable authored content, whether the source scene comes from an editor-authored entity file or from imported glTF content.

## Evidence Summary

- `src/commonMain/kotlin/app/thelema/ecs/Entity.kt` - hierarchical entity/component tree, path addressing, JSON serialization
- `src/commonMain/kotlin/app/thelema/ecs/ECS.kt` - component descriptor registry and default engine/editor metadata
- `src/commonMain/kotlin/app/thelema/res/Project.kt`, `Loader.kt`, `EntityLoader.kt` - resource loading graph, async monitoring, deferred scene start
- `src/commonMain/kotlin/app/thelema/g3d/scene.kt` - renderable/light gathering, culling, render ordering, uniform buffer upload
- `src/commonMain/kotlin/app/thelema/g3d/sceneInstance.kt` - prefab-like scene copy and live branch mirroring
- `src/commonMain/kotlin/app/thelema/gltf/GLTF.kt`, `GLTFSceneInstance.kt`, `GLTFSettings.kt` - async glTF load pipeline, configurable import behavior, scene provision
- `src/commonMain/kotlin/app/thelema/shader/PBRShader.kt`, `shader/node/PBRNode.kt`, `shader/node/GBufferOutputNode.kt` - shader-node PBR, shadow, and deferred output pipeline
- `src/commonMain/kotlin/app/thelema/g3d/IBLMapBaker.kt` - irradiance/prefilter/BRDF LUT generation
- `src/commonMain/kotlin/app/thelema/shader/ForwardRenderingPipeline.kt` - post-processing stack with FBO swapper and velocity channel
- `src/androidMain/kotlin/app/thelema/android/AndroidApp.kt`, `AndroidTouch.kt`, `AndroidMouse.kt`, `AndroidFS.kt` - Android platform glue
- `src/jvmCommonMain/kotlin/app/thelema/jvm/ode/RigidBodyPhysicsWorld.kt` - physics world, contacts, ODE descriptor registration
- `src/commonTest/kotlin/app.thelema.ecs/*` - small automated test surface for files and path resolution

## Risks Or Limits

- The repository is stale; last push at selection was `2022-12-21`.
- Basic Gradle discovery currently fails in this lab because the environment has only a JRE, not a full JDK.
- The build stack itself is also old enough to deserve caution: Gradle `7.3`, Kotlin `1.6.20-RC`, AGP `7.0.0`, and older Ktor/LWJGL versions indicate maintenance and modernization risk.
- `src/commonMain/kotlin/app/thelema/g3d/scene.kt` calls `opaque.sortedWith(frontToBackSorter)` without storing the returned list, so the intended front-to-back ordering optimization appears ineffective on the inspected revision.
- `src/androidMain/kotlin/app/thelema/android/AndroidTouch.kt` and `AndroidMouse.kt` look primarily tuned for single-pointer interaction; they use `actionIndex` directly and guard several callbacks with `pointerCount == 1`, so complex multitouch gameplay input likely needs extra work.
- `src/commonMain/kotlin/app/thelema/shader/ForwardRenderingPipeline.kt` carries an explicit `FIXME problem with changing window size`, which lowers confidence in its resizing robustness.
- Automated testing is minimal relative to the engine's scope; the verified `commonTest` surface covers only simple file/path behavior, not the renderer, Android integration, glTF loading, or physics.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `3d`, `android`, `multiplatform`, `scene-graph`, `opengl`, `shader`, `physics`, `asset-pipeline`
- Follow-up needed:
  - if the lab revisits this repository, focus on the glTF loader pipeline, shader-node authoring flow, or Android platform shell instead of reopening the entire engine broadly
  - re-run build verification in a real JDK `11+` environment before treating any Gradle surface as reproducible
