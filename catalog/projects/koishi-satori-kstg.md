# KStg

## Basic Info

- Project name: `KStg`
- Source repository: `https://github.com/Koishi-Satori/KStg`
- Author / organization: `Koishi-Satori`
- License: `Apache-2.0`
- Research note: [research/findings/koishi-satori-kstg.md](../../research/findings/koishi-satori-kstg.md)
- Investigated commit: `d65d9d962903120683aee3d00ce8c828b470121b`
- Last verified: `2026-07-10`
- Activity / maintenance status: low current activity; last pushed at selection on `2023-10-07`

## Short Description

KStg is a desktop JVM/Kotlin shoot-em-up engine built around Java2D/Swing rendering, a simple scheduled thread runtime, object pools, script-loaded assets, key-bind handling, replay recording, plugin jars, and a separate crash-handler helper.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `input`, `collision`, `audio`, `asset-pipeline`
- Engine / framework: custom JVM STG engine
- Rendering approach: Java2D/Swing with offscreen `BufferedImage` and optional `VolatileImage` / Java2D OpenGL acceleration
- Main language(s): Kotlin, Java, C++ bootstrapper support
- Android target: none found
- Build system: Gradle Kotlin DSL, Gradle wrapper `7.1`, CrashHandler subproject

## Why It Matters

- It gives the lab a compact bullet-hell engine comparison point with explicit runtime, resource loading, collision, replay, and plugin seams.
- The most reusable Android-adjacent idea is the subchunk grid for narrowing bullet collision checks in dense projectile scenes.
- It is useful as a reference and caution, not as a direct mobile architecture model, because the checked-in runtime is desktop/Swing-first and contains visible unfinished or incorrect pieces.

## Reusable Ideas

- Gameplay ideas: stage action queues, frame-delayed enemy/boss/dialog scheduling, replay recording of deterministic seed plus key/player data.
- Architecture patterns: fluent bootstrapper, separate scheduled systems for info/render/logic/audio, object pools split by loading/UI/player/objects/bullets.
- Graphics / rendering techniques: offscreen buffer rendering, optional VRAM-compatible buffer, cached texture transforms/convolutions, script-driven sprite-sheet slicing.
- Input / UI approaches: global key-state table, object-bound and generic key events, input barriers during replay playback.
- Performance or optimization ideas: subchunk mesh for reducing bullet collision checks near the player.

## Notable Implementations

- `Bootstrapper.kt` wires settings, loaders, Swing window configuration, input, and periodic engine systems.
- `GameLoop.kt` applies a clear state-driven update order across player, stage, UI, objects, bullets, key binds, and delayed tasks.
- `SubChunks.kt` indexes bullet UUIDs into a grid and lets player collision tests skip irrelevant chunks.
- `GFXLoader.kt` and `AudioLoader.kt` implement small script languages for texture and audio definitions.
- `ReplayRecorder.kt` serializes key states, FPS, player coordinates, and metadata into a compressed replay file.
- `KStgEngineMain.kt` loads plugin jars and runs classes implementing `JvmPlugin`.

## Android Relevance

- Native Android use: none found.
- Kotlin relevance: useful for studying compact Kotlin JVM engine organization and gameplay/runtime seams.
- Porting or adaptation notes: Android reuse would require replacing Swing/Java2D, removing global desktop state, fixing collision/script issues, and designing lifecycle-aware Android host ownership.

## Risks / Limitations

- Desktop-only in the inspected revision.
- Stale public activity compared with stronger current candidates.
- `ReplayPlayer.kt` still contains unfinished playback logic.
- `VM.kt` appears to implement division as addition.
- `CollideSystem.circleIntersectCircle` appears to use an inverted condition.
- Some checked-in tests are closer to demo/sample code than assertive regression coverage.

## Notes

Keep this as a focused reference for STG object pools, resource scripts, replay recording, and subchunk collision. Do not copy its collision or script VM code without correction.
