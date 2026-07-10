# Captain Treasure Android Game

## Basic Info

- Project name: `Captain Treasure Android Game`
- Source repository: `https://github.com/KAMRAN16-byte/Captain-Treasure-Android-Game`
- Author / organization: `KAMRAN16-byte`
- License: `MIT`
- Research note: [research/findings/kamran16-byte-captain-treasure-android-game.md](../../research/findings/kamran16-byte-captain-treasure-android-game.md)
- Investigated commit: `ac9d241721eca7f1aff3503272556ed67e3420de`
- Last verified: `2026-07-10`
- Activity / maintenance status: fresh at selection; last push visible on `2026-06-04`

## Short Description

Tiny Android Jetpack Compose treasure-hunting micro-game where each direction choice randomly grants treasure or causes storm damage, with a simple HP, repair, game-over, and reset loop.

## Technical Profile

- Primary category: `reference-only`
- Focus tags: `2d`, `android`, `input`, `ui-hud`
- Engine / framework: Android SDK + Jetpack Compose + Material 3
- Rendering approach: Compose layout tree with text HUD rows and Material button controls
- Main language(s): `Kotlin`
- Android target: direct Android app only
- Build system: `Gradle` (Kotlin DSL)

## Why It Matters

This project is useful only as a compact comparison sample for the smallest possible Compose game shell:

- direct Android Compose setup
- button-driven movement/event loop
- random treasure versus damage rule
- HP, repair, reset, and game-over state

It is not a strong architecture baseline, but it helps calibrate the lower bound of what the lab considers a documented micro-game reference.

## Reusable Ideas

- Gameplay ideas: tiny risk/reward loop where each move can grant treasure or damage the player
- Architecture patterns: mostly a cautionary example showing when UI-owned mutable state should be extracted into a domain model
- Graphics / rendering techniques: none beyond standard Compose layout and Material icons
- Input / UI approaches: cardinal direction button grid plus repair/reset actions
- Performance or optimization ideas: none; the game is too small for meaningful performance lessons

## Notable Implementations

- `Captain_Treasure()` keeps the full HUD and controls in one composable.
- The shared direction handler mutates direction, event text, treasure, HP, and game-over state.
- Repair converts treasure into HP only while the game is active.
- Reset restores the whole visible session state.

## Android Relevance

- Native Android use: direct Android app module with launcher activity
- Kotlin relevance: high only for beginner-level Compose state examples
- Porting or adaptation notes: reuse the game idea or tiny UI pattern, not the state architecture

## Risks / Limitations

- monolithic one-file implementation
- no `ViewModel`, reducer, domain model, persistence, or lifecycle game handling
- random logic is not injectable or testable
- only template tests are present
- local `gradlew.bat help --no-daemon` fails on the lab machine because AGP `8.2.0-rc01` needs Java `11+` while the machine exposes Java `8`
- README text shows encoding issues in the inspected Windows console output

## Notes

Keep this as a small reference-only Compose prototype and cautionary baseline. Stronger Android Compose game architecture remains better represented by `Neon`, `Compose Tetris`, `NumPairs`, `Space`, `KnowIt`, and similar accepted entries.
