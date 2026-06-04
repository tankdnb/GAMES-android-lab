# Research Note

## Repository Snapshot

- Repository: `codeyousef/Materia`
- Source URL: [https://github.com/codeyousef/Materia](https://github.com/codeyousef/Materia)
- Owner: `codeyousef`
- Batch ID: [`BATCH-2026-06-04-M`](../batches/BATCH-2026-06-04-M.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-05-10`
- Stars at selection: `108`
- Default branch at selection: `main`
- Investigated commit: `018c94cef6077494cdb46d69feb1e49628ab81c7`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/codeyousef-materia.md](../../catalog/projects/codeyousef-materia.md)

## Why This Repository Was Selected

- `Materia` emerged from the refreshed explicit-license shortlist after exact repository-level GraphQL verification, not only search-index metadata.
- It had the strongest current balance of fit, freshness, and expected research yield among the new candidates because it is a Kotlin Multiplatform 3D engine stack with a declared Android target, active rendering/backend work, and a much broader architecture surface than the smaller gameplay samples in the same shortlist.
- The main question for this batch was whether the repository is coherent enough to keep as a primary engine reference or whether it is still too transitional and better kept as `reference-only`. The answer is `accepted`: the codebase is clearly in transition, but the shared scene/runtime design, asset pipeline, GPU abstraction, and Android host seams already make it a strong engine-study reference.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: Kotlin Multiplatform 3D engine stack with a shared three.js-style scene API, a separate GPU abstraction layer, an engine-focused renderer/runtime layer, loaders, validation tooling, and multiplatform examples
- Rendering stack:
  - root shared renderer interfaces for `WebGPU`, `Vulkan`, and `WebGL`
  - `materia-gpu` abstraction backed by `wgpu4k-toolkit`
  - `materia-engine` renderer/runtime layer with `SceneRenderer` and `EngineRenderer`
  - Android-specific Filament-backed engine/example hosts that currently coexist with the wgpu-backed path
- Android target: direct but transitional; Android-specific source sets, examples, and host paths are checked in, but they currently span both wgpu/Vulkan-oriented code and Filament-based fallback/runtime wrappers
- Build system: Gradle Kotlin DSL monorepo using Kotlin `2.2.20`, AGP `8.12.3`, KMP, Dokka, Kover, Maven publishing, and signing
- Repository layout summary:
  - root `src/` contains the shared scene graph, renderer APIs, loaders, validation helpers, and most of the broad feature surface
  - `materia-engine/` contains the newer engine-side runtime, render loop, scene graph, and engine renderer
  - `materia-gpu/` contains GPU abstraction types and wgpu-backed platform glue
  - `materia-validation/` contains the production-readiness and verification tooling
  - `examples/` contains desktop, browser, Android, and Apple host examples
  - `docs/` contains architecture, guide, API, and benchmark material
  - `tests/` contains extra standalone contract/integration/performance/visual suites that are not obviously wired as a normal Gradle module
- Source footprint:
  - total files counted in repository: `1369`
  - Kotlin/KTS/Java files counted in repository: `1140`
- Test surface:
  - wired test-like files found under active source-set trees: `197`
  - extra files found under the standalone `tests/` tree: `29`
  - notable caveat: several files inside the standalone `tests/` tree are placeholder suites with `fail("Not yet implemented ...")`, and the tree is not included as a Gradle module in `settings.gradle.kts`
- Key modules reviewed:
  - `README.md`
  - `LICENSE`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle.properties`
  - `gradle/libs.versions.toml`
  - `docs/architecture/overview.md`
  - `src/commonMain/kotlin/io/materia/core/scene/Object3D.kt`
  - `src/commonMain/kotlin/io/materia/core/scene/Scene.kt`
  - `src/commonMain/kotlin/io/materia/renderer/BackendType.kt`
  - `src/commonMain/kotlin/io/materia/renderer/Renderer.kt`
  - `src/commonMain/kotlin/io/materia/renderer/RendererFactory.kt`
  - `src/jvmMain/kotlin/io/materia/renderer/RendererFactory.kt`
  - `src/commonMain/kotlin/io/materia/loader/GLTFLoader.kt`
  - `src/commonMain/kotlin/io/materia/geometry/processing/LODGenerator.kt`
  - `src/androidMain/kotlin/io/materia/renderer/AndroidWgpuRenderer.kt`
  - `src/androidMain/kotlin/io/materia/renderer/gpu/GpuContext.android.kt`
  - `materia-engine/src/commonMain/kotlin/io/materia/engine/core/RenderLoop.kt`
  - `materia-engine/src/commonMain/kotlin/io/materia/engine/render/EngineRenderer.kt`
  - `materia-engine/src/androidMain/kotlin/io/materia/engine/render/EngineRendererPlatform.android.kt`
  - `materia-engine/src/commonTest/kotlin/io/materia/engine/scene/SceneTests.kt`
  - `materia-engine/src/commonTest/kotlin/io/materia/engine/core/RenderLoopConfigTest.kt`
  - `materia-validation/build.gradle.kts`
  - `.github/workflows/publish.yml`
  - `examples/triangle-android/src/main/java/io/materia/examples/triangle/android/TriangleActivity.kt`
  - `examples/triangle-android/src/main/java/io/materia/examples/triangle/android/DirectFilamentTriangleRuntime.kt`
  - `examples/embedding-galaxy-android/src/main/java/io/materia/examples/embeddinggalaxy/android/EmbeddingGalaxyActivity.kt`
  - `examples/volume-texture/README.md`
  - `src/commonTest/kotlin/io/materia/renderer/RendererContractSuiteTest.kt`
  - `tests/integration/backend/BackendAutoSelectionTest.kt`
  - `tests/integration/VulkanRenderOutputTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds in the inspected clone:
  - Gradle `8.13`
  - Launcher JVM `1.8.0_321`
- `cmd /c gradlew.bat help --no-daemon` fails in the lab because Gradle cannot find a Java compiler:
  - `No Java compiler found, please ensure you are running Gradle with a JDK`
- The checked-in build expects a much newer environment than the current lab machine:
  - README says `JDK 17+`
  - `gradle.properties` explicitly states `wgpu4k-toolkit requires Java 22+ for JVM runtime`
  - `.github/workflows/publish.yml` sets up Temurin `JDK 22` plus the Android SDK and `naga-cli`
- The visible automation surface is notable but narrower than the README positioning might imply:
  - the only checked-in GitHub Actions workflow is `publish.yml`
  - it runs selected JVM tests and publishing on pushes to `main`
  - there is no separate normal PR/CI workflow checked in under `.github/workflows/`
- The latest inspected commit is `Add GLTF cache and WebGL readback guard (#12)`, which is consistent with the active feature and runtime work seen in the code.
- No runtime launch was attempted inside the lab.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - `Materia` has a rich enough real code surface to justify main-catalog status: scene graph, renderer abstractions, GPU layer, loaders, validation tools, Android hosts, benchmark tooling, and a substantial test surface.
  - It is not fully coherent yet, especially on Android, but those transitional seams are themselves useful research material for teams building Kotlin game runtimes or internal engines.

## Interesting Findings

### Engine Architecture And Core Loop

- `src/commonMain/kotlin/io/materia/core/scene/Object3D.kt` is a strong reusable scene-graph base: local/world transform storage, hierarchy traversal, layer masks, render callbacks, and dirty-flagged matrix updates are all built into the common object model.
- `src/commonMain/kotlin/io/materia/core/scene/Scene.kt` keeps the root scene explicit and practical. It owns background, fog, environment lighting, override-material passes, and JSON export, which mirrors the expected workflow for a scene-first engine rather than an ECS-first runtime.
- `materia-engine/src/commonMain/kotlin/io/materia/engine/core/RenderLoop.kt` uses an `expect/actual` render-loop seam instead of hard-coding one loop model across platforms. That gives the engine a clean place to separate browser `requestAnimationFrame` behavior from blocking desktop/native loops.
- `materia-engine/src/commonMain/kotlin/io/materia/engine/render/EngineRenderer.kt` reveals the most important architecture fact in the repo: the newer engine-side renderer explicitly says it bypasses the legacy renderer stack and talks directly to the multiplatform GPU layer. That means the repository currently carries two live render/runtime lines rather than one fully consolidated engine surface.

### Rendering And Graphics

- `src/commonMain/kotlin/io/materia/renderer/Renderer.kt`, `BackendType.kt`, and `RendererFactory.kt` define a backend-aware root renderer interface shaped around `WebGPU`, `Vulkan`, and `WebGL` rather than around older OpenGL-only assumptions. The comments also make the refactor state explicit: several older properties and controls were removed and are intended to return later.
- `materia-engine/src/commonMain/kotlin/io/materia/engine/render/EngineRenderer.kt` and its internal `EngineRendererImpl` show a pragmatic high-level renderer assembly: acquire `GpuInstance`, request adapter/device, configure a surface, build a `SceneRenderer`, and optionally route output through offscreen FXAA resources.
- The same `EngineRendererImpl` also exposes a useful current limitation: depth attachments are disabled on the Vulkan backend because of a known implementation constraint. That is the kind of real engine caveat worth preserving for future runtime work.
- `materia-gpu/src/jvmMain/kotlin/io/materia/gpu/GpuCoreJvm.kt` shows the low-level backend strategy clearly by creating a `WGPU` instance with a forced Vulkan backend on JVM. That is valuable as a Kotlin-side example of treating Vulkan as the common desktop/native rendering substrate.
- `src/commonMain/kotlin/io/materia/geometry/processing/LODGenerator.kt` and the surrounding geometry-processing helpers show that mesh simplification and distance-based LOD are treated as first-class runtime concerns rather than as external preprocessing-only steps.

### Tooling And Content Pipeline

- `src/commonMain/kotlin/io/materia/loader/GLTFLoader.kt` is one of the strongest findings in the repository. It does more than parse files: it caches pristine source assets, shares in-flight async loads, and returns cloned scene trees that intentionally share geometry/material/texture state while separating mutable transforms and hierarchy. That is a very reusable pattern for Android-adjacent engines that want fast multi-instance content reuse.
- The same loader stack, plus the README and architecture docs, shows a broad built-in asset story: glTF, FBX, COLLADA, OBJ/PLY/STL, KTX2, EXR/HDR, and Draco references are all part of the intended surface.
- `build.gradle.kts` contains a real shader-tooling seam via `compileShaders`, with Tint/Naga discovery and WGSL-to-SPIR-V generation for JVM/Android resources. That is directly reusable as a reference for Kotlin engine repos that need one shader authoring source with platform-specific compiled artifacts.
- `materia-validation/` is not just documentation theater. The module includes production-readiness validation code, OWASP dependency checking, and report-generation tasks that are worth studying as examples of how an engine repo can formalize "is this ready enough?" into code.

### Android Platform Integration

- `src/androidMain/kotlin/io/materia/renderer/AndroidWgpuRenderer.kt` confirms that there is a real Android-specific renderer path in the root stack. It manages surface initialization, device/context creation, depth attachment setup, per-frame traversal of `Scene` nodes, and GPU submission through wgpu-backed types.
- `src/androidMain/kotlin/io/materia/renderer/gpu/GpuContext.android.kt` shows that the Android Vulkan path still depends on a reflective bridge to `io.materia.gpu.bridge.VulkanBridge`. That makes the Android backend feel more infrastructure-heavy and fragile than the higher-level README might suggest, but it is also a concrete example of how to hide a native bridge behind Kotlin-side GPU abstractions.
- `materia-engine/src/androidMain/kotlin/io/materia/engine/render/EngineRendererPlatform.android.kt` shows that the engine-side Android path is currently different from the root renderer path. The `actual` engine renderer for Android is `AndroidFilamentEngineRenderer`, which uses Filament instead of the same wgpu-based rendering route as the desktop/core stack.
- The example apps make the transition even more visible:
  - `examples/triangle-android/.../TriangleActivity.kt` and `DirectFilamentTriangleRuntime.kt` boot a dedicated `SurfaceView` + `Choreographer` Android host using Filament, with the triangle runtime hard-coded to `Engine.Backend.OPENGL`
  - `examples/embedding-galaxy-android/.../EmbeddingGalaxyActivity.kt` boots a `SurfaceView` host and handles Vulkan support checks explicitly
  - `examples/volume-texture/README.md` states plainly that Android currently renders through a Filament/OpenGL path with CPU-sampled fallback while the public Android wgpu backend is blocked upstream
- The Android result is not a single stable story yet, but it is a strong reference for host-surface management, `SurfaceView` + `Choreographer` loops, backend capability gating, and how a KMP engine team can keep shipping example paths while its "ideal" Android renderer is still in motion.

### Performance And Memory

- `Object3D.kt` uses matrix dirty flags and local/world version tracking rather than recomputing transforms blindly every frame. That is still one of the most transferable performance patterns in the whole repository.
- `GLTFAssetCache` is also a practical performance pattern: dedupe concurrent loads, keep one immutable parsed source asset, and clone only the mutable graph shell when a caller needs another instance.
- `EngineRendererImpl` keeps FXAA/offscreen resources cached and recreates them only when needed. That is a useful reference for a "small but serious" renderer that wants to keep post-process state explicit.
- The README benchmark system and `build.gradle.kts` benchmark tasks show a disciplined performance-measurement workflow: benchmark capture, raw JSON output, snapshot aggregation, and README publication are all built into the repository rather than treated as ad hoc manual work.

### Build, Release, And Testing

- `gradle/libs.versions.toml`, `build.gradle.kts`, and `publish.yml` show a modern toolchain baseline around Kotlin `2.2.20`, AGP `8.12.3`, Android SDK `34`, and JDK `22` for the publication path.
- The active source-set tests are substantial enough to matter. `src/commonTest/.../RendererContractSuiteTest.kt` and other common tests cover renderer contracts, backend negotiation helpers, render-pass helpers, geometry helpers, material registries, and performance-monitor seams. `materia-engine` adds more scene and render-loop tests.
- There is also an important caveat about the broader `tests/` directory:
  - it contains extra contract/integration/performance/visual suites such as `tests/integration/VulkanRenderOutputTest.kt`
  - `settings.gradle.kts` does not include a `tests` module
  - several files there are explicit placeholders, for example `tests/integration/backend/BackendAutoSelectionTest.kt` uses `fail("Not yet implemented ...")`
  - this means the repository has both real wired tests and aspirational/unwired test suites side by side
- `materia-validation/build.gradle.kts` is another useful reality check:
  - it uses `-Xskip-prerelease-check`
  - it explicitly lowers the Kover verification minimum to `35`
  - the comments say the intended threshold is much higher
  - this makes the validation surface useful, but still clearly mid-flight rather than finished
- `settings.gradle.kts` also records current scope limitations directly:
  - tool modules are disabled on Windows due to compilation issues
  - `materia-postprocessing` is disabled because it needs architectural fixes
- `docs/architecture/overview.md` does not fully match the live module graph anymore. It still describes module names like `materia-core`, `materia-renderer`, `materia-scene`, and other split components, while the actual active build is centered on the root module plus `materia-engine`, `materia-gpu`, `materia-validation`, and selected examples. That doc/runtime drift is itself an important maintenance signal.

## Reusable Takeaways

- A Kotlin engine repo can keep a rich scene-first API while still isolating lower-level GPU/backend work into a dedicated module.
- Shared asset caches should return cloned scene trees while reusing heavy immutable render assets.
- Android support in a multiplatform engine does not have to be a single path during transition; separate host/runtime seams can coexist if the boundaries are explicit and documented.
- Validation, benchmark capture, and shader compilation can be built into the repository workflow rather than handled as one-off scripts outside the build.

## Evidence Summary

- `src/commonMain/kotlin/io/materia/core/scene/Object3D.kt` and `Scene.kt` - shared scene graph, world/local transform handling, background/fog/environment state
- `src/commonMain/kotlin/io/materia/renderer/*` plus `src/jvmMain/kotlin/io/materia/renderer/RendererFactory.kt` - root renderer contract, backend policy, and JVM Vulkan selection
- `materia-engine/src/commonMain/kotlin/io/materia/engine/render/EngineRenderer.kt` - newer engine-side renderer that bypasses the legacy stack
- `materia-gpu/src/jvmMain/kotlin/io/materia/gpu/GpuCoreJvm.kt` - wgpu-backed Vulkan-first JVM GPU initialization
- `src/commonMain/kotlin/io/materia/loader/GLTFLoader.kt` - clone-on-read GLTF asset cache and multi-instance scene reuse strategy
- `src/commonMain/kotlin/io/materia/geometry/processing/LODGenerator.kt` - built-in progressive mesh simplification and distance-based LOD
- `src/androidMain/kotlin/io/materia/renderer/AndroidWgpuRenderer.kt` and `GpuContext.android.kt` - Android-specific wgpu/Vulkan-side renderer and reflective native bridge
- `materia-engine/src/androidMain/kotlin/io/materia/engine/render/EngineRendererPlatform.android.kt` and Android example activities - Filament-backed Android engine/example path
- `build.gradle.kts`, `gradle.properties`, `materia-validation/build.gradle.kts`, and `.github/workflows/publish.yml` - build floor, shader tooling, validation gates, and publish/test automation

## Risks Or Limits

- The repository is clearly in transition between at least two render/runtime stacks:
  - the root `Feature 019` renderer APIs
  - the newer `materia-engine` path
  - the Android Filament example/runtime path
- Android support is real, but it is not yet one clean unified implementation story. Some checked-in Android paths still rely on Filament/OpenGL or CPU-side fallback instead of a single shared wgpu-based renderer.
- Architecture documentation and active module graph have drifted apart.
- The visible Actions automation is centered on publish-to-main rather than a broader CI matrix.
- Some aspirational tests live in a standalone `tests/` tree with explicit placeholder failures and do not appear wired into the normal Gradle module graph.
- Meaningful local verification in this lab would still require a real JDK and, for Android work, an SDK-ready environment.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `3d`, `android`, `multiplatform`, `scene-graph`, `shader`, `asset-pipeline`, `performance`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, do it in a JDK `22` plus Android SDK-ready environment and isolate either the dual renderer-stack boundary, the Android Filament/wgpu split, the GLTF cache/loader pipeline, or the validation/benchmark workflow instead of reopening the whole repository broadly
