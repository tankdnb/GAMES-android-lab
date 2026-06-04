# Project Entry

## Basic Info

- Project name: `FriceEngine`
- Source repository: [https://github.com/icela/FriceEngine](https://github.com/icela/FriceEngine)
- Author / organization: `icela`
- License: `AGPL-3.0`
- Research note: [research/findings/icela-friceengine.md](../../research/findings/icela-friceengine.md)
- Investigated commit: `8374f87a286d7323348d7aea8213eaebd64dfe6c`
- Last verified: `2026-06-04`
- Activity / maintenance status: historically popular but stale; the last code push was on `2019-12-28`, while the visible build and CI surface still depends on Java `8`, Gradle `4.7`, JCenter, and Bintray-era publishing assumptions.

## Short Description

Legacy Kotlin/JVM game engine with one shared API over Swing and JavaFX, plus small built-in helpers for animations, input, delayed events, audio, images, and file/XML preferences.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `input`, `collision`, `audio`
- Engine / framework: custom JVM 2D engine with Swing and JavaFX backends
- Rendering approach: Swing `JComponent` / `Graphics2D` backbuffer path and JavaFX `Canvas` / `GraphicsContext` path behind shared `FriceDrawer` and `FriceImage` abstractions
- Main language(s): Kotlin, Java
- Android target: none in the checked-in tree
- Build system: Gradle `4.7` + Kotlin `1.2.60` + Java `8` + Dokka `0.9.17` + legacy Bintray/JCenter publishing plugins

## Why It Matters

- `FriceEngine` is worth keeping because it is still one of the clearer small historical examples of a Kotlin-authored engine trying to unify two desktop UI backends behind one gameplay-facing API.
- It is not strong enough to be a main baseline for this lab. The Android path is absent, the build is partially dead on modern infrastructure, the runtime exposes a few concrete maturity problems, and the AGPL license makes it a poor default reuse target.

## Reusable Ideas

- Gameplay ideas:
  - none central; the main value is runtime structure and utility seams rather than shipped gameplay systems
- Architecture patterns:
  - one shared engine API for two rendering backends
  - buffered per-layer add/remove queues
  - explicit delayed-event scheduling over engine time
- Graphics / rendering techniques:
  - drawer/image abstractions over Swing and JavaFX
  - lightweight frame animation through timed image resources
- Input / UI approaches:
  - separate button registry with centralized hit-testing
  - simple backend-native key/mouse translation into shared engine events
- Performance or optimization ideas:
  - image/resource caching through small manager types
  - optional auto-GC for off-screen objects in tiny 2D runtimes

## Notable Implementations

- `Game`, `GameFX`, and `FriceGame` define one engine contract across Swing and JavaFX hosts.
- `Layer` stages object and text mutations through buffers before each frame.
- `FriceDrawer`, `JvmDrawer`, `JfxDrawer`, and `FriceImage` abstract backend rendering/image operations cleanly for a small codebase.
- `EventManager`, `DelayedEvent`, `FClock`, and `FTimer` provide a compact explicit-time scheduler.
- `FManager`, `Preference`, and `XMLPreference` provide small file/web/jar resource caching and desktop-style preference helpers.

## Android Relevance

- Native Android use:
  - none in the checked-in tree
- Kotlin relevance:
  - moderate as a historical Kotlin engine sample
- Porting or adaptation notes:
  - strongest only as a legacy comparison point for runtime layering, resource helpers, and event scheduling; the Swing/JavaFX runtime and AGPL license make it a weak direct source for Android implementation reuse

## Risks / Limitations

- No Android module or host integration exists.
- The build now fails during Gradle configuration because the old Bintray plugin path no longer resolves `http-builder:0.7.2`.
- The JavaFX backend drives rendering from a raw background thread.
- Button removal bookkeeping in `Layer` is visibly wrong for `FButton` objects.
- Much of the test tree is interactive demo code rather than real regression coverage.
- The project is stale and still tied to Java `8`, JCenter, and multiple retired CI/publication surfaces.

## Notes

Keep `FriceEngine` as `reference-only`: it is still useful when we need a compact historical example of Kotlin engine layering on the JVM, but it should not compete with the lab's fresher Android-relevant or multiplatform engine references.
