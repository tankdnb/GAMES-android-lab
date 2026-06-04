# Project Entry

## Basic Info

- Project name: `Dark Matter`
- Source repository: [https://github.com/Quillraven/Dark-Matter](https://github.com/Quillraven/Dark-Matter)
- Author / organization: `Quillraven`
- License: `MIT`
- Research note: [research/findings/quillraven-dark-matter.md](../../research/findings/quillraven-dark-matter.md)
- Investigated commit: `676da9ddaec5b61e8ff08253cae99d01705dedb8`
- Last verified: `2026-06-04`
- Activity / maintenance status: stale but coherent direct Android/Desktop sample; the latest inspected commit was `Delete trigger` from `2022-12-04`, GitHub last pushed the repository on `2023-02-05`, and the visible CI still targets the older JDK8 + Gradle build era.

## Short Description

Compact Kotlin LibGDX autoscroller for Android and desktop, built around Ashley ECS, a code-driven Scene2D HUD/menu layer, patterned power-up spawning, and a bottom-hazard survival loop.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `ecs`, `input`, `ui-hud`, `audio`
- Engine / framework: LibGDX + LibKTX + Ashley ECS
- Rendering approach: sorted sprite ECS rendering with a scrolling repeated background, cached atlas animations, and a shield-outline shader pass
- Main language(s): Kotlin
- Android target: direct Android app module with portrait orientation, immersive mode, shared root assets, and minimal launcher glue
- Build system: Gradle Kotlin DSL multi-module project with `buildSrc`, `core`, `android`, and `desktop`

## Why It Matters

- `Dark Matter` is a good compact reference for teams that want a direct Android LibGDX game sample without the size of a full adventure or sandbox project.
- It is especially useful as a smaller companion to `Quilly-s-Adventure`: same author, same broad LibGDX/Kotlin ecosystem, but a much tighter arcade scope that makes ECS, HUD, input, and presentation patterns faster to lift into prototypes.

## Reusable Ideas

- Gameplay ideas:
  - bottom-hazard survival pressure instead of enemy-heavy combat
  - patterned power-up waves rather than purely random pickup spawning
- Architecture patterns:
  - one shared Ashley ECS runtime reused across menu, gameplay, and game-over screens
  - small event bus for HUD and gameplay reactions without heavy framework overhead
- Graphics / rendering techniques:
  - speed-reactive repeated background scroll
  - post-render shield outline shader on the player only
  - cached atlas-animation dispatch by enum
- Input / UI approaches:
  - one pointer-follow control path that works for both mouse and touch
  - code-driven Scene2D HUD and skin definitions instead of JSON skin files
- Performance or optimization ideas:
  - fixed-rate movement updates with interpolated render positions
  - one-frame sound-request coalescing to reduce effect spam

## Notable Implementations

- `Game.kt`, `LoadingScreen.kt`, and `Screen.kt` define a compact staged-load runtime and shared screen shell.
- `MoveSystem.kt` implements fixed-step movement, interpolation, and HUD-facing distance/speed event dispatch.
- `PowerUpSystem.kt` and `DamageSystem.kt` provide the core arcade loop around pickup waves, shield-first damage, and death feedback.
- `RenderSystem.kt` combines ordered ECS drawing, scrolling background control, and the shield-outline shader pass.
- `GameUI.kt`, `MenuUI.kt`, and `ui/skin.kt` show a clean code-first Scene2D HUD/menu approach.
- `android/build.gradle.kts`, `AndroidManifest.xml`, and `launcher.kt` keep the Android shell direct and easy to compare against larger Android game hosts.

## Android Relevance

- Native Android use:
  - direct
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - this is already a direct Android project, so the main reuse value is in extracting its compact ECS, HUD, and input patterns rather than porting it across stacks

## Risks / Limitations

- The repository is stale and built on an older toolchain: AGP `4.0.2`, Kotlin `1.4.10`, LibGDX `1.9.12`, and `jcenter()`.
- No real automated tests were found in the inspected source tree; CI only signals build plus `detekt`.
- The gameplay scope is intentionally narrow, so it is better as a focused arcade-reference sample than as a broad product-shell model.
- Local Gradle discovery in this lab still needs a full JDK instead of the machine's Java `8` JRE.

## Notes

This is an `accepted` `android-game` reference because it stays small without becoming trivial. Use it when we want an ECS-driven Android LibGDX baseline that is easier to digest than the lab's larger adventure or engine entries.
