# Project Entry

## Basic Info

- Project name: `SMF`
- Source repository: [https://github.com/qorrnsmj/smf](https://github.com/qorrnsmj/smf)
- Author / organization: `qorrnsmj`
- License: `MIT`
- Research note: [research/findings/qorrnsmj-smf.md](../../research/findings/qorrnsmj-smf.md)
- Investigated commit: `304987dc65c9b284e733e644e2c453cd8abb6975`
- Last verified: `2026-06-05`
- Activity / maintenance status: very fresh but still openly experimental; the last pushed code revision at selection was `2026-05-31`, while the checked-in README still frames the engine as in-progress and tutorial-inspired.

## Short Description

Low-level Kotlin JVM engine built on LWJGL, GLFW, OpenGL, and OpenAL, with a small built-in gameplay shell, simple physics, post-processing, and debug-oriented sample level code.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `3d`, `opengl`, `collision`, `audio`
- Engine / framework: custom desktop-only LWJGL/OpenGL engine
- Rendering approach: GLFW windowing, OpenGL 3.3 multi-pass renderer, optional post-processing, skybox or terrain or entity passes, debug rendering, and text overlays
- Main language(s): Kotlin
- Android target: none in the checked-in tree
- Build system: Gradle `8.8` + Kotlin JVM `2.0.0` + Shadow fat-jar packaging

## Why It Matters

- `SMF` is worth keeping because it is not just a blank prototype. It already has a readable fixed-step loop, scene container, render-pass split, simple physics world, audio source pooling, and a small task/cutscene/state layer.
- It should stay `reference-only` because the engine is still desktop-only, openly tutorial-derived, mixed with testbed/demo code, and not yet clean or disciplined enough to serve as a main Android-facing engine reference.

## Reusable Ideas

- Gameplay ideas:
  - lightweight task or cutscene sequencing over a simple level shell
- Architecture patterns:
  - fixed-step accumulator loop with interpolated render alpha
  - scene container that owns lights or camera or entities or effects
  - state shell above level loading
- Graphics / rendering techniques:
  - pass-split renderer with optional post-processing
  - compact scene-plus-renderer separation for small engines
- Input / UI approaches:
  - host-level GLFW ownership kept near bootstrap
  - debug-oriented key handling inside a small sample level
- Performance or optimization ideas:
  - source-pooled OpenAL audio
  - broad-phase collider filtering before narrow checks

## Notable Implementations

- `SMF`, `Game`, and `FixedTimestepGame` provide a readable bootstrap and main-loop baseline.
- `Scene` and `MasterRenderer` show a practical small-engine render organization.
- `PhysicsWorld` and `CollisionDetection` add real though simple physics/collision ownership instead of leaving movement fully ad hoc.
- `AudioManager` shows a better-than-expected early audio-service abstraction for a hobby-sized engine.

## Android Relevance

- Native Android use:
  - none in the checked-in tree
- Kotlin relevance:
  - moderate as a small readable desktop engine sample
- Porting or adaptation notes:
  - strongest only as a comparison source for loop, renderer, audio, and collision patterns; the runtime is desktop-only and currently too rough to act as a direct Android baseline

## Risks / Limitations

- No Android or multiplatform host module exists.
- The repository is explicitly framed as in-progress and inspired by ThinMatrix tutorial material.
- No real automated tests were found.
- The source tree mixes engine/runtime code with demo/testbed logic.
- Repository hygiene is rough, including checked-in `.idea`, a checked-in debug jar, and visible encoding issues in text/comments.
- Build verification worked only as lightweight Gradle discovery; the repo still represents a single desktop fat-jar workflow rather than a richer product/toolchain surface.

## Notes

Keep `SMF` as `reference-only`: it is useful as a compact LWJGL/OpenGL comparison sample, especially for fixed-step loop, render-pass, audio-pool, and simple collision patterns, but it should not compete with stronger Android-relevant or more mature engine references.
