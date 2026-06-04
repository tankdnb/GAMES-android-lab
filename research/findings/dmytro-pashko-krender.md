# Research Note

## Repository Snapshot

- Repository: `Dmytro-Pashko/KRender`
- Source URL: [https://github.com/Dmytro-Pashko/KRender](https://github.com/Dmytro-Pashko/KRender)
- Owner: `Dmytro-Pashko`
- Batch ID: [`BATCH-2026-06-04-I`](../batches/BATCH-2026-06-04-I.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-06-03`
- Stars at selection: `2`
- Default branch at selection: `feature/v2`
- Investigated commit: `1340df930963ea14a3d4d02c7f666202a9f3d17a`
- Research status: `accepted`
- Build mode: `static-review + gradle-help + core-test-dry-run`
- Catalog card: [catalog/projects/dmytro-pashko-krender.md](../../catalog/projects/dmytro-pashko-krender.md)

## Why This Repository Was Selected

- `KRender` was the next verified candidate in the compact explicit-license shortlist and had the strongest current balance of freshness, direct Android relevance, and expected architecture yield.
- The repository is explicitly framed as a small Kotlin engine and toolset rather than as a narrow one-game sample, and the checked-in tree includes both an Android app module and a desktop/editor workflow.
- The main question for this pass was whether `KRender` is already a real reusable engine reference or still mostly a scaffold. The answer is that it is still evolving, but the current revision already contains enough working runtime, tooling, and tests to justify keeping it in the main catalog.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Kotlin engine with backend-neutral core APIs, a LibGDX runtime backend, and built-in editor tools
- Rendering stack: backend-neutral render commands consumed by a LibGDX / OpenGL / `gdx-gltf` 3D renderer, with dynamic terrain meshes, debug rendering, and ImGui-based editor overlays
- Android target: direct; the repository includes an `android` app module alongside shared `core` runtime code and a desktop `lwjgl3` launcher
- Build system: Gradle multi-module workspace with `android`, `core`, and `lwjgl3` modules
- Repository layout summary:
  - `core/` contains the engine runtime, ECS, render commands, terrain pipeline, runtime UI, scene tooling, and editor scenes
  - `android/` contains the Android application shell and Android-specific asset/native preparation tasks
  - `lwjgl3/` contains the desktop launcher and packaging tasks
  - `assets/` and `docs/` provide runtime content plus tool screenshots and documentation
- Source footprint:
  - total files counted in repository: `310`
  - Kotlin/Java/Gradle files counted in repository: `143`
- Test surface:
  - test files found: `26`
  - meaningful automated tests found: `26`
- Key modules reviewed:
  - `README.md`
  - `settings.gradle`
  - `build.gradle`
  - `gradle.properties`
  - `gradle/gradle-daemon-jvm.properties`
  - `android/build.gradle`
  - `core/build.gradle`
  - `lwjgl3/build.gradle`
  - `core/src/main/kotlin/com/pashkd/krender/engine/api/EngineRuntime.kt`
  - `core/src/main/kotlin/com/pashkd/krender/engine/api/Scene.kt`
  - `core/src/main/kotlin/com/pashkd/krender/engine/api/Ecs.kt`
  - `core/src/main/kotlin/com/pashkd/krender/engine/api/Render.kt`
  - `core/src/main/kotlin/com/pashkd/krender/engine/api/Input.kt`
  - `core/src/main/kotlin/com/pashkd/krender/engine/api/Assets.kt`
  - `core/src/main/kotlin/com/pashkd/krender/engine/backend/gdx/LibGdxBackend.kt`
  - `core/src/main/kotlin/com/pashkd/krender/engine/render3d/Components3D.kt`
  - `core/src/main/kotlin/com/pashkd/krender/engine/render3d/RuntimeEnvironmentSystem.kt`
  - `core/src/main/kotlin/com/pashkd/krender/engine/runtimeui/RuntimeUiService.kt`
  - `core/src/main/kotlin/com/pashkd/krender/engine/scene/SceneSerializer.kt`
  - `core/src/main/kotlin/com/pashkd/krender/game/RuntimeScene.kt`
  - `core/src/main/kotlin/com/pashkd/krender/game/RuntimeSceneBuilder.kt`
  - `core/src/main/kotlin/com/pashkd/krender/game/AssetBrowserScene.kt`
  - `core/src/main/kotlin/com/pashkd/krender/game/SceneEditorScene.kt`
  - `core/src/test/kotlin/com/pashkd/krender/game/RuntimeSceneTest.kt`
  - `core/src/test/kotlin/com/pashkd/krender/game/RuntimeSceneBuilderTest.kt`
  - `core/src/test/kotlin/com/pashkd/krender/engine/render3d/RuntimeEnvironmentFactoryTest.kt`
  - `core/src/test/kotlin/com/pashkd/krender/engine/runtimeui/RuntimeUiServiceTest.kt`
  - `core/src/test/kotlin/com/pashkd/krender/engine/scene/SceneSerializerTest.kt`
  - `core/src/test/kotlin/com/pashkd/krender/engine/terrain/TerrainRuntimePipelineTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `9.4.0`; the wrapper is launched from the lab's Java `8` environment, but Gradle resolves a compatible daemon/toolchain path from `gradle/gradle-daemon-jvm.properties`.
- `cmd /c gradlew.bat help --no-daemon` succeeds.
- `cmd /c gradlew.bat :core:test --dry-run --no-daemon` also succeeds, which is stronger local verification than many recent lab batches reached.
- The checked-in build surface is modern and explicit:
  - Android Gradle Plugin `8.9.3`
  - Kotlin `2.2.21`
  - `gradle/gradle-daemon-jvm.properties` pins `toolchainVersion=21`
  - `android/build.gradle` targets `compileSdk 35`, `minSdkVersion 21`, and `targetSdkVersion 35`
  - root `build.gradle` generates a shared asset list and keeps non-Android JVM targets on Java/Kotlin level `11`
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `3`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `KRender` already demonstrates a coherent engine shape instead of only a README-level plan.
  - The most reusable value is the combination of backend-neutral runtime APIs, deferred ECS mutations, render-command submission, scene serialization, terrain/runtime scene loading, and built-in editor tooling.
  - It is not yet a proven production engine, but it is a strong current reference for Kotlin-first engine architecture with a direct Android path.

## Interesting Findings

### Engine Architecture And Core Loop

- `EngineRuntime.kt` is the clearest architecture seam in the repository. `EngineRuntime` owns the frame loop, `SceneManager`, runtime stats/profiler boundaries, asset updates, and render submission, while `EngineContext` exposes scenes, assets, input, UI, runtime UI, tasks, viewport, logs, window control, and exit requests to scene code through one stable facade.
- The frame pipeline is explicit and readable: UI frame begin, input snapshot, main-thread task flush, asset update, pending scene transitions, fixed updates, normal update, late update, runtime UI update, UI frame end, render-command collection, renderer submission, runtime UI render, editor UI render, and input/stats finalization.
- `Scene.kt` keeps scene transitions deferred through `SceneManager` operations (`Replace`, `Push`, `Pop`) so scene-stack changes happen at safe points instead of inside arbitrary update logic.
- `Ecs.kt` shows a pragmatic ECS: class-keyed components, typed `query` helpers, a phased `SystemPipeline`, and a `CommandBuffer` that defers entity/component mutation while systems iterate. That is not high-performance archetype ECS, but it is reusable and easy to audit.
- `RuntimeScene.kt` and `RuntimeSceneBuilder.kt` demonstrate that the scene tooling is not cosmetic only. Runtime scenes are loaded from serialized descriptors, validated, converted into `SceneWorld` entities, wired with terrain/environment systems, and then run through the same engine loop as tool scenes.

### Rendering And Graphics

- `Render.kt` defines a backend-neutral render surface with `DrawModel`, `DrawDynamicModel`, `DrawLine`, `DrawWorldGrid`, `DrawWorldAxes`, `DrawText`, and `ApplyEnvironment`. That keeps scene systems talking in engine terms instead of directly touching LibGDX model instances.
- `ModelRenderSystem` and the terrain runtime systems collect render commands into `RenderCommandBuffer`, while `GdxRenderer3D` resolves those commands into concrete LibGDX rendering passes. This split is one of the strongest transferable ideas in the repository.
- `GdxRenderer3D` is more substantial than a minimal sample backend: it handles static models, glTF scenes, dynamic terrain meshes, wireframe overlays, shader debug rendering, PBR preview rendering, skybox/environment commands, and runtime-generated textures.
- The terrain pipeline is especially useful for the lab. `TerrainRenderSystem`, `RuntimeTerrainMeshSystem`, and the related bake services produce `DynamicModel` meshes plus runtime texture payloads instead of forcing terrain through a file-backed mesh pipeline.
- `RuntimeEnvironmentSystem.kt` shows a small but clean pattern for treating skybox/ambient/environment setup as just another render command, which keeps scene configuration backend-neutral.

### Input And Controls

- `Input.kt` defines a normalized engine input model with keys, mouse buttons, pointer phases, actions, axes, UI-capture flags, and frame-stable snapshots. The core runtime never depends directly on LibGDX input types.
- `GdxInputService` in `LibGdxBackend.kt` converts LibGDX keyboard, mouse, scroll, and pointer callbacks into `InputSnapshot`, including one-frame pressed/released sets, pointer tracking, and optional cursor capture.
- The same input service also tracks UI capture state so editor/runtime UI can suppress gameplay input when needed. That is a practical seam for mixed tool/runtime workflows.
- The action/axis helpers are intentionally small, but they already provide a reusable baseline for engine-owned controls such as editor cameras or runtime sandbox scenes.

### UI, HUD, And Menus

- `RuntimeUiService.kt` keeps runtime UI layers ordered and backend-driven. `Hud`, `Modal`, and `Overlay` are synchronized deterministically, while custom layers are still allowed. That is a good small pattern for in-game runtime UI that should not be tightly coupled to one editor UI system.
- `AssetBrowserScene.kt` and `SceneEditorScene.kt` show the repository's real bias: editor tooling is treated as part of the engine, not as a separate later add-on. Panels, operations services, registry/model state, and layout tracking are all wired into the same scene/runtime model.
- The scene editor path is especially notable because it uses a separate `SceneWorld` for edited document state while still hosting the editor itself inside the engine runtime. That keeps editable scene data and editor-camera/tool state from being conflated.

### Tooling And Content Pipeline

- `AssetBrowserScene.kt` wires asset registry scanning, default asset creation, tool dispatch, metadata details, and open-with flows into one reusable asset-tool scene. This is much closer to a real tool pipeline than to a toy debug screen.
- `SceneSerializer.kt` is a durable reference for content persistence. It round-trips entities, transforms, cameras, lights, model references, terrain references, nested scene settings, and backward-compatible legacy lighting/environment formats into `.krscene` JSON.
- `RuntimeSceneTest.kt`, `RuntimeSceneBuilderTest.kt`, and `SceneSerializerTest.kt` show that the scene pipeline is not only architected but also tested as a data format and loader flow.
- The repository structure itself is useful: shared `assets/`, a core runtime, a desktop tool shell, and an Android app module all consume the same engine/content surface rather than maintaining separate implementations.

### Android Platform Integration

- `android/build.gradle` confirms that Android is a first-class target, not a speculative note. The module is configured as an Android application with `compileSdk 35`, `minSdkVersion 21`, and `targetSdkVersion 35`.
- The Android module includes explicit `prepareAndroidAssets` and `copyAndroidNatives` tasks, which is a practical reference for LibGDX-style asset and native-library preparation in Kotlin Android game workspaces.
- `LibGdxBackend` switches to `NoOpUiService()` on Android while keeping the richer ImGui editor UI on desktop. That is a clean example of one shared engine core supporting different host capabilities without `if (android)` branches leaking everywhere.
- Because the repository also keeps `lwjgl3` as the richer desktop tool host, it models a useful pattern for Android game teams that want one runtime/core plus a better desktop tooling shell.

### Performance And Memory

- `EngineRuntime` clamps oversized frame deltas and uses a fixed-step accumulator, which is still one of the cleanest baseline runtime patterns for deterministic gameplay systems.
- The ECS command buffer defers entity/component changes until safe points, reducing iterator invalidation and keeping system phases predictable.
- `GdxAssetService` is more than a thin loader wrapper. It caches model metadata, triangle counts, skeletons, bounds, texture preview handles, runtime textures, and pose-sampling state, which reduces repeated expensive inspection work in viewer/editor tools.
- The terrain runtime path also favors generated meshes and cached baked textures over re-importing terrain data every frame, which is the right shape for a tool-heavy engine.

### Build, Release, And Testing

- `KRender` currently has one of the healthier local verification surfaces in the lab. `gradlew help` and `:core:test --dry-run` both work in the inspected clone.
- The checked-in tests cover meaningful engine seams rather than only helpers: runtime scene loading, runtime environment derivation, runtime UI layering, scene serialization, terrain material baking/runtime mesh generation, and several viewer/tooling paths.
- `gradle/gradle-daemon-jvm.properties` plus the module build scripts make the expected Java toolchain explicit, which reduces ambiguity compared with repositories that silently rely on developer-local JDK setup.

## Reusable Takeaways

- A Kotlin game engine stays easier to grow when the runtime core speaks in backend-neutral services and render commands instead of exposing LibGDX objects everywhere.
- Tooling becomes much easier to scale when editors, asset browsers, and runtime scenes all reuse the same scene/world/runtime surface instead of each building a separate host shell.
- Direct Android support does not require giving up a richer desktop tool environment if the repository keeps Android and desktop as host modules around one shared core.
- Scene serialization, runtime validation, and focused pipeline tests are worth adding early even in an experimental engine, because they force the runtime shape to stay coherent.

## Evidence Summary

- `engine/api/EngineRuntime.kt`, `engine/api/Scene.kt`, and `engine/api/Ecs.kt` - explicit runtime/frame ownership, deferred scene transitions, phased systems, and command-buffered ECS mutation
- `engine/api/Render.kt`, `engine/render3d/Components3D.kt`, and `engine/render3d/RuntimeEnvironmentSystem.kt` - backend-neutral render commands and runtime environment submission
- `engine/backend/gdx/LibGdxBackend.kt` - concrete LibGDX backend, normalized input, asset service, Android/desktop UI split, and 3D renderer implementation
- `game/RuntimeScene.kt`, `game/RuntimeSceneBuilder.kt`, and `engine/scene/SceneSerializer.kt` - serialized runtime scenes, validation/build flow, and `.krscene` persistence
- `game/AssetBrowserScene.kt` and `game/SceneEditorScene.kt` - real editor/tool scenes sharing the same runtime surface
- `core/src/test/...` runtime, serializer, terrain, and runtime-UI tests - meaningful verification around several core engine seams

## Risks Or Limits

- The default branch is `feature/v2`, which suggests the inspected surface is still actively evolving rather than stabilized.
- The repository is still more engine-and-editor workspace than ready Android production baseline; the strongest current value is architectural and tooling-oriented reuse.
- The backend implementation is currently very LibGDX-centered, so teams that want a pure Android-native renderer or a Compose-only runtime would still adapt the ideas rather than copy the stack directly.
- The lab did not run a real Android build or launch, so Android value here is verified from source/build structure, not from device/emulator execution.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `3d`, `android`, `ecs`, `libgdx`, `editor-tools`, `asset-pipeline`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, rerun selected `core` tests or Android tasks in a full JDK `21` plus Android SDK-ready environment
  - the best narrow revisit targets would be the render-command/backend boundary, the scene-editor document/runtime split, the runtime UI layering, or the terrain runtime pipeline
