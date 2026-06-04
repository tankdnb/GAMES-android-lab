# Research Note

## Repository Snapshot

- Repository: `kool-engine/kool`
- Source URL: [https://github.com/kool-engine/kool](https://github.com/kool-engine/kool)
- Owner: `kool-engine`
- Batch ID: [`BATCH-2026-06-04-R`](../batches/BATCH-2026-06-04-R.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-03`
- Stars at selection: `556`
- Default branch at selection: `main`
- Investigated commit: `27da5cfeda200128331a052c74ee6de8d938e1d9`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-java8-needs-java17`
- Catalog card: [catalog/projects/kool-engine-kool.md](../../catalog/projects/kool-engine-kool.md)

## Why This Repository Was Selected

- `kool` came out of the refreshed exact-license shortlist after the queue was exhausted at the end of `BATCH-2026-06-04-Q`.
- It had the strongest current balance of popularity, freshness, Android relevance, and architecture yield among the newly verified candidates.
- The main question for this batch was whether `kool` is too broad and desktop-leaning for an Android-focused lab. The answer is `accepted`: Android is not just aspirational here. The repository has real Android source sets, platform glue, input, assets, and build workflow, even though Android is disabled by default for easier library consumption.

## Technical Profile

- Main language(s): Kotlin, plus small HTML / JavaScript / CMake / C++ support files
- Engine / framework: Kotlin Multiplatform 3D engine stack with shared scene graph, platform contexts, physics modules, embedded UI, editor modules, and demo applications
- Rendering stack:
  - shared `RenderBackend` abstraction in `kool-core`
  - desktop Vulkan, OpenGL, and `wgpu4k` paths
  - browser JS and WASM backends with WebGPU / WebGL
  - Android OpenGL ES 3 path
  - shader generation through the engine's KSL pipeline
- Android target: direct but disabled by default in the checked-in Gradle surface; Android source sets, context, input, assets, and OpenGL backend are checked in, while the public starter app lives in the separate `kool-templates` repository
- Build system: Gradle Kotlin DSL monorepo with custom convention plugins, optional Android enablement, Dokka, Maven publishing, and GitHub Actions build/publish workflows
- Repository layout summary:
  - `kool-core/` - shared runtime, rendering abstractions, scene graph, platform adapters, assets, UI foundation
  - `kool-backend-wgpu4k/` - desktop `wgpu4k` backend
  - `kool-physics/` - 3D physics bindings and runtime
  - `kool-physics-2d/` - 2D physics wrappers
  - `kool-compose-ui/` - Compose-style UI bridge over the engine UI system
  - `kool-editor-model/` and `kool-editor/` - scene-editor model and editor tooling
  - `kool-demo/` - feature and demo applications
- Source footprint:
  - total files counted in repository: `1260`
  - Kotlin/Java files counted in repository: `1223`
- Test surface:
  - `11` files with actual `@Test` annotations were found, mostly in `kool-core/src/desktopTest`
  - `23` test-named files were found overall, but several of them are demo / feature scenes rather than normal automated tests
- Key files reviewed:
  - `README.md`
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle.properties`
  - `.github/workflows/build.yml`
  - `.github/workflows/publish.yml`
  - `buildSrc/src/main/kotlin/kool.lib-conventions.gradle.kts`
  - `buildSrc/src/main/kotlin/kool.androidlib-conventions.gradle.kts`
  - `kool-core/build.gradle.kts`
  - `kool-demo/build.gradle.kts`
  - `kool-compose-ui/build.gradle.kts`
  - `kool-physics/build.gradle.kts`
  - `kool-backend-wgpu4k/build.gradle.kts`
  - `kool-core/src/commonMain/kotlin/de/fabmax/kool/KoolApplication.kt`
  - `kool-core/src/commonMain/kotlin/de/fabmax/kool/KoolContext.kt`
  - `kool-core/src/commonMain/kotlin/de/fabmax/kool/scene/Scene.kt`
  - `kool-core/src/commonMain/kotlin/de/fabmax/kool/util/Time.kt`
  - `kool-core/src/commonMain/kotlin/de/fabmax/kool/util/KoolDispatchers.kt`
  - `kool-core/src/commonMain/kotlin/de/fabmax/kool/pipeline/backend/RenderBackend.kt`
  - `kool-core/src/desktopMain/kotlin/de/fabmax/kool/platform/Lwjgl3Context.kt`
  - `kool-core/src/androidMain/kotlin/de/fabmax/kool/platform/KoolContextAndroid.kt`
  - `kool-core/src/androidMain/kotlin/de/fabmax/kool/platform/KoolSurfaceView.kt`
  - `kool-core/src/androidMain/kotlin/de/fabmax/kool/KoolConfigAndroid.kt`
  - `kool-core/src/androidMain/kotlin/de/fabmax/kool/input/PlatformInput.android.kt`
  - `kool-core/src/commonMain/kotlin/de/fabmax/kool/input/TouchGestureEvaluator.kt`
  - `kool-core/src/commonMain/kotlin/de/fabmax/kool/Assets.kt`
  - `kool-core/src/androidMain/kotlin/de/fabmax/kool/Assets.android.kt`
  - `kool-physics/src/commonMain/kotlin/de/fabmax/kool/physics/PhysicsWorld.kt`
  - `kool-physics-2d/src/commonMain/kotlin/de/fabmax/kool/physics2d/Physics2dWorld.kt`
  - `kool-compose-ui/src/commonMain/kotlin/de/fabmax/kool/modules/compose/UiSurfaceComposition.kt`
  - `kool-editor/src/commonMain/kotlin/de/fabmax/kool/editor/ProjectFiles.kt`
  - `kool-demo/src/commonMain/kotlin/de/fabmax/kool/demo/tests/LaunchedEffectTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds in the inspected clone:
  - Gradle `9.5.1`
  - Launcher JVM `1.8.0_321`
- `cmd /c gradlew.bat help --no-daemon` fails in the lab because Gradle itself now needs a newer JVM:
  - `Gradle requires JVM 17 or later to run. Your build is currently configured to use JVM 8.`
- `cmd /c gradlew.bat :kool-core:desktopTest --dry-run --no-daemon` fails for the same reason before task graph discovery can complete.
- The checked-in upstream toolchain floor is materially higher than the current lab machine:
  - README documents Java `17` as the general desktop minimum
  - `kool.lib-conventions` uses `jvmToolchain(25)`
  - CI workflows set up Temurin `25`
  - `kool-backend-wgpu4k` uses `java.lang.foreign.MemorySegment`, which matches the README warning that this module needs Java `22`
- Android is intentionally disabled by default:
  - `buildSrc/src/main/kotlin/kool.androidlib-conventions.gradle.kts` keeps `com.android.library`, `androidTarget`, and the `android {}` block commented out
  - root tasks `enableAndroidPlatform` and `disableAndroidPlatform` edit convention and module build files to toggle those blocks
  - this is a pragmatic build-shape decision so normal library consumers do not need an Android SDK just to work with the core repository
- No runtime launch was attempted inside the lab.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - `kool` has enough real architecture depth to justify main-catalog status: multiplatform contexts, backend abstraction, editor modules, Compose-style UI, two physics stacks, Android platform code, and an unusually explicit build toggle for Android support.
  - The Android story is not a turnkey "run demos on phone" path from this repository alone, but the checked-in Android seams are real and reusable.

## Interesting Findings

### Engine Architecture And Core Loop

- `kool-core/src/commonMain/kotlin/de/fabmax/kool/KoolContext.kt` is the most important core-loop file in the repository. It double-buffers `FrameData`, polls input, flushes Compose snapshot writes, advances a shared frame clock, collects visible scenes, and keeps background passes separate from foreground content.
- The same file also exposes a strong split-thread pattern through `render()` and `FrameData.syncData()`: frontend scene mutation, synced capture, and backend GPU submission are treated as separate phases instead of one monolithic render callback.
- `kool-core/src/commonMain/kotlin/de/fabmax/kool/scene/Scene.kt` adds another useful layer: scenes own their own coroutine scope, can suspend in `onRenderScene`, and sort extra GPU passes by dependency before forcing the main screen pass to execute last.
- `kool-core/src/desktopMain/kotlin/de/fabmax/kool/platform/Lwjgl3Context.kt` shows a serious desktop runtime instead of a toy loop. It can prepare `nextFrameData` asynchronously when `asyncSceneUpdate` is enabled, applies focus-aware frame limiting, and falls back to OpenGL when the preferred backend cannot be created.
- `kool-core/src/commonMain/kotlin/de/fabmax/kool/util/KoolDispatchers.kt` avoids pretending there is one "main thread". It exposes explicit `Frontend`, `Backend`, and `Synced` dispatchers plus matching scopes, which is a reusable pattern for internal engines that need clear ownership around scene mutation and GPU access.

### Rendering And Graphics

- `kool-core/src/commonMain/kotlin/de/fabmax/kool/pipeline/backend/RenderBackend.kt` is a clean backend contract: it standardizes shader generation, pass creation, texture upload/download, frame GPU timing, and normalized device-coordinate differences between OpenGL, Vulkan, and WebGPU.
- The same backend contract keeps depth range and NDC Y direction explicit through `DeviceCoordinates`, which is a small but high-value detail for multiplatform rendering correctness.
- The platform matrix is real in the checked-in code, not only in README claims:
  - desktop OpenGL and Vulkan in `kool-core/src/desktopMain/.../pipeline/backend/`
  - desktop `wgpu4k` in `kool-backend-wgpu4k`
  - JS / WASM WebGPU and WebGL source sets in `kool-core/src/jsMain`, `webMain`, and `wasmJsMain`
  - Android OpenGL ES implementation in `kool-core/src/androidMain/.../RenderBackendGlImpl.kt`
- `kool-backend-wgpu4k/src/desktopMain/.../ArrayBuffer.desktop.kt` and `RenderBackendWgpu4k.desktop.kt` use `MemorySegment`, which explains why the repository's WebGPU desktop path is coupled to a higher Java floor.
- `Scene.ScreenPass` in `Scene.kt` is also worth keeping in mind: one scene can own multiple views plus extra offscreen or compute passes while still presenting a simple screen-pass default for normal use.

### UI, Editor, And Content Tooling

- `kool-compose-ui/src/commonMain/kotlin/de/fabmax/kool/modules/compose/UiSurfaceComposition.kt` is a strong reference if we ever want Compose-style authoring inside a custom renderer. It bridges `UiSurface` into a `MinimalComposition`, wires its own `BroadcastFrameClock`, and mounts popup layers directly under the engine viewport.
- That same file proves the repository is not merely "inspired by Compose" in documentation. The runtime really does drive composition from the engine frame clock and injects UI state through `CompositionLocalProvider`.
- `kool-demo/src/commonMain/kotlin/de/fabmax/kool/demo/tests/LaunchedEffectTest.kt` shows the Compose-style surface being used as a live demo/test harness for hover animation, tweening, state-driven shape morphing, and toggle animation. That makes the UI layer easier to trust as a real subsystem rather than only a side experiment.
- `kool-editor/src/commonMain/kotlin/de/fabmax/kool/editor/ProjectFiles.kt` is a simple but useful tooling pattern: editable project data lives under `src/commonMain/koolProject` and `src/commonMain/resources/kool-project.json`, which keeps editor output aligned with source-controlled multiplatform project structure instead of inventing a separate opaque asset container.

### Physics And Android Platform Integration

- `kool-physics/src/commonMain/.../PhysicsWorld.kt` shows a proper fixed-step 3D physics seam with async stepping, capture/interpolation callbacks, and scene-hook registration through `Scene.onRenderScene`.
- `kool-physics-2d/src/commonMain/.../Physics2dWorld.kt` mirrors the same shape for 2D simulation, which makes the repository interesting as a reference for keeping 2D and 3D physics under one runtime philosophy instead of bolting them on in unrelated ways.
- `kool-physics/build.gradle.kts` adds a distinctive code-generation / transformation workflow: Android and web physics sources are derived from desktop PhysX sources through `TransformTask` instead of being maintained as fully independent implementations.
- `kool-core/src/androidMain/kotlin/de/fabmax/kool/platform/KoolContextAndroid.kt`, `KoolSurfaceView.kt`, `KoolConfigAndroid.kt`, `PlatformInput.android.kt`, and `TouchGestureEvaluator.kt` show a real Android host:
  - preserved `GLSurfaceView` context
  - Android soft-keyboard control
  - shared pointer and key abstractions
  - multitouch pinch and two-finger drag gesture evaluation
  - configurable UI scale modifier tied to Android density conventions
- `kool-core/src/androidMain/kotlin/de/fabmax/kool/Assets.android.kt` adds another concrete Android seam: bitmap and SVG decoding, HTTP cache init, and Android-specific file-system asset loading are checked in, while unsupported features are made explicit instead of silently emulated. For example, AtlasFont generation, clipboard, and file chooser support are clearly marked unsupported on Android.

### Build, Release, And Testing

- Root build logic is unusually pragmatic for a multiplatform engine with Android support. `enableAndroidPlatform` and `disableAndroidPlatform` deliberately rewrite commented build blocks so contributors can keep Android in the repository without forcing every clone to configure an Android SDK.
- `.github/workflows/build.yml` and `publish.yml` both enable Android before building, then run on JDK `25`. That means the "Android disabled by default" choice is a repository-consumption convenience, not a sign that Android support is abandoned.
- The actual automated test surface is narrower than the module graph might suggest:
  - `11` real `@Test` files were found, concentrated in `kool-core/src/desktopTest`
  - they cover math, spatial trees, file systems, memory layout, and ray picking
  - many demo-side `*Test.kt` files are interactive feature scenes, not normal regression tests
- This still makes `kool` a better workflow reference than many hobby engines because the repo has real CI, real publishing, and a non-trivial automated core test surface, even if rendering/editor/physics verification is not broadly covered by unit tests.

## Reusable Takeaways

- A custom engine can support frontend, backend, and synced execution phases explicitly instead of hiding everything behind a vague "main thread" assumption.
- Compose-style UI authoring can be embedded into a custom renderer by driving composition from the engine's own frame clock and wrapping existing UI nodes rather than rewriting the whole scene/UI model.
- Keeping Android source sets checked in but disabled by default is a practical way to reduce local contributor friction while preserving real Android support in the same repository.
- Platform-specific physics bindings can be generated from a shared desktop source base when the higher-level API stays stable.

## Evidence Summary

- `KoolContext.kt`, `Scene.kt`, `Lwjgl3Context.kt`, and `KoolDispatchers.kt` - split frontend/backend/synced frame model, async scene preparation, and dependency-ordered pass execution
- `RenderBackend.kt` plus platform backend trees - one rendering contract spanning OpenGL, Vulkan, WebGPU, browser, and Android GLES
- `UiSurfaceComposition.kt` and `LaunchedEffectTest.kt` - Compose-style UI composition driven from the engine runtime rather than from a separate app shell
- `PhysicsWorld.kt`, `Physics2dWorld.kt`, and `kool-physics/build.gradle.kts` - async interpolated physics plus transform-based Android/web physics-source derivation
- `KoolContextAndroid.kt`, `KoolSurfaceView.kt`, `KoolConfigAndroid.kt`, `PlatformInput.android.kt`, `TouchGestureEvaluator.kt`, and `Assets.android.kt` - real Android platform glue, input, assets, and scaling behavior
- root Gradle tasks and GitHub workflows - Android enable/disable strategy, JDK floor, and publication discipline

## Risks Or Limits

- `kool` is large and subsystem-rich, so it is not a lightweight "copy this whole pattern" reference.
- The Android target is real, but the checked-in repository deliberately disables it by default and points users to a separate template repo for a minimal Android app.
- The effective toolchain floor is high:
  - Gradle configuration already needs JVM `17+`
  - core conventions pin `jvmToolchain(25)`
  - the `wgpu4k` backend needs Java `22`
- The automated test surface is focused mostly on math, file system, and picking utilities; many rendering or UI "tests" in demos are interactive scenes rather than normal assertions.
- Some Android-side capabilities remain intentionally unsupported or limited, such as clipboard and file chooser support.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `3d`, `android`, `multiplatform`, `scene-graph`, `shader`, `physics`, `editor-tools`, `asset-pipeline`, `performance`
- Follow-up needed:
  - if the lab revisits this repository, do it in a JDK `25` plus Android SDK-ready environment and isolate either the Android enable/disable workflow, the backend split between Vulkan / OpenGL / `wgpu4k`, the Compose-style in-engine UI, or the shared-API physics transformation path instead of reopening the whole repository broadly
