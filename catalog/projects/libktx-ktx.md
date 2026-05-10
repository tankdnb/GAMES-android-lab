# Project Entry

## Basic Info

- Project name: `KTX`
- Source repository: [https://github.com/libktx/ktx](https://github.com/libktx/ktx)
- Author / organization: `libktx`
- License: `CC0-1.0`
- Research note: [research/findings/libktx-ktx.md](../../research/findings/libktx-ktx.md)
- Investigated commit: `0f28adef8191a15a3c4f453a97fe15524fb3c8fd`
- Last verified: `2026-05-10`

## Short Description

Modular Kotlin-first SDK layer for libGDX that adds render-thread coroutine dispatchers, async asset loading, UI DSLs, AI builders, and lightweight dependency injection helpers.

## Technical Profile

- Primary category: `library-sdk`
- Focus tags: `libgdx`, `ui-hud`, `ai`, `asset-pipeline`, `performance`
- Engine / framework: KTX on top of libGDX
- Rendering approach: extends libGDX rather than replacing it
- Main language(s): Kotlin
- Android target: indirect but strong for libGDX-based Android games
- Build system: Gradle Kotlin DSL

## Why It Matters

- It condenses many Kotlin usability improvements for real game code into small, reusable modules.
- The repository is useful even if the lab only reuses patterns instead of importing the full library.

## Reusable Ideas

- Gameplay ideas:
  - AI behavior-tree builders for cleaner gameplay authoring
- Architecture patterns:
  - lightweight DI context for small game subsystems
- Graphics / rendering techniques:
  - render-thread-aware coroutine dispatchers
- Input / UI approaches:
  - type-safe Scene2D builders for menus and HUDs
- Performance or optimization ideas:
  - background asset loading with explicit progress and dependency tracking

## Notable Implementations

- `dispatchers.kt` aligns Kotlin coroutines with the libGDX threading model.
- `storage.kt` implements coroutine-first asset loading with error tracking and reference counts.
- `factory.kt` provides a contract-backed Scene2D DSL.
- `behaviorTree.kt` adds AI builders over gdxAI.
- `inject.kt` provides minimal DI and optional reflection-based construction.

## Android Relevance

- Native Android use:
  - indirect
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - strongest when the target stack already uses libGDX or similar render-thread constraints

## Risks / Limitations

- It is a library suite, not a full game reference.
- Android transfer is best for libGDX-based projects rather than Android SDK-only games.
- Batch research did not confirm a successful local build.

## Notes

This is a strong catalog entry for Kotlin-specific game-development ergonomics.
