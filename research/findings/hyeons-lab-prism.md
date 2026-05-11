# Research Note

## Repository Snapshot

- Repository: `hyeons-lab/prism`
- Source URL: [https://github.com/hyeons-lab/prism](https://github.com/hyeons-lab/prism)
- Owner: `hyeons-lab`
- Batch ID: [`BATCH-2026-05-11-J`](../batches/BATCH-2026-05-11-J.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-05-11`
- Last pushed at selection: `2026-05-09`
- Stars at selection: `1`
- Investigated commit: `84261cc5c8de24dbba23f8c62cbbecc6b8e1d2ec`
- Research status: `accepted`
- Build mode: `static-review + gradle-discovery-attempt-timeout`
- Catalog card: [catalog/projects/hyeons-lab-prism.md](../../catalog/projects/hyeons-lab-prism.md)

## Why This Repository Was Selected

- It was the strongest current research-yield candidate from the refreshed shortlist after comparing it against `yamin8000/Dooz`, `Dmytro-Pashko/KRender`, and `JohnLavender474/Megaman-Maverick`.
- Even with almost no ecosystem signal yet, it exposed a much broader reusable surface than the remaining alternatives: Kotlin Multiplatform engine modules, Android and Compose surfaces, ECS, scene graph, glTF asset pipeline, WebGPU renderer, and real common-test coverage.
- It also broadened the lab with a newer Android-relevant WebGPU/Vulkan engine reference instead of another narrow gameplay sample.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Kotlin Multiplatform 3D engine with modular runtime, ECS, scene graph, and Compose bridge
- Rendering stack: `wgpu4k` WebGPU backend with PBR materials, CPU-generated IBL, HDR render target, tone mapping, and Android Vulkan integration
- Android target: direct Android demo and Android Compose surface integration are present in the inspected repository
- Build system: Gradle Kotlin DSL monorepo with Gradle `9.2.0`, AGP `8.13.2`, Kotlin `2.3.10`, Android KMP library modules, and JDK `25` / `21+` toolchain expectations
- Repository layout summary: large KMP monorepo with separate engine modules (`prism-core`, `prism-renderer`, `prism-assets`, `prism-ecs`, `prism-scene`, `prism-native-widgets`, `prism-compose`), demo shells (`prism-demo-core`, `prism-android-demo`, iOS/Flutter companions), architecture docs, build-status notes, and a `devlog/` folder that records design/debug history
- Key modules reviewed:
  - `prism-core/src/commonMain/kotlin/com/hyeonslab/prism/core/Engine.kt`
  - `prism-core/src/commonMain/kotlin/com/hyeonslab/prism/core/GameLoop.kt`
  - `prism-core/src/commonMain/kotlin/com/hyeonslab/prism/core/Time.kt`
  - `prism-ecs/src/commonMain/kotlin/com/hyeonslab/prism/ecs/World.kt`
  - `prism-ecs/src/commonMain/kotlin/com/hyeonslab/prism/ecs/System.kt`
  - `prism-ecs/src/commonMain/kotlin/com/hyeonslab/prism/ecs/systems/RenderSystem.kt`
  - `prism-renderer/src/commonMain/kotlin/com/hyeonslab/prism/renderer/WgpuRenderer.kt`
  - `prism-renderer/src/commonMain/kotlin/com/hyeonslab/prism/renderer/IblGenerator.kt`
  - `prism-assets/src/commonMain/kotlin/com/hyeonslab/prism/assets/AssetManager.kt`
  - `prism-assets/src/commonMain/kotlin/com/hyeonslab/prism/assets/GltfLoader.kt`
  - `prism-assets/src/commonMain/kotlin/com/hyeonslab/prism/assets/GlbReader.kt`
  - `prism-native-widgets/src/commonMain/kotlin/com/hyeonslab/prism/widget/PrismSurface.kt`
  - `prism-native-widgets/src/androidMain/kotlin/com/hyeonslab/prism/widget/PrismSurface.android.kt`
  - `prism-compose/src/nonNativeMain/kotlin/com/hyeonslab/prism/compose/EngineState.kt`
  - `prism-compose/src/androidMain/kotlin/com/hyeonslab/prism/compose/PrismView.android.kt`
  - `prism-demo-core/src/commonMain/kotlin/com/hyeonslab/prism/demo/DemoScene.kt`
  - `prism-demo-core/src/commonMain/kotlin/com/hyeonslab/prism/demo/GltfDemoScene.kt`
  - `prism-demo-core/src/nonNativeMain/kotlin/com/hyeonslab/prism/demo/DemoSceneState.kt`
  - `prism-android-demo/src/main/kotlin/com/hyeonslab/prism/demo/PrismDemoActivity.kt`
  - `prism-assets/src/commonTest/kotlin/com/hyeonslab/prism/assets/GltfLoaderTest.kt`
  - `prism-renderer/src/commonTest/kotlin/com/hyeonslab/prism/renderer/IblGeneratorTest.kt`
  - `prism-demo-core/src/commonTest/kotlin/com/hyeonslab/prism/demo/DemoStoreTest.kt`

## Build And Runtime Notes

- The repository was inspected statically and with lightweight Gradle discovery only.
- `java -version` in the lab still reports Java `1.8.0_321`.
- `cmd /c gradlew.bat --version` succeeds in the clone and reports Gradle `9.2.0`; it also shows the wrapper using a generated `gradle/gradle-daemon-jvm.properties` file that points at an Azul Java `24` daemon toolchain.
- `cmd /c gradlew.bat help --no-daemon` timed out after roughly 124 seconds in the lab without surfacing a final configuration error.
- `cmd /c gradlew.bat :prism-demo-core:jvmTest --dry-run --no-daemon` timed out in the same way, so even targeted task discovery was not reproducible here.
- `settings.gradle.kts` makes `mavenLocal()` load-bearing for `io.ygdrasil` and `com.hyeons-lab`, while `gradle/libs.versions.toml` pins `wgpu4k = 0.2.0-SNAPSHOT`, so a clean machine still needs locally published upstream artifacts before real builds are likely to work.
- `prism-demo-core/build.gradle.kts` and `prism-android-demo/build.gradle.kts` require `jvmToolchain(25)`, while the docs also state JDK `21+` for non-FFI modules.
- No runtime launch was attempted.
- Known setup limitations:
  - local build reproducibility is currently weak in this lab because the machine remains on Java `8`
  - the exact failure root cause for Gradle discovery was not verified because both tasks timed out before configuration completed
  - the repository depends on unpublished-to-central snapshot artifacts and upstream forks under the `hyeons-lab` organization

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - despite the very low star count, the inspected codebase is architecturally denser than most fresh low-signal Kotlin game repositories
  - it gives the lab a rare Android-relevant Kotlin Multiplatform WebGPU/Vulkan reference that also covers Compose embedding, glTF/PBR asset handling, and platform-native surface creation
  - the repository is clearly experimental, but the core ideas are still strong enough to keep as a main catalog reference rather than as comparison-only material

## Interesting Findings

### Engine Architecture And Core Loop

- `prism-core/src/commonMain/kotlin/com/hyeonslab/prism/core/Engine.kt` keeps the runtime as a subsystem list with explicit `initialize -> fixed update -> update -> shutdown` ownership, which is a simple but transferable pattern for small internal engines.
- `prism-core/src/commonMain/kotlin/com/hyeonslab/prism/core/GameLoop.kt` supports both a blocking fixed-step loop and an `startExternal()/tick()` mode for platform-managed frame schedulers, which is exactly what the Android/Compose and WASM shells need.
- `prism-ecs/src/commonMain/kotlin/com/hyeonslab/prism/ecs/World.kt` and `prism-ecs/src/commonMain/kotlin/com/hyeonslab/prism/ecs/systems/RenderSystem.kt` show a lightweight ECS layer where systems are priority-sorted and rendering stays an ordinary system rather than a hard-coded engine singleton.
- `prism-demo-core/src/commonMain/kotlin/com/hyeonslab/prism/demo/GltfDemoScene.kt` uses the same engine/ECS shell for both blocking and progressive scene setup, which makes the demo useful as a runtime architecture reference rather than only as a visual showcase.

### Rendering And Graphics

- `prism-renderer/src/commonMain/kotlin/com/hyeonslab/prism/renderer/WgpuRenderer.kt` uses an explicit four-bind-group PBR layout (scene, object, material, environment), which keeps camera, transform, material, and IBL state separated in a way that should scale better than ad hoc uniform packing.
- The same `WgpuRenderer.kt` keeps an `objectUboPool`, material bind-group cache, texture-view cache, and sampler cache so per-draw transforms and per-material resources can be reused without collapsing all draws onto one mutable buffer.
- `WgpuRenderer.kt` also snapshots `hdrEnabled` at render-pass start and routes HDR frames through a separate `RGBA16Float` render target plus a fullscreen tone-map pass, which is a concrete example of avoiding mid-frame render-target mismatches.
- `prism-renderer/src/commonMain/kotlin/com/hyeonslab/prism/renderer/IblGenerator.kt` generates BRDF LUT, irradiance cubemap, and prefiltered environment cubemap on the CPU and uploads them to GPU textures, which is a useful self-contained PBR/IBL reference when external prebaked assets are unavailable.

### Gameplay Systems

- `prism-demo-core/src/commonMain/kotlin/com/hyeonslab/prism/demo/DemoScene.kt` is more of a technical demo shell than a game, but it still shows a clean pattern for per-frame progressive setup queues, orbit-camera control, and material-environment overrides driven from UI state.
- The current batch did not reveal a deep gameplay, combat, or simulation subsystem; the repository's main value is engine/runtime architecture rather than mature game logic.

### Input And Controls

- `prism-demo-core/src/commonMain/kotlin/com/hyeonslab/prism/demo/DemoScene.kt` maps drag-derived azimuth/elevation deltas onto a clamped orbit camera, which is a small but clear reusable pattern for inspection-style 3D viewers.
- `prism-compose/src/androidMain/kotlin/com/hyeonslab/prism/compose/PrismView.android.kt` separates Android surface lifecycle handling from frame ticking, which matters more here than any higher-level input abstraction because rendering must stop immediately when the surface dies.

### UI, HUD, And Menus

- `prism-compose/src/nonNativeMain/kotlin/com/hyeonslab/prism/compose/EngineState.kt` wraps engine lifecycle, timing, FPS, and surface size in a `StateFlow`-backed MVI store so Compose never mutates engine state directly.
- `prism-demo-core/src/nonNativeMain/kotlin/com/hyeonslab/prism/demo/DemoSceneState.kt` applies the same reducer-style store pattern to the demo controls, which gives the lab a lightweight reference for keeping game-facing sliders/toggles outside the renderer itself.
- `prism-compose/src/androidMain/kotlin/com/hyeonslab/prism/compose/PrismView.android.kt` drives rendering with `withFrameNanos`, smooths FPS updates inside the UI store, and explicitly guards against `surfaceDestroyed` racing with async `createPrismSurface()`.

### Physics And Collision

- No meaningful physics or collision subsystem was reviewed in depth in this batch; the current repository snapshot is stronger as a rendering/runtime reference than as a physics reference.

### Tooling, Android Integration, Or Other Notable Areas

- `prism-native-widgets/src/commonMain/kotlin/com/hyeonslab/prism/widget/PrismSurface.kt` defines an expect/actual surface abstraction, while `prism-native-widgets/src/androidMain/kotlin/com/hyeonslab/prism/widget/PrismSurface.android.kt` creates a Vulkan-backed `WGPUContext` from `SurfaceHolder`, giving the lab a direct reference for hiding platform surface setup behind a small API.
- `prism-android-demo/src/main/kotlin/com/hyeonslab/prism/demo/PrismDemoActivity.kt` uses a thin `SurfaceView` + `Choreographer` shell around the shared demo scene, which is a useful counterpoint to the Compose-based embedding path.
- `prism-assets/src/commonMain/kotlin/com/hyeonslab/prism/assets/GltfLoader.kt` has a valuable progressive-loading seam: `loadStructure()` parses the scene and records raw compressed image bytes or byte ranges first, then lets the caller upload textures later and invalidate only the affected material bind groups.
- `prism-assets/src/commonMain/kotlin/com/hyeonslab/prism/assets/GlbReader.kt` adds basic GLB bounds checking and records `binOffset`, which enables zero-copy native-buffer slicing for WASM progressive texture decode.
- `prism-assets/src/commonMain/kotlin/com/hyeonslab/prism/assets/AssetManager.kt` shows a simple extension-keyed asset-loader registry, but its `update()` queue remains a stub, so the higher-level asset story is promising but not yet fully mature.
- `prism-assets/src/commonTest/kotlin/com/hyeonslab/prism/assets/GltfLoaderTest.kt`, `prism-renderer/src/commonTest/kotlin/com/hyeonslab/prism/renderer/IblGeneratorTest.kt`, and `prism-demo-core/src/commonTest/kotlin/com/hyeonslab/prism/demo/DemoStoreTest.kt` together show that the repo is not test-free: parsing edge cases, IBL math invariants, and reducer behavior are all covered with focused common tests.

## Reusable Takeaways

- Keep the core loop capable of both owning its own while-loop and advancing from external frame schedulers so the same runtime can work under `SurfaceView`, Compose, iOS, and WASM.
- Separate native-surface creation from engine state using a small expect/actual boundary such as `PrismSurface`, then let platform shells choose whether they embed that surface through a direct activity or through Compose.
- Progressive glTF loading can stay practical if structure parse, texture decode, GPU upload, and material-cache invalidation are separate steps instead of one blocking load call.
- A WebGPU/PBR renderer can stay understandable if per-scene, per-object, per-material, and per-environment data are split into explicit bind-group layers and backed by small reusable caches.
- CPU-side IBL generation is viable as a portable fallback when a project needs PBR lighting but does not want to depend on external prebaked environment assets.

## Evidence Summary

- `settings.gradle.kts` - module map plus load-bearing `mavenLocal()` routing for snapshot dependencies
- `gradle/libs.versions.toml` - AGP/Kotlin/Android SDK and `wgpu4k` snapshot coordinates
- `gradle/gradle-daemon-jvm.properties` - generated Gradle daemon toolchain metadata
- `prism-core/src/commonMain/kotlin/com/hyeonslab/prism/core/Engine.kt` - subsystem lifecycle
- `prism-core/src/commonMain/kotlin/com/hyeonslab/prism/core/GameLoop.kt` - fixed-step + external tick loop
- `prism-ecs/src/commonMain/kotlin/com/hyeonslab/prism/ecs/World.kt` - lightweight ECS container
- `prism-ecs/src/commonMain/kotlin/com/hyeonslab/prism/ecs/systems/RenderSystem.kt` - renderer-as-system composition
- `prism-renderer/src/commonMain/kotlin/com/hyeonslab/prism/renderer/WgpuRenderer.kt` - PBR/HDR renderer, caches, tone mapping
- `prism-renderer/src/commonMain/kotlin/com/hyeonslab/prism/renderer/IblGenerator.kt` - CPU IBL generation
- `prism-assets/src/commonMain/kotlin/com/hyeonslab/prism/assets/GltfLoader.kt` - progressive glTF structure/image pipeline
- `prism-assets/src/commonMain/kotlin/com/hyeonslab/prism/assets/GlbReader.kt` - GLB parsing and bounds checks
- `prism-assets/src/commonMain/kotlin/com/hyeonslab/prism/assets/AssetManager.kt` - asset-loader registry surface
- `prism-native-widgets/src/commonMain/kotlin/com/hyeonslab/prism/widget/PrismSurface.kt` - cross-platform surface boundary
- `prism-native-widgets/src/androidMain/kotlin/com/hyeonslab/prism/widget/PrismSurface.android.kt` - Android Vulkan surface creation
- `prism-compose/src/nonNativeMain/kotlin/com/hyeonslab/prism/compose/EngineState.kt` - Compose-facing engine store
- `prism-compose/src/androidMain/kotlin/com/hyeonslab/prism/compose/PrismView.android.kt` - Android Compose render loop and surface lifecycle
- `prism-demo-core/src/commonMain/kotlin/com/hyeonslab/prism/demo/GltfDemoScene.kt` - progressive scene setup and texture upload
- `prism-demo-core/src/nonNativeMain/kotlin/com/hyeonslab/prism/demo/DemoSceneState.kt` - reducer-driven demo UI state
- `prism-android-demo/src/main/kotlin/com/hyeonslab/prism/demo/PrismDemoActivity.kt` - direct Android `SurfaceView` + `Choreographer` shell
- `prism-assets/src/commonTest/kotlin/com/hyeonslab/prism/assets/GltfLoaderTest.kt`, `prism-renderer/src/commonTest/kotlin/com/hyeonslab/prism/renderer/IblGeneratorTest.kt`, and `prism-demo-core/src/commonTest/kotlin/com/hyeonslab/prism/demo/DemoStoreTest.kt` - focused common-test coverage

## Risks Or Limits

- `README.md` explicitly says the repository is an experiment being "vibe-coded with Claude", so even accepted patterns should be treated as promising references rather than as production-proven guidance.
- Ecosystem signal is currently extremely weak because the repository had only `1` star at selection time.
- Build reproducibility is currently fragile: the repository depends on `mavenLocal()` snapshot artifacts (`wgpu4k 0.2.0-SNAPSHOT`) plus JDK `25` / `21+` toolchains, and the lab could not get even lightweight discovery tasks to complete.
- The ECS layer is intentionally simple and map-backed rather than a proven high-performance archetype ECS, so it should be read as a clarity-first architecture sample.
- The strongest value is renderer/runtime/platform architecture, not finished gameplay systems or production Android packaging maturity.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `3d`, `android`, `multiplatform`, `ecs`, `scene-graph`, `shader`, `asset-pipeline`, `performance`
- Follow-up needed:
  - if the lab revisits this repository later, rerun Gradle discovery in a JDK `25` + prepared-`mavenLocal` environment and compare its WebGPU/Compose/Android surface lifecycle choices against other accepted engine references instead of reopening the whole monorepo blindly
