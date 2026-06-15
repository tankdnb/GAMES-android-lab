# AxieFeat/Arc

- Repository: [AxieFeat/Arc](https://github.com/AxieFeat/Arc)
- Repository type: `engine-framework`
- Final status: `accepted`
- Reviewed on: `2026-06-15`
- License: `MIT`
- Stars at review: `1`
- Last pushed at review: `2026-03-26`
- Default branch: `master`
- Investigated commit: `HEAD on 2026-06-15 local clone`
- Build mode: `static-review + gradle-help-failed-no-jdk-compiler`

## What This Repository Is

`Arc` is a modular Kotlin game-engine workspace centered on a backend-neutral core API, with concrete OpenGL, OpenGLES/ANGLE, and Vulkan modules plus optional extensions for audio, input, display, font, model loading, and profiling.

The checked-in demo is desktop-first and GLFW-driven, but the repository is materially more than a toy sample: it already shows a deliberate separation between engine contracts, platform or graphics backends, and optional extension bootstrapping.

## Why It Is Interesting For The Lab

- It is a compact reference for a Kotlin engine that tries to keep `arc-core` free from backend naming and implementation leakage.
- It demonstrates a reusable module-layout pattern for splitting common abstractions from backend-specific implementations and optional extensions.
- It adds a useful counterexample to Android-first samples: a desktop-first engine can still be valuable if the runtime seams are explicit and portable enough to inform future Android engine work.

## Architecture Snapshot

### 1. Backend-neutral engine surface

- `arc-core/src/main/kotlin/arc/Application.kt` exposes the runtime facade: window, render system, assets, clipboard, screenshots, and lifecycle.
- `arc-core/src/main/kotlin/arc/graphics/RenderSystem.kt` is the main rendering contract: frame boundaries, state toggles, shader or texture binding, viewport control, and draw access.
- `arc-core/src/main/kotlin/arc/graphics/scene/Scene.kt` keeps scene ownership small: camera, `fps`, `delta`, cursor visibility, and `render()`.

### 2. Shared runtime logic above concrete backends

- `arc-common/src/main/kotlin/arc/AbstractApplication.kt` and `AbstractApplicationBackend.kt` hold the reusable shell around platform services.
- `arc-core/src/main/kotlin/arc/graphics/scene/AbstractScene.kt` and `DeltaTimer.kt` show a simple runtime pattern: delta computation and FPS reporting stay in a generic scene base instead of in backend code.
- `arc-demo/src/main/kotlin/arc/demo/screen/Screen.kt` extends that with render-time measurement and aspect updates.

### 3. Real backend split, but uneven maturity

- `arc-opengl/.../GlApplication.kt` and `GlRenderSystem.kt` provide a concrete working OpenGL path with frame begin or end handling, viewport reset, blending, culling, and depth-state control.
- `arc-vulkan/.../VkApplication.kt` and `VkRenderSystem.kt` keep the same engine shape but large parts of the render-system implementation are still empty stubs.
- README also describes `arc-opengles` as the ANGLE-focused path.

### 4. Extension bootstrapping instead of a monolithic engine

- `AlAudioExtension.bootstrap(provider)` registers `SoundEngine.Provider` and `SoundLoader.Factory`.
- `GlfwInputEngine.hook(window)` wires GLFW callbacks from an extension layer rather than baking input directly into the core runtime.
- The repo structure mirrors this pattern across audio, display, input, font, model, and profiler modules.

## Reusable Technical Ideas

- backend-neutral `Application` and `RenderSystem` contracts
- shared scene timing with explicit delta and FPS ownership
- extension bootstrap pattern for audio or input or other optional subsystems
- demo-level voxel helpers such as block raycast stepping, AABB highlighting, and UBO-backed light upload

## Android Relevance

Android relevance is **indirect today**.

Why it still matters:

- the core API is intentionally backend-agnostic
- the module boundaries are reusable for future Android runtime layering
- the extension bootstrapping model can transfer cleanly to Android service integration

Why it is not a direct Android baseline:

- the visible checked-in runtime is GLFW and desktop oriented
- the demo loop is desktop window based
- no concrete Android module or Android input or rendering host was found in the reviewed code

## Build And Verification Notes

- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.8`, but the lab machine still exposes only Java `8`.
- `cmd /c gradlew.bat help --no-daemon` fails while resolving the Foojay toolchain plugin because no JDK compiler is available locally.
- `gradle.properties` declares `javaVersion=21`.
- The failure shape looks environmental rather than like a clear repository misconfiguration.

## Risks And Caveats

- Vulkan backend maturity is visibly incomplete: `VkRenderSystem` is mostly stubbed.
- `GlApplication.screenshot()` appears to swap width and height when allocating the pixel buffer.
- Public signal is very low at the time of research.
- Android transfer is architectural rather than direct because the visible host stack is desktop-first.

## Verdict

Keep `AxieFeat/Arc` as `accepted`.

It is not yet a direct Android engine reference, but it is a worthwhile catalog entry because the repository already preserves a real modular engine layout, a backend-neutral rendering contract, explicit extension bootstrapping, and a useful contrast between clean architecture intent and still-uneven backend maturity.
