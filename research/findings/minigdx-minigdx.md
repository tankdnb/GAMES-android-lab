# Research Note

## Repository Snapshot

- Repository: `minigdx/minigdx`
- Source URL: [https://github.com/minigdx/minigdx](https://github.com/minigdx/minigdx)
- Owner: `minigdx`
- Batch ID: [`BATCH-2026-05-11-B`](../batches/BATCH-2026-05-11-B.md)
- Type: `engine-framework`
- License: `MIT`
- Selection date: `2026-05-11`
- Last pushed at selection: `2022-10-10`
- Stars at selection: `178`
- Investigated commit: `494b3929176b773dac5226a601e4f26dbcbb3cbe`
- Research status: `accepted`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/minigdx-minigdx.md](../../catalog/projects/minigdx-minigdx.md)

## Why This Repository Was Selected

- Fresh GitHub `updated` searches were again dominated by near-zero-signal repositories, so the strongest remaining path was a stale but still credible backlog candidate.
- `minigdx/minigdx` had better ecosystem signal than the remaining framework backlog, a permissive license, explicit Android support, and enough engine depth to justify a full pass.
- It also complements the previously researched `minigdx/tiny` repository by exposing the lower-level runtime, ECS, rendering, and platform abstractions that `tiny` builds on top of.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: `miniGDX`
- Rendering stack: custom OpenGL/WebGL renderer with shader-program wrappers, framebuffer stages, mesh/sprite pipelines, and LWJGL/OpenGL on JVM plus GLES/WebGL platform adapters
- Android target: direct Android support is implemented through `MiniGdxActivity`, `MiniGdxSurfaceView`, Android-specific GL/input/file handlers, and README platform claims for Android in the supported matrix
- Build system: single-module Gradle Kotlin DSL Kotlin Multiplatform library with Android, JVM, JS, and `macosX64` source sets
- Repository layout summary: one KMP engine module with most engine/runtime code in `commonMain`, platform adapters in `androidMain` / `jvmMain` / `jsMain`, and a meaningful `commonTest` surface for engine, input, collision, viewport, and render-stage behavior
- Key modules reviewed:
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/GameApplicationBuilder.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/GameContext.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/Engine.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/Game.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/GameNode.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/GameWrapper.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/Storyboard.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/render/Stage.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/render/QuadRenderStage.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/render/ModelComponentRenderStage.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/graphics/FrameBuffer.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/graphics/TextureFrameBuffer.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/entities/EntityFactoryDelegate.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/systems/ScriptExecutorSystem.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/script/ScriptContext.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/input/TouchManager.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/graphics/ViewportStrategy.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/file/FileHandlerCommon.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/file/GraphSceneLoader.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/physics/AABBCollisionResolver.kt`
  - `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/physics/SATCollisionResolver.kt`
  - `src/androidMain/kotlin/com/github/dwursteisen/minigdx/MiniGdxActivity.kt`
  - `src/androidMain/kotlin/com/github/dwursteisen/minigdx/internal/MiniGdxSurfaceView.kt`
  - `src/androidMain/kotlin/com/github/dwursteisen/minigdx/PlatformContextCommon.kt`
  - `src/androidMain/kotlin/com/github/dwursteisen/minigdx/input/AndroidInputHandler.kt`
  - `src/androidMain/kotlin/com/github/dwursteisen/minigdx/file/PlatformFileHandler.kt`
  - `src/jvmMain/kotlin/com/github/dwursteisen/minigdx/input/LwjglInput.kt`
  - `src/commonTest/kotlin/com/github/dwursteisen/minigdx/ecs/EngineTest.kt`
  - `src/commonTest/kotlin/com/github/dwursteisen/minigdx/input/TouchManagerTest.kt`
  - `src/commonTest/kotlin/com/github/dwursteisen/minigdx/ecs/physics/SATCollisionResolverTest.kt`
  - `src/commonTest/kotlin/com/github/dwursteisen/minigdx/graphics/FillViewportStrategyTest.kt`
  - `.github/workflows/build.yml`
  - `gradle/libs.versions.toml`

## Build And Runtime Notes

- The repository was investigated primarily through static code review.
- A lightweight Gradle discovery pass was attempted with `cmd /c gradlew.bat help --no-daemon`.
- `java -version` reports `1.8.0_321` in the lab environment, and Gradle fails during version-catalog compilation with `No Java compiler found`, so no meaningful local build validation was possible.
- `.github/workflows/build.yml` shows that upstream CI expected `JDK 11` for `./gradlew ktlintCheck build` at the inspected revision.
- `gradle/libs.versions.toml` shows older but coherent toolchain choices around Android Gradle Plugin `7.2.2`, LWJGL `3.2.3`, and several `LATEST-SNAPSHOT` dependencies for `kotlin-math`, `minigdx-gltf`, and `imgui-light`.
- Known setup limitations:
  - the local lab machine still lacks a full JDK/compiler
  - iOS/native support is still aspirational in README wording and was not verifiable from the inspected source tree
  - reproducibility risk is higher than average because several dependencies are snapshot-based

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - it is a real Kotlin multiplatform engine/runtime with direct Android integration rather than a sample app pretending to be a framework
  - the engine exposes reusable patterns for framebuffer pipelines, scene-to-ECS import, coroutine-based scripts, collision helpers, and platform-neutral input
  - despite age and rough edges, it still provides a better Android-friendly engine reference than the current low-signal fresh GitHub candidates

## Interesting Findings

### Engine Architecture And Core Loop

- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/GameApplicationBuilder.kt` delays game creation until the platform context exists, which avoids early access to GL/input/file resources and is a useful pattern for Android-owned runtime startup.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/Game.kt` defines a clear engine contract: default technical systems, game-specific systems, post-render systems, optional framebuffer graph, normal render stages, and debug stages.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/GameNode.kt` bootstraps a game by wiring systems first, flattening framebuffer dependencies into `gameContext.frameBuffers`, compiling shaders after asset loads, and then calling `engine.onGameStart()`, which is a clean staged startup flow for a small engine.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/Engine.kt` keeps entity updates safe by queueing structural mutations until the next update, routes events through a dedicated `EventQueue`, and enforces that only one storyboard event survives a frame.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/GameWrapper.kt` plus `Storyboard.kt` implement screen/game transitions as nested `GameNode` trees with `switchTo`, `replaceWith`, and `back`, including named-child reuse instead of rebuilding every screen instance blindly.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/systems/ScriptExecutorSystem.kt` runs each `ScriptComponent` inside its own coroutine context, while `ScriptContext.kt` provides `yield`, `emit`, `executeInGameLoop`, `waiting`, and `moveOf` helpers, which is a notable Kotlin-native scripting surface without embedding Lua or JS.

### Rendering And Graphics

- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/render/Stage.kt` wraps shader compilation, camera/light queries, and combined projection-view matrix setup into a reusable `RenderStage` base instead of scattering that logic across each stage.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/graphics/FrameBuffer.kt` models framebuffers as both assets and systems, recursively prepares dependency framebuffers, restores the default framebuffer/viewport after offscreen rendering, and can nominate a single `renderOnScreen` framebuffer as the root of the pipeline.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/graphics/TextureFrameBuffer.kt` auto-inserts a fullscreen `QuadRenderStage` around a fragment shader, which is a practical pattern for chaining post-processing passes without duplicating quad setup per effect.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/render/QuadRenderStage.kt` allocates a reusable fullscreen plane buffer once on game start and then just swaps fragment-shader state before drawing, which keeps the post-process path compact.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/render/ModelComponentRenderStage.kt` handles opaque and transparent primitives differently, sorting alpha primitives back-to-front relative to camera direction and pushing light uniforms per draw call.
- Platform GL shims in `src/androidMain/kotlin/com/github/dwursteisen/minigdx/AndroidGL.kt`, `src/jvmMain/kotlin/com/github/dwursteisen/minigdx/LwjglGL.kt`, and `src/jsMain/kotlin/com/github/dwursteisen/minigdx/WebGL.kt` keep the higher-level rendering code mostly platform-agnostic.

### Gameplay Systems

- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/entities/EntityFactoryDelegate.kt` turns imported scene nodes into ECS entities for cameras, lights, models, armatures, boxes, text, sprites, and particle emitters, which is a strong bridge between authored content and runtime entities.
- The same `EntityFactoryDelegate.kt` builds sprite quads generically and computes sprite-sheet UVs after texture load completion, which is a reusable late-binding pattern for asset-driven sprite animation.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/file/GraphSceneLoader.kt` loads protobuf-backed scenes into a `GraphScene` that already carries `assetsManager`, `fileHandler`, and `jointLimit` options, keeping content-loading context close to imported scenes.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/components/particles/ParticleConfiguration.kt` exposes a compact emitter DSL with generation counters, looping controls, per-particle factory/update hooks, and a ready-made radial `spark` preset.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/Storyboard.kt` and `GameWrapper.kt` together make it possible to express modal screens, nested game states, or lightweight minigame shells without a separate navigation framework.

### Input And Controls

- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/input/TouchManager.kt` normalizes touch and key events into queued `just pressed` and held-state views, and uses an `ObjectPool` for internal events to reduce per-frame allocation churn.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/graphics/ViewportStrategy.kt` and `FillViewportStrategy` centralize aspect-preserving viewport math plus device-to-game coordinate conversion, which is directly reusable for Android devices with varied aspect ratios.
- `src/jvmMain/kotlin/com/github/dwursteisen/minigdx/input/LwjglInput.kt` maps mouse buttons into virtual touches and uses viewport conversion to emulate touch semantics on desktop, which makes Android-style input flows easier to debug on JVM.
- `src/androidMain/kotlin/com/github/dwursteisen/minigdx/input/AndroidInputHandler.kt` attempts to map Android multitouch through the same `TouchManager` interface, so the engine presents a shared input model across Android, desktop, and web.

### UI, HUD, And Menus

- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/Game.kt` always reserves `ImGuiRenderStage` in debug render stages and conditionally adds `BoundingBoxRenderStage`, which treats live inspection overlays as a standard engine capability rather than ad hoc game code.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/entities/EntityFactoryDelegate.kt` creates text entities by pairing a `TextComponent` with a font sprite-backed quad `ModelComponent`, which is a straightforward text/HUD rendering pattern for lightweight engines.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/components/text/*` and `TextEffectSystem` show that animated text effects such as typewriter and wave motion are treated as engine-level reusable components rather than game-local widgets.

### Physics And Collision

- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/physics/AABBCollisionResolver.kt` provides a minimal axis-aligned box overlap path for cheap broad-phase or simple collision use cases.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/physics/SATCollisionResolver.kt` adds a more interesting OBB-style narrow phase: it first short-circuits on bounding-sphere distance, then projects box edges onto rotated local axes for SAT overlap checks.
- `src/commonTest/kotlin/com/github/dwursteisen/minigdx/ecs/physics/SATCollisionResolverTest.kt` verifies translated and rotated cases, which raises confidence above a purely undocumented math helper.

### Tooling, Android Integration, Or Other Notable Areas

- `src/androidMain/kotlin/com/github/dwursteisen/minigdx/MiniGdxActivity.kt` and `internal/MiniGdxSurfaceView.kt` give the engine a direct Android entry path through `GLSurfaceView`, capped delta timing, runtime viewport updates, and keyboard event forwarding to the shared input layer.
- `src/androidMain/kotlin/com/github/dwursteisen/minigdx/PlatformContextCommon.kt` builds Android-specific subsystems cleanly: `AndroidGL`, `AndroidInputHandler`, `FillViewportStrategy`, `AndroidLogger`, and a `SoundPool`-backed file handler.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/file/FileHandlerCommon.kt` caches typed content by filename, routes loads through explicit loader registries, and exposes progress/load-state helpers for higher-level loading screens.
- `src/androidMain/kotlin/com/github/dwursteisen/minigdx/file/PlatformFileHandler.kt` and `src/jvmMain/kotlin/com/github/dwursteisen/minigdx/file/PlatformFileHandler.kt` show a clear split between Android asset loading, JVM jar-or-filesystem fallback, platform texture decoding, and per-platform sound decode/playback.
- `.github/workflows/build.yml` plus the `commonTest` tree show that the repository was not only an engine sketch: it had CI and targeted tests for engine, input, viewport, collision, and render-stage behavior.

## Reusable Takeaways

- A Kotlin game engine can stay small and still support Android, desktop, and web if GL, input, file IO, and viewport math are hidden behind thin platform adapters.
- Framebuffers become much easier to reuse when they are modeled as dependency-aware systems/assets instead of being hardwired into one monolithic renderer.
- Content import is cleaner when authored scene assets are converted into ECS entities through a dedicated factory rather than being consumed directly by rendering code.
- Coroutine-based script components are a pragmatic Kotlin-native alternative to external scripting languages for short gameplay flows, cutscenes, and event-driven entity logic.
- Typed asset caches plus delayed `onLoad` hooks are a good fit for sprite-sheet UV generation and other content that depends on late-arriving texture metadata.

## Evidence Summary

- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/Game.kt` - engine contract for systems, framebuffers, render stages, and debug stages
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/GameNode.kt` - staged bootstrap, framebuffer graph flattening, shader compilation order
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/Engine.kt` - queued structural updates, event routing, storyboard-event guard
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/game/GameWrapper.kt` and `Storyboard.kt` - nested game-node transitions and reusable screen switching
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/render/Stage.kt` - common camera/light shader stage base
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/graphics/FrameBuffer.kt` and `TextureFrameBuffer.kt` - dependency-aware post-processing/render pipeline
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/render/ModelComponentRenderStage.kt` - mesh rendering, lighting uniforms, transparent sorting
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/entities/EntityFactoryDelegate.kt` - scene-to-ECS import, runtime sprite quad/UV generation, templates
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/systems/ScriptExecutorSystem.kt` and `ecs/script/ScriptContext.kt` - coroutine scripting surface and frame-yield helpers
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/input/TouchManager.kt` and `graphics/ViewportStrategy.kt` - normalized input state and aspect-safe coordinate conversion
- `src/androidMain/kotlin/com/github/dwursteisen/minigdx/MiniGdxActivity.kt`, `internal/MiniGdxSurfaceView.kt`, and `PlatformContextCommon.kt` - direct Android runtime integration
- `src/commonTest/kotlin/com/github/dwursteisen/minigdx/ecs/EngineTest.kt`, `input/TouchManagerTest.kt`, `ecs/physics/SATCollisionResolverTest.kt`, and `graphics/FillViewportStrategyTest.kt` - targeted engine/input/collision/viewport tests

## Risks Or Limits

- The repository is stale by the lab's standards: last push at selection was `2022-10-10`.
- `gradle/libs.versions.toml` depends on several `LATEST-SNAPSHOT` libraries, which weakens long-term reproducibility.
- Local build validation could not progress beyond `gradlew help` because the lab machine still has only Java `8` runtime bits and no full JDK/compiler, while upstream CI expected `JDK 11`.
- `src/androidMain/kotlin/com/github/dwursteisen/minigdx/input/AndroidInputHandler.kt` uses `event.action` and calls `getX(pointerId)` / `getY(pointerId)` with a pointer id rather than a pointer index, so proper Android multitouch handling is likely unreliable on the inspected revision.
- `src/commonMain/kotlin/com/github/dwursteisen/minigdx/ecs/script/ScriptContext.kt` computes `moveOf()` per-axis speed as `duration / distance` instead of `distance / duration`, so non-unit scripted moves appear to have incorrect timing.
- README still frames iOS/native as expected future targets rather than something verifiable in the inspected repository tree, so the multiplatform story should be treated as JVM/JS/Android-first in practice.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `3d`, `android`, `multiplatform`, `ecs`, `collision`, `input`, `shader`, `testing`
- Follow-up needed:
  - if a later pass is worthwhile, verify the build/test surface in a real JDK `11` environment and check whether the snapshot dependency chain is still healthy
  - if Android-specific reuse becomes important, review the multitouch adapter and script helper math before treating the engine as a drop-in mobile runtime reference
