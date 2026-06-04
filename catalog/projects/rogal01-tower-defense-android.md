# Project Entry

## Basic Info

- Project name: `tower-defense-android`
- Source repository: [https://github.com/rogal01/tower-defense-android](https://github.com/rogal01/tower-defense-android)
- Author / organization: `rogal01`
- License: `MIT`
- Research note: [research/findings/rogal01-tower-defense-android.md](../../research/findings/rogal01-tower-defense-android.md)
- Investigated commit: `1f03efb7f778368ed590f6d18628454b14c25a3d`
- Last verified: `2026-06-04`
- Activity / maintenance status: freshly updated but still zero-signal; the latest inspected commit is `docs: remove emojis from ecosystem header` from `2026-06-03`, and no CI workflows or test tree were found.

## Short Description

Android-first tower-defense game with a shared Kotlin gameplay core, custom `SurfaceView` plus Canvas rendering, a large campaign and meta-progression layer, procedural audio generation, and partially scaffolded iOS starter code.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `multiplatform`, `ui-hud`, `audio`, `save-load`, `procedural-generation`
- Engine / framework: Android SDK + shared Kotlin runtime + custom `SurfaceView` game loop
- Rendering approach: fully procedural Canvas rendering on Android, with hand-drawn `Path`-based entities and cached terrain or path geometry; iOS SpriteKit starter files exist but are not fully integrated
- Main language(s): Kotlin, Swift
- Android target: direct Android app module with `minSdk 26`, `targetSdk 35`, and `compileSdk 35`
- Build system: Gradle `9.3.1` wrapper + AGP `9.1.0` + Kotlin Android `2.2.10` + Kotlin Multiplatform `2.1.0`

## Why It Matters

- This repository is worth keeping because it shows how far a native Android game can go without a third-party engine while still keeping most simulation logic in a shared Kotlin module.
- Its strongest value for the lab is the combination of a dense tower-defense runtime, randomized path-layout generation, code-drawn rendering, a broad product shell, and a procedural SFX pipeline that avoids shipping a large effect-asset set.

## Reusable Ideas

- Gameplay ideas:
  - authored campaign levels with restrictions and star thresholds, endless bounty boards, randomizer mode, and tower or boss ability packaging
- Architecture patterns:
  - shared gameplay core plus thin Android adapters for rendering, storage, and audio
- Graphics / rendering techniques:
  - cached Canvas rendering, code-drawn entities, and map-path jitter that preserves authored structure while varying runs
- Input / UI approaches:
  - native HUD around a custom render view, placement or drag control modes, long-press tower inspection, and save export or import through Android document pickers
- Performance or optimization ideas:
  - pre-allocated paints, cached path geometry, and simple frame pacing that drops to 30 FPS in battery-saver mode

## Notable Implementations

- `GameEngine.kt` centralizes campaigns, modes, path generation, placement validation, progression, achievements, run history, and save flow inside one shared runtime.
- `GameView.kt` hosts the render loop and touch pipeline in a custom Android `SurfaceView`.
- `EntityRenderer.kt` renders enemies, towers, bosses, and the base entirely in code.
- `CampaignLevel.kt` models 40 campaign levels with restrictions, economics, maps, and derived star-score thresholds.
- `SoundManager.kt` synthesizes PCM samples into cached WAV files and loads them through `SoundPool`.
- `SettingsActivity.kt` exports and imports full local save state as JSON.

## Android Relevance

- Native Android use:
  - yes, direct Android app with native menus, settings, audio, and `SurfaceView` rendering
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - best reused as an Android-first product-shell and gameplay-systems reference; the cross-platform story is interesting, but the current iOS path is still manual and incomplete

## Risks / Limitations

- No visible tests or CI.
- The shared runtime and Android render layer are both very large monoliths.
- The iOS path is not actually enabled in the active shared-module build and still contains TODO-level work.
- Build configuration is noisy, with deprecated Android flags and Android SDK dependence for real task execution.
- The checked-in README is portfolio-facing rather than purely engineering-facing, and an empty `0`-byte `app/src/main/java/com/example/myapp/game/GameEngine.kt` file suggests rough repository hygiene.

## Notes

`tower-defense-android` is stronger as a direct Android reference than as a true multiplatform baseline. The most transferable parts are the shared runtime boundary, placement and path rules, procedural rendering and audio, and the way the menu shell exposes a surprisingly broad set of game modes and progression systems without adding a heavyweight external engine.
