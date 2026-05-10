# Project Entry

## Basic Info

- Project name: `LittleKt`
- Source repository: [https://github.com/littlektframework/littlekt](https://github.com/littlektframework/littlekt)
- Author / organization: `littlektframework`
- License: `Apache-2.0`
- Research note: [research/findings/littlektframework-littlekt.md](../../research/findings/littlektframework-littlekt.md)
- Investigated commit: `169ae1bbbbbeba2e544b38bf4448380274ef48c0`
- Last verified: `2026-05-10`
- Activity / maintenance status: last push recorded at selection on `2026-01-17`.

## Short Description

Kotlin multiplatform 2D framework with a WebGPU-first runtime, explicit asset/input abstractions, and a "build your own engine" orientation.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `multiplatform`, `input`, `asset-pipeline`, `performance`
- Engine / framework: LittleKt
- Rendering approach: WebGPU-oriented runtime with JVM and web backends
- Main language(s): Kotlin
- Android target: in progress rather than fully shipped on the inspected branch
- Build system: Gradle Kotlin DSL

## Why It Matters

- It is a useful reference for how a Kotlin game runtime can be structured around a context object, asset pipeline, and signal-based input layer.
- The WebGPU-first direction gives the lab a technically distinct engine reference beyond libGDX- and scene-graph-centric stacks.

## Reusable Ideas

- Gameplay ideas:
  - not the main value of this repository
- Architecture patterns:
  - callback-based runtime context and thin app bootstrap
- Graphics / rendering techniques:
  - backend boundary around WebGPU surface/device setup
- Input / UI approaches:
  - domain-signal input mapping across keyboard, pointer, and gamepad
- Performance or optimization ideas:
  - frame-budget-aware dispatcher flow and deferred preparation of loaded assets

## Notable Implementations

- `Context` exposes update, post-update, resize, release, and deferred-runnable hooks.
- `LwjglContext` runs a compact no-OpenGL main loop around WebGPU setup.
- `AssetProvider` separates async loading from post-load preparation.
- `InputMapController` turns raw device inputs into custom game signals.
- `MutableTextureAtlas` builds atlases at runtime from existing slices and textures.

## Android Relevance

- Native Android use:
  - not yet on the main inspected branch
- Kotlin relevance:
  - very high
- Porting or adaptation notes:
  - best reused today as architecture guidance and subsystem inspiration; direct Android backend patterns should be revisited when the Android branch stabilizes

## Risks / Limitations

- Android support is still in progress.
- JDK 22+ requirements increase validation cost.
- No build validation was attempted in this batch.

## Notes

This is a strong forward-looking engine reference even though it is not yet the most direct Android runtime choice.
