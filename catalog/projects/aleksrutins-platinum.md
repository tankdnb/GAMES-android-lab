# Project Entry

## Basic Info

- Project name: `Platinum`
- Source repository: [https://github.com/aleksrutins/platinum](https://github.com/aleksrutins/platinum)
- Author / organization: `aleksrutins`
- License: `MIT`
- Research note: [research/findings/aleksrutins-platinum.md](../../research/findings/aleksrutins-platinum.md)
- Investigated commit: `82f8d4b1983dfae0e49e193c6e114538c388000b`
- Last verified: `2026-06-04`
- Activity / maintenance status: low-signal and bursty; the repository was pushed on `2026-05-31`, but the latest inspected commit only adds the MIT license and the previous visible activity clusters around small test and Gradle adjustments in late `2025`.

## Short Description

Very small Kotlin/JVM 2D engine prototype with a tiny ECS-style runtime, Swing/AWT rendering, keyboard polling, rollback-based collision, a tilemap loader, and a placeholder desktop editor.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `input`, `collision`
- Engine / framework: custom Kotlin/JVM 2D engine prototype
- Rendering approach: Swing `JComponent` rendering through `Graphics2D` and `BufferedImage` sprites, with a transform-offset camera
- Main language(s): Kotlin, Java
- Android target: none in the checked-in tree
- Build system: Gradle multi-project build with `lib`, `example`, and `editor` modules plus a JDK `21` toolchain declaration

## Why It Matters

- `Platinum` is useful as a compact comparison sample for how little code is needed to wire a small ECS-style loop, input polling, sprite drawing, and collision into a working desktop prototype.
- It is also useful as a cautionary reference because the current scene abstraction is not actually connected to the main runtime and the editor/tooling claims are still much thinner than the repository metadata suggests.

## Reusable Ideas

- Gameplay ideas:
  - none directly; the main value is runtime and prototype structure rather than shipped gameplay systems
- Architecture patterns:
  - explicit system-typed components with minimal ECS wiring
  - outer-loop ownership of input and per-frame game decisions
- Graphics / rendering techniques:
  - tiny Swing renderer where drawing is just another system pass
  - camera offsets applied through transform modifiers instead of a larger viewport stack
- Input / UI approaches:
  - raw-key polling via one listener plus a pressed-key set
- Performance or optimization ideas:
  - not a performance-focused repository; the strongest idea is transform-history rollback as a cheap prototype collision strategy

## Notable Implementations

- `Game`, `System`, `Entity`, and `Component` form a very small ECS-like runtime.
- `RenderSystem2D` renders entities by letting them update against the render system during `paint(...)`.
- `CollisionBox2D` resolves overlaps by rolling back transform history until collision clears.
- `LevelLoader` slices tilemap sprites and injects gameplay entities through a callback.
- `Editor.java` confirms that the editor path is still mostly a placeholder.

## Android Relevance

- Native Android use:
  - none in the checked-in tree
- Kotlin relevance:
  - moderate
- Porting or adaptation notes:
  - useful only indirectly for tiny Kotlin gameplay-core experiments; the AWT/Swing rendering and input shell would need full replacement for Android

## Risks / Limitations

- No root `README.md`, docs, or CI workflows were found.
- The visible test surface is only one trivial entity-addition test.
- `Scene` storage exists, but the renderer, camera, and collision paths still iterate only `baseEntities`, so scene switching is incomplete.
- The editor module is only a placeholder Swing window.
- The current freshness signal is partly superficial because the latest inspected commit only adds the MIT license.

## Notes

Keep `Platinum` as `reference-only`: it is good for tiny-runtime comparisons and for spotting early-engine pitfalls, but not strong enough to treat as a main reusable baseline for Android game work.
