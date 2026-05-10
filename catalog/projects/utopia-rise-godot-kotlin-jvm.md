# Project Entry

## Basic Info

- Project name: `Godot Kotlin/JVM`
- Source repository: [https://github.com/utopia-rise/godot-kotlin-jvm](https://github.com/utopia-rise/godot-kotlin-jvm)
- Author / organization: `utopia-rise`
- License: `MIT`
- Research note: [research/findings/utopia-rise-godot-kotlin-jvm.md](../../research/findings/utopia-rise-godot-kotlin-jvm.md)
- Investigated commit: `36081a7598b221899049467b49d6c3b019b42494`
- Last verified: `2026-05-10`

## Short Description

Kotlin/JVM binding layer for Godot with a mixed Kotlin/C++ runtime bridge, registration-file generation, coroutine helpers, Gradle plugin support, and Android export packaging tasks.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `android`, `multiplatform`, `testing`
- Engine / framework: Godot Kotlin/JVM binding
- Rendering approach: delegates rendering to Godot, while this repository manages runtime and tooling integration
- Main language(s): Kotlin, C++
- Android target: indirect, but explicit Android export support exists in the plugin/tooling path
- Build system: Gradle Kotlin DSL plus native build tooling

## Why It Matters

- It is valuable as a reference for Kotlin-to-engine runtime integration and code generation.
- The Android export support and dex packaging details are useful even though the project is not an Android-native game.

## Reusable Ideas

- Gameplay ideas:
  - not the main value of this repository
- Architecture patterns:
  - staged bootstrap and teardown for mixed native/JVM runtime loading
- Graphics / rendering techniques:
  - not the main value of this repository
- Input / UI approaches:
  - coroutine-aware signal and frame helpers
- Performance or optimization ideas:
  - explicit bootstrap ordering and Android dex packaging rules

## Notable Implementations

- `Bootstrap.kt` loads registries through `ServiceLoader` and initializes them in a fixed order.
- `CoroutineTest.kt` demonstrates signal, frame, and main-thread coroutine helpers.
- `gd_kotlin.cpp` owns JVM/Graal loading, config merging, staged init, and reload/finalize behavior.
- `GodotPlugin.kt` and `createMainDexFileTask.kt` show Gradle and Android packaging support.

## Android Relevance

- Native Android use:
  - indirect
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - best treated as a reference for engine bindings, build tooling, and export/runtime integration rather than a direct Android-game template

## Risks / Limitations

- Requires custom Godot editor/export artifacts.
- Mixed native/JVM architecture is expensive to adopt.
- Less directly reusable for Android-native Kotlin game projects than other catalog entries.

## Notes

This entry is intentionally kept under `reference-only` rather than promoted as a main Android-first model.
