# Project Entry

## Basic Info

- Project name: `Mechanica`
- Source repository: [https://github.com/DominicDolan/Mechanica](https://github.com/DominicDolan/Mechanica)
- Author / organization: `DominicDolan`
- License: `MIT`
- Research note: [research/findings/dominicdolan-mechanica.md](../../research/findings/dominicdolan-mechanica.md)
- Investigated commit: `8918e04435a79da975d06c88989a842516ea4a04`
- Last verified: `2026-06-12`
- Activity / maintenance status: low-signal but still active enough to matter; the last pushed code revision at selection was `2026-02-26`, and the checked-in multi-module structure is clearly more than an abandoned sketch.

## Short Description

Desktop-first Kotlin 2D engine over LWJGL/GLFW/OpenGL, with a scene manager, fixed-step update policy, shader-backed draw helpers, UI adapter seams, samples, and a visible lifecycle-focused test surface.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `opengl`, `shader`, `ui-hud`, `testing`
- Engine / framework: custom Kotlin JVM engine with LWJGL desktop host modules
- Rendering approach: custom OpenGL drawer/shader pipeline, geometry-shader path rendering, and GLFW-backed window management
- Main language(s): Kotlin
- Android target: none in the checked-in tree
- Build system: Gradle Kotlin DSL multi-module build with Kotlin `2.2.0`, Java toolchain `22`, local jar dependency, and required external LWJGL-native properties

## Why It Matters

- `Mechanica` matters because it gives the lab a compact engine-architecture reference that sits between toy demos and large multiplatform frameworks.
- Its strongest value is indirect for Android work:
  - scene lifecycle ownership
  - fixed-step delta strategy
  - engine-to-UI adapter seams
  - shader-backed custom rendering helpers
- It is worth keeping as `accepted` even without an Android target because the internal architecture is concrete and reusable.

## Reusable Ideas

- Gameplay ideas:
  - none especially game-specific; the main value is engine/runtime architecture
- Architecture patterns:
  - centralized scene manager with delayed scene switches, pause state, and frame stepping
  - fixed-step accumulator loop with interpolation-friendly values and explicit overrun handling
- Graphics / rendering techniques:
  - geometry-shader line and circle expansion for path rendering
  - GLFW window host abstraction separated from game/runtime ownership
- Input / UI approaches:
  - explicit bridge from UI render descriptions into engine drawing operations
- Performance or optimization ideas:
  - multi-update delta stepping
  - dynamic vertex-buffer resizing for variable path complexity

## Notable Implementations

- `GameSetup.kt` assembles the runtime, cameras, persistence, contexts, and scene manager in one deliberate bootstrap seam.
- `MultiUpdateCalculator.kt` is a reusable small-engine timing reference.
- `SceneManager.kt` shows compact but real scene lifecycle ownership.
- `PathRenderer.kt` demonstrates shader-based path rendering rather than only sprite or texture plumbing.
- `UIUtils.kt` keeps UI-to-render translation explicit.
- `ActiveStateTests.kt` gives the repo a real lifecycle-oriented test surface.

## Android Relevance

- Native Android use:
  - none in the checked-in tree
- Kotlin relevance:
  - high as a readable custom-engine reference
- Porting or adaptation notes:
  - best reused for runtime and renderer architecture, not as a direct mobile engine baseline

## Risks / Limitations

- Desktop-only in the current repository.
- Build reproducibility depends on external properties such as `lwjgl_natives`.
- README requirements are stale relative to the actual Java toolchain in Gradle.
- Local jar and `mavenLocal()` usage reduce clean-room reproducibility.
- Public ecosystem signal is still minimal.

## Notes

Keep `Mechanica` as an `accepted` compact engine reference. Its value is strongest for scene management, delta-step policy, and explicit rendering or host seams, not for Android platform integration.
