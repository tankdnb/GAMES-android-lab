# game-2048

## Basic Info

- Project name: `game-2048`
- Source repository: `https://github.com/inaidE/game-2048`
- Author / organization: `inaidE`
- License: `MIT`
- Research note: [research/findings/inaide-game-2048.md](../../research/findings/inaide-game-2048.md)
- Investigated commit: `2a751fe54a3281a8c961c7ef41a1c355d3528576`
- Last verified: `2026-06-12`
- Activity / maintenance status: very fresh at selection; last push visible on `2026-06-12`

## Short Description

Tiny Android Jetpack Compose implementation of 2048 with swipe controls, animated tiles, score tracking, a persistent high score, and a game-over overlay, all inside a single app module.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `ui-hud`, `input`, `animation`
- Engine / framework: Android SDK + Jetpack Compose + Material 3
- Rendering approach: Compose layout tree with animated tile color, scale, and value transitions
- Main language(s): `Kotlin`
- Android target: direct Android app only
- Build system: `Gradle` (Kotlin DSL)

## Why It Matters

This project is only a narrow reference, but it is still useful when we want the smallest possible Compose casual-game baseline:

- direct swipe-to-board interaction
- compact 2048 merge logic
- simple high-score persistence
- lightweight animated tile presentation

## Reusable Ideas

- Gameplay ideas: compact row-slide and merge-scoring implementation for 2048-style grid games
- Architecture patterns: minimal `AndroidViewModel`-owned board state with direct UI binding
- Graphics / rendering techniques: `AnimatedContent` plus color/scale transitions for tile feedback
- Input / UI approaches: threshold-based swipe detection with `detectDragGestures`
- Performance or optimization ideas: none beyond keeping the board model tiny and immutable-at-the-edge

## Notable Implementations

- `move()` normalizes directional moves through row reversal and matrix transpose transforms
- `slideRow()` is a compact merge-and-score routine
- `GameBoard()` maps drag direction into board moves with minimal gesture logic
- `Tile()` uses basic Compose animation primitives to make number and color transitions readable

## Android Relevance

- Native Android use: direct Android-only app
- Kotlin relevance: high for beginner-level Compose puzzle shells
- Porting or adaptation notes: best reused as a tiny example, not as a structural baseline for larger games

## Risks / Limitations

- monolithic implementation concentrated in `MainActivity.kt`
- missing `gradle-wrapper.jar`, so the checked-in wrapper is incomplete
- effectively no real test surface
- rough README/text encoding hygiene

## Notes

This is best kept as a comparison sample for very small Compose puzzle apps, not as a primary reference for repository structure or long-term Android game architecture.
