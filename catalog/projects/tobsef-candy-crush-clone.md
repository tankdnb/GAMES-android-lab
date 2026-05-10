# Project Entry

## Basic Info

- Project name: `Candy Crush Clone`
- Source repository: [https://github.com/TobseF/Candy-Crush-Clone](https://github.com/TobseF/Candy-Crush-Clone)
- Author / organization: `TobseF`
- License: `MIT`
- Research note: [research/findings/tobsef-candy-crush-clone.md](../../research/findings/tobsef-candy-crush-clone.md)
- Investigated commit: `842c751c83f2578dd055597be1da601c4dd48de4`
- Last verified: `2026-05-10`
- Activity / maintenance status: last push recorded at selection on `2025-10-15`.

## Short Description

Compact Kotlin KorGE match-3 sample with Android output support, event-driven cascade handling, renderer/model separation, and unusually solid `commonTest` coverage for board mechanics.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `korge`, `input`, `ui-hud`, `testing`
- Engine / framework: KorGE / Korlibs
- Rendering approach: KorGE scene graph with sprite-sheet based tile rendering and tweened board animation
- Main language(s): Kotlin
- Android target: indirect Android build target via the KorGE Gradle plugin, plus JVM, JS, and desktop outputs
- Build system: Gradle Kotlin DSL

## Why It Matters

- It is one of the clearest small-scale references in the lab for structuring a Kotlin puzzle game around pure board logic, typed events, and a separate animation/render layer.
- The repository is especially useful as a readable implementation model, not because it is large, but because it makes its match-3 flow and test coverage easy to reuse.

## Reusable Ideas

- Gameplay ideas:
  - deterministic reserve-based next-tile feed for handcrafted or tutorial levels
- Architecture patterns:
  - event-driven game flow with DI-composed services and renderer-independent board logic
- Graphics / rendering techniques:
  - mirrored renderer grid with command-driven swap/drop/insert animation
- Input / UI approaches:
  - drag-to-grid input translation plus HUD score popups and move/objective counters
- Performance or optimization ideas:
  - keep logic and renderer synchronized through explicit move commands instead of per-frame reconciliation

## Notable Implementations

- `GameFlow` sequences swap, delete, gravity, refill, and cascade checks from drag events.
- `GameMechanics` encapsulates board rules, adjacency validation, gravity, and insert command generation.
- `GameFieldRenderer` and `TileAnimator` keep visual state separate from model state while still synchronized.
- `commonTest` covers board parsing, match detection, gravity, insert ordering, reserve behavior, and coordinate mapping.

## Android Relevance

- Native Android use:
  - indirect through KorGE's Android target
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - strongest reuse is for Kotlin Android puzzle or board-style games that want a small but disciplined architecture reference

## Risks / Limitations

- The sample is narrow in scope and does not address persistence, networking, monetization, or large Android app structure.
- Build confirmation was limited because the local environment lacked a JDK during Gradle discovery.
- KorGE integration is visible, but the repo does not contain a large checked-in Android module surface to study.

## Notes

This is a strong small-reference entry for event-driven match-3 architecture in Kotlin.
