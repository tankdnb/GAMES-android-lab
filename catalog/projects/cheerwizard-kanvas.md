# Project Entry

## Basic Info

- Project name: `Kanvas`
- Source repository: [https://github.com/CheerWizard/Kanvas](https://github.com/CheerWizard/Kanvas)
- Author / organization: `CheerWizard`
- License: `MIT`
- Research note: [research/findings/cheerwizard-kanvas.md](../../research/findings/cheerwizard-kanvas.md)
- Investigated commit: `f863585c225dd60aa5b63d4a2511e4b365881487`
- Last verified: `2026-06-04`
- Activity / maintenance status: low-signal but recently maintained at selection; the repository was pushed on `2026-04-10`, and the latest inspected commit focused on shader DSL work, editor windowing, platform abstraction restructuring, SPIR-V compilation, and gamepad abstraction.

## Short Description

Ambitious Kotlin Multiplatform engine workspace with Android, desktop, JS, and iOS targets, separate Vulkan/WebGPU rendering layers, a shader DSL, and a desktop editor shell.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `android`, `multiplatform`, `shader`, `editor-tools`, `asset-pipeline`
- Engine / framework: custom Kotlin Multiplatform engine plus rendering, shader, editor, and native backend modules
- Rendering approach: shared render API over Vulkan on JVM/native plus WebGPU on JS, with platform-specific surface hosts
- Main language(s): Kotlin, C, C++
- Android target: direct in the build and host layers, with Android-specific `GameActivity`, `TextureView`, and platform service adapters
- Build system: large Gradle Kotlin DSL multiplatform monorepo with Android, desktop JVM, JS, iOS, and native C/C++ integration

## Why It Matters

- `Kanvas` is useful as a cross-platform engine-architecture reference, especially for host-loop abstraction, multi-backend rendering splits, and editor/runtime separation.
- It is not a strong primary model for production reuse because the inspected revision still looks incomplete in several key runtime paths.

## Reusable Ideas

- Gameplay ideas:
  - none directly; the strongest value is engine and tooling architecture rather than shipped gameplay systems
- Architecture patterns:
  - one `expect`/`actual` game-loop contract across Android, JS, iOS, and desktop hosts
- Graphics / rendering techniques:
  - backend-neutral render abstractions over Vulkan and WebGPU, plus offscreen native-to-Compose desktop presentation
- Input / UI approaches:
  - platform windows translate native input into one shared event/listener model while Compose remains an overlay shell
- Performance or optimization ideas:
  - isolate GPU resource abstractions, command-buffer access, and shader tooling into dedicated modules instead of tangling them with game logic

## Notable Implementations

- `PlatformGameLoop.*` maps one engine loop API to `Choreographer`, `requestAnimationFrame`, and `CADisplayLink`.
- `GameView.android.kt`, `GameView.desktop.kt`, `GameView.js.kt`, and `GameViewController.ios.kt` show platform-specific surface hosting with Compose UI layered over it.
- `RenderContext` has separate Vulkan and WebGPU implementations behind one shared rendering API.
- `Window.desktop.kt` pushes native-rendered pixels into a Compose `ImageBitmap`.
- `kanvas-shaderc` introduces a Kotlin shader DSL with GLSL and WGSL translation directions.
- `kanvas-editor` includes dock-window state, project build/launch orchestration, and dynamic game-module loading ambitions.

## Android Relevance

- Native Android use:
  - direct in architecture, but not strongly validated as a finished runtime
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - best mined for platform-loop, surface-hosting, and backend-separation ideas rather than reused as-is

## Risks / Limitations

- The checked-in runtime still looks unfinished: `GameLoop` never wires in `GameModuleManager`, the shared render thread still looks scaffold-like, and `kanvas-server` has no visible source tree.
- `WGSLTranslator.kt` appears mid-refactor relative to the current translator interface.
- The tree has no meaningful automated engine tests and no checked-in root `README.md` or project docs.
- Local Gradle discovery in the lab is still blocked because the machine only has a Java `8` JRE and no full JDK.

## Notes

This is worth keeping as a reference-only architecture repo: promising ideas, broad target ambition, and useful host/render/tooling splits, but not yet stable enough to treat as a primary engine model.
