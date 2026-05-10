# Research Note

## Repository Snapshot

- Repository: `littlektframework/littlekt`
- Source URL: [https://github.com/littlektframework/littlekt](https://github.com/littlektframework/littlekt)
- Owner: `littlektframework`
- Batch ID: [`BATCH-2026-05-10-B`](../batches/BATCH-2026-05-10-B.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-05-10`
- Last pushed at selection: `2026-01-17`
- Stars at selection: `394`
- Investigated commit: `169ae1bbbbbeba2e544b38bf4448380274ef48c0`
- Research status: `accepted`
- Build mode: `static-review-only`
- Catalog card: [catalog/projects/littlektframework-littlekt.md](../../catalog/projects/littlektframework-littlekt.md)

## Why This Repository Was Selected

- It is a Kotlin-first engine/framework candidate with a clear "build your own engine" positioning instead of a closed black-box runtime.
- The WebGPU direction makes it a useful contrast against the already researched KorGE and KTX stacks.
- Even though Android support is still in progress, the runtime and asset abstractions are directly useful as architecture references.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: LittleKt
- Rendering stack: WebGPU abstraction over JVM and web backends, with JVM using `wgpu-native` through Java FFM and web using browser WebGPU
- Android target: not yet on the mainline branch; README documents Android support as in progress
- Build system: Gradle Kotlin DSL
- Repository layout summary: compact multiplatform framework with `core`, examples, and convention plugins rather than a very large monorepo
- Key modules reviewed:
  - `core`
  - `examples`
  - platform-specific source sets under `core/src/jvmMain` and `core/src/webMain`

## Build And Runtime Notes

- The repository was investigated through static code review only.
- No build validation was attempted in this batch because the framework explicitly requires JDK 22+ for the current FFM-based JVM backend.
- Known setup limitations:
  - Android support is still tracked as in progress rather than shipped on the inspected branch
  - backend requirements are stricter than typical Android-library research targets

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `3`
- Overall verdict: `accepted`
- Why:
  - the framework contains several reusable runtime patterns even before Android support is fully finished
  - input, asset, callback, and texture-packing layers are portable into other Kotlin game stacks
  - the WebGPU-first direction is technically distinctive inside the Kotlin game ecosystem

## Interesting Findings

### Engine Architecture And Core Loop

- `core/src/commonMain/kotlin/com/littlekt/Context.kt` centralizes the runtime around callback registries for update, post-update, resize, release, and deferred runnables instead of forcing game code into one monolithic application subclass.
- `core/src/jvmMain/kotlin/com/littlekt/LwjglContext.kt` drives a tight frame loop that calculates frame timing, executes pending dispatcher work against the available frame budget, updates audio and input, then runs post-frame runnables.
- `core/src/commonMain/kotlin/com/littlekt/LittleKtApp.kt` keeps application startup intentionally thin, which makes the framework easier to embed into custom launch flows.

### Rendering And Graphics

- `core/src/jvmMain/kotlin/com/littlekt/LwjglContext.kt` explicitly disables the OpenGL client API at window creation time and then configures the render surface/device through the framework's graphics layer, which is a clean backend boundary for a WebGPU-first engine.
- `core/src/commonMain/kotlin/com/littlekt/util/MutableTextureAtlas.kt` shows a practical runtime atlas builder that packs slices, builds atlas metadata, and materializes GPU textures from generated pixmaps.

### Gameplay Systems

- This repository is infrastructure-first rather than game-specific, so the main value is the runtime, asset, and rendering architecture rather than gameplay rules.

### Input And Controls

- `core/src/commonMain/kotlin/com/littlekt/input/InputMapController.kt` maps keyboard, modifier chords, gamepad buttons, axes, and pointer inputs into custom game-defined signals, then composes those signals into axes and vectors. This is a strong pattern for decoupling game actions from raw device events.

### UI, HUD, And Menus

- `core/src/commonMain/kotlin/com/littlekt/util/MutableTextureAtlas.kt` is also valuable for UI and HUD work because it supports combining existing texture slices and atlases into one generated atlas without an external pipeline step.

### Physics And Collision

- Physics and collision were not a major focus of this pass.

### Tooling, Android Integration, Or Other Notable Areas

- `core/src/commonMain/kotlin/com/littlekt/AssetProvider.kt` loads assets asynchronously, tracks progress, prevents duplicate in-flight loads, and separates "load" from "prepare after loading". That split is very reusable for Android game startup flows.
- `core/src/commonMain/kotlin/com/littlekt/Context.kt` exposes resource, URL, and application VFS roots in the same runtime contract, which is a useful portability pattern for cross-platform content loading.

## Reusable Takeaways

- Keep the engine core centered on a platform/runtime context instead of pushing every concern into a giant game class.
- Separate asset IO from post-load preparation so that expensive asset initialization can complete before first meaningful gameplay.
- Normalize input into domain-specific signals early, especially when touch, keyboard, and controller paths all need to coexist.
- Runtime atlas generation is worth keeping in mind for sprite-heavy UI or mod/tooling scenarios.

## Evidence Summary

- `core/src/commonMain/kotlin/com/littlekt/Context.kt` - runtime contract, callback lifecycle, VFS access
- `core/src/jvmMain/kotlin/com/littlekt/LwjglContext.kt` - JVM main loop, WebGPU surface/device setup, frame timing
- `core/src/commonMain/kotlin/com/littlekt/LittleKtApp.kt` - app bootstrap wrapper
- `core/src/commonMain/kotlin/com/littlekt/AssetProvider.kt` - async asset loading and preparation
- `core/src/commonMain/kotlin/com/littlekt/input/InputMapController.kt` - signal-based input abstraction
- `core/src/commonMain/kotlin/com/littlekt/util/MutableTextureAtlas.kt` - runtime texture-atlas construction

## Risks Or Limits

- Mainline Android support is not yet complete on the inspected branch.
- JDK 22+ requirements make quick validation heavier than typical Android research repos.
- No build or runtime validation was attempted in this batch.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `multiplatform`, `input`, `asset-pipeline`, `performance`
- Follow-up needed:
  - inspect the Android branch once it stabilizes if the lab wants direct mobile-backend patterns rather than architecture-only takeaways
