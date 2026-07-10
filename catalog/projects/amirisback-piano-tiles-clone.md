# Piano Tiles Clone

## Basic Info

- Project name: `Piano Tiles Clone`
- Source repository: `https://github.com/amirisback/piano-tiles-clone`
- Author / organization: `amirisback`
- License: `Apache-2.0`
- Research note: [research/findings/amirisback-piano-tiles-clone.md](../../research/findings/amirisback-piano-tiles-clone.md)
- Investigated commit: `f8c1838ca8d381747331aa70e3c8035491c6a84a`
- Last verified: `2026-07-11`
- Activity / maintenance status: older code activity; last push visible on `2023-04-09`, with repository metadata updated on GitHub in `2026`

## Short Description

Android Piano Tiles clone aggregator containing six independent app modules that demonstrate several small rhythm-game implementation styles: custom `SurfaceView`, bitmap-backed `Canvas` in an `ImageView`, direct `ImageView` spawning, touch lanes, tilt input, sound feedback, and high-score persistence.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `audio`, `save-load`, `ui-hud`
- Engine / framework: Android SDK with multiple standalone app modules
- Rendering approach: mixed `SurfaceView`, bitmap-backed `Canvas` in `ImageView`, and view hierarchy mutation
- Main language(s): `Kotlin`, `Java`
- Android target: direct Android apps
- Build system: `Gradle` (Kotlin DSL)

## Why It Matters

This is useful as a comparison archive rather than a main architecture baseline. It lets the lab compare several ways to implement the same mobile rhythm-game loop:

- lane-based tile spawning
- moving tile hit testing
- surface versus bitmap versus view-based rendering
- raw thread/timer loops
- touch and accelerometer variants
- small audio and high-score persistence patterns

The most reusable material is the `jghjianghan` module's mode-specific engine/orchestrator split and tilt variant.

## Reusable Ideas

- Gameplay ideas: classic, arcade, raining, and tilt variants of a Piano Tiles loop
- Architecture patterns: small mode-specific engine classes around shared tile/drawer/orchestrator concepts
- Graphics / rendering techniques: `SurfaceView` canvas loop, bitmap-backed `ImageView` canvas, and direct `ImageView` tile spawning as contrasting approaches
- Input / UI approaches: lane tap hit testing, wrong-lane fail feedback, accelerometer-controlled tilt mode
- Performance or optimization ideas: keep tile generation lane-aware and avoid immediate same-lane repeats; use caution with `CopyOnWriteArrayList` and raw threads in hot loops

## Notable Implementations

- `atillaturkmen` module keeps a compact `SurfaceView` and 60 FPS `GameThread` loop with sound/vibration feedback.
- `frostygum` and `obedkristiaji` modules draw rectangles into a mutable bitmap displayed through an `ImageView`.
- `mihaimaximfii` module uses `Timer`/`Handler` scheduling and real `ImageView` objects as falling tiles.
- `gianmartind` module adds Java-based sensor interaction and SQLite score storage.
- `jghjianghan` module splits runtime behavior into `GameEngine`, `TileOrchestrator`, `TileDrawer`, and four mode-specific engines.

## Android Relevance

- Native Android use: high; every meaningful module is an Android app.
- Kotlin relevance: mixed Kotlin and Java, with enough Kotlin runtime code to compare Android-specific game loops.
- Porting or adaptation notes: reuse individual ideas, not the raw lifecycle/thread ownership as-is. For new Android games, move the rules into a lifecycle-aware model and keep rendering behind a custom `View`, Compose frame loop, or engine surface.

## Risks / Limitations

- aggregator of cloned projects rather than one coherent codebase
- overlaps with the already researched `atillaturkmen/piano-tiles`
- no tests found
- static-analysis workflow only; no build/test CI found
- many loops use raw `Thread`, `Timer`, mutable flags, and handler messages
- some audio/resource cleanup and SQLite cursor/query handling is risky
- local `gradlew.bat help --no-daemon` fails because the lab environment has Java runtime tools but not the JDK tools needed by Kotlin compilation

## Notes

Keep as a reference-only Android rhythm-game comparison card. If revisited, focus narrowly on the `jghjianghan` mode orchestration and tilt input, or on comparing rendering choices across `SurfaceView`, bitmap-backed `ImageView`, and direct view-spawning implementations.
