# Research Note

## Repository Snapshot

- Repository: `CheerWizard/Kanvas`
- Source URL: [https://github.com/CheerWizard/Kanvas](https://github.com/CheerWizard/Kanvas)
- Owner: `CheerWizard`
- Batch ID: [`BATCH-2026-06-04-E`](../batches/BATCH-2026-06-04-E.md)
- Type: `engine-framework`
- License: `MIT`
- Selection date: `2026-06-04`
- Last pushed at selection: `2026-04-10`
- Stars at selection: `1`
- Investigated commit: `f863585c225dd60aa5b63d4a2511e4b365881487`
- Research status: `reference-only`
- Build mode: `static-review + gradle-help-failed-no-jdk`
- Catalog card: [catalog/projects/cheerwizard-kanvas.md](../../catalog/projects/cheerwizard-kanvas.md)

## Why This Repository Was Selected

- After the previous shortlist was exhausted, `Kanvas` stood out as the strongest fresh explicit-license engine candidate even with very low public signal.
- The repository claims a Kotlin Multiplatform engine targeting JVM, mobile, native, and web, and its module graph suggested deeper Android-transfer value than the narrower direct-Android candidates in the refreshed shortlist.
- The main question for this pass was whether `Kanvas` is already a real reusable engine reference or still mostly an ambitious architecture scaffold. Static review shows more of the latter.

## Technical Profile

- Main language(s): Kotlin, C, C++
- Engine / framework: custom Kotlin Multiplatform game engine with separate rendering, shader, editor, asset, and native-backend modules
- Rendering stack: Vulkan-backed JVM/native path plus a separate browser WebGPU path, wrapped behind a shared rendering API
- Android target: direct in the build surface; the core engine and rendering modules include Android targets and Android-specific host code
- Build system: large Gradle Kotlin DSL multiplatform monorepo with Android, desktop JVM, JS, iOS, and native C/C++ integration
- Repository layout summary: `kanvas/` engine core, `kanvas-rendering/` backend/frontend GPU abstractions, `kanvas-shaderc/` shader DSL and translation, `kanvas-vk/` native Vulkan bridge, `kanvas-editor/` desktop editor shell, `print/` cross-platform logging/runtime utilities, and several sandbox or helper modules
- Source footprint:
  - total files counted in repository: `702`
  - Kotlin/Java/C/C++/shader files counted in repository: `629`
- Test surface:
  - test files found: `1`
  - meaningful engine or gameplay tests found: `0`
- Key modules reviewed:
  - `settings.gradle.kts`
  - `build.gradle.kts`
  - `gradle/libs.versions.toml`
  - `kanvas/build.gradle.kts`
  - `kanvas-rendering/build.gradle.kts`
  - `kanvas-vk/build.gradle.kts`
  - `kanvas-wgpu/build.gradle.kts`
  - `kanvas-editor/build.gradle.kts`
  - `kanvas-server/build.gradle.kts`
  - `kanvas-assetc/build.gradle.kts`
  - `print-sandbox/build.gradle.kts`
  - `kanvas/src/commonMain/kotlin/com/cws/kanvas/core/Engine.kt`
  - `kanvas/src/commonMain/kotlin/com/cws/kanvas/core/GameLoop.kt`
  - `kanvas/src/commonMain/kotlin/com/cws/kanvas/core/GameModule.kt`
  - `kanvas/src/commonMain/kotlin/com/cws/kanvas/core/GameModuleManager.kt`
  - `kanvas/src/commonMain/kotlin/com/cws/kanvas/core/Window.kt`
  - `kanvas/src/commonMain/kotlin/com/cws/kanvas/core/Platform.kt`
  - `kanvas/src/androidMain/kotlin/com/cws/kanvas/core/GameActivity.android.kt`
  - `kanvas/src/androidMain/kotlin/com/cws/kanvas/core/GameView.android.kt`
  - `kanvas/src/androidMain/kotlin/com/cws/kanvas/core/PlatformGameLoop.android.kt`
  - `kanvas/src/androidMain/kotlin/com/cws/kanvas/core/Platform.android.kt`
  - `kanvas/src/desktopMain/kotlin/com/cws/kanvas/core/GameView.desktop.kt`
  - `kanvas/src/desktopMain/kotlin/com/cws/kanvas/core/Window.desktop.kt`
  - `kanvas/src/jsMain/kotlin/com/cws/kanvas/core/GameView.js.kt`
  - `kanvas/src/jsMain/kotlin/com/cws/kanvas/core/PlatformGameLoop.js.kt`
  - `kanvas/src/iosMain/kotlin/com/cws/kanvas/core/GameViewController.ios.kt`
  - `kanvas/src/iosMain/kotlin/com/cws/kanvas/core/GameView.ios.kt`
  - `kanvas/src/iosMain/kotlin/com/cws/kanvas/core/PlatformGameLoop.ios.kt`
  - `kanvas/src/desktopMain/kotlin/com/cws/kanvas/gamepad/GamepadManager.desktop.kt`
  - `kanvas-rendering/src/commonMain/kotlin/com/cws/kanvas/rendering/backend/RenderThread.kt`
  - `kanvas-rendering/src/commonMain/kotlin/com/cws/kanvas/rendering/backend/RenderContext.kt`
  - `kanvas-rendering/src/vkJvmMain/kotlin/com/cws/kanvas/rendering/backend/RenderContext.vkJvm.kt`
  - `kanvas-rendering/src/wgpuMain/kotlin/com/cws/kanvas/rendering/backend/RenderContext.wgpu.kt`
  - `kanvas-rendering/src/commonMain/kotlin/com/cws/kanvas/rendering/frontend/Camera.kt`
  - `kanvas-rendering/src/commonMain/kotlin/com/cws/kanvas/rendering/frontend/UniformBuffer.kt`
  - `kanvas-shaderc/src/commonMain/kotlin/com/cws/kanvas/shaderc/translation/Translator.kt`
  - `kanvas-shaderc/src/commonMain/kotlin/com/cws/kanvas/shaderc/translation/GLSLTranslator.kt`
  - `kanvas-shaderc/src/commonMain/kotlin/com/cws/kanvas/shaderc/translation/WGSLTranslator.kt`
  - `kanvas-shaderc-sandbox/src/desktopMain/kotlin/com.cws.kanvas.shaderc.sandbox/Main.kt`
  - `kanvas-editor/src/desktopMain/kotlin/com/cws/kanvas/editor/Main.kt`
  - `kanvas-editor/src/desktopMain/kotlin/com/cws/kanvas/editor/app/Application.kt`
  - `kanvas-editor/src/desktopMain/kotlin/com/cws/kanvas/editor/window/WindowRegistry.kt`
  - `kanvas-editor/src/desktopMain/kotlin/com/cws/kanvas/editor/project/ProjectManager.kt`
  - `kanvas-editor/src/desktopMain/kotlin/com/cws/kanvas/editor/project/GameModuleLoader.kt`
  - `print-sandbox/src/commonMain/kotlin/PrintTests.kt`

## Build And Runtime Notes

- The repository was investigated through static code review plus lightweight Gradle discovery.
- No root `README.md` or project docs were present in the checked-in tree, so the initial understanding came mostly from GitHub metadata, module names, and source inspection.
- `cmd /c gradlew.bat --version` succeeds and reports Gradle `8.13` on the current lab machine.
- `cmd /c gradlew.bat help --no-daemon` fails because the current machine only exposes a Java `8` JRE and Gradle cannot find a Java compiler:
  - `No Java compiler found, please ensure you are running Gradle with a JDK`
- The build surface itself points to a more modern toolchain than the current lab environment:
  - Kotlin `2.2.10`
  - AGP `8.11.0`
  - Compose Multiplatform `1.8.2`
  - Android `compileSdk` `36` in core/sandbox modules
- No runtime launch was attempted.

## Usefulness Assessment

- Reuse potential: `2`
- Android transfer: `2`
- Implementation depth: `3`
- Code clarity: `1`
- Novelty: `3`
- Overall verdict: `reference-only`
- Why:
  - `Kanvas` has real architectural ambition and several reusable ideas around cross-platform host loops, backend abstraction, editor/runtime separation, and shader tooling.
  - At the same time, the inspected revision looks incomplete enough that it is risky as a primary model for future projects.
  - The repository is worth preserving as an architecture reference and cautionary comparison, but not as a main catalog baseline.

## Interesting Findings

### Engine Architecture And Core Loop

- `kanvas/src/commonMain/kotlin/com/cws/kanvas/core/PlatformGameLoop.kt` plus the Android, JS, and iOS `actual` implementations show a consistent design goal: one platform-agnostic loop API with host-specific frame scheduling hidden behind it.
- `PlatformGameLoop.android.kt` uses a dedicated thread with its own `Looper` plus `Choreographer.FrameCallback`, which is a useful Android-hosting pattern for engines that do not want their update cadence tied directly to Compose recomposition.
- `PlatformGameLoop.js.kt` maps the same loop contract onto `requestAnimationFrame`, while `PlatformGameLoop.ios.kt` uses `CADisplayLink`. The API unification itself is one of the better reusable ideas in the repository.
- `GameActivity.android.kt`, `GameView.android.kt`, `GameView.desktop.kt`, `GameView.js.kt`, and `GameViewController.ios.kt` show the intended host strategy clearly: let each platform own the surface, then overlay Compose UI on top of it.

### Rendering And Graphics

- `kanvas-rendering/` is a serious split instead of a thin wrapper. The repository separates shared GPU-facing abstractions (`RenderContext`, `RenderPipeline`, `Shader`, `Texture`, `UniformBuffer`, `StorageBuffer`, `VertexBuffer`) from backend-specific `actual` implementations.
- `RenderContext.vkJvm.kt` and `RenderContext.vkNative.kt` bridge into a native Vulkan layer through `kanvas-vk`, while `RenderContext.wgpu.kt` gives the browser path its own WebGPU implementation with explicit error-scope handling and canvas reconfiguration.
- `Window.desktop.kt` uses an offscreen pixel callback path (`RenderBridge.nativeSetOffscreenCallback`) to copy native-rendered bytes into a Compose `ImageBitmap`. That desktop bridge is one of the more concrete runtime ideas in the repo.
- `GameView.js.kt` uses two canvases, one for the engine runtime and one for the Compose UI shell, which is a clean workaround for mixing engine rendering and declarative UI in browser targets.

### Input And Controls

- `Window.kt` is a compact reusable event-queue design: platform windows push raw events into a locked queue, and the engine side drains them through one dispatch path.
- `Window.android.kt` maps `MotionEvent` taps into engine listeners without forcing Android classes into shared code.
- `Window.desktop.kt` translates Compose pointer and key events into the engine's own key/mouse codes and also polls a dedicated gamepad manager on every event pump.
- `GamepadManager.desktop.kt` is a good example of platform-specific device handling living outside the shared game logic surface.

### Tooling, Editor, And Content Pipeline

- `kanvas-shaderc/` is conceptually one of the most interesting parts of the repo. The engine includes a Kotlin shader DSL plus separate translation layers for GLSL and WGSL, with a sandbox module that writes generated shader output to disk.
- `ProjectManager.kt` in the editor shows a promising workflow idea: treat game modules as buildable load units, with build/launch helpers for desktop, Android, iOS, and web targets from one editor shell.
- `GameModuleLoader.kt` shows an intended hot-ish workflow where project modules are built as JARs and loaded dynamically through `URLClassLoader` into the editor/runtime environment.
- `kanvas-editor/` is not just a placeholder directory. It already contains dock-window state, controller classes, window registries, and project/build orchestration, which makes the repo more useful as a tooling reference than as a finished engine runtime.

### Android Platform Integration

- `GameActivity.android.kt` plus `GameView.android.kt` show a direct Android engine shell built around `TextureView` and Compose interop rather than around a traditional `GLSurfaceView`.
- `GameView.android.kt` starts the engine loop when the `SurfaceTexture` becomes available, resizes the engine viewport on texture changes, and routes touch events back into the shared loop.
- `Platform.android.kt` isolates Android-only sensor/audio dependencies behind shared interfaces, keeping the common engine layer relatively clean.
- The multiplatform build configuration in `kanvas/build.gradle.kts` and `kanvas-rendering/build.gradle.kts` demonstrates a direct Android target path, even though the checked-in runtime still looks incomplete.

## Reusable Takeaways

- A shared `expect`/`actual` frame-loop contract is a strong foundation when one engine wants Android, JS, iOS, and desktop hosts without duplicating lifecycle semantics.
- Mixing engine rendering with Compose is easier when the engine owns one surface and Compose owns a second overlay surface instead of both trying to draw into the same layer.
- Keeping shader authoring, translation, backend bindings, editor tooling, and runtime hosting in separate modules can make a cross-platform engine easier to evolve, even if the repo is still immature.
- Dynamic project-module loading inside an editor is a promising workflow idea, but the inspected implementation also shows how quickly that surface becomes fragile if the underlying runtime is not yet stabilized.

## Evidence Summary

- `PlatformGameLoop.android.kt`, `PlatformGameLoop.js.kt`, `PlatformGameLoop.ios.kt` - shared loop API mapped onto platform-native frame schedulers
- `GameActivity.android.kt`, `GameView.android.kt`, `GameView.desktop.kt`, `GameView.js.kt`, `GameViewController.ios.kt` - host-specific surface strategies with Compose overlays
- `Window.kt`, `Window.android.kt`, `Window.desktop.kt`, `GamepadManager.desktop.kt` - event-queue, input translation, and device polling seams
- `RenderContext.kt`, `RenderContext.vkJvm.kt`, `RenderContext.vkNative.kt`, `RenderContext.wgpu.kt` - backend-neutral rendering API over Vulkan and WebGPU paths
- `Window.desktop.kt` - offscreen native-render-to-Compose bitmap bridge
- `Translator.kt`, `GLSLTranslator.kt`, `WGSLTranslator.kt`, `kanvas-shaderc-sandbox/Main.kt` - shader DSL and multi-language translation ambitions
- `ProjectManager.kt`, `GameModuleLoader.kt`, `WindowRegistry.kt`, `Application.kt` - editor/runtime tooling and dynamic module-management direction

## Risks Or Limits

- The repository is clearly mid-construction. Several important seams are scaffold-like or incomplete.
- `GameLoop.kt` defines `gameModuleManager`, but the inspected tree never initializes or injects it anywhere. As checked in, the main update/render/module path appears disconnected.
- `RenderThread.kt` still uses a placeholder `Frame(string)` payload and keeps most of the render body commented out, which makes the shared render-thread layer look more like a stub than a finished pipeline.
- `kanvas-server/` has a build file but no visible `src/` tree in the inspected revision.
- `WGSLTranslator.kt` appears to be mid-refactor and no longer lines up cleanly with `Translator.kt` signatures, which suggests the shader toolchain is still unstable in the checked-in state.
- `PlatformGameLoop.ios.kt` currently computes `dtMillis` as `prevTime - timeMillis`, which implies a negative delta in the inspected logic.
- No real automated engine tests were found. The only test-like file in the tree is `PrintTests.kt`, which is a log-generator sandbox rather than a verification suite.
- The absence of a checked-in `README.md` or real project docs raises the cost of adoption and lowers confidence in intended runtime flows.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `reference-only`
- Focus tags: `android`, `multiplatform`, `shader`, `editor-tools`, `asset-pipeline`
- Follow-up needed:
  - if the lab revisits this repository, do it in a real JDK environment and focus narrowly on one subsystem such as the platform loop abstraction, the Vulkan/WebGPU rendering split, or the shader DSL/editor pipeline
  - treat the inspected revision as a source of architecture ideas and cautionary signals, not as a turnkey engine baseline
