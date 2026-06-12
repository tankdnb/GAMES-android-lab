# Project Entry

## Basic Info

- Project name: `number-tap`
- Source repository: [https://github.com/xarlord/number-tap](https://github.com/xarlord/number-tap)
- Author / organization: `xarlord`
- License: `MIT`
- Research note: [research/findings/xarlord-number-tap.md](../../research/findings/xarlord-number-tap.md)
- Investigated commit: `18857a1dd2a75df01c58e65bfd80d75987add3dc`
- Last verified: `2026-06-12`
- Activity / maintenance status: very fresh small Android game; latest checked-in code push at selection was `2026-06-12`, with a real test surface and active product-oriented repository structure despite zero public signal.

## Short Description

Android hyper-casual number puzzle built with Kotlin and Jetpack Compose, with a pure gameplay engine, direct Android product shell, retention layer, procedural audio, and lightweight ad/revive integration.

## Technical Profile

- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `audio`, `save-load`, `testing`
- Engine / framework: custom Android gameplay stack over Jetpack Compose
- Rendering approach: Compose UI plus lightweight custom draw/update flow
- Main language(s): Kotlin
- Android target: direct Android app, `minSdk 24`, `targetSdk 35`
- Build system: Gradle `8.11.1` wrapper + AGP app module + Compose + Kover

## Why It Matters

- `number-tap` is useful because it is directly Android-native and keeps the actual gameplay rules separate from the Compose shell.
- It also adds a practical small-product layer around retention, revive flows, audio feedback, and persistence, which is often missing from tiny casual-game samples.

## Reusable Ideas

- Gameplay ideas:
  - progressive number-tap puzzle that expands from `4x4` to `5x5`
  - replacement rule `currentValue + gridSizeTotal`
  - combo-sensitive time reward and wrong-tap time penalty
- Architecture patterns:
  - pure `GameEngine` with immutable `GameState`
  - typed difficulty tuning via `DifficultyConfig`
  - isolated profile/retention repository
- Graphics / rendering techniques:
  - compact Compose-native product shell without a heavyweight engine
- Input / UI approaches:
  - direct tap-to-grid gameplay through a controller-owned state flow
  - single-activity multi-screen Compose shell
- Performance or optimization ideas:
  - keep puzzle logic side-effect-free and cheap enough to test heavily and drive from a simple Android loop

## Notable Implementations

- `GameEngine.kt` handles scoring, timer changes, combo windows, grid progression, tutorial flow, and revive behavior without depending on Compose.
- `ProfileRepository.kt` implements missions, streak rewards, purchases, and JSON-backed profile persistence over `SharedPreferences`.
- `SoundManager.kt` generates SFX/music procedurally instead of relying only on bundled audio assets.
- `AdManagerImpl.kt` keeps the rewarded/interstitial ad seam reasonably isolated from the rest of the game logic.

## Android Relevance

- Native Android use:
  - yes
- Kotlin relevance:
  - high
- Porting or adaptation notes:
  - the pure gameplay engine is easy to reuse in other Kotlin Android puzzle games; the current `MainActivity` product shell should be mined selectively because it is quite monolithic

## Risks / Limitations

- `MainActivity` centralizes too many responsibilities.
- Public documentation has visible encoding corruption.
- Public ecosystem signal is still near zero.
- Local build verification in the lab was limited by the missing JDK/compiler.

## Notes

`number-tap` is a good catalog entry for small Android games because it combines a clean puzzle-core split with real product-shell concerns such as revive flow, missions, local profile state, and procedural audio.
