# Research Note

## Repository Snapshot

- Repository: `AndreasHefti/flyko-lib`
- Source URL: [https://github.com/AndreasHefti/flyko-lib](https://github.com/AndreasHefti/flyko-lib)
- Owner: `AndreasHefti`
- Batch ID: [`BATCH-2026-06-05-A`](../batches/BATCH-2026-06-05-A.md)
- Type: `engine-framework`
- License: `Apache-2.0`
- Selection date: `2026-06-05`
- Last pushed at selection: `2023-06-09`
- Stars at selection: `11`
- Default branch at selection: `master`
- Investigated commit: `0bbd8c2d946d86119356a100b8ae46519e3ade48`
- Research status: `accepted`
- Build mode: `static-review + gradle-version + gradle-help-failed-konan-home-permission`
- Catalog card: [catalog/projects/andreashefti-flyko-lib.md](../../catalog/projects/andreashefti-flyko-lib.md)

## Why This Repository Was Selected

- `flyko-lib` was the next carried-over exact-license candidate after the completed `Naijaludo` batch.
- The main question for this pass was whether the repository is only a thin multiplatform promise, or a real reusable Kotlin game-framework codebase.
- The answer is `accepted`: it is a real 2D engine library with substantial common runtime code, a desktop backend, and meaningful tests, even though its Android and broader multiplatform story is still unfinished.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Kotlin Multiplatform ECS-style 2D framework over libGDX LWJGL3 on JVM
- Rendering stack: common rendering abstractions plus JVM `libGDX` / `LWJGL3` backend
- Android target: not implemented in the checked-in revision; Android relevance is indirect through shared Kotlin runtime patterns
- Build system: Gradle `6.8` wrapper + Kotlin Multiplatform `1.7.20` + JVM target `11`
- Repository layout summary:
  - `src/commonMain/` - core runtime, ECS, rendering, gameplay helpers, AI, contact/collision, tile/world loaders
  - `src/jvmMain/` - desktop backend and low-level API implementations
  - `src/jsMain/` - platform stubs with `TODO()` implementations
  - `src/nativeMain/` - platform stubs with `TODO()` implementations
  - `src/jvmTest/` - unit and example-heavy test surface
  - `docs/` - architecture image and API skeleton notes
- Source footprint:
  - total files counted in repository: `241`
  - Kotlin/Kotlin DSL/Java files counted in repository: `162`
- Test surface:
  - files matching `*Test.kt`: `26`
  - the visible test surface is meaningful for a small engine repo: core lifecycle, collections, geometry, rendering/view logic, tiles, JSON/Tiled loading, and several runnable example-style tests
- Key modules reviewed:
  - `README.md`
  - `build.gradle.kts`
  - `settings.gradle.kts`
  - `src/commonMain/kotlin/com/inari/firefly/core/Engine.kt`
  - `src/commonMain/kotlin/com/inari/firefly/core/Component.kt`
  - `src/commonMain/kotlin/com/inari/firefly/core/Entity.kt`
  - `src/commonMain/kotlin/com/inari/firefly/graphics/view/View.kt`
  - `src/commonMain/kotlin/com/inari/firefly/physics/contact/ContactScan.kt`
  - `src/commonMain/kotlin/com/inari/firefly/game/world/TiledJsonBinding.kt`
  - `src/commonMain/kotlin/com/inari/firefly/core/api/GraphicsAPI.kt`
  - `src/jvmMain/kotlin/com/inari/firefly/DesktopApp.kt`
  - `src/jsMain/kotlin/com.inari.firefly.core.api/GraphicsAPIImpl.kt`
  - `src/nativeMain/kotlin/com.inari.firefly.core.api/GraphicsAPIImpl.kt`
  - `src/jvmTest/kotlin/com/inari/firefly/core/ComponentTest.kt`
  - `src/jvmTest/kotlin/com/inari/firefly/graphics/view/ViewSystemTest.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` failed at first because the wrapper tried to write under the blocked user home path:
  - `Could not create parent directory for lock file C:\Users\Username\.gradle\wrapper\dists\...`
- After redirecting `GRADLE_USER_HOME` into the cloned worktree, `cmd /c gradlew.bat --version` succeeded and bootstrapped Gradle `6.8`.
- `cmd /c gradlew.bat help --no-daemon` then progressed far enough to confirm the build shape, but failed while Kotlin/Native tooling tried to unpack under the blocked global Konan home:
  - `Please wait while Kotlin/Native compiler 1.7.20 is being installed.`
  - unpack path attempted under `C:\Users\Username\.konan\...`
- That failure shape is an environment limitation plus old KMP native tooling behavior, not a clear proof that the repository itself is broken.
- The checked-in build also shows that the multiplatform claim is only partially realized:
  - `jvmMain` is real and substantial
  - `jsMain` and `nativeMain` low-level API implementations are almost entirely `TODO("Not yet implemented")`
  - the README explicitly says Android JVM implementation is not done yet

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - `flyko-lib` is not an Android-ready engine, but it is a real Kotlin game-framework codebase with reusable ECS, rendering, contact, Tiled-loading, and lifecycle patterns.
  - Its strongest value is as an architectural reference for shared-core game runtime design rather than as a drop-in mobile stack.
  - The repository is held back by unfinished non-JVM backends and somewhat sprawling internal API style, but the implementation depth is still high enough for the main catalog.

## Interesting Findings

### Engine Architecture And Core Loop

- `src/commonMain/kotlin/com/inari/firefly/core/Engine.kt` shows a deliberately centralized engine singleton that keeps graphics, audio, input, timer, and resource services behind explicit low-level API seams instead of scattering platform calls through gameplay code.
- The same `Engine.kt` uses event-dispatched `update`, `render`, and `postRender` phases rather than a monolithic hard-coded loop, which is a useful reference for Kotlin game runtimes that need modular system wiring.
- `src/commonMain/kotlin/com/inari/firefly/core/Component.kt` implements a custom indexed component model with lifecycle states (`initialized`, `loaded`, `active`) and named keys, which is more structured than a toy ECS but still lighter than a large editor engine.
- `src/commonMain/kotlin/com/inari/firefly/core/Entity.kt` shows a second entity-side component layer with pooled `EntityComponent` instances, aspect bitsets, and reuse caches for entity and component recycling.
- `src/jvmMain/kotlin/com/inari/firefly/DesktopApp.kt` is a clear host-runtime adapter: desktop bootstrapping, renderer initialization, system-font setup, and engine updates are kept out of `commonMain`.

### Rendering And Graphics

- `src/commonMain/kotlin/com/inari/firefly/graphics/view/View.kt` is one of the better takeaways in the repo:
  - base view plus virtual views
  - optional render targets
  - view-owned shaders
  - viewport-fit logic
  - reload-on-state-change behavior for render routing
- `src/commonMain/kotlin/com/inari/firefly/core/api/GraphicsAPI.kt` defines a strong backend seam for views, textures, sprites, shaders, shape rendering, and framebuffer-style flush flow.
- The rendering stack is explicitly designed around multiple viewports and render-to-texture composition rather than a single flat canvas, which is still useful for Android even though the checked-in Android backend does not exist yet.
- The repo also includes a broad GLSL bundle under `src/commonMain/resources/firefly/glsl/`, which reinforces that the engine is designed around real shader-driven rendering rather than only sprite blitting.

### Gameplay Systems

- `src/commonMain/kotlin/com/inari/firefly/game/world/TiledJsonBinding.kt` is a practical reference for loading Tiled-authored maps and tilesets into a custom Kotlin runtime without binding the game logic directly to Tiled DTOs.
- The same world package shows reusable `TileSet`, `TileMap`, `Room`, and `Area` ownership patterns for grid/tile games.
- `src/commonMain/kotlin/com/inari/firefly/game/actor/Player.kt` and nearby helpers show that the engine is trying to ship higher-level gameplay utilities, not only raw rendering primitives.

### Input And Controls

- Input is abstracted through `src/commonMain/kotlin/com/inari/firefly/core/api/InputAPI.kt` plus platform implementations, keeping gameplay input consumption shared even when backend details differ.
- `DesktopApp.setExitKey()` and related patterns in the desktop host are simple, but they show a good seam: platform input hooks stay at the edge while engine systems consume normalized events.

### Physics And Collision

- `src/commonMain/kotlin/com/inari/firefly/physics/contact/ContactScan.kt` is a meaningful subsystem rather than a placeholder:
  - simple and full contact scans
  - contact-type and material filtering
  - bitmask-backed contact intersections
  - circle vs rect collision handling
- The contact system is more nuanced than naive AABB-only hobby code and is worth keeping as a reusable reference for tile or platformer engines.
- `src/commonMain/kotlin/com/inari/firefly/physics/movement/MovementSystem.kt` and related movement components show a clear split between transform/movement state and contact-resolution behavior.

### Build, Release, And Testing

- The build is old but readable:
  - one KMP module
  - JVM, JS, and host-native targets
  - JUnit on JVM
  - Maven publishing enabled
- `src/jvmTest/kotlin/com/inari/firefly/core/ComponentTest.kt` shows real lifecycle verification rather than template-only tests.
- `src/jvmTest/kotlin/com/inari/firefly/graphics/view/ViewSystemTest.kt` confirms that view creation and controller activation are actually asserted.
- The test tree also includes many example-style executable scenarios, which is not ideal as pure unit-test design but still raises the repository above a documentation-only engine stub.

## Reusable Takeaways

- Keep platform graphics/input/audio APIs behind a strict shared-core interface so the gameplay runtime can stay in `commonMain`.
- A small engine can still gain a lot from explicit lifecycle states like initialize/load/activate/deactivate instead of relying only on constructor side effects.
- Viewports, offscreen targets, and shader ownership are worth modeling at the engine layer even in 2D stacks, especially when later Android ports may need layered UI/world rendering.
- Tiled import code is more reusable when it is converted into neutral runtime attributes and world structures rather than exposed directly to gameplay systems.

## Evidence Summary

- `Engine.kt`, `Component.kt`, and `Entity.kt` - shared runtime lifecycle, ECS-ish ownership, and pooled entity/component patterns
- `View.kt` and `GraphicsAPI.kt` - explicit rendering/view abstraction and render-target pipeline
- `ContactScan.kt` - bitmask-aware contact and collision scanning
- `TiledJsonBinding.kt` - Tiled-to-runtime content import seam
- `DesktopApp.kt` - clean JVM host adapter over the shared runtime
- `jsMain` and `nativeMain` API impl files - verified incompleteness of non-JVM backends
- `ComponentTest.kt` and `ViewSystemTest.kt` - confirmed non-trivial test intent

## Risks Or Limits

- The Android backend is not implemented in the inspected revision; Android relevance is indirect, not direct.
- `jsMain` and `nativeMain` are mostly backend stubs with `TODO()` implementations, so the multiplatform claim is only partially true in practice.
- The codebase is active only historically; last push at selection was `2023-06-09`, so this is not a fresh engine baseline.
- The internal API style is powerful but sprawling: several subsystems use custom abstractions and generated-key patterns that would need careful onboarding before reuse.
- Local Gradle validation in the lab could not fully configure the project because Kotlin/Native tooling tries to write under blocked global home paths.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `engine-framework`
- Focus tags: `2d`, `multiplatform`, `ecs`, `rendering`, `collision`, `testing`
- Follow-up needed:
  - if the lab revisits this repository, do it in an environment with writable Gradle and Konan homes and keep the scope narrow: shared runtime lifecycle, the view/render-target pipeline, the contact system, or the Tiled-loading seam instead of reopening the whole repository broadly
