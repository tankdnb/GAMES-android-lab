# Research Note

## Repository Snapshot

- Repository: `xarlord/number-tap`
- Source URL: [https://github.com/xarlord/number-tap](https://github.com/xarlord/number-tap)
- Owner: `xarlord`
- Batch ID: [`BATCH-2026-06-12-D`](../batches/BATCH-2026-06-12-D.md)
- Type: `android-game`
- License: `MIT`
- Selection date: `2026-06-12`
- Last pushed at selection: `2026-06-12`
- Stars at selection: `0`
- Default branch at selection: `master`
- Investigated commit: `18857a1dd2a75df01c58e65bfd80d75987add3dc`
- Research status: `accepted`
- Build mode: `static-review + gradle-version + gradle-help-failed-no-jdk-compiler`
- Catalog card: [catalog/projects/xarlord-number-tap.md](../../catalog/projects/xarlord-number-tap.md)

## Why This Repository Was Selected

- `xarlord/number-tap` was the last active exact-license shortlist candidate after `Mechanica`.
- The main question for this pass was whether the repository is only a small Android shell or whether it contains reusable game logic, product-shell, and testing patterns worth keeping.
- The answer is `accepted`: it is a compact but real Android game product with a stronger-than-expected split between pure gameplay logic and the Android shell, plus unusually broad tests for a zero-star repository.

## Technical Profile

- Main language(s): Kotlin
- Engine / framework: custom Android game stack over Jetpack Compose
- Rendering stack: Compose UI plus Canvas-style drawing and custom Android audio/ad integrations
- Android target: direct Android app, `minSdk 24`, `targetSdk 35`
- Build system: Gradle `8.11.1` wrapper + AGP app module + Compose + Kover
- Repository layout summary:
  - `app/` - Android app, gameplay core, retention, ads, audio, UI, tests
  - `assets/` - shipped content/assets
  - `docs/` - product design notes, including `GDD.md`
  - `scripts/` - helper scripts
- Source footprint:
  - total files counted in repository: `99`
  - Kotlin/Java files counted in repository: `57`
- Test surface:
  - visible `src/test` tree covers ads, analytics, audio, data, gameplay, retention, and haptics
  - visible `src/androidTest` tree covers Compose UI and `MainActivity`
- Key modules reviewed:
  - `README.md`
  - `docs/GDD.md`
  - `app/build.gradle.kts`
  - `app/src/main/java/com/xarlord/numbertap/game/GameEngine.kt`
  - `app/src/main/java/com/xarlord/numbertap/data/GameState.kt`
  - `app/src/main/java/com/xarlord/numbertap/data/DifficultyConfig.kt`
  - `app/src/main/java/com/xarlord/numbertap/MainActivity.kt`
  - `app/src/main/java/com/xarlord/numbertap/retention/PlayerProfile.kt`
  - `app/src/main/java/com/xarlord/numbertap/retention/ProfileRepository.kt`
  - `app/src/main/java/com/xarlord/numbertap/audio/SoundManager.kt`
  - `app/src/main/java/com/xarlord/numbertap/ads/AdManager.kt`
  - `app/src/main/java/com/xarlord/numbertap/ads/AdManagerImpl.kt`
  - `app/src/test/java/com/xarlord/numbertap/game/GameEngineTest.kt`
  - `app/src/test/java/com/xarlord/numbertap/game/GameFlowIntegrationTest.kt`
  - `app/src/test/java/com/xarlord/numbertap/retention/ProfileRepositoryTest.kt`

## Build And Runtime Notes

- The repository was investigated through static review plus lightweight Gradle discovery.
- `cmd /c gradlew.bat --version` succeeded after redirecting `GRADLE_USER_HOME` into `research/cache/gradle-xarlord-number-tap`.
- `cmd /c gradlew.bat help --no-daemon` failed because the lab machine exposes only a Java runtime without compiler tools:
  - `No Java compiler found, please ensure you are running Gradle with a JDK`
- `cmd /c gradlew.bat :app:testDebugUnitTest --dry-run --no-daemon` failed for the same reason.
- The checked-in repository itself looks structurally healthy:
  - wrapper files exist
  - CI exists under `.github`
  - `app/build.gradle.kts` clearly targets Java/Kotlin `17`
  - Kover coverage gates are configured
- Two documentation-quality caveats were visible during static review:
  - `README.md` appears to have text-encoding corruption
  - `docs/GDD.md` also shows mojibake in several sections

## Usefulness Assessment

- Reuse potential: `3`
- Android transfer: `3`
- Implementation depth: `2`
- Code clarity: `2`
- Novelty: `2`
- Overall verdict: `accepted`
- Why:
  - The repo is directly Android-relevant and contains a real gameplay core instead of burying all logic in the UI layer.
  - It also preserves useful product-shell references around retention, rewarded revive flow, procedural audio generation, and lightweight monetization seams.
  - The main weakness is that `MainActivity` centralizes too much orchestration, which makes the product shell less reusable than the pure engine pieces.

## Interesting Findings

### Engine Architecture And Core Loop

- `GameEngine.kt` is the strongest takeaway:
  - pure state-in/state-out game logic
  - no Compose dependencies
  - correct-tap, wrong-tap, combo, timer, revive, and tutorial flows kept in one deterministic core
- The gameplay loop is built around immutable `GameState` updates rather than mutable view-side callbacks, which makes the logic easy to test and portable to future Android game prototypes.
- `DifficultyConfig.kt` keeps progression thresholds, timer gain/loss rules, combo windows, and grid-size transitions in typed configuration instead of scattering them through UI code.

### Input And Controls

- `MainActivity.kt` uses a direct Compose shell, but the actual tap semantics are still mediated through the pure `GameEngine`.
- The game design itself is a compact reusable pattern:
  - find the next required number
  - replace consumed cells with `currentValue + gridSizeTotal`
  - progress from `4x4` to `5x5`
  - reward speed with combo-sensitive time gain
- This is a useful reference for fast Android puzzle loops that need simple but escalating touch interaction without a heavy engine.

### UI, HUD, And Menus

- `MainActivity.kt` shows a real single-activity Android product shell with menu, gameplay, settings, and game-over screens inside one Compose host.
- The same file also shows the downside of that approach:
  - game loop orchestration
  - persistence
  - high-score handling
  - missions
  - haptics
  - ads
  - audio
  - notifications
  all meet in one place.
- This is still useful as a practical Android shell reference, but it should be studied selectively rather than copied wholesale.

### Audio

- `SoundManager.kt` is more interesting than expected for a tiny casual game:
  - generates WAV temp files procedurally
  - loads them into `SoundPool`
  - modulates combo pitch
  - builds lightweight procedural background music with `AudioTrack`
- That makes the repository useful not only for puzzle-flow logic, but also for compact synthetic audio patterns that avoid a large asset footprint.

### Android Platform Integration

- `AdManagerImpl.kt` keeps `Activity` references out of the long-lived ad manager and only passes them at show-time, which is a cleaner Android seam than many small-game samples use.
- The product shell also includes:
  - rewarded revive flow
  - interstitial frequency gating
  - notification-permission handling
  - daily-login processing
  - persisted settings/high scores/themes
- `ProfileRepository.kt` and `PlayerProfile.kt` show a richer-than-usual retention layer for a small Android game: streak rewards, missions, power-ups, purchases, and serialized profile state.

### Build, Release, And Testing

- `app/build.gradle.kts` enables Kover and enforces a minimum coverage threshold of `60`.
- `GameEngineTest.kt` covers the pure gameplay engine broadly: timers, combos, wrong taps, grid growth, shuffle behavior, and state immutability.
- `GameFlowIntegrationTest.kt` adds end-to-end flow coverage around actual gameplay transitions.
- `ProfileRepositoryTest.kt` verifies retention/persistence logic with a fake `SharedPreferences` surface.
- The test discipline is much stronger than the repository's public signal would suggest.

## Reusable Takeaways

- Keep the gameplay loop pure even in a small Android Compose game so it can be tested independently from the UI shell.
- Use typed difficulty/config objects to move timer, grid, and progression tuning out of the presentation layer.
- Compact casual Android games can still benefit from dedicated retention and revive seams instead of burying those rules inside screen composables.
- Procedural audio generation is viable for tiny puzzle games when you want lightweight feedback without building an asset-heavy sound pipeline.

## Evidence Summary

- `GameEngine.kt`, `GameState.kt`, and `DifficultyConfig.kt` - pure gameplay engine, typed state, and progression configuration
- `MainActivity.kt` - Compose-first Android shell plus orchestration caveat
- `PlayerProfile.kt` and `ProfileRepository.kt` - retention, missions, streaks, power-ups, and local JSON-backed persistence
- `SoundManager.kt` - generated SFX/music pipeline
- `AdManagerImpl.kt` - rewarded/interstitial Android ad seam
- `GameEngineTest.kt`, `GameFlowIntegrationTest.kt`, and `ProfileRepositoryTest.kt` - meaningful automated verification

## Risks Or Limits

- `MainActivity.kt` is monolithic and centralizes too many product responsibilities.
- Public documentation quality is weakened by visible encoding corruption in both `README.md` and `docs/GDD.md`.
- The project has zero stars, so ecosystem signal is currently low.
- Local Gradle validation in the lab is blocked by the missing JDK/compiler, so build health was only partially confirmed.

## Catalog Decision

- Keep in main catalog: `yes`
- Primary category: `android-game`
- Focus tags: `2d`, `android`, `input`, `ui-hud`, `audio`, `save-load`, `testing`
- Follow-up needed:
  - if this repository is revisited, keep the follow-up narrow:
    - `GameEngine`
    - `ProfileRepository`
    - `SoundManager`
    - selective `MainActivity` product-shell patterns
