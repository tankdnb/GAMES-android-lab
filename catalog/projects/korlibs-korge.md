# Project Entry

## Basic Info

- Project name: `KorGE`
- Source repository: [https://github.com/korlibs/korge](https://github.com/korlibs/korge)
- Author / organization: `korlibs`
- License: `Other`
- Research note: [research/findings/korlibs-korge.md](../../research/findings/korlibs-korge.md)
- Investigated commit: `42a995a0564191fa4b8bda5537abb304672bdda8`
- Last verified: `2026-05-10`
- Activity / maintenance status: last push recorded at selection on `2026-05-08`.

## Short Description

Large Kotlin multiplatform game engine monorepo with Android embedding support, scene management infrastructure, hot reload tooling, and frame-aware coroutine scheduling.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `android`, `multiplatform`, `scene-graph`, `korge`, `performance`
- Engine / framework: KorGE / Korlibs
- Rendering approach: cross-platform `GameWindow` runtime with scene-graph rendering and Android-specific backends
- Main language(s): Kotlin
- Android target: explicit Android source sets and host-`View` integration path
- Build system: Gradle Kotlin DSL

## Why It Matters

- It is a high-signal reference for Kotlin game-engine runtime design.
- The Android embedding path is especially relevant because it shows how an engine can live inside a host app instead of owning the full Android process shape.

## Reusable Ideas

- Gameplay ideas:
  - not the main value of this repository
- Architecture patterns:
  - dedicated scene container with transitions, navigation history, and async routing
- Graphics / rendering techniques:
  - cross-platform window abstraction with Android-specific implementation layers
- Input / UI approaches:
  - centralized runtime boundary for input, lifecycle, and scene flow
- Performance or optimization ideas:
  - frame-budgeted coroutine dispatcher

## Notable Implementations

- `SceneContainer` handles transitions, history, back/forward navigation, and reload behavior.
- `KorgeAndroidView` exposes the engine as an embeddable Android `View`.
- `GameWindowCoroutineDispatcher` budgets work per frame to protect frame time.
- `KorgeReloadAgent` isolates hot-reload tooling.

## Android Relevance

- Native Android use:
  - yes, through dedicated Android runtime layers
- Kotlin relevance:
  - very high
- Porting or adaptation notes:
  - best reused as architecture guidance or targeted subsystem inspiration rather than by copying the full engine stack

## Risks / Limitations

- License is not a standard SPDX result in metadata and should be reviewed manually.
- Monorepo size increases extraction complexity.
- No build validation was attempted in this batch.

## Notes

This is a strong anchor project for the lab's `engine-framework` category.
