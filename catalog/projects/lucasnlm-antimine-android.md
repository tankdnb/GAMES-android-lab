# Project Entry

## Basic Info

- Project name: `Antimine - Minesweeper`
- Source repository: [https://github.com/lucasnlm/antimine-android](https://github.com/lucasnlm/antimine-android)
- Author / organization: `lucasnlm`
- License: `GPL-3.0`
- Research note: [research/findings/lucasnlm-antimine-android.md](../../research/findings/lucasnlm-antimine-android.md)
- Investigated commit: `86400370a7b7bd8e27ccc6520065c6b68d64b8f2`
- Last verified: `2026-05-10`
- Activity / maintenance status: last push recorded at selection on `2025-08-02`.

## Short Description

Kotlin Android minesweeper project with a custom LibGDX board renderer, native no-guess generation support, binary save/load handling, and support for multiple Android form factors.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `libgdx`, `save-load`, `procedural-generation`
- Engine / framework: Android SDK plus LibGDX and native Simon Tatham generator integration
- Rendering approach: LibGDX stage/actor board rendering embedded in an Android app
- Main language(s): Kotlin, C++
- Android target: direct Android game with phone, Wear OS, and Android Auto modules
- Build system: Gradle Kotlin DSL

## Why It Matters

- It demonstrates how to keep a Kotlin Android game modular across gameplay logic, rendering, native helpers, and platform-specific shells.
- The repository is stronger than a typical sample because it handles persistence, procedural generation quality, and multiple Android targets.

## Reusable Ideas

- Gameplay ideas:
  - no-guess board generation with solver-backed fallback validation
- Architecture patterns:
  - pure Kotlin gameplay core with native helper fallback and separate rendering module
- Graphics / rendering techniques:
  - theme-aware tile rendering through LibGDX actors inside a board stage
- Input / UI approaches:
  - custom board UI separated from Android app shell
- Performance or optimization ideas:
  - timeout-guarded native generation path with safe fallback

## Notable Implementations

- `GameController` orchestrates safe-first-open generation and fallback creation logic.
- `SaveFileSerializer` uses explicit binary save/load serialization.
- `MinefieldStage` and `AreaActor` manage custom board rendering behavior.
- `wear` and `auto` modules show form-factor-specific Android adaptation.

## Android Relevance

- Native Android use:
  - yes
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - strongest reuse is for Android puzzle/board games, but the module split and fallback-generation strategy generalize well

## Risks / Limitations

- `GPL-3.0` may block direct code reuse in some projects.
- Puzzle-specific logic is less reusable than the architecture around it.
- Batch research did not confirm a successful local build.

## Notes

This is one of the best first-pass examples in the lab for Android-first Kotlin game architecture.
