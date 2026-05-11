# Project Entry

## Basic Info

- Project name: `Piano Tiles`
- Source repository: [https://github.com/atillaturkmen/piano-tiles](https://github.com/atillaturkmen/piano-tiles)
- Author / organization: `atillaturkmen`
- License: `GPL-3.0`
- Research note: [research/findings/atillaturkmen-piano-tiles.md](../../research/findings/atillaturkmen-piano-tiles.md)
- Investigated commit: `d9257698ffddd3a5be60f96e558aa4be75d6ad17`
- Last verified: `2026-05-11`
- Activity / maintenance status: active at selection; the repository was last pushed on `2026-04-26`, and the inspected Android stack is modernized to AGP `8.9.1`, SDK `35`, and Java/Kotlin target `17`.

## Short Description

Direct Android Piano Tiles clone written in Kotlin with a custom `SurfaceView`/`Canvas` loop, configurable starting speed, optional sound and vibration, and per-speed local high scores.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `audio`, `save-load`
- Engine / framework: Android SDK + `SurfaceView` + manual game thread + Navigation component
- Rendering approach: plain `Canvas` lane lines and `Rect`-based tiles on a `SurfaceView`, plus an Android view overlay for replay
- Main language(s): Kotlin
- Android target: direct single-app Android application
- Build system: single-module Android Gradle app

## Why It Matters

- This repository is a useful narrow Android-native comparison sample for teams that still want to study small custom-drawn `SurfaceView` arcade games instead of Compose or LibGDX-only references.
- Its strongest value for the lab is not depth, but the combination of device-normalized speed scaling, simple tactile feedback, difficulty-bucketed high scores, and direct touch handling against a moving tile queue.

## Reusable Ideas

- Gameplay ideas:
  - avoid immediate lane repetition, expose optional gradual speed escalation, and keep separate high-score buckets per starting difficulty
- Architecture patterns:
  - thin activity shell + one runtime owner view + one render thread is enough for a tiny arcade sample, but only if lifecycle and shutdown are handled more carefully than in this repository
- Graphics / rendering techniques:
  - quarter-screen lane geometry and rect-based note rendering that automatically scale with device dimensions
- Input / UI approaches:
  - forgiving hitboxes, raw pointer-down handling, drawer-locked shell navigation, and a replay overlay kept outside the `SurfaceView`
- Performance or optimization ideas:
  - snapshot moving entities before hit-testing, normalize velocity to device height, and avoid copying the repository's busy-spin thread shutdown bug

## Notable Implementations

- `GameActivity.kt` converts user-selected speed into device-relative runtime speed and mounts the replay overlay separately from the game surface.
- `GameThread.kt` shows a compact fixed-FPS loop with a pre-start warmup, but also highlights a lifecycle bug where the thread never exits cleanly.
- `GameView.kt` centralizes queue spawning, touch handling, optional sound/vibration, replay flow, and SharedPreferences-backed high-score writes.
- `Tile.kt` combines row-based geometry, forgiving hitboxes, optional speed escalation, and a visible red miss-feedback path.
- `HighScoresFragment.kt` renders a speed-keyed score table rather than a single global leaderboard.

## Android Relevance

- Native Android use:
  - yes; this is a direct Android game with portrait-only activities, raw touch input, `SoundPool`, vibration, `SurfaceView`, and SharedPreferences
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - best treated as a comparison sample for simple pre-Compose custom-drawn games, not as a primary architecture baseline

## Risks / Limitations

- GPL-3.0 licensing limits direct reuse.
- The project is narrow and untested.
- The render thread never exits cleanly after stop, and per-frame logging remains in the tile update path.
- Several important runtime values are stored in mutable static companion state.

## Notes

Keep this as a reference-only Android `SurfaceView` arcade sample. It is useful when you specifically need tiny custom-canvas/tactile-feedback ideas, but stronger entries such as `SeaBattle`, `Neon`, or `Minesweeper-JC` are better primary architecture references.
