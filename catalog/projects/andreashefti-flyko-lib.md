# Project Entry

## Basic Info

- Project name: `flyko-lib`
- Source repository: [https://github.com/AndreasHefti/flyko-lib](https://github.com/AndreasHefti/flyko-lib)
- Author / organization: `AndreasHefti`
- License: `Apache-2.0`
- Research note: [research/findings/andreashefti-flyko-lib.md](../../research/findings/andreashefti-flyko-lib.md)
- Investigated commit: `0bbd8c2d946d86119356a100b8ae46519e3ade48`
- Last verified: `2026-06-05`
- Activity / maintenance status: older small project; the inspected default branch still has a real codebase and tests, but the latest code push at selection was `2023-06-09` and the broader multiplatform roadmap is unfinished.

## Short Description

Kotlin Multiplatform 2D engine library with a custom indexed ECS-style runtime, view or render-target pipeline, contact or collision subsystem, Tiled import support, and a real desktop libGDX backend around a shared `commonMain` game core.

## Technical Profile

- Primary category: `engine-framework`
- Focus tags: `2d`, `multiplatform`, `ecs`, `rendering`, `collision`, `testing`
- Engine / framework: custom Kotlin Multiplatform engine over libGDX LWJGL3 on JVM
- Rendering approach: shared view and shader abstractions with JVM-side libGDX rendering backend
- Main language(s): Kotlin
- Android target: not implemented in the checked-in revision
- Build system: Gradle `6.8` wrapper + Kotlin Multiplatform `1.7.20`

## Why It Matters

- `flyko-lib` is worth keeping because it is a real engine codebase, not only a marketing scaffold.
- Its strongest value is not direct Android readiness, but reusable shared-core patterns:
  - explicit engine lifecycle phases
  - pooled entity/component ownership
  - view and render-target composition
  - bitmask-aware contact scanning
  - Tiled map import
- It gives the lab a useful mid-sized reference between tiny hobby engines and very large production frameworks.

## Reusable Ideas

- Gameplay ideas:
  - reusable tile/world loading and actor/world helpers around a custom engine core
- Architecture patterns:
  - shared low-level API seams for graphics, input, audio, timer, and resource loading
  - lifecycle-driven component system with initialize/load/activate/deactivate states
  - pooled entity-component ownership with aspect filters
- Graphics / rendering techniques:
  - base view plus virtual views, render targets, shader-bound views, and viewport-fit logic
- Input / UI approaches:
  - backend-normalized input APIs consumed from shared gameplay code
- Performance or optimization ideas:
  - entity/component reuse pools and render-target-based layered composition

## Notable Implementations

- `Engine.kt` centralizes shared runtime services and update or render event phases.
- `Component.kt` and `Entity.kt` implement a custom keyed component lifecycle and pooled entity-side components.
- `View.kt` models offscreen rendering and view routing rather than only one world camera.
- `ContactScan.kt` shows richer-than-usual contact scanning with type/material filters and bitmask intersections.
- `TiledJsonBinding.kt` shows a practical import seam from Tiled-authored content into neutral runtime structures.

## Android Relevance

- Native Android use:
  - no checked-in Android backend
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - strongest as a shared-core architecture reference for future Android engines or game runtimes; the rendering, lifecycle, and collision patterns transfer better than the platform backend code itself

## Risks / Limitations

- Android support is explicitly not implemented in the inspected revision.
- JS and native platform backends are mostly `TODO()` stubs, so the multiplatform story is incomplete in practice.
- The codebase is no longer very fresh.
- The internal abstraction style is dense and custom; it is a study reference more than a copy-paste starter.

## Notes

`flyko-lib` is useful because it proves there is substantial engine code behind the repo, while also clearly showing the limit between a reusable shared game-runtime core and a truly finished multiplatform engine product.
